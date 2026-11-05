# Import a Laravel Forge database backup into a local database
# Usage: tmu-db <backup.zip|file.sql|file.sql.gz> <database>
# CREATE DATABASE / USE lines in the dump are removed, so the data always
# lands in <database> no matter what the backup's database was called.
# If <database> already exists you must type its name before it is replaced.
function tmu-db() {
    local file=$1 db=$2
    local -a mysql_cmd=(mysql --socket /tmp/mysql_3306.sock -uroot)

    if [[ -z $file || -z $db ]]; then
        echo "Usage: tmu-db <backup.zip|file.sql|file.sql.gz> <database>"
        return 1
    fi
    [[ -f $file ]] || { echo "File not found: $file"; return 1 }
    [[ $db =~ '^[A-Za-z0-9_]+$' ]] || { echo "Bad database name: $db"; return 1 }

    # Forge zips hold a single dump; gzip -dcf passes plain SQL through unchanged
    local entry
    case $file in
        *.zip)
            entry=$(unzip -Z1 "$file" | grep -m1 -E '\.sql(\.gz)?$')
            [[ -n $entry ]] || { echo "No .sql or .sql.gz file inside $file"; return 1 }
            ;;
        *.sql|*.sql.gz) ;;
        *) echo "File is not .zip, .sql or .sql.gz: $file"; return 1 ;;
    esac

    case $db in
        mysql|sys|information_schema|performance_schema)
            echo "Refusing to import into the $db system database"; return 1 ;;
    esac

    # Replacing an existing database requires typing its name
    local exists
    exists=$("${mysql_cmd[@]}" -N -e "SELECT COUNT(*) FROM information_schema.schemata WHERE schema_name='$db'") \
        || { echo "Could not connect to mysql"; return 1 }
    if (( exists )); then
        local count reply
        count=$("${mysql_cmd[@]}" -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='$db'") || return 1
        echo "Database '$db' already exists with $count tables. Importing will DELETE everything in it."
        read -r "reply?Type the database name to drop and replace it: "
        [[ $reply == $db ]] || { echo "Cancelled, $db was not changed"; return 1 }
        "${mysql_cmd[@]}" -e "DROP DATABASE \`$db\`" || return 1
    fi
    "${mysql_cmd[@]}" -e "CREATE DATABASE \`$db\`" || return 1

    echo "Importing ${entry:-$file} into $db..."
    local start=$SECONDS
    # Skip FK/unique checks and commit once at the end, for this session only
    if [[ -n $entry ]]; then unzip -p "$file" "$entry"; else cat "$file"; fi \
        | gzip -dcf \
        | { LC_ALL=C sed -E '/^CREATE DATABASE /d; /^USE `/d'; echo "COMMIT;"; } \
        | "${mysql_cmd[@]}" --max-allowed-packet=1G \
            --init-command="SET SESSION foreign_key_checks=0, unique_checks=0, autocommit=0" "$db"
    local -a codes=($pipestatus)
    local elapsed=$(( SECONDS - start ))

    if [[ -z ${codes:#0} ]]; then
        echo "Done: $db imported in $(( elapsed / 60 ))m $(( elapsed % 60 ))s"
        osascript -e "display notification \"$db imported\" with title \"tmu-db\""
    else
        echo "Import failed (exit codes: $codes)"
        osascript -e "display notification \"$db import failed\" with title \"tmu-db\""
        return 1
    fi
}

# Tab completion: backup files first, then local database names
function _tmu-db() {
    _arguments \
        '1:backup file:_files -g "*.(zip|sql|sql.gz)(-.)"' \
        '2:database:->db'
    if [[ $state == db ]]; then
        local -a dbs=(${(f)"$(mysql --socket /tmp/mysql_3306.sock -uroot --connect-timeout=1 -N -e 'SHOW DATABASES' 2>/dev/null)"})
        compadd -- $dbs
    fi
}
compdef _tmu-db tmu-db
