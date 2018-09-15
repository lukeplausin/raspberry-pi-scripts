#!/bin/bash

# Run this as root!

# This script sets up the user on the first boot.
# Remember to put the 'ssh' file on the boot partition to enable ssh.

username="luke"
homedir="/home"

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

