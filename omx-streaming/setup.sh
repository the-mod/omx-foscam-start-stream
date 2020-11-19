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
   echo "copying omx-init to /etc/init.d/omx-init"
   cp omx-init /etc/init.d/omx-init
   chmod 775 /etc/init.d/omx-init
   update-rc.d /etc/init.d/omx-init defaults
else
   echo "skipping autostart"
fi

sleep 2;
####################################
#
#
# Adding Watcher Script
#
#
####################################
echo "Watch omx process via Crontab? (y|n):"
read SHOULD_WATCH

if [ "$SHOULD_WATCH" = "y" ]; then
   chmod 775 watchdog.sh
   crontab -l > mycron
   cat watchdog.crontab >> mycron
   crontab mycron
   rm mycron
   echo "added content of 'watchdog-crontab.sh' to '/etc/crontab'"
   sleep 2;
else
   echo "skipping watching"
fi

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

sleep 2;
echo "Done :-)"