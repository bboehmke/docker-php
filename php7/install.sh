#!/bin/bash

set -e
set -x

# update packet database
export DEBIAN_FRONTEND=noninteractive
apt-get update

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# gd
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies and runtime libs
apt-get -y install libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
                   libfreetype6     libjpeg62-turbo     libpng16-16

# create extension
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
docker-php-ext-install gd

# remove build dependencies
apt-get -y remove  libfreetype6-dev libjpeg62-turbo-dev libpng-dev


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# imap
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies and runtime libs
apt-get -y install libc-client2007e-dev libkrb5-dev \
                   libc-client2007e     libkrb5-3

# create extension
docker-php-ext-configure imap --with-kerberos --with-imap-ssl
docker-php-ext-install imap

# remove build dependencies
apt-get -y remove  libc-client2007e-dev libkrb5-dev


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# intl
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies and runtime libs
apt-get -y install libicu-dev \
                   libicu57

# create extension
docker-php-ext-install intl

# remove build dependencies
apt-get -y remove  libicu-dev


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# ldap
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies
apt-get -y install libldap2-dev

# create extension
docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
docker-php-ext-install ldap

# remove build dependencies
apt-get -y remove  libldap2-dev


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# mysqli
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies and runtime libs
#apt-get -y install 

# create extension
docker-php-ext-install mysqli

# remove build dependencies
#apt-get -y remove  


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# pdo_mysql
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies and runtime libs
#apt-get -y install

# create extension
docker-php-ext-install pdo_mysql

# remove build dependencies
#apt-get -y remove  


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# mbstring
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies and runtime libs
#apt-get -y install

# create extension
docker-php-ext-install mbstring

# remove build dependencies
#apt-get -y remove  


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# pcntl
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies and runtime libs
#apt-get -y install

# create extension
docker-php-ext-install pcntl

# remove build dependencies
#apt-get -y remove  


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# zip
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies
apt-get -y install zlib1g-dev

# create extension
docker-php-ext-install zip

# remove build dependencies
apt-get -y remove  zlib1g-dev


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# redis (from git)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# install build dependencies/tools
apt-get -y install git

cd /tmp

# get source
git clone https://github.com/phpredis/phpredis.git
cd phpredis

# build extension
phpize
./configure
make && make install

# enable extension
docker-php-ext-enable redis

# cleanup
cd /tmp
rm -r /tmp/phpredis

# remove build dependencies/tools
apt-get -y remove git  


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# cleanup
apt-get -y autoremove
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
