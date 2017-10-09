#!/bin/bash
apt update
apt upgrade -y

#nginx
apt install -y nginx

#php
add-apt-repository ppa:ondrej/php
apt update
apt install -y php5.6

#mysql
apt install -y mysql-client mysql-server phpmyadmin

#nginx-php connect
apt install -y php5.6-fpm
#config files fix~~~~
#service reboot
service nginx restart
nginx -t


