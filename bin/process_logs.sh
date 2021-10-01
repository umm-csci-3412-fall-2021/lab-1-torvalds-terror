#!/usr/bin/bash

#Make temporary directory
dir=$(mktemp -d)

orig_dir=$(pwd)

#Loop throough given arguments and untar files
for FILE in "$@"
do  
    basedName=$(basename -s .tgz "$FILE")
    mkdir "$dir"/"$basedName"
    tar xzf "$orig_dir"/"$FILE" -C "$dir"/"$basedName"
    ./bin/process_client_logs.sh "$dir"/"$basedName"
done

cd "$orig_dir" || exit

./bin/create_username_dist.sh "$dir"
./bin/create_hours_dist.sh "$dir"
./bin/create_country_dist.sh "$dir"
./bin/assemble_report.sh "$dir"
mv "$dir"/failed_login_summary.html "$orig_dir"