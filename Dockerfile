# Use an official PHP image as the base image for Laravel
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libpq-dev \
    libzip-dev \
    zip \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /var/www/html

# Copy Laravel application files
COPY . .

# Install PHP dependencies using Composer
RUN composer install --optimize-autoloader --no-dev

# Install Node.js (required for Vite)
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Install NPM dependencies
RUN npm install

# Build the frontend assets for production
RUN npm run build

# Expose port for PHP server
EXPOSE 8000

# Expose port for Vite (if running in dev mode)
EXPOSE 5173

# Set the APP_URL environment variable
ENV APP_URL=https://surigao-health-services.onrender.com

# Start the Laravel application using PHP-FPM and Vite
CMD php artisan serve --host=0.0.0.0 --port=8000
