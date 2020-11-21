# Restart App Button
Should restart omx process in case it hunged up.

## Setup Python
Install python libs:
`sudo apt-get install python-rpi.gpio python3-rpi.gpio`

## Setup systemd
Copy the push_button.service to `/etc/systemd/system/pushButton.service`
`sudo systemctl enable pushButton.service`

### Cheat Sheet:
Check if unit is active:  `sudo systemctl is-enabled push_button.service`
Disable Service: `sudo systemctl disable pushButton.service`
Status Service: `sudo systemctl status pushButton.service`
Restart Service: `sudo systemctl restart pushButton.service`