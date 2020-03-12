FROM php:7.4.3-fpm-alpine3.11

# Install dependencies
RUN apk update && apk upgrade
RUN apk --no-cache add libwebp-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    # libcurl \
    curl-dev \
    zip

# Configure Install php extensions
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install gd zip mysqli pdo pdo_mysql opcache exif curl

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