#!/bin/bash

getUSBDev(){
	lsblk | grep "29.9G" | tail -1 | grep -oP "s[db]{2}[0-9]"
}

repo=/nomansland/MAIN_REPOS/phd_thesis_mtekman/b_thesis/
point=""

mountUSB(){
	usbdev=$(getUSBDev)
	point="/mnt"
	echo "mount $usbdev --> $point"

	sudo mount /dev/$usbdev $point
}
export -f mountUSB

unmountUSB(){
	usbdev=$(getUSBDev)
	echo "unmount $usbdev"
	sudo umount $usbdev
}
export -f unmountUSB

linkData(){
	# usb must be mounted
	ln -s $point/data $repo/data
	echo "linked to $repo/data"
}
export -f linkData

getLatestDate(){
	ls $point | sort -n | tail -1
}
export -f getLatestData

goLatestSection(){
	cd /mnt/$(getLatestData)/b_thesis/
}
export -f goLatestSection



latest_backup() {
	date_set=`date +%Y_%m_%d`
	date_fold=$date_set
	incr=1

	while [ -e /mnt/$date_fold ]; do
		date_fold=$date_set"_$incr"
		incr=$(( $incr + 1 ))
	done

	echo "/mnt/$date_set" "$(( $incr - 1 ))"
}


thesis_backup(){
	folder=$( latest_backup )
	new_folder=$(echo $folder | awk '{print $1}')"_"$(( $(echo $folder | awk '{print $2}') + 1 ))

	mkdir -p $new_folder
	rsync -avP --exclude .git $repo $new_folder
}

thesis_sync(){
	folder=$( latest_backup )
	latest_folder=$(echo $folder | awk '{print $1}')"_"$(echo $folder | awk '{print $2}')

	rsync -avPu --exclude git $latest_folder $repo
}

export -f thesis_backup

# Start
mountUSB
thesis_sync
linkData
goLatestSection

