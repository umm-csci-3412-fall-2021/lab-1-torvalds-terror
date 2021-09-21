#!/usr/bin/bash

#Takes a directory as a command line input
dir=$1

#Peek into the directory
cd "$dir" || exit

#Gets the usernames from the failed_login_data.txt file, sorts them, and puts them in a temporary file
cat ./*/failed_login_data.txt | awk 'match($0, /[a-zA-Z]+ [0-9 ]+[a-zA-Z0-9]+ ([0-9.]+)/, groups) {print groups[1]}' | sort > sortedIPs.txt

#Join the country-IP map and sorted IP file, extract just the country code from that, sort it again, get the unique occurrences, and finally extract that and create the addRow lines
join ../etc/country_IP_map.txt sortedIPs.txt | awk 'match($0, /[0-9.]+ ([a-zA-Z]+)/, groups) {print groups[1]}' | sort | uniq -c | awk 'match($0, /([0-9]+) ([a-zA-Z]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, "groups[1]"]);"}' >> tmpAddRows.txt

#Back it up a step
cd .. || exit

#Calls wrap contents on the temp file just created and passes the necessary html components
/bin/bash "$(dirname "$0")/wrap_contents.sh" "$dir"/tmpAddRows.txt country_dist "$dir"/country_dist.html