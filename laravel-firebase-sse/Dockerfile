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
    php7.4 libapache2-mod-php7.4 \
    php7.4-mysql \
    php7.4-curl \
    php7.4-zip \
    php7.4-gd \
    php7.4-intl \
    php7.4-imap \
    php7.4-pspell \
    php7.4-sqlite3 \
    php7.4-tidy \
    php7.4-xmlrpc \
    php7.4-xsl \
    php7.4-mbstring \
    php7.4-dev \
    php7.4-redis \
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

RUN apt-get -y install wget
RUN wget -O - http://aptget.chilkat.io/chilkat.gpg.key | apt-key add -
RUN add-apt-repository "deb http://aptget.chilkat.io/repos chilkat main"
RUN apt-get -y update
RUN apt-get -y install php7.4-chilkat

# Configure PHP
ADD files/php.ini /etc/php/7.4/apache2/conf.d/
ADD files/cli.ini /etc/php/7.4/cli/conf.d/

RUN cp /usr/share/php/20190902/chilkat_9_5_0.php /usr/share/php

# Configure vhost
ADD files/default.conf /etc/apache2/sites-enabled/000-default.conf

EXPOSE 80 443

WORKDIR /var/www/html

CMD apachectl -D FOREGROUND
