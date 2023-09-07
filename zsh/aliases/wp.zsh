function wpexport() {
  # Get the current date
  current_date=$(date +'%Y-%m-%d')

  # Get the last part of the current directory path (folder name)
  current_directory=$(basename "$PWD")

  # Set default values for site_name and database_name
  site_name_default=$current_directory
  database_name_default=$current_directory

  # Prompt the user for the site name (defaulting to the current folder name)
  echo -n "What is the site name (${site_name_default})? "
  read site_name
  site_name=${site_name:-$site_name_default}

  # Prompt the user for the database name (defaulting to the site name)
  echo -n "What is the database name (${database_name_default})? "
  read database_name
  database_name=${database_name:-$database_name_default}

  # Confirm the provided values
  echo "Site Name: $site_name"
  echo "Database Name: $database_name"

  # Prompt for confirmation before proceeding
  echo -n "Proceed with the export? (y/n) "
  read confirm
  if [[ $confirm == "y" || $confirm == "Y" ]]; then
    # Export the database
    database_file="${database_name}-export-${current_date}.sql"
    wp db export "$database_file"

    # Compress the database file with gzip
    gzip "$database_file"

    # Create a tar archive containing the gzipped database file and the uploads folder
    tar_file="$HOME/Downloads/${site_name}-export-${current_date}.tar.gz"
    tar -czf "$tar_file" "$database_file.gz" web/app/uploads/

    # Remove the gzipped database file
    rm "$database_file.gz"

    echo "Export done! View it in the ~/Downloads folder - $tar_file"
  else
    echo "Export canceled."
  fi
}
