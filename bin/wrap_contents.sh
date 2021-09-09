#!/usr/bin/bash

#The "contents" that need to be wrapped by html header/footer
contents=$1
#User's desired header and footer
headerFooterName=$2
#The user chosen name of the resulting file
outputFileName=$3

#Concatinate files together into the output file
cat "${headerFooterName}_header.html" "$contents" "${headerFooterName}_footer.html" > "$outputFileName"