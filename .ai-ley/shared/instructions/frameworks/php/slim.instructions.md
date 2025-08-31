---
applyTo: 'slim, slim-framework, slim4'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Slim 4.x with PSR standards and modern PHP 8.1+ features'
---

# Slim Framework Instructions for AI Agents

## When to Use Slim

Use Slim when you need:

- Lightweight, fast PHP APIs and microservices
- RESTful web services with minimal overhead
- Rapid API development with clean routing
- PSR-compliant middleware architecture
- Simple web applications without full-framework complexity
- Microservice architecture with independent deployments
- Learning modern PHP development patterns
- High-performance applications with minimal dependencies
- JSON APIs and web services for mobile/frontend applications

## When to Avoid Slim

Consider alternatives when:

- Building large enterprise applications (consider Symfony or Laravel)
- Need extensive built-in features like ORM, templating, authentication
- Team requires opinionated framework structure and conventions
- Building traditional server-rendered web applications
- Need comprehensive admin panels and CRUD generation
- Working with complex business logic requiring sophisticated architecture
- Require extensive third-party package ecosystem

## Framework Overview

- **Framework**: Slim 4.x
- **Type**: Lightweight PHP micro-framework for APIs and web services
- **Architecture**: PSR-7/PSR-15 compliant with middleware-based request handling
- **Language**: PHP 8.1+ with modern features and type declarations
- **Use Cases**: REST APIs, microservices, JSON web services, lightweight web apps

## Installation & Setup

### ✅ Recommended: Composer Installation

```bash
# Create new Slim project
composer create-project slim/slim-skeleton my-api

# Navigate to project
cd my-api

# Install additional dependencies
composer require slim/psr7 slim/http

# For database operations
composer require illuminate/database

# For validation
composer require respect/validation

# For JWT authentication
composer require firebase/php-jwt

# Start development server
php -S localhost:8000 -t public
```

### Manual Setup

```bash
# Create project directory
mkdir my-slim-api && cd my-slim-api

# Initialize composer
composer init

# Install Slim framework
composer require slim/slim:"4.*"
composer require slim/psr7
composer require slim/http

# Create directory structure
mkdir -p public src/{Controllers,Middleware,Models}
```

## Project Structure

```
my-api/
├── public/                 # Web-accessible directory
│   └── index.php          # Application entry point
├── src/                   # Application source code
│   ├── Controllers/       # Request handlers
│   │   ├── ApiController.php
│   │   └── UserController.php
│   ├── Middleware/        # Custom middleware
│   │   ├── AuthMiddleware.php
│   │   └── CorsMiddleware.php
│   ├── Models/           # Data models (if using ORM)
│   │   └── User.php
│   ├── Services/         # Business logic services
│   │   └── UserService.php
│   └── Dependencies/     # DI container configuration
│       └── container.php
├── config/               # Configuration files
│   ├── settings.php      # Application settings
│   └── routes.php        # Route definitions
├── logs/                 # Log files
├── tests/               # Unit and integration tests
├── vendor/              # Composer dependencies
├── composer.json        # Composer configuration
└── .htaccess           # Apache rewrite rules
```

## Core Concepts

### Application Setup and Configuration

- **Purpose**: Initialize Slim application with middleware and routes
- **Usage**: Configure application in entry point with dependency injection

```php
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
```

### Routing and Controllers

- **Purpose**: Define API endpoints and handle HTTP requests
- **Usage**: Create RESTful routes with controller methods

```php
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
```

### Controllers and Request Handling

- **Purpose**: Handle business logic and return JSON responses
- **Usage**: Create controller classes with dependency injection

```php
// src/Controllers/UserController.php
<?php

declare(strict_types=1);

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Services\UserService;
use Respect\Validation\Validator as v;

class UserController
{
    private UserService $userService;

    public function __construct(UserService $userService)
    {
        $this->userService = $userService;
    }

    public function getUsers(Request $request, Response $response): Response
    {
        try {
            $queryParams = $request->getQueryParams();
            $page = (int) ($queryParams['page'] ?? 1);
            $limit = (int) ($queryParams['limit'] ?? 10);

            $users = $this->userService->getAllUsers($page, $limit);
            
            $payload = json_encode([
                'status' => 'success',
                'data' => $users,
                'pagination' => [
                    'page' => $page,
                    'limit' => $limit
                ]
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json');
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    public function getUser(Request $request, Response $response, array $args): Response
    {
        try {
            $userId = (int) $args['id'];
            
            if (!v::intVal()->positive()->validate($userId)) {
                return $this->errorResponse($response, 'Invalid user ID', 400);
            }

            $user = $this->userService->getUserById($userId);
            
            if (!$user) {
                return $this->errorResponse($response, 'User not found', 404);
            }

            $payload = json_encode([
                'status' => 'success',
                'data' => $user
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json');
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    public function createUser(Request $request, Response $response): Response
    {
        try {
            $data = $request->getParsedBody();

            // Validation
            $validation = $this->validateUserData($data);
            if (!$validation['isValid']) {
                return $this->errorResponse($response, 'Validation failed', 400, $validation['errors']);
            }

            $user = $this->userService->createUser($data);

            $payload = json_encode([
                'status' => 'success',
                'message' => 'User created successfully',
                'data' => $user
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json')->withStatus(201);
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    public function updateUser(Request $request, Response $response, array $args): Response
    {
        try {
            $userId = (int) $args['id'];
            $data = $request->getParsedBody();

            if (!v::intVal()->positive()->validate($userId)) {
                return $this->errorResponse($response, 'Invalid user ID', 400);
            }

            $user = $this->userService->updateUser($userId, $data);
            
            if (!$user) {
                return $this->errorResponse($response, 'User not found', 404);
            }

            $payload = json_encode([
                'status' => 'success',
                'message' => 'User updated successfully',
                'data' => $user
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json');
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    public function deleteUser(Request $request, Response $response, array $args): Response
    {
        try {
            $userId = (int) $args['id'];

            if (!v::intVal()->positive()->validate($userId)) {
                return $this->errorResponse($response, 'Invalid user ID', 400);
            }

            $deleted = $this->userService->deleteUser($userId);
            
            if (!$deleted) {
                return $this->errorResponse($response, 'User not found', 404);
            }

            $payload = json_encode([
                'status' => 'success',
                'message' => 'User deleted successfully'
            ]);

            $response->getBody()->write($payload);
            return $response->withHeader('Content-Type', 'application/json');
            
        } catch (\Exception $e) {
            return $this->errorResponse($response, $e->getMessage(), 500);
        }
    }

    private function validateUserData(array $data): array
    {
        $errors = [];

        if (!v::notEmpty()->validate($data['name'] ?? '')) {
            $errors[] = 'Name is required';
        }

        if (!v::email()->validate($data['email'] ?? '')) {
            $errors[] = 'Valid email is required';
        }

        if (!v::notEmpty()->validate($data['password'] ?? '')) {
            $errors[] = 'Password is required';
        } elseif (!v::length(8, null)->validate($data['password'])) {
            $errors[] = 'Password must be at least 8 characters';
        }

        return [
            'isValid' => empty($errors),
            'errors' => $errors
        ];
    }

    private function errorResponse(Response $response, string $message, int $statusCode, array $errors = []): Response
    {
        $payload = json_encode([
            'status' => 'error',
            'message' => $message,
            'errors' => $errors
        ]);

        $response->getBody()->write($payload);
        return $response->withHeader('Content-Type', 'application/json')->withStatus($statusCode);
    }
}
```

## ✅ Best Practices

### Middleware Implementation

```php
// src/Middleware/AuthMiddleware.php
<?php

declare(strict_types=1);

namespace App\Middleware;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class AuthMiddleware implements Middleware
{
    private string $jwtSecret;

    public function __construct(string $jwtSecret)
    {
        $this->jwtSecret = $jwtSecret;
    }

    public function process(Request $request, RequestHandler $handler): Response
    {
        $authHeader = $request->getHeaderLine('Authorization');
        
        if (!$authHeader || !preg_match('/Bearer\s+(.*)$/i', $authHeader, $matches)) {
            return $this->unauthorizedResponse();
        }

        $token = $matches[1];

        try {
            $decoded = JWT::decode($token, new Key($this->jwtSecret, 'HS256'));
            
            // Add user info to request attributes
            $request = $request->withAttribute('user', $decoded);
            
            return $handler->handle($request);
            
        } catch (\Exception $e) {
            return $this->unauthorizedResponse();
        }
    }

    private function unauthorizedResponse(): Response
    {
        $response = new \Slim\Psr7\Response();
        $payload = json_encode([
            'status' => 'error',
            'message' => 'Unauthorized'
        ]);
        
        $response->getBody()->write($payload);
        return $response->withHeader('Content-Type', 'application/json')->withStatus(401);
    }
}

// src/Middleware/CorsMiddleware.php
<?php

declare(strict_types=1);

namespace App\Middleware;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\MiddlewareInterface as Middleware;
use Psr\Http\Server\RequestHandlerInterface as RequestHandler;

class CorsMiddleware implements Middleware
{
    public function process(Request $request, RequestHandler $handler): Response
    {
        $response = $handler->handle($request);
        
        return $response
            ->withHeader('Access-Control-Allow-Origin', '*')
            ->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')
            ->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS')
            ->withHeader('Access-Control-Allow-Credentials', 'true');
    }
}
```

### Service Layer and Business Logic

```php
// src/Services/UserService.php
<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\User;
use Illuminate\Database\Capsule\Manager as DB;

class UserService
{
    public function getAllUsers(int $page = 1, int $limit = 10): array
    {
        $offset = ($page - 1) * $limit;
        
        $users = DB::table('users')
            ->select(['id', 'name', 'email', 'created_at'])
            ->offset($offset)
            ->limit($limit)
            ->get()
            ->toArray();

        return array_map(function($user) {
            return (array) $user;
        }, $users);
    }

    public function getUserById(int $id): ?array
    {
        $user = DB::table('users')
            ->select(['id', 'name', 'email', 'created_at'])
            ->where('id', $id)
            ->first();

        return $user ? (array) $user : null;
    }

    public function createUser(array $data): array
    {
        $hashedPassword = password_hash($data['password'], PASSWORD_DEFAULT);
        
        $userId = DB::table('users')->insertGetId([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => $hashedPassword,
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s')
        ]);

        return $this->getUserById($userId);
    }

    public function updateUser(int $id, array $data): ?array
    {
        $updateData = [
            'updated_at' => date('Y-m-d H:i:s')
        ];

        if (isset($data['name'])) {
            $updateData['name'] = $data['name'];
        }

        if (isset($data['email'])) {
            $updateData['email'] = $data['email'];
        }

        if (isset($data['password'])) {
            $updateData['password'] = password_hash($data['password'], PASSWORD_DEFAULT);
        }

        $updated = DB::table('users')
            ->where('id', $id)
            ->update($updateData);

        return $updated ? $this->getUserById($id) : null;
    }

    public function deleteUser(int $id): bool
    {
        return DB::table('users')->where('id', $id)->delete() > 0;
    }

    public function authenticateUser(string $email, string $password): ?array
    {
        $user = DB::table('users')
            ->where('email', $email)
            ->first();

        if ($user && password_verify($password, $user->password)) {
            return [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email
            ];
        }

        return null;
    }
}
```

### Dependency Injection Configuration

```php
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
```

## Common Patterns

### JSON API Response Helper

```php
// src/Helpers/ResponseHelper.php
<?php

declare(strict_types=1);

namespace App\Helpers;

use Psr\Http\Message\ResponseInterface as Response;

class ResponseHelper
{
    public static function json(Response $response, array $data, int $status = 200): Response
    {
        $payload = json_encode($data);
        $response->getBody()->write($payload);
        
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus($status);
    }

    public static function success(Response $response, $data = null, string $message = 'Success'): Response
    {
        return self::json($response, [
            'status' => 'success',
            'message' => $message,
            'data' => $data
        ]);
    }

    public static function error(Response $response, string $message, int $status = 400, array $errors = []): Response
    {
        return self::json($response, [
            'status' => 'error',
            'message' => $message,
            'errors' => $errors
        ], $status);
    }

    public static function paginated(Response $response, array $data, int $page, int $limit, int $total): Response
    {
        return self::json($response, [
            'status' => 'success',
            'data' => $data,
            'pagination' => [
                'page' => $page,
                'limit' => $limit,
                'total' => $total,
                'pages' => ceil($total / $limit)
            ]
        ]);
    }
}
```

### Request Validation

```php
// src/Validators/UserValidator.php
<?php

declare(strict_types=1);

namespace App\Validators;

use Respect\Validation\Validator as v;

class UserValidator
{
    public static function validateCreate(array $data): array
    {
        $errors = [];

        if (!v::notEmpty()->validate($data['name'] ?? '')) {
            $errors['name'] = 'Name is required';
        } elseif (!v::length(2, 50)->validate($data['name'])) {
            $errors['name'] = 'Name must be between 2 and 50 characters';
        }

        if (!v::email()->validate($data['email'] ?? '')) {
            $errors['email'] = 'Valid email is required';
        }

        if (!v::notEmpty()->validate($data['password'] ?? '')) {
            $errors['password'] = 'Password is required';
        } elseif (!v::length(8, null)->validate($data['password'])) {
            $errors['password'] = 'Password must be at least 8 characters';
        }

        return [
            'isValid' => empty($errors),
            'errors' => $errors
        ];
    }

    public static function validateUpdate(array $data): array
    {
        $errors = [];

        if (isset($data['name']) && !v::length(2, 50)->validate($data['name'])) {
            $errors['name'] = 'Name must be between 2 and 50 characters';
        }

        if (isset($data['email']) && !v::email()->validate($data['email'])) {
            $errors['email'] = 'Valid email is required';
        }

        if (isset($data['password']) && !v::length(8, null)->validate($data['password'])) {
            $errors['password'] = 'Password must be at least 8 characters';
        }

        return [
            'isValid' => empty($errors),
            'errors' => $errors
        ];
    }
}
```

### JWT Authentication Service

```php
// src/Services/AuthService.php
<?php

declare(strict_types=1);

namespace App\Services;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class AuthService
{
    private string $jwtSecret;
    private string $algorithm;
    private int $expirationTime;

    public function __construct(string $jwtSecret, string $algorithm = 'HS256', int $expirationTime = 3600)
    {
        $this->jwtSecret = $jwtSecret;
        $this->algorithm = $algorithm;
        $this->expirationTime = $expirationTime;
    }

    public function generateToken(array $userData): string
    {
        $issuedAt = time();
        $expirationTime = $issuedAt + $this->expirationTime;

        $payload = [
            'iat' => $issuedAt,
            'exp' => $expirationTime,
            'user' => [
                'id' => $userData['id'],
                'email' => $userData['email'],
                'name' => $userData['name']
            ]
        ];

        return JWT::encode($payload, $this->jwtSecret, $this->algorithm);
    }

    public function validateToken(string $token): ?array
    {
        try {
            $decoded = JWT::decode($token, new Key($this->jwtSecret, $this->algorithm));
            return (array) $decoded;
        } catch (\Exception $e) {
            return null;
        }
    }

    public function refreshToken(string $token): ?string
    {
        $decoded = $this->validateToken($token);
        
        if (!$decoded) {
            return null;
        }

        return $this->generateToken($decoded['user']);
    }
}
```

## Integration Points

### Database Integration (Eloquent ORM)

- **Purpose**: Database operations with Laravel's Eloquent ORM
- **Setup**: `composer require illuminate/database`
- **Usage**: 
  ```php
  $capsule = new \Illuminate\Database\Capsule\Manager;
  $capsule->addConnection($databaseConfig);
  $capsule->setAsGlobal();
  $capsule->bootEloquent();
  ```

### Caching Integration

- **Purpose**: Improve performance with Redis or file-based caching
- **Setup**: `composer require predis/predis`
- **Usage**: 
  ```php
  $redis = new \Predis\Client();
  $redis->set('key', 'value', 'EX', 3600);
  ```

## Version Compatibility

- **PHP**: 8.1+ (8.2+ recommended for latest features)
- **Composer**: 2.x
- **PSR**: PSR-7, PSR-15, PSR-11 compliant
- **Database**: MySQL 8.0+, PostgreSQL 13+, SQLite 3.35+
- **Web Server**: Apache 2.4+, Nginx 1.18+, or PHP built-in server

## Troubleshooting

### Debug Mode

```bash
# Enable error reporting in settings
$settings['displayErrorDetails'] = true;
$settings['logErrors'] = true;
$settings['logErrorDetails'] = true;

# Check PHP error logs
tail -f /var/log/php_errors.log

# Use Monolog for structured logging
composer require monolog/monolog
```

### Log Analysis

- **Application logs**: Configure Monolog for structured logging
- **Web server logs**: Check Apache/Nginx access and error logs
- **Database logs**: Enable query logging for performance analysis

### Common Error Messages

- **Error**: `Class 'App\Controllers\UserController' not found`
  **Cause**: Autoloader not properly configured or class namespace incorrect
  **Solution**: Run `composer dump-autoload` and verify namespace declarations

- **Error**: `Slim\Exception\HttpNotFoundException`
  **Cause**: Route not found or middleware blocking request
  **Solution**: Check route definitions and middleware configuration

- **Error**: `Fatal error: Uncaught TypeError`
  **Cause**: Type mismatch in method parameters or return values
  **Solution**: Verify type declarations and ensure proper data types are passed
- **Example**: [Code example]

### [Concept 2]
- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

## Development Workflow
1. **Setup**: [Initial project setup steps]
2. **Development**: [Development server, hot reload, etc.]
3. **Testing**: [Testing framework and commands]
4. **Building**: [Build process and commands]
5. **Deployment**: [Deployment strategies]

## Best Practices
- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

## Common Patterns
### [Pattern Name]
```[language]
// Example implementation
[code example]
```

### [Pattern Name]
```[language]
// Example implementation
[code example]
```

## Configuration
### [Config File 1]
```[format]
# Configuration options
[example configuration]
```

### [Config File 2]
```[format]
# Configuration options
[example configuration]
```

## Essential Commands
```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions
### [Issue 1]
**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]
**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization
- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations
- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources
- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines
### Code Style
- [Coding conventions specific to this framework]
- [Naming conventions]
- [File organization patterns]

### Architecture Patterns
- [Recommended architectural patterns]
- [State management approaches]
- [Component/module organization]

## Integration Points
### [External Service/Tool 1]
- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

### [External Service/Tool 2]
- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

## Version Compatibility
- **Node.js**: [Supported versions]
- **Dependencies**: [Key dependency versions]
- **Browser Support**: [If applicable]
- **OS Support**: [If applicable]

## Troubleshooting
### Debug Mode
```bash
[debug commands]
```

### Log Analysis
- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages
- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]
