FROM php:7.3-fpm-alpine3.8

# Install packages
RUN apk --no-cache add libzip-dev zip freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev

# Install php extensions
RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install -j$(nproc) mysqli
RUN docker-php-ext-install -j$(nproc) zip
RUN docker-php-ext-install -j$(nproc) bcmath
RUN docker-php-ext-install -j$(nproc) pdo
RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd
#RUN docker-php-ext-install -j$(nproc) curl

# Add mariadb client
RUN apk --no-cache add mariadb-client

# Add user commands and user group
RUN apk --no-cache add shadow && \
    usermod -u 1001 www-data && \
    groupmod -g 1001 www-data

# Copy config files
COPY ./.config/php.ini /usr/local/etc/php/php.ini

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/composer

# Install WP-Cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
        && chmod +x wp-cli.phar \
        && mv wp-cli.phar /usr/local/bin/wp