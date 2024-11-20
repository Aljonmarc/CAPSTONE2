# Use a base PHP image with necessary extensions for Laravel
FROM php:8.3-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql gd zip \
    && apt-get clean

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache


# Install Composer globally
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Set the working directory
WORKDIR /var/www/html

# Copy only composer files initially for optimized Docker builds
COPY composer.json composer.lock ./ 

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node.js (for building the frontend assets)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Copy package.json and install Node.js dependencies
COPY package.json package-lock.json ./ 
RUN npm install --legacy-peer-deps

# Copy the application files
COPY . .

# Build the frontend assets
RUN npm run build

# Set permissions for Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Expose the port your application runs on
EXPOSE 8000



# Set the environment variables (update APP_URL and other env vars as needed)
ENV APP_ENV=production
ENV APP_KEY=base64:your-app-key-here
ENV APP_URL=https://surigao-health-services.onrender.com
ENV DB_CONNECTION=mysql
ENV DB_HOST=db
ENV DB_PORT=3306
ENV DB_DATABASE=your-database
ENV DB_USERNAME=your-username
ENV DB_PASSWORD=your-password

ENV NODE_ENV=production

# Start the Laravel application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
