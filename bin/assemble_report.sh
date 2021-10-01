#!/usr/bin/bash

cur_dir=$(pwd)

#Store the input directory
dir=$1

cd "$dir" || exit

#Concatenate the country, hour, and username distribution data into one "summary" file
cat country_dist.html hours_dist.html username_dist.html > summary.html

cd "$cur_dir" || exit

#Execute the wrap_contents script and give it the summary file, the summary_plot header and footer, and write it in the input directory to failed_login_summary.html
./bin/wrap_contents.sh "$dir"/summary.html html_components/summary_plots "$dir"/failed_login_summary.html