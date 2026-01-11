# Install all dependencies
composer install

# Install only production dependencies
composer install --no-dev

# Install with optimizations
composer install --optimize-autoloader --no-dev

# Add new dependency
composer require monolog/monolog
composer require guzzlehttp/guzzle "^7.0"
composer require --dev phpunit/phpunit

# Add with specific constraints
composer require "doctrine/orm:^2.15"
composer require "symfony/*:^6.0"

# Install from specific repository
composer require vendor/package --repository=https://custom-repo.com

# Install global packages
composer global require laravel/installer
composer global require phpunit/phpunit