FROM php:8.2-apache

# Enable Apache rewrite (OpenCATS uses .htaccess)
RUN a2enmod rewrite

# Install required PHP extensions
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    libldap2-dev \
    zlib1g-dev \
    unzip \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j"$(nproc)" \
    mysqli \
    pdo_mysql \
    mbstring \
    zip \
    gd \
    ldap \
  && rm -rf /var/lib/apt/lists/*

# Keep OpenCATS under a clean docroot mount
WORKDIR /var/www/html
