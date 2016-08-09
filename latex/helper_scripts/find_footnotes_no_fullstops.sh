#!/bin/bash

files=`ls ../Main.tex ../Sections/*.tex ../bibliography.bib`

for f in $files; do
#	grep -HnoP '\\footnote{({[^}]+})*[^{}]*}' $f | grep -vP "\.}$"
	grep -HnoP '\\footnote{(({[^}]+})*)([^{}]*)}' $f 
done | sort | uniq -c | sort -nr

#echo $files
