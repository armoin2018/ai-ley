# Install with optimizations
composer install --no-dev --optimize-autoloader --classmap-authoritative

# Alternative optimization flags
composer install --no-dev --optimize-autoloader --apcu-autoloader

# Update with optimization
composer update --optimize-autoloader --classmap-authoritative

# Generate optimized autoloader
composer dump-autoload --optimize --classmap-authoritative
composer dump-autoload --apcu