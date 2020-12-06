#!/bin/bash

#check if online, if yes start process and check every 5 seconds if it is running
#ping -q -w 1 -c 1 `/sbin/ip r | grep default | cut -d ' ' -f 3` > /dev/null && echo ok || echo error

while :;
do
	default_gw=$(/sbin/ip r | grep default | cut -d ' ' -f 3)
	echo "Found Gateway: $default_gw"

# TODO: check if default_gw is empty
	if [ -z "$default_gw" ]
	then
		echo "No Gateway found"
	else
		# pinging gateway
		ping_result=$(ping -q -w 1 -c 1 $default_gw > /dev/null && echo ok || echo not_ok)
		echo "Ping Check was: $ping_result"

		if [[ "$ping_result" == "ok" ]]
		then
			process=$(ps axf | grep /usr/bin/omxplayer | grep -v grep | awk '{print $1}')
		
			if [ -z "$process" ]
			then
				echo "No omx process found, starting omx..."
				nohup python omx-warmstart.sh &>/dev/null &
				echo "Process started"
			fi
			sleep 5
		fi
	fi
done
