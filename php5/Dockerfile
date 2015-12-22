FROM php:5-fpm

# install extensions
COPY install.sh /tmp/install.sh
RUN sh /tmp/install.sh

# add improved fpm config (socket + more children)
COPY php-fpm.conf /usr/local/etc/

# prepare socket dir
RUN mkdir /run/php/ && \
    chown www-data:www-data /run/php

# set volumes
VOLUME ["/run/php", "/srv/www"]
