FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get -y install curl
RUN apt-get -y install apache2
RUN apt-get -y install software-properties-common
RUN apt-get -y install git
RUN apt-get -y install zip

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get -y update

RUN apt-get -y install \
    git curl software-properties-common apache2 \
    php7.2 libapache2-mod-php7.2 \
    php7.2-mysql \
    php7.2-curl \
    php7.2-zip \
    php7.2-gd \
    php7.2-intl \
    php7.2-imap \
    php7.2-pspell \
    php7.2-recode \
    php7.2-sqlite3 \
    php7.2-tidy \
    php7.2-xmlrpc \
    php7.2-xsl \
    php7.2-mbstring \
    php7.2-dev \
    php7.2-gmp \
    php-memcache \
    php-imagick \
    php-pear

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get -y install nodejs

# Install yacron
RUN apt-get -y install python3-pip
RUN pip3 install yacron

VOLUME ["/var/www/html/", "/etc/httpd/", "/var/log/"]

RUN a2enmod rewrite expires

# Configure PHP
ADD files/php.ini /etc/php/7.2/apache2/conf.d/
ADD files/cli.ini /etc/php/7.2/cli/conf.d/

# Configure vhost
ADD files/default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80 443

WORKDIR /var/www/html

CMD apachectl -D FOREGROUND