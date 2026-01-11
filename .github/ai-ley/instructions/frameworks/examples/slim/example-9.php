// src/Dependencies/container.php
<?php

declare(strict_types=1);

use DI\Container;
use DI\ContainerBuilder;
use Illuminate\Database\Capsule\Manager as Capsule;
use App\Services\UserService;
use App\Middleware\AuthMiddleware;

return function () {
    $containerBuilder = new ContainerBuilder();

    $settings = require __DIR__ . '/../../config/settings.php';

    $containerBuilder->addDefinitions([
        'settings' => $settings,

        // Database
        Capsule::class => function () use ($settings) {
            $capsule = new Capsule;
            $capsule->addConnection($settings['database']);
            $capsule->setAsGlobal();
            $capsule->bootEloquent();
            return $capsule;
        },

        // Services
        UserService::class => DI\autowire(),

        // Middleware
        AuthMiddleware::class => function () use ($settings) {
            return new AuthMiddleware($settings['jwt']['secret']);
        },
    ]);

    return $containerBuilder->build();
};