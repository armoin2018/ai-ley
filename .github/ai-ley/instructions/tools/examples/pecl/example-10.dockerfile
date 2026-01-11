# Dockerfile for PECL Extensions
FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libsasl2-dev \
    libmemcached-dev \
    libmagickwand-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PECL extensions
RUN pecl install \
    redis-5.3.7 \
    mongodb-1.15.3 \
    apcu-5.1.22 \
    memcached-3.2.0 \
    imagick-3.7.0 \
    && docker-php-ext-enable \
        redis \
        mongodb \
        apcu \
        memcached \
        imagick

# Copy optimized configuration
COPY config/php/extensions/ /usr/local/etc/php/conf.d/

# Verify extensions
RUN php -m | grep -E "(redis|mongodb|apcu|memcached|imagick)"

# Multi-stage build for production
FROM php:8.1-fpm-alpine AS production

# Copy extensions from builder stage
COPY --from=0 /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=0 /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Verify production setup
RUN php -m && php -v