#!/bin/bash

#function tether(){
	# Downlink ethernet
	enp=`ip a | grep -oP "(enp[1-9]s[^ ]*)[0-9]"`
	echo "set $enp down"
	sudo ip link set dev $enp down

	# Connects to the latest usb device
	dev=`ip a | grep -oP "(usb|enp0s[^ ]*)[0-9]"`
	echo "listen on $dev"
	sudo dhcpcd $dev
	ping 8.8.8.8
#}
