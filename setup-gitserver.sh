#!/bin/bash



adduser git --home /home/git --disabled-password --quiet
cp -r /home/luke/.ssh /home/git/.ssh
chown git:git /home/git/.ssh

mkdir /srv/git


