# Laravel aliases
alias nrd='npm run dev'
alias art='php artisan'
alias plz='php please'
alias lreset='rm -rf ./vendor && composer install && npm ci && npm run build'
alias lupdate='rm -rf vendor node_modules package-lock.json composer.lock && composer update && npm i && npm run build'
alias phpunit='vendor/bin/phpunit'
alias composer='COMPOSER_MEMORY_LIMIT=-1 composer'

# Require a package from a local folder
composer-link() {
    composer config repositories.local '{"type": "path", "url": "'$1'"}' --file composer.json
}

# Control multiple TMU instances
function tower() {
    php ~/Code/tower/artisan tower:$@
}

# Start a new laravel project with austencam/cable
function newapp() {
    composer create-project --prefer-dist laravel/laravel ${1:-newapp}
    cd ${1:-newapp}
    composer require austencam/cable
    php artisan cable:run
    cp .env.example .env
    php artisan key:generate
}

# Open dev setup for the current project / folder
function dev() {
    cd ~/Code/${1:-$PWD} && code .;
    if [ "$2" = "-w" ]; then
        npm run watch
    fi
}

function createdb() {
    mysql --socket /tmp/mysql_3306.sock -uroot -e "create database if not exists ${1:-laravel};"
}

function somefail() {
    if [ "$1" = "--help" ]; then
        cat <<EOF
Usage: somefail FILE TEST

This command is used to repeatedly run tests until they fail.
Passing no arguments will run the entire test suite.
Passing FILE or TEST arguments allows you to run a specific test file and/or test method.
The command stops executing after the first failure.

Arguments:
  FILE  (Optional) Name of the test file within the 'tests/Feature' directory or within
        'vendor/hdmaster/core/tests/Feature'. Do not include the directory path.
  TEST  (Optional) The specific test method to run. If omitted, all tests in the
        file are run.

Examples:
  somefail ExampleTest.php        # Runs all tests in ExampleTest.php
  somefail ExampleTest.php testMethod  # Runs a specific test method in ExampleTest.php
EOF
        return 0
    fi

    count=0
    file=$1
    test=$2
    testFile=""
    if [ -f "$(pwd)/tests/Feature/$file" ]; then
        testFile="tests/Feature/$file"
    elif [ -f "vendor/hdmaster/core/tests/Feature/$file" ]; then
        testFile="vendor/hdmaster/core/tests/Feature/$file"
    fi

    if [ -z "$test" ]; then
        command="artisan test $testFile --parallel --stop-on-error --stop-on-failure"
    else
        if grep -q "$test" "$testFile"; then
            command="artisan test $testFile --parallel --stop-on-error --stop-on-failure --filter '^.*::${test:-}( .*)?$'"
        else
            echo "Test not found in the file."
            return 1
        fi
    fi

    # Use eval to execute the command stored in the variable
    while eval $command; do
        ((count++))
        echo "✅ Completed test run #$count.\n\n"
    done
}
