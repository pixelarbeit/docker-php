FROM pxlrbt/php:8

RUN apk --no-cache add supervisor

ENV PHPREDIS_VERSION 5.3.2
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis

ENV DOCUMENT_ROOT /var/www/html/

COPY entrypoint.sh /entrypoint.sh
COPY artisan-schedule.sh /usr/local/bin/artisan-schedule.sh
RUN chmod +x /entrypoint.sh /usr/local/bin/artisan-schedule.sh

COPY .config/supervisord.conf /etc/supervisord.conf
RUN echo "* * * * * /usr/local/bin/artisan-schedule.sh" >> /etc/crontabs/root

ENTRYPOINT [ "/entrypoint.sh" ]
