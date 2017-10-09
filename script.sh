#!/bin/bash
sudo -s
apt update
apt upgrade -y

#nginx
apt install -y nginx

#nginx default fix -> vi /etc/nginx/sites-available/default

#php
add-apt-repository ppa:ondrej/php
apt update
apt upgrade
apt install -y php5.6

#nginx-php connect
apt install -y php5.6-fpm

#mysql
apt install -y mysql-client mysql-server phpmyadmin


#config files fix~~~~
#service reboot
service nginx restart
nginx -t

# phpmyadmin connect
# make symbolic link to Webroot(/asdf)
# ln -s /usr/share/phpmyadmin /asdf

#mysql install for phpmyadmin 
apt install -y php5.6-mysql

# install php-mbstring for phpmyadmin
apt install -y php5.6-mbstring


#enter /phpmyadmin

