./texcount.pl ../../Sections/*.tex ../../*.tex ../../Other/*.tex | grep "Words in text" | awk -F ":" '{s+=$2} END {print s}'
