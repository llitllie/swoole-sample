ARG PHP_TAG="7.2-cli-alpine3.9"

FROM php:$PHP_TAG

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN set -ex \
  	&& apk update \
    && apk add --no-cache --virtual .build-deps curl gcc g++ make build-base autoconf \
    && apk add libstdc++ openssl-dev libffi-dev \
    && docker-php-ext-install sockets \
    && docker-php-source extract \
    && printf "yes\nyes\nno\nyesnno\n" | pecl install swoole \
    && docker-php-ext-enable swoole \
    && docker-php-source delete \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apk del .build-deps \
    && rm -rf /tmp/* 

WORKDIR /usr/src/app
COPY . ./
EXPOSE 9501
CMD ["php", "test.php"]