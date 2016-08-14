#!/bin/bash

gs -o - -sDEVICE=inkcov ../../Main.pdf | tee cmyk_per_page.txt
