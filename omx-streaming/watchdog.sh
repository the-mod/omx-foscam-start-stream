#!/bin/bash

process=$(ps axf | grep omx | grep -v grep | awk '{print $1}')

if [ -z "$process" ]
then
 echo "No omx process running, restarting omx"
 # call service
 omx restart
fi