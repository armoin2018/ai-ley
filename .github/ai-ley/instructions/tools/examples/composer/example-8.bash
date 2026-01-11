# Update all packages
composer update

# Update specific package
composer update monolog/monolog
composer update vendor/package

# Update with development dependencies
composer update --with-dependencies

# Update without development dependencies
composer update --no-dev

# Update to latest versions (ignore constraints)
composer update --with-all-dependencies

# Show what would be updated
composer outdated
composer outdated --direct
composer outdated --minor-only

# Interactive update
composer update --interactive

# Update lock file only
composer update --lock