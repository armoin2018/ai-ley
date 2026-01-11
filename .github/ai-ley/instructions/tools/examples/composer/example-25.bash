# Production installation
composer install --no-dev --optimize-autoloader --classmap-authoritative

# Production configuration
{
    "config": {
        "optimize-autoloader": true,
        "classmap-authoritative": true,
        "apcu-autoloader": true,
        "process-timeout": 300
    }
}