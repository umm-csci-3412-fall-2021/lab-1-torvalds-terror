#!/usr/bin/bash

#Script takes a directory as input
dir=$1

#Enter given directory
cd "$dir" || exit

#Run awk regex check and print on all files in the given directory
for FILE in var/log/*; do 
    awk 'match($0, /([a-zA-Z]+)[ ]+([0-9]+) ([0-9]+):[0-9]+:[0-9]+ [a-zA-Z_]+ sshd\[[0-9]+\]: Failed password for (|invalid user {1,})([a-zA-Z0-9_-]+) from ([0-9.]+)/, groups) {print groups[1]  groups[2] " " groups[3] " " groups[5] " " groups[6]}' < "$FILE" >> failed_login_data.txt
done