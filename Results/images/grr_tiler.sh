#!/bin/bash


base="grr*.png"
outdir=grr_images

mkdir -p $outdir

names=( "01:Base" "02:Ungenotyped Father" "03:Indiv 16 and 13" "04:Indiv 12 and 19" "05:Indiv 18 and 15" "06:Indiv 16 only" "07:Indiv 13 only" "08:Indiv 16 out" "09:New Genotyped Mother for 16" "10:New Genotyped Father for 16" ) 

counter=0

list=""

for f in 117_FSGS_{run1,run2,scenario1_16+13,scenario1_12+19,scenario3,scenario4,scenario5,zrun3,zrun4_newmother,zrun4_newfath}*; do
    dir=$f
    file=`find $dir -type f -name "$base"`

    disp_name=${names[$counter]}
    counter=$(( $counter + 1 ))
    
    impor=`echo $disp_name | sed 's/+/_/g' | sed 's/:/_/g' | sed 's/ /_/g'`

    outname=$outdir/$impor

    convert -crop 480x350+35+65 $file $outname.tmp.png
    composite -pointsize 15 label:"$disp_name" -geometry +40+20 -gravity northwest -colorspace Transparent $outname.tmp.png $outname.png

    rm $outname.tmp.png

    echo -e $dir"\n"$file"-->"$outname
#    gpicview $outname.png
#    exit 0
    
    list=$list" $outname.png"
done


montage -geometry 2000x -tile 2x5 $list $outdir/117_montage.png
