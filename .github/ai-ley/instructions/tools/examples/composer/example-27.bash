# Increase memory limit temporarily
php -d memory_limit=-1 $(which composer) install

# Set memory limit globally
echo 'memory_limit = 2G' >> /etc/php/8.1/cli/php.ini

# Use optimizations to reduce memory usage
composer install --prefer-dist --no-dev --optimize-autoloader