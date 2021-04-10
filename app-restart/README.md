# Restart App Button
Should restart omx process in case it hunged up.

## Setup Python
Install python libs:
`sudo apt-get install python-rpi.gpio python3-rpi.gpio`

## Restart script
Copy `omx-warmstart.sh` and execute `chmod +x omx-warmstart.sh`.

Update the references to this script in `push_button.py`

## Setup systemd
Copy the pushButton.service to `/etc/systemd/system/pushButton.service`

and enable it via `sudo systemctl enable pushButton.service`

### Cheat Sheet:
Check if unit is active:  `sudo systemctl is-enabled pushButton.service`

Disable Service: `sudo systemctl disable pushButton.service`

Status Service: `sudo systemctl status pushButton.service`

Restart Service: `sudo systemctl restart pushButton.service`