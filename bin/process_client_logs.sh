#!/usr/bin/bash

#Script takes a directory as input
dir=$1

#Enter given directory
cd "$dir" || exit

#Create a file for the failed logins
touch failed_login_data.txt

#Run awk regex check and print on all files in the given directory
for FILE in *; do 
    awk 'match($0, /([a-zA-Z 0-9 0-9]+):[0-9]+:[0-9]+ [a-zA-Z_]+ sshd\[[0-9]+\]: Failed password for invalid user ([a-zA-Z0-9]+) from ([0-9.0-9.0-9.0-9]+) port [0-9]+ ssh2/, groups) {print groups[1] groups[2] groups[3] "\n"}' < "$FILE" > failed_login_data.txt
done

#Run awk regex check and print on all files in the given directory
for FILE in *; do 
    awk 'match($0, /([a-zA-Z 0-9 0-9]+):[0-9]+:[0-9]+ [a-zA-Z_]+ sshd\[[0-9]+\]: Failed password for ([a-zA-Z0-9]+) from ([0-9.0-9.0-9.0-9]+) port [0-9]+ ssh2/, groups) {print groups[1] groups[2] groups[3] "\n"}' < "$FILE" > failed_login_data.txt
done