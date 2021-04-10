# omx-foscam-startup
omx player script to start a stream from foscam surveillance camera on raspberry
I used this script to start omx player on startup of a raspberry.
The reason to use this player was that it can use raspberry´s hardware decoding capabilities.

## Check OS Version
Execute `cat /etc/os-release`.
Project was tested with raspian buster.

## Usage
Just replace Placeholders for username, password, ip and port in the `omx.sh` file.
May you have to escape special charaters like ! to %21 or & to %26

Then add it to the init system of your choice.
60 seconds timeout is to give time for network initialization.
For further details how to use omx player see [omx usage](https://elinux.org/Omxplayer#Usage)

## Register init.d
Copy `omx-init` to `/etc/init.d` and `chmod +x /etc/init.d/omx-init`

Test with `etc/init.d/omx-init start`

Register `update-rc.d omx-init defaults`

## Set Display Blank Timeout
It toke a while to find the right place, to set display settings on start up.

Place the `display.sh` on the Raspberry and execute `chmod +x display.sh`

Add `@lxterminal -e /home/pi/omx/display.sh` to `~/.config/lxsession/LXDE-pi/autostart`

### What to do if  '~/.config/lxsession' doesn't exists
Simply copy it from `/etc/xdg/lxsession` via `cp -r /etc/xdg/lxsession ~/.config/lxsession`