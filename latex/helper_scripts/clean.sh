#!/bin/bash

mp=../

res1=`find $mp -type f -name "*.aux"`
res2=`find $mp -type f -name "*.a*"`
res3=`find $mp -type f -name "*.*-gl*"`

echo $res1 $res2 $res3 | tr " " "\n"
