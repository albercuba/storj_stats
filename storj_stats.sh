#!/bin/bash

function egress {
	satellites=$(curl -s 127.0.0.1:14002/api/dashboard | jq -r ".data.satellites[].id")
	
	egress_usage=0
	for satellite in $satellites
	do
		bandwidth_days=$(curl -s 127.0.0.1:14002/api/satellite/$satellite | jq ".data.bandwidthDaily[].egress.usage")
	
		for bandwidthDaily in $bandwidth_days
		do
			egress_usage=$((egress_usage+bandwidthDaily))
		done
	done

	echo $egress_usage
}

function ingress {
	satellites=$(curl -s 127.0.0.1:14002/api/dashboard | jq -r ".data.satellites[].id")

	ingress_usage=0
	for satellite in $satellites
	do
		bandwidth_days=$(curl -s 127.0.0.1:14002/api/satellite/$satellite | jq ".data.bandwidthDaily[].ingress.usage")
	
		for bandwidthDaily in $bandwidth_days
		do
			ingress_usage=$((ingress_usage+bandwidthDaily))
		done
	done
	
	echo $ingress_usage
}

function diskSpace_used {
	curl -s 127.0.0.1:14002/api/dashboard | jq ".data.diskSpace.used"
}

function upToDate {
	upToDate_string=$(curl -s 127.0.0.1:14002/api/dashboard | jq ".data.upToDate")
	
	if [ $upToDate_string == "true" ]; then echo "1"; else echo "0"; fi
}

case "$1" in
	egress) 	egress;;
	ingress) 	ingress;;
	disk)		diskSpace_used;;
	upToDate)	upToDate;;
esac
