#!/usr/bin/bash

#Make temporary directory
dir=$(mktemp -d)

#Enter temp directory to do work
cd "$dir" || exit

#Loop throough given arguments and untar files
for FILE in "$@"
do  
    name=$(echo "$FILE" | cut -f 1 -d '.')
    mkdir "$name"
    tar -xzf "$FILE" -C "$name" | /bin/bash "$(dirname "$0")/process_client_logs.sh"
done

#Enter temp directory to do work
cd "$dir" || exit

for DIR in *
do
    /bin/bash "$(dirname "$0")/create_username_dist.sh" "$DIR"
    /bin/bash "$(dirname "$0")/create_hour_dist.sh" "$DIR"
    /bin/bash "$(dirname "$0")/create_country_dist.sh" "$DIR"
    /bin/bash "$(dirname "$0")/assemble_report.sh" "$DIR"
    mv "$DIR"/*/var/log/failed_login_summary.txt ../failed_login_summary.txt
done