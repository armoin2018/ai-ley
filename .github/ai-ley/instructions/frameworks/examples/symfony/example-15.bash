# Enable debug mode
export APP_ENV=dev
export APP_DEBUG=1

# Clear cache
php bin/console cache:clear

# Debug container services
php bin/console debug:container
php bin/console debug:container UserService

# Debug routes
php bin/console debug:router
php bin/console debug:router app_user_list