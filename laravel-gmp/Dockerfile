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
    php7.3 libapache2-mod-php7.3 \
    php7.3-mysql \
    php7.3-curl \
    php7.3-zip \
    php7.3-gd \
    php7.3-intl \
    php7.3-imap \
    php7.3-pspell \
    php7.3-sqlite3 \
    php7.3-tidy \
    php7.3-xmlrpc \
    php7.3-xsl \
    php7.3-mbstring \
    php7.3-dev \
    php7.3-redis \
    php7.3-gmp \
    php-memcache \
    php-imagick \
    php-pear

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

# Configure PHP
ADD files/php.ini /etc/php/7.3/apache2/conf.d/
ADD files/cli.ini /etc/php/7.3/cli/conf.d/

# Configure vhost
ADD files/default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80 443

WORKDIR /var/www/html

CMD apachectl -D FOREGROUND
