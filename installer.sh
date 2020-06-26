#!/usr/bin/env sh

#sudo apt update
sudo apt install ssmtp

hostname=$(hostname | awk '{print $1}')
username="YOUR_EMAIL"
password="YOUR_PASSWORD"

printf "root=%s\nmailhub=smtp.gmail.com:465\nhostname=%s\nAuthUser=%s\nAuthPass=%s\nFromLineOverride=YES\nUseTLS=YES\n" "$username" "$hostname" "$username" "$password" | sudo tee /etc/ssmtp/ssmtp.conf

# cp the core
sudo cp ssh-notifier-daemon /usr/bin/

# cp the unit file
sudo cp ssh-notifier-daemon.service /etc/systemd/system/

sudo mkdir -p /var/log/ssh-notifier-daemon/logs

#start the service
sudo systemctl daemon-reload
sudo systemctl stop ssh-notifier-daemon.service
sudo systemctl start ssh-notifier-daemon.service
sudo systemctl status ssh-notifier-daemon.service

printf ""

exit 0
