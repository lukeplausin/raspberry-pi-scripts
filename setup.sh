#!/bin/bash

# Run this as root!

# This script sets up the user on the first boot.
# Remember to put the 'ssh' file on the boot partition to enable ssh.

username="luke"
homedir="/home"

DUCK_DOMAIN="lukeplausinpi"

# Update, enable SSH
apt-get update -y
systemctl enable ssh

# Update config
# TODO: Why does this lock me out of the SSH server? broken config...
# cp ./sshd.conf /etc/ssh/sshd_config -f
# service sshd restart

# Install packages
sudo apt-get install vim -y

# Run RPI config
# raspi-config

# Setup duck DNS
echo "DUCK_TOKEN=$DUCK_TOKEN"
mkdir /var/log/duckdns/
echo '#!/bin/bash' > /usr/local/bin/duckdns
echo "echo url=\"https://www.duckdns.org/update?domains=$DUCK_DOMAIN&token=$DUCK_TOKEN&ip=\" | curl -s -k -o /var/log/duckdns/duck.log -K -" >> /usr/local/bin/duckdns
chmod 700 /usr/local/bin/duckdns
crontab -l > mycron
echo "0 * * * * /usr/local/bin/duckdns >/dev/null 2>&1" >> mycron
crontab mycron
rm mycron
