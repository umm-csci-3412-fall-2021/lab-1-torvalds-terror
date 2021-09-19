#!/usr/bin/bash

#Store the input directory
DIR=$1

#Concatenate the country, hour, and username distribution data into one "summary" file
cat "$DIR"/country_dist.html "$DIR"/hours_dist.html "$DIR"/username_dist.html > "summary.html"

#Execute the wrap_contents script and give it the summary file, the summary_plot header and footer, and write it in the input directory to failed_login_summary.html
/bin/bash "$(dirname "$0")/wrap_contents.sh"  summary.html summary_plots "$DIR"/failed_login_summary.html