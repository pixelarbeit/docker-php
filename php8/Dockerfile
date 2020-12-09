FROM php:8-fpm-alpine

# Install dependencies
RUN apk update && apk upgrade
RUN apk --no-cache add libwebp-dev libpng-dev libjpeg-turbo-dev imagemagick-dev freetype-dev \
    libzip-dev zip curl-dev


# Configure Install php extensions
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp
RUN docker-php-ext-install gd zip mysqli pdo pdo_mysql opcache exif curl

# Add mariadb client
RUN apk --no-cache add mariadb-client

# Add nodeJS and yarn
RUN apk --no-cache add nodejs npm yarn

# Add git
RUN apk --no-cache add git

# Add user commands and user group
RUN apk --no-cache add shadow && \
    usermod -u 1001 www-data && \
    groupmod -g 1001 www-data

# Copy config files
COPY ./.config/php.ini /usr/local/etc/php/php.ini

# Install composer
COPY ./install-composer.sh /install-composer.sh
RUN chmod +x /install-composer.sh && /install-composer.sh && rm /install-composer.sh
