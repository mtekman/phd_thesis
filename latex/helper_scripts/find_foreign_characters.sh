#!/bin/bash

files=`ls ../Main.tex ../Sections/*.tex ../bibliography.bib`

char=$1

# – ü “ ” ’

for f in $files; do
	grep --color -Hn "$1" $f
done | sort | uniq -c | sort -nr

#echo $files
