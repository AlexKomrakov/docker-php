FROM php:5.6.23-fpm

RUN apt-get update

RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y ant

# Устанавливаем composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Устанавливаем prestissimo (composer parallel install plugin)
RUN composer global require "hirak/prestissimo:^0.3"
RUN composer global require "fxp/composer-asset-plugin:~1.1.1"

RUN apt-get install -y zlib1g-dev
RUN docker-php-ext-install zip

RUN apt-get install -y libxml2-dev
RUN apt-get install -y php-soap
RUN docker-php-ext-install soap

RUN apt-get install -y libpq-dev
RUN apt-get install -y php5-pgsql
RUN docker-php-ext-install pgsql
RUN docker-php-ext-install pdo_pgsql

RUN apt-get install -y php5-mysql
RUN docker-php-ext-install mysql
RUN docker-php-ext-install pdo_mysql

RUN apt-get install -y libicu-dev
RUN apt-get install -y php5-intl
RUN docker-php-ext-install intl

RUN apt-get install -y libmemcached-dev
RUN printf "\n" | pecl install memcached
RUN docker-php-ext-enable memcached

RUN printf "\n" | pecl install apcu-4.0.11
RUN docker-php-ext-enable apcu

RUN apt-get install -y php5-gd
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

RUN apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN printf "\n" | pecl install imagick
RUN docker-php-ext-enable imagick


