#!/bin/bash

# Run this as root!

# This script sets up the user on the first boot.
# Remember to put the 'ssh' file on the boot partition to enable ssh.

username="luke"
homedir="/home"

# Create a new user
mkdir $homedir/$username
groups=$(groups pi | cut -f 2 -d ":" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e "s/ /,/g")
useradd -s /bin/bash -G $groups -d $homedir/$username $username
chown $username:$username $homedir/$username

# Add SSH key, change permissions on folders
mkdir $homedir/$username/.ssh
cp ./authorized_keys $homedir/$username/.ssh/authorized_keys
chown $username:$username $homedir/$username/
chmod 644 $homedir/$username/.ssh/authorized_keys

# Add new user to sudoers
echo "$username ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/010_$username-nopasswd
chmod 440 /etc/sudoers.d/010_$username-nopasswd

