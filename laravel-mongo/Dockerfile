FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get -y install curl
RUN apt-get -y install apache2
RUN apt-get -y install software-properties-common
RUN apt-get -y install git
RUN apt-get -y install zip
RUN apt-get -y install vim

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get -y update

RUN apt-get -y install php8.0 libapache2-mod-php8.0

RUN apt-get -y update

RUN apt-get -y install php8.0-fpm libapache2-mod-fcgid

RUN apt-get -y install php8.0-mysql \
    php8.0-curl \
    php8.0-zip \
    php8.0-gd \
    php8.0-intl \
    php8.0-imap \
    php8.0-pspell \
    php8.0-sqlite3 \
    php8.0-tidy \
    php8.0-xsl \
    php8.0-mbstring \
    php8.0-dev \
    php8.0-redis \
    php-memcache \
    php-imagick \
    php-pear

# Install the mongodb extension
RUN pecl install mongodb

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get -y install nodejs

# Install yacron
RUN apt-get -y install python3-pip
RUN pip3 install yacron

VOLUME ["/var/www/html/", "/etc/httpd/", "/var/log/"]

RUN a2enmod rewrite expires
RUN a2enmod proxy_fcgi setenvif
RUN a2enconf php8.0-fpm

# Configure PHP
ADD files/php.ini /etc/php/8.0/apache2/conf.d/
ADD files/cli.ini /etc/php/8.0/cli/conf.d/

# Configure vhost
ADD files/default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80 443

WORKDIR /var/www/html

CMD apachectl -D FOREGROUND
