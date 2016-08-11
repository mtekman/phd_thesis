#!/bin/bash

files=`ls ../*.tex ../Sections/*.tex ../bibliography.bib ../Other/*.tex`

#echo $files


chars=" – ü “ ” ’ "

function find() {
	echo "$1"
	for f in $files; do
		grep --color -Hn "$1" $f
	done | sort | uniq -c | sort -nr
	echo ""
	echo ""
}


if [ $1 = "" ]; then
	for c in $chars; do
		find "$c"
	done
else
	find $1
fi
