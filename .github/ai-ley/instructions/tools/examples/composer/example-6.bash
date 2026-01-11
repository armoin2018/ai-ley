# The composer.lock file ensures reproducible builds
# Always commit composer.lock to version control
# Contains exact versions of all dependencies

# Update lock file without changing dependencies
composer update --lock

# Validate lock file
composer validate --strict