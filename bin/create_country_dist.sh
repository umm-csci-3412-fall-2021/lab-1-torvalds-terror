#!/usr/bin/bash

#Takes a directory as a command line input
dir=$1

cur_dir=$(pwd)

#Peek into the directory
cd "$dir" || exit

#Gets the usernames from the failed_login_data.txt file, sorts them, and puts them in a temporary file
cat ./*/failed_login_data.txt | awk 'match($0, /[a-zA-Z]+ [0-9 ]+[a-zA-Z0-9]+ ([0-9.]+)/, groups) {print groups[1]}' | sort > "$cur_dir"/sortedIPs.txt

#Join the country-IP map and sorted IP file, extract just the country code from that, sort it again, get the unique occurrences, and finally extract that and create the addRow lines
join "$cur_dir"/sortedIPs.txt "$cur_dir"/etc/country_IP_map.txt | awk 'match($0, /[0-9.]+ ([a-zA-Z]+)/, groups) {print groups[1]}' | sort | uniq -c | awk 'match($0, /([0-9]+) ([a-zA-Z]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, "groups[1]"]);"}' >> countryAddRows.txt

#Back it up a step
cd "$cur_dir" || exit

#Calls wrap contents on the temp file just created and passes the necessary html components
./bin/wrap_contents.sh "$dir"/countryAddRows.txt html_components/country_dist "$dir"/country_dist.html

#Delete the temp file
rm "$dir"/countryAddRows.txt