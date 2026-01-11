# Create new Slim project
composer create-project slim/slim-skeleton my-api

# Navigate to project
cd my-api

# Install additional dependencies
composer require slim/psr7 slim/http

# For database operations
composer require illuminate/database

# For validation
composer require respect/validation

# For JWT authentication
composer require firebase/php-jwt

# Start development server
php -S localhost:8000 -t public