#!/bin/bash

function pdf2img(){
	[ $# != 2 ] && echo "src and dest required" && return -1
	convert -density 100 $1 -trim $2
}

export -f pdf2img
