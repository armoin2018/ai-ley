// public/index.php
<?php

declare(strict_types=1);

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;
use Slim\Middleware\ErrorMiddleware;

require __DIR__ . '/../vendor/autoload.php';

// Load settings
$settings = require __DIR__ . '/../config/settings.php';

// Create DI container
$container = require __DIR__ . '/../src/Dependencies/container.php';

// Set container to create App with DI
AppFactory::setContainer($container);

// Instantiate the app
$app = AppFactory::create();

// Add middleware
$app->addBodyParsingMiddleware();
$app->addRoutingMiddleware();

// Add error middleware
$errorMiddleware = $app->addErrorMiddleware(
    $settings['displayErrorDetails'],
    $settings['logErrors'],
    $settings['logErrorDetails']
);

// Add custom middleware
$app->add(new \App\Middleware\CorsMiddleware());

// Load routes
$routes = require __DIR__ . '/../config/routes.php';
$routes($app);

$app->run();