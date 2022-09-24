FROM node:10-alpine

ENV VS_ENV prod

WORKDIR /var/www

RUN apk add --no-cache curl git

RUN apk add --no-cache --virtual .build-deps ca-certificates wget python make g++
RUN apk del .build-deps

COPY files/vue-storefront.sh /usr/local/bin/
COPY files/vue-storefront-api.sh /usr/local/bin/