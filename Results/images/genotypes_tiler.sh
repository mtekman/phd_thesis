#!/bin/bash


base="genotypes*.pdf"
outdir=genotype_images

mkdir -p $outdir

names=( "01:Base" "02:Ungenotyped Father" "03:Indiv 16 and 13" "04:Indiv 12 and 19" "05:Indiv 18 and 15" "06:Indiv 16 only" "07:Indiv 13 only" "08:Indiv 16 out" "09:New Genotyped Mother for 16" "10:New Genotyped Father for 16" ) 

counter=0

list=""

for f in 117_FSGS_{run1,run2,scenario1_16+13,scenario1_12+19,scenario3,scenario4,scenario5,zrun3,zrun4_newmother,zrun4_newfath}*; do
    dir=$f
    file=`find $dir -type f -name "$base"`
    #	impor=`echo $dir\
    # | grep -oP "(?<=(117_FSGS_))([a-z_0-9+]+)"\
    # | sed 's/+/_/g'`

    disp_name=${names[$counter]}
    counter=$(( $counter + 1 ))
    
    impor=`echo $disp_name | sed 's/+/_/g' | sed 's/:/_/g' | sed 's/ /_/g'`

    
    outname=$outdir/`basename $file .pdf`"_$impor"

    if ! :; then
	convert -colorspace CMYK $file -trim $outname.tmp1.png
	composite -pointsize 20 label:"$disp_name" -geometry +60+40 -gravity northwest $outname.tmp1.png $outname.png

	rm $outname.tmp1.png
    fi

    echo -e $dir"\n"$file"-->"$outname
    #	exit 0
    list=$list" $outname.png"
done


montage -geometry 2000x -tile 2x5 $list $outdir/117_montage.png
