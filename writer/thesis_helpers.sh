#!/bin/bash

getUSBDev(){
	lsblk | grep "29.9G" | tail -1 | grep -oP "s[a-z]{2}[0-9]"
}

repo=/nomansland/MAIN_REPOS/phd_thesis_mtekman/b_thesis/

mountUSB(){
	usbdev=$(getUSBDev)
	echo "mount $usbdev --> /mnt"

	sudo mount /dev/$usbdev /mnt
}

unmountUSB(){
	usbdev=$(getUSBDev)
	echo "unmount $usbdev"
	sudo umount /dev/$usbdev
}

linkData(){
	# usb must be mounted
	ln -s /mnt/data $repo/data
	echo "linked to $repo/data"
}

getLatestDate(){
	ls /mnt | sort -n | tail -1
}

goLatestSection(){
	cd /mnt/$(getLatestDate)/b_thesis/
}



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
	incr=$( echo $folder | awk '{print $2}' )

	latest_folder=$(echo $folder | awk '{print $1}')

	[ $incr -gt 1 ] && latest_folder=$latest_folder"_"$(echo $folder | awk '{print $2}')

	rsync -avPu --exclude git $latest_folder/* $repo
}

startThesis(){
	mountUSB
	thesis_sync
	linkData
#	goLatestSection
}

