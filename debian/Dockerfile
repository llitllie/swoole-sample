ARG PHP_TAG="7.2-cli"

FROM php:$PHP_TAG

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apt-get update && apt-get install -y libssl-dev libffi-dev \
    && docker-php-ext-install sockets \
    && docker-php-source extract \
    && printf "yes\nyes\nno\nyesnno\n" | pecl install swoole \
    && docker-php-ext-enable swoole \
    && docker-php-source delete \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt autoremove && apt clean \
    && rm -rf /tmp/* 
