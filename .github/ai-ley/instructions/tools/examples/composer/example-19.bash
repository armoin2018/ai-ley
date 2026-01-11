# Configure cache directory
composer config cache-dir /tmp/composer-cache

# Clear cache
composer clear-cache

# Cache repository metadata
composer config cache-ttl 86400

# Disable cache temporarily
composer install --no-cache