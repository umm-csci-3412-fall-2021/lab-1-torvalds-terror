#!/usr/bin/bash

#Takes a directory as a command line input
dir=$1

#Gets the usernames from the failed_login_data.txt file and puts them all in a temporary file
for FILE in "$dir"/*/var/log/*; do 
    awk 'match($0, /[a-zA-Z]+ [0-9 ]+([a-zA-Z0-9]+)+[ 0-9.]+/, groups) {print groups[1]}' < failed_login_data.txt >> tmpUsername.txt
done

#Sorts the temp file of usernames for uniq
sort "$dir"/tmpUsername.txt

#Counts the occurences of each username and passes that to awk, which grabs the number of occurrences and username and prints them in a data.addRow line in another temp file
uniq c tmpUsername.txt | awk 'match($0, /([0-9]+) ([a-zA-Z0-9_]+)/, groups) {print "data.addRow([\x27groups[2]\x27, groups[1]]);}' >> tmpAddRows.txt

#Calls wrap contents on the temp file just created and passes the necessary html components
bin/wrap_contents.sh html_components/username_dist tmpAddRows.txt html_components/username_dist