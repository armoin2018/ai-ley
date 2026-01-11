# Enable error reporting in settings
$settings['displayErrorDetails'] = true;
$settings['logErrors'] = true;
$settings['logErrorDetails'] = true;

# Check PHP error logs
tail -f /var/log/php_errors.log

# Use Monolog for structured logging
composer require monolog/monolog