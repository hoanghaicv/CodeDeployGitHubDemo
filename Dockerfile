FROM php:7.4-apache

# Enable Apache rewrite (OpenCATS uses .htaccess)
RUN a2enmod rewrite

# Install required PHP extensions
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
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

# Allow .htaccess overrides under the docroot
RUN { \
      echo '<Directory /var/www/html>'; \
      echo '  AllowOverride All'; \
      echo '  Require all granted'; \
      echo '</Directory>'; \
    } > /etc/apache2/conf-available/opencats.conf \
  && a2enconf opencats

# Keep OpenCATS under a clean docroot mount
WORKDIR /var/www/html
