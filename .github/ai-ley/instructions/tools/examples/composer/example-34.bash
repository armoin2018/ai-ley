# Enable debug output
composer install -vvv

# Debug specific issues
composer diagnose
composer why vendor/package
composer why-not vendor/package 2.0

# Check platform requirements
composer check-platform-reqs

# Validate configuration
composer validate --strict