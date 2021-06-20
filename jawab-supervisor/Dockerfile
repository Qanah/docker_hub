FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get -y install curl
RUN apt-get -y install software-properties-common
RUN apt-get -y install git
RUN apt-get -y install zip
RUN apt-get -y install vim

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get -y update

RUN apt-get -y install \
    php7.1 \
    php7.1-mysql \
    php7.1-curl \
    php7.1-zip \
    php7.1-gd \
    php7.1-intl \
    php7.1-imap \
    php7.1-pspell \
    php7.1-sqlite3 \
    php7.1-tidy \
    php7.1-xmlrpc \
    php7.1-xsl \
    php7.1-mbstring \
    php7.1-dev \
    php7.1-redis \
    php-memcache \
    php-imagick \
    php-pear

# Install the mongodb extension
RUN pecl install mongodb

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install supervisor
RUN apt-get -y install supervisor

WORKDIR /var/www/html

ADD files/cli.ini /etc/php/7.1/cli/conf.d/
ADD files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
