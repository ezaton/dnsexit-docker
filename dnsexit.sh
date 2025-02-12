#!/bin/bash

IPFILE=/dev/shm/MYIP
[ -f ${IPFILE} ] && MYIP=$( cat ${IPFILE} ) || MYIP="None"

function updateIP() {
	[ -n "${APIKEY_FILE}" ] && APIKEY=$( cat ${APIKEY_FILE} )
	#RESULT=$(curl -s "https://www.dnsexit.com/RemoteUpdate.sv?login=${LOGIN}&password=${PASSWORD}&host=${HOST}")
	curl -s -k https://api.dnsexit.com/dns/ud/?apikey=${APIKEY} -d host=${HOST}
	RESULT=$?
	echo "result is $RESULT"
	if [ $RESULT -eq 0 ]; then
		MYIP=${IP}
		echo ${MYIP} > ${IPFILE}
	fi
}

function checkIP() {
	IP=$(curl -s "https://api.ipify.org")
	IP=$(echo $IP)

	if [ "$IP" != "$MYIP" ]; then
		echo "IP has changed from '$MYIP' to '$IP'";
		updateIP $IP
	else
		echo "IP is still '$MYIP'";
	fi
	echo "Waiting ${INTERVAL}..."
	sleep ${INTERVAL}
}

while true; do
	checkIP;
done;

