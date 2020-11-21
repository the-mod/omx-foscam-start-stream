# omx-foscam-startup
omx player script to start a stream from foscam surveillance camera on raspberry
I used this script to start omx player on startup of a raspberry.
The reason to use this player was that it can use raspberry´s hardware decoding capabilities.

## Check OS Version
Execute `cat /etc/os-release`.
Project was tested with raspian buster.

## Usage
Just replace Placeholders for username, password, ip and port in the `omx.sh` file.

Then add it to the init system of your choice.
60 seconds timeout is to give time for network initialization.
For further details how to use omx player see [omx usage](https://elinux.org/Omxplayer#Usage)


## Set Display Blank Timeout
It toke a while to find the right place, to set display settings on start up.
Add this to `~/.config/lxsession/LXDE-pi/autostart`
`@lxterminal -e /home/pi/omx/display.sh`

### What to do if  '~/.config/lxsession' doesn't exists
Simply copy it from `/etc/xdg/lxsession`
`cp -r /etc/xdg/lxsession ~/.config/lxsession`