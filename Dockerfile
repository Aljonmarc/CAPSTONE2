# Use the Node.js base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Install PHP and other dependencies required for Laravel
RUN apt-get update && apt-get install -y \
    php-cli \
    php-mbstring \
    php-xml \
    php-curl \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Composer (for Laravel)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy package.json and package-lock.json (if present)
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Install Laravel PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Run the build command for production
RUN npm run build

# Expose the ports your apps will run on
EXPOSE 4173 8000

# Set the APP_URL environment variable for Laravel
ENV APP_URL=https://surigao-health-services.onrender.com

# Ensure the container listens on the correct ports
ENV PORT=4173

# Install supervisord
RUN apt-get update && apt-get install -y supervisor

# Create a supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Run supervisord to manage both Node and PHP processes
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
