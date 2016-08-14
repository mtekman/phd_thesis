#!/bin/bash

gs -o - -sDEVICE=inkcov ../../Main.pdf > cmyk_per_page.txt 
cat cmyk_per_page.txt\
 | tr "\n" "  "\
 | sed 's/Page/\nPage/g'\
 | grep -v "GPL"\
 > cmyk_per_page.2.txt
