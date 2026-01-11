# Code analysis and formatting
composer require --dev phpstan/phpstan
composer require --dev friendsofphp/php-cs-fixer
composer require --dev phpunit/phpunit

# Run quality checks
./vendor/bin/phpstan analyse
./vendor/bin/php-cs-fixer fix
./vendor/bin/phpunit