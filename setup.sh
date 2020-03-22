#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Initial Setup for OMX Streaming...";

sleep 2;

####################################
#
#
# Setting up Wifi
#
#
####################################
echo "Setting up Wifi..."

echo "Enter SSID:";
read SSID;

echo "Enter WIFI PSK:";
read WIFI_PASSWORD;

echo "Creating Entry at /etc/wpa_supplicant/wpa_supplicant.conf"
wpa_passphrase $SSID $WIFI_PASSWORD >> /etc/wpa_supplicant/wpa_supplicant.conf


sleep 2;
####################################
#
#
# Setting up Display
# 'lcd_rotate' works only for raspberry Pi 7" display
# otherwise use display_hdmi_rotate
#
#
####################################
echo "Setting up Display 7\" Display..";

echo "Display Timeout in seconds:";
read TIMEOUT;

echo "Set Display Standby to $TIMEOUT seconds"
export DISPLAY=:0
xset s $TIMEOUT

echo "Rotate Display 180 degress? (y|n):"
read SHOULD_ROTATE

if [ "$SHOULD_ROTATE" = "y" ]; then
   echo "lcd_rotate=2 >> /boot/config.txt"
   "# rotate display 180 degrees clockwise" >> /boot/config.txt
   "lcd_rotate=2" >> /boot/config.txt
else
   echo "skipping rotate display"
fi

sleep 2;
####################################
#
#
# Setting Startup
#
#
####################################
echo "Start omx player on System Startup? (y|n):"
read SHOULD_AUTOSTART

if [ "$SHOULD_AUTOSTART" = "y" ]; then
   echo "copying omx.service to /etc/init.d/omx.service"
   cp omx.service /etc/init.d/omx.service
   chmod 775 /etc/init.d/omx.service
   update-rc.d /etc/init.d/omx.service defaults
else
   echo "skipping rotate display"
fi

sleep 2;
####################################
#
#
# Restart to apply changes
#
#
####################################
echo "Restart to apply changes? (y|n):"
read SHOULD_RESTART

if [ "$SHOULD_RESTART" = "y" ]; then
   echo "restarting..."
   sleep 2;
   shutdown -r now
else
   echo "staying up and running (changes may not apply)"
fi

echo "Done :-)"