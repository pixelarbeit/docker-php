FROM php:7-fpm-alpine

# Install dependencies
RUN apk --no-cache update \
    && apk --no-cache upgrade \
    && apk --no-cache add \
        # PHP Extension Requirements
        libwebp-dev libpng-dev libjpeg-turbo-dev freetype-dev \
        # imagemagick-dev zlib-dev
        libzip-dev  curl-dev \
        libxml2-dev bzip2-dev postgresql-dev \
        # Usability
        shadow \
        # Dev Tools
        mariadb-client nodejs npm yarn git zip

# Configure Install php extensions
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install bcmath bz2 curl exif gd intl mysqli opcache pcntl pdo pdo_mysql pdo_pgsql sockets xml zip

# Add user commands and user group
RUN usermod -u 1001 www-data  \
    && groupmod -g 1001 www-data

# Copy config files
COPY ./.config/php.ini /usr/local/etc/php/php.ini

# Install composer
COPY ./install-composer.sh /install-composer.sh
RUN chmod +x /install-composer.sh && /install-composer.sh && rm /install-composer.sh

# Install WP-Cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
