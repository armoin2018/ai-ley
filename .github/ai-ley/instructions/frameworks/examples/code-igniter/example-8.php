// app/Config/Routes.php
<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */

// Default route
$routes->get('/', 'Home::index');

// User management routes
$routes->group('users', ['namespace' => 'App\Controllers'], function($routes) {
    $routes->get('/', 'UserController::index', ['as' => 'users.index']);
    $routes->get('create', 'UserController::new', ['as' => 'users.create']);
    $routes->post('/', 'UserController::create');
    $routes->get('(:num)', 'UserController::show/$1', ['as' => 'users.show']);
    $routes->get('(:num)/edit', 'UserController::edit/$1', ['as' => 'users.edit']);
    $routes->put('(:num)', 'UserController::update/$1');
    $routes->delete('(:num)', 'UserController::delete/$1', ['as' => 'users.delete']);
});

// API routes
$routes->group('api', ['namespace' => 'App\Controllers\API'], function($routes) {
    $routes->resource('users', ['controller' => 'UserController']);
    $routes->resource('posts', ['controller' => 'PostController']);
    
    // Custom API routes
    $routes->post('auth/login', 'AuthController::login');
    $routes->post('auth/logout', 'AuthController::logout');
    $routes->get('users/(:num)/posts', 'UserController::posts/$1');
});

// Admin routes with filter
$routes->group('admin', ['filter' => 'auth'], function($routes) {
    $routes->get('dashboard', 'Admin\DashboardController::index');
    $routes->resource('users', ['controller' => 'Admin\UserController']);
});