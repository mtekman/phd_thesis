#!/bin/bash

gs -o - -sDEVICE=inkcov ../../mtekman_phd_thesis.v4.2016_08_15.printed.pdf | tee temp.txt
cat temp.txt\
 | tr "\n" "  "\
 | sed 's/Page/\nPage/g'\
 | grep -v "GPL"\
 > cmyk_per_page.txt

rm temp.txt
