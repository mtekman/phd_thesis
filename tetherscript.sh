#!/bin/bash

function tether(){
	# Connects to the latest usb device
	dev=`ip a | grep -oP "(usb|enp0s[^ ]*)[0-9]"`
	sudo dhcpcd $dev
	ping 8.8.8.8
}
