#!/bin/bash

# Run this as root!

apt-get install mysql-server mysql-client wordpress python-certbot-apache fail2ban libapache2-modsecurity -y

ln -s /usr/share/wordpress /var/www/wordpress
rm /etc/apache2/sites-enabled/000-default.conf

cp ./001-wordpress.conf /etc/apache2/sites-available/
ln -s /etc/apache2/sites-available/001-wordpress.conf /etc/apache2/sites-enabled/001-wordpress.conf
apachectl configtest

gzip -d /usr/share/doc/wordpress/examples/setup-mysql.gz
/usr/share/doc/wordpress/examples/setup-mysql -n wordpress_lp wp.luke.plaus.in
chown -R www-data /usr/share/wordpress

systemctl enable apache2
systemctl restart apache2

sudo certbot --authenticator webroot --installer apache

# Security
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
