#!/usr/bin/bash

#Takes a directory as a command line input
dir=$1

cur_dir=$(pwd)

#Peek into the directory
cd "$dir" || exit

#Gets the usernames from the failed_login_data.txt file, sorts them, gets the frequency of their occurrences, and puts that in a temp file
cat ./*/failed_login_data.txt | awk 'match($0, /[a-zA-Z]+ [0-9 ]+([a-zA-Z0-9_-]+)+[ 0-9.]+/, groups) {print groups[1]}' | sort | uniq -c | awk 'match($0, /([0-9]+) ([a-zA-Z0-9_]+)/, groups) {print "data.addRow([\x27"groups[2]"\x27, "groups[1]"]);"}' >> tmpAddRows.txt

#Back it up a step
cd "$cur_dir" || exit

#Calls wrap contents on the temp file just created and passes the necessary html component
./bin/wrap_contents.sh "$dir"/tmpAddRows.txt html_components/username_dist "$dir"/username_dist.html