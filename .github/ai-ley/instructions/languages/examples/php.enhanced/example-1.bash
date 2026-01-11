# Modern PHP development workflow
composer create-project laravel/laravel my-api
cd my-api

# Install development dependencies
composer require --dev phpunit/phpunit phpstan/phpstan friendsofphp/php-cs-fixer

# Set up environment
cp .env.example .env
php artisan key:generate

# Database setup
php artisan migrate
php artisan db:seed

# Development server
php artisan serve