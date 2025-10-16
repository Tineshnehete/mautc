FROM php:8.1-apache

# Install required packages
RUN apt-get update && apt-get install -y \
    mariadb-server mariadb-client \
    unzip curl git \
    libpng-dev libzip-dev libxml2-dev libonig-dev \
    && docker-php-ext-install pdo pdo_mysql mysqli gd zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Download Mautic
RUN curl -Lo mautic.zip https://www.mautic.org/download/latest
RUN unzip mautic.zip -d . && rm mautic.zip

# Set permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port
EXPOSE 80

# Start container
CMD ["/entrypoint.sh"]
