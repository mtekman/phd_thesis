#!/bin/bash

files=`ls ../Main.tex ../Sections/*.tex`

for f in $files; do
	file_and_match=`grep -oP "[A-Z.]{2,}[0-9]*" $f`
#	file=$( echo $file_and_match | awk -F':' '{print $1}'  )
#	match=$(echo $file_and_match | awk -F':' '{print $NF}' )

	echo "$file_and_match"

done | sort | uniq -c | sort -nr

#echo $files
