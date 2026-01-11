# Create project directory
mkdir my-slim-api && cd my-slim-api

# Initialize composer
composer init

# Install Slim framework
composer require slim/slim:"4.*"
composer require slim/psr7
composer require slim/http

# Create directory structure
mkdir -p public src/{Controllers,Middleware,Models}