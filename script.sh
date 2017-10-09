#!/bin/bash
apt update
apt upgrade -y

#nginx
apt install -y nginx

#php
add-apt-repository ppa:ondrej/php
apt update
apt install -y php5.6


