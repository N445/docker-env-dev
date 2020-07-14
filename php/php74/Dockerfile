FROM php:7.4-fpm

RUN export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" \
    && apt-get update && apt-get install -y --no-install-recommends ghostscript gnupg unzip iputils-ping acl bash-completion \
    libmagickwand-dev ssh git htop zip nodejs grunt nano npm wkhtmltopdf libxslt-dev libgd-dev libxml2-dev imagemagick libzip-dev cron wget \
    && pecl install imagick-3.4.3 \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/

# Installation de yarn via npm
RUN npm install yarn sass -g


# Extensions php etc
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache soap bcmath bz2 calendar intl gd xsl xml zip exif

# SSH
RUN mkdir /root/.ssh -p
COPY ./conf/.ssh/id_rsa /root/.ssh/id_rsa
COPY ./conf/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub

RUN chmod -R 700 /root/.ssh && chmod 600 /root/.ssh/id_rsa
COPY ./conf/.bashrc /root/.bashrc

# Config PHP
COPY ./conf/php-ini-overrides.ini /usr/local/etc/php/conf.d/99-overrides.ini

# COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Symfony
RUN wget https://get.symfony.com/cli/installer -O - | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

RUN /bin/bash -c "source /root/.bashrc"

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /data/www
