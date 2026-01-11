# Laravel project
composer create-project laravel/laravel my-app
cd my-app
composer require laravel/sanctum
composer require --dev laravel/telescope

# Symfony project
composer create-project symfony/skeleton my-app
cd my-app
composer require webapp
composer require --dev symfony/profiler-pack

# WordPress with Composer
composer create-project roots/bedrock my-site
cd my-site
composer require wpackagist-plugin/advanced-custom-fields