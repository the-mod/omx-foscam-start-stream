# Restart App Button
Should restart omx process in case it hunged up.

## Setup Python
Install python libs:
`sudo apt-get install python-rpi.gpio python3-rpi.gpio`

## Setup systemd
Copy the push_button.service to `/etc/systemd/system`
`sudo systemctl enable push_button.service`

### Cheat Sheet:
Check if unit is active: `sudo systemctl is-enabled push_button.service`
Disable Service: `sudo systemctl disable push_button.service`
Restart Service: `sudo systemctl restart push_button.service`