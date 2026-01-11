// config/routes.php
<?php

declare(strict_types=1);

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\App;
use Slim\Routing\RouteCollectorProxy;

return function (App $app) {
    // Basic route
    $app->get('/', function (Request $request, Response $response) {
        $payload = json_encode(['message' => 'Slim 4 API', 'status' => 'success']);
        $response->getBody()->write($payload);
        return $response->withHeader('Content-Type', 'application/json');
    });

    // API group with middleware
    $app->group('/api/v1', function (RouteCollectorProxy $group) {
        
        // User routes
        $group->get('/users', \App\Controllers\UserController::class . ':getUsers');
        $group->get('/users/{id}', \App\Controllers\UserController::class . ':getUser');
        $group->post('/users', \App\Controllers\UserController::class . ':createUser');
        $group->put('/users/{id}', \App\Controllers\UserController::class . ':updateUser');
        $group->delete('/users/{id}', \App\Controllers\UserController::class . ':deleteUser');

        // Auth routes
        $group->post('/auth/login', \App\Controllers\AuthController::class . ':login');
        $group->post('/auth/register', \App\Controllers\AuthController::class . ':register');
        
    })->add(\App\Middleware\AuthMiddleware::class);

    // Public routes (no auth required)
    $app->group('/api/v1/public', function (RouteCollectorProxy $group) {
        $group->post('/login', \App\Controllers\AuthController::class . ':login');
        $group->post('/register', \App\Controllers\AuthController::class . ':register');
        $group->get('/health', \App\Controllers\ApiController::class . ':health');
    });
};