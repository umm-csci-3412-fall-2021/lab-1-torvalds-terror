#!/usr/bin/bash

toWrap=$1
specifier=$2
result=$3

#Concat specifier with header and footer extensions
specFooter="${specifier}_footer.html"
specHeader="${specifier}_header.html"

#Concatenate files in the desired resulting file.
cat "$specHeader" "$toWrap" "$specFooter" >"$result"