# Package management
composer install                    # Install dependencies
composer update                     # Update dependencies
composer require vendor/package     # Add dependency
composer remove vendor/package      # Remove dependency
composer search keyword             # Search packages

# Project management
composer init                       # Initialize project
composer create-project template    # Create from template
composer validate                   # Validate composer.json
composer diagnose                   # Diagnose issues

# Autoloader management
composer dump-autoload              # Regenerate autoloader
composer dump-autoload --optimize   # Optimize for production
composer dump-autoload --classmap-authoritative  # Use classmap only

# Information and analysis
composer show                       # List installed packages
composer show vendor/package        # Show package details
composer depends vendor/package     # Show dependents
composer why vendor/package         # Alias for depends
composer why-not vendor/package     # Show conflicts

# Script execution
composer run-script script-name     # Run defined script
composer test                       # Run test script
composer cs-fix                     # Run code style fixer

# Global operations
composer global require package     # Install globally
composer global update              # Update global packages
composer global show               # Show global packages

# Cache management
composer clear-cache                # Clear all caches
composer clearcache                 # Alias for clear-cache

# Security and maintenance
composer audit                      # Check for vulnerabilities
composer outdated                   # Show outdated packages
composer licenses                   # Show package licenses