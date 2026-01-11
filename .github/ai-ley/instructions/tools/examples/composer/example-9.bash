# Generate autoloader
composer dump-autoload

# Optimize autoloader for production
composer dump-autoload --optimize

# Include autoloader in PHP files
<?php
require_once 'vendor/autoload.php';

use App\Models\User;
use Monolog\Logger;
use Guzzle\Http\Client;

$user = new User();
$logger = new Logger('app');
$client = new Client();