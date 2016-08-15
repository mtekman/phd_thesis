#!/bin/bash

mp=../

res1=`find $mp -type f -name "*.aux"`
res2=`find $mp -type f -name "*.a*"`
res3=`find $mp -type f -name "*.*-gl*"`
res4=`find ../ -maxdepth 1 -type f -name "Main.*" -a ! -name "Main.tex" -a ! -name "Main.pdf"`

echo $res1 $res2 $res3 $res4 | tr " " "\n" |  sort | uniq
