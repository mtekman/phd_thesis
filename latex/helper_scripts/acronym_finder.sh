#!/bin/bash

for f in *.tex Sections/*.tex; do
	grep -oP "[A-Z]{2,}" $f | grep -Pv "(AA)|(BB)|(AB)";
done | sort | uniq


