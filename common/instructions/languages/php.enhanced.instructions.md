`
---
applyTo: "**/*.php,**/*.phtml"
---

# PHP Programming Instructions

## Overview
- **Domain**: Server-side Web Development and API Creation
- **Purpose**: Build scalable, secure, and maintainable web applications and APIs using modern PHP
- **Applicable To**: Web applications, REST APIs, microservices, and enterprise systems
- **Integration Level**: Full-stack development with frontend separation

## Core Principles

### Fundamental Concepts
1. **API-First Architecture**: Strict separation between backend logic and frontend presentation
2. **Modern PHP Standards**: Use PHP 8.0+ features with strict typing and performance optimization
3. **Security-First Development**: Input validation, prepared statements, and comprehensive sanitization
4. **Performance Optimization**: Efficient coding patterns and caching strategies

### Key Benefits
- Rapid development with extensive ecosystem and frameworks
- Strong type system with PHP 8+ features for better code reliability
- Excellent performance with modern optimization techniques
- Comprehensive security features and well-established best practices

### Common Misconceptions
- **Myth**: PHP is inherently insecure and slow
  **Reality**: Modern PHP 8+ with proper practices is secure and performant
- **Myth**: PHP lacks strong typing capabilities
  **Reality**: PHP 8+ provides robust type system with union types, enums, and strict typing
- **Myth**: PHP is only for small projects
  **Reality**: PHP powers large-scale applications like Facebook, Wikipedia, and WordPress

## Implementation Framework

### Getting Started
#### Prerequisites
- PHP 8.0+ (8.2+ recommended for latest features)
- Composer for dependency management
- Web server (Apache/Nginx) or PHP built-in server for development
- Database server (MySQL/PostgreSQL recommended)

#### Initial Setup
1. **Environment Setup**: Configure PHP with proper extensions and settings
2. **Project Structure**: Organize code with PSR-4 autoloading and clear separation of concerns
3. **Dependency Management**: Use Composer for all third-party libraries
4. **Configuration Management**: Environment-based configuration with proper secret handling

### Core Methodologies
#### Strict Type Declaration
- **Purpose**: Enforce type safety and improve code reliability
- **When to Use**: All PHP files should use strict types
- **Implementation Steps**:
  1. Add strict_types declaration at the top of all PHP files
  2. Use type hints for all function parameters and return values
  3. Leverage union types and nullable types for flexible APIs
- **Success Metrics**: Zero type-related runtime errors

#### API-First Development
- **Purpose**: Create maintainable backend services with clear frontend separation
- **When to Use**: All web applications and services
- **Implementation Steps**:
  1. Design REST API endpoints with clear resource structure
  2. Return JSON responses from all API endpoints
  3. Separate business logic from presentation logic
  4. Implement proper HTTP status codes and error handling
- **Success Metrics**: Clean API documentation and frontend/backend independence

### Process Integration
#### Development Workflow Integration
```bash
# Modern PHP development workflow
composer create-project laravel/laravel my-api
cd my-api

# Install development dependencies
composer require --dev phpunit/phpunit phpstan/phpstan friendsofphp/php-cs-fixer

# Set up environment
cp .env.example .env
php artisan key:generate

# Database setup
php artisan migrate
php artisan db:seed

# Development server
php artisan serve
```

#### Quality Assurance Integration
```bash
# Code analysis and formatting
composer require --dev phpstan/phpstan
composer require --dev friendsofphp/php-cs-fixer
composer require --dev phpunit/phpunit

# Run quality checks
./vendor/bin/phpstan analyse
./vendor/bin/php-cs-fixer fix
./vendor/bin/phpunit
```

#### Documentation Requirements
- PHPDoc comments for all public methods and classes
- API documentation using OpenAPI/Swagger specifications
- README files with setup and usage instructions
- Architecture decision records for significant design choices

## Best Practices

### Modern PHP Syntax and Features
```php
<?php
declare(strict_types=1);

namespace App\Services;

use App\Models\User;
use App\Exceptions\ValidationException;
use Psr\Log\LoggerInterface;

/**
 * User management service with modern PHP features
 */
class UserService
{
    public function __construct(
        private readonly LoggerInterface $logger,
        private readonly UserRepository $userRepository
    ) {}

    /**
     * Create a new user with validation
     *
     * @param array{email: string, name: string, password: string} $userData
     * @throws ValidationException
     */
    public function createUser(array $userData): User
    {
        $validatedData = $this->validateUserData($userData);
        
        $user = new User(
            email: $validatedData['email'],
            name: $validatedData['name'],
            passwordHash: $this->hashPassword($validatedData['password'])
        );

        $savedUser = $this->userRepository->save($user);
        
        $this->logger->info('User created successfully', [
            'user_id' => $savedUser->getId(),
            'email' => $savedUser->getEmail()
        ]);

        return $savedUser;
    }

    /**
     * Validate user registration data
     *
     * @param array<string, mixed> $data
     * @return array{email: string, name: string, password: string}
     * @throws ValidationException
     */
    private function validateUserData(array $data): array
    {
        $errors = [];

        if (!filter_var($data['email'] ?? '', FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = 'Invalid email format';
        }

        if (strlen($data['name'] ?? '') < 2) {
            $errors['name'] = 'Name must be at least 2 characters';
        }

        if (strlen($data['password'] ?? '') < 8) {
            $errors['password'] = 'Password must be at least 8 characters';
        }

        if (!empty($errors)) {
            throw new ValidationException('Validation failed', $errors);
        }

        return [
            'email' => $data['email'],
            'name' => $data['name'], 
            'password' => $data['password']
        ];
    }

    private function hashPassword(string $password): string
    {
        return password_hash($password, PASSWORD_ARGON2ID, [
            'memory_cost' => 65536,
            'time_cost' => 4,
            'threads' => 3
        ]);
    }
}
```

### Database Integration with Security
```php
<?php
declare(strict_types=1);

namespace App\Repositories;

use PDO;
use PDOException;
use App\Models\User;
use App\Exceptions\DatabaseException;

class UserRepository
{
    public function __construct(
        private readonly PDO $pdo
    ) {}

    /**
     * Find user by ID with proper error handling
     */
    public function findById(int $id): ?User
    {
        try {
            $stmt = $this->pdo->prepare(
                'SELECT id, email, name, created_at FROM users WHERE id = :id'
            );
            $stmt->bindValue(':id', $id, PDO::PARAM_INT);
            $stmt->execute();

            $userData = $stmt->fetch(PDO::FETCH_ASSOC);
            
            return $userData ? User::fromArray($userData) : null;
        } catch (PDOException $e) {
            throw new DatabaseException('Failed to fetch user', 0, $e);
        }
    }

    /**
     * Save user with transaction support
     */
    public function save(User $user): User
    {
        $this->pdo->beginTransaction();
        
        try {
            if ($user->getId() === null) {
                $user = $this->insert($user);
            } else {
                $user = $this->update($user);
            }
            
            $this->pdo->commit();
            return $user;
        } catch (PDOException $e) {
            $this->pdo->rollBack();
            throw new DatabaseException('Failed to save user', 0, $e);
        }
    }

    private function insert(User $user): User
    {
        $stmt = $this->pdo->prepare(
            'INSERT INTO users (email, name, password_hash, created_at) 
             VALUES (:email, :name, :password_hash, NOW())'
        );
        
        $stmt->execute([
            ':email' => $user->getEmail(),
            ':name' => $user->getName(),
            ':password_hash' => $user->getPasswordHash()
        ]);

        $userId = (int) $this->pdo->lastInsertId();
        return $user->withId($userId);
    }

    /**
     * Optimized batch operations for performance
     */
    public function findMultipleById(array $ids): array
    {
        if (empty($ids)) {
            return [];
        }

        $placeholders = str_repeat('?,', count($ids) - 1) . '?';
        $stmt = $this->pdo->prepare(
            "SELECT id, email, name, created_at FROM users WHERE id IN ($placeholders)"
        );
        
        $stmt->execute($ids);
        
        return array_map(
            fn(array $userData) => User::fromArray($userData),
            $stmt->fetchAll(PDO::FETCH_ASSOC)
        );
    }
}
```

### API Controller Best Practices
```php
<?php
declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Services\UserService;
use App\Http\Requests\CreateUserRequest;
use App\Http\Resources\UserResource;
use App\Exceptions\ValidationException;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * User API controller following REST principles
 */
class UserController
{
    public function __construct(
        private readonly UserService $userService
    ) {}

    /**
     * Create a new user
     * 
     * @api {post} /api/users Create User
     * @apiName CreateUser
     * @apiGroup Users
     */
    public function store(Request $request): JsonResponse
    {
        try {
            $userData = $this->validateCreateUserRequest($request);
            $user = $this->userService->createUser($userData);

            return new JsonResponse(
                data: new UserResource($user),
                status: Response::HTTP_CREATED
            );
        } catch (ValidationException $e) {
            return new JsonResponse(
                data: [
                    'error' => 'Validation failed',
                    'message' => $e->getMessage(),
                    'errors' => $e->getErrors()
                ],
                status: Response::HTTP_UNPROCESSABLE_ENTITY
            );
        } catch (\Exception $e) {
            return new JsonResponse(
                data: [
                    'error' => 'Internal server error',
                    'message' => 'An unexpected error occurred'
                ],
                status: Response::HTTP_INTERNAL_SERVER_ERROR
            );
        }
    }

    /**
     * Get user by ID
     */
    public function show(int $id): JsonResponse
    {
        $user = $this->userService->findUserById($id);
        
        if ($user === null) {
            return new JsonResponse(
                data: ['error' => 'User not found'],
                status: Response::HTTP_NOT_FOUND
            );
        }

        return new JsonResponse(
            data: new UserResource($user),
            status: Response::HTTP_OK
        );
    }

    /**
     * List users with pagination
     */
    public function index(Request $request): JsonResponse
    {
        $page = (int) ($request->query->get('page', '1'));
        $perPage = (int) ($request->query->get('per_page', '15'));
        
        // Validate pagination parameters
        $page = max(1, $page);
        $perPage = min(100, max(1, $perPage));

        $users = $this->userService->getUsers($page, $perPage);

        return new JsonResponse(
            data: [
                'data' => UserResource::collection($users->getItems()),
                'pagination' => [
                    'current_page' => $users->getCurrentPage(),
                    'per_page' => $users->getPerPage(),
                    'total' => $users->getTotal(),
                    'last_page' => $users->getLastPage()
                ]
            ],
            status: Response::HTTP_OK
        );
    }

    private function validateCreateUserRequest(Request $request): array
    {
        $data = json_decode($request->getContent(), true);
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new ValidationException('Invalid JSON payload');
        }

        return $data;
    }
}
```

## Common Patterns and Examples

### Pattern 1: Repository Pattern with Caching
**Scenario**: Implement data access layer with caching for improved performance
**Implementation**:
```php
<?php
declare(strict_types=1);

namespace App\Repositories;

use Psr\Cache\CacheItemPoolInterface;
use App\Models\User;

class CachedUserRepository implements UserRepositoryInterface
{
    public function __construct(
        private readonly UserRepositoryInterface $repository,
        private readonly CacheItemPoolInterface $cache
    ) {}

    public function findById(int $id): ?User
    {
        $cacheKey = "user.{$id}";
        $cacheItem = $this->cache->getItem($cacheKey);

        if ($cacheItem->isHit()) {
            return $cacheItem->get();
        }

        $user = $this->repository->findById($id);
        
        if ($user !== null) {
            $cacheItem->set($user);
            $cacheItem->expiresAfter(3600); // 1 hour
            $this->cache->save($cacheItem);
        }

        return $user;
    }

    public function save(User $user): User
    {
        $savedUser = $this->repository->save($user);
        
        // Invalidate cache
        $this->cache->deleteItem("user.{$savedUser->getId()}");
        
        return $savedUser;
    }
}
```
**Expected Outcomes**: Improved performance with automatic cache invalidation

### Pattern 2: Event-Driven Architecture
**Scenario**: Implement domain events for loose coupling and extensibility
**Implementation**:
```php
<?php
declare(strict_types=1);

namespace App\Events;

class UserCreated
{
    public function __construct(
        public readonly User $user,
        public readonly \DateTimeImmutable $occurredAt = new \DateTimeImmutable()
    ) {}
}

// Event dispatcher
namespace App\Services;

class EventDispatcher
{
    private array $listeners = [];

    public function addListener(string $eventClass, callable $listener): void
    {
        $this->listeners[$eventClass][] = $listener;
    }

    public function dispatch(object $event): void
    {
        $eventClass = get_class($event);
        
        foreach ($this->listeners[$eventClass] ?? [] as $listener) {
            $listener($event);
        }
    }
}

// Usage in service
class UserService
{
    public function __construct(
        private readonly UserRepository $repository,
        private readonly EventDispatcher $eventDispatcher
    ) {}

    public function createUser(array $userData): User
    {
        $user = User::create($userData);
        $savedUser = $this->repository->save($user);
        
        $this->eventDispatcher->dispatch(new UserCreated($savedUser));
        
        return $savedUser;
    }
}
```
**Expected Outcomes**: Decoupled architecture with easy extensibility

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Direct Database Access in Controllers
- **Description**: Executing SQL queries directly in controller methods
- **Why It's Problematic**: Violates separation of concerns and makes testing difficult
- **Better Approach**: Use repository pattern with proper abstraction layers

#### Anti-Pattern 2: String Concatenation in Loops
- **Description**: Building strings using concatenation operators in loops
- **Why It's Problematic**: Poor performance due to string immutability
- **Better Approach**: Use array collection and implode() for string building

## Tools and Resources

### Essential Tools
#### Development Environment
- **PHP**: Version 8.0+ with OPcache enabled for production
- **Composer**: Dependency management and autoloading
- **Xdebug**: Debugging and profiling for development
- **PHPStan**: Static analysis for type checking and error detection

#### Framework Ecosystem
- **Laravel**: Full-featured framework with elegant syntax and comprehensive ecosystem
- **Symfony**: Component-based framework for enterprise applications
- **API Platform**: API-first framework built on Symfony
- **Laminas**: Enterprise-ready components and framework

#### Testing and Quality
```php
// PHPUnit test example
<?php
declare(strict_types=1);

namespace Tests\Unit\Services;

use PHPUnit\Framework\TestCase;
use App\Services\UserService;
use App\Repositories\UserRepository;
use App\Exceptions\ValidationException;

class UserServiceTest extends TestCase
{
    private UserService $userService;
    private UserRepository $userRepository;

    protected function setUp(): void
    {
        $this->userRepository = $this->createMock(UserRepository::class);
        $this->userService = new UserService($this->userRepository);
    }

    public function testCreateUserWithValidData(): void
    {
        $userData = [
            'email' => 'test@example.com',
            'name' => 'John Doe',
            'password' => 'securepassword123'
        ];

        $expectedUser = new User(
            id: 1,
            email: 'test@example.com',
            name: 'John Doe'
        );

        $this->userRepository
            ->expects($this->once())
            ->method('save')
            ->willReturn($expectedUser);

        $result = $this->userService->createUser($userData);

        $this->assertEquals($expectedUser, $result);
    }

    public function testCreateUserWithInvalidEmailThrowsException(): void
    {
        $userData = [
            'email' => 'invalid-email',
            'name' => 'John Doe',
            'password' => 'securepassword123'
        ];

        $this->expectException(ValidationException::class);
        $this->expectExceptionMessage('Invalid email format');

        $this->userService->createUser($userData);
    }
}
```

### Templates and Checklists
#### PHP Project Checklist
- [ ] **Security**: Input validation, prepared statements, HTTPS enforcement
- [ ] **Performance**: OPcache enabled, database indexing, caching strategy
- [ ] **Code Quality**: Strict types, PHPStan analysis, PSR-12 formatting
- [ ] **Testing**: Unit tests, integration tests, code coverage >80%
- [ ] **Documentation**: PHPDoc comments, API documentation, README
- [ ] **Deployment**: Environment configuration, error logging, monitoring

### Learning Resources
- **PHP Manual**: https://www.php.net/manual/
- **PHP Standards**: https://www.php-fig.org/
- **Laravel Documentation**: https://laravel.com/docs
- **Symfony Documentation**: https://symfony.com/doc
- **PHPUnit Documentation**: https://phpunit.de/documentation.html

## Quality and Compliance

### Quality Standards
- Code coverage of 80%+ for critical business logic
- PHPStan level 8 analysis with zero errors
- PSR-12 coding standard compliance
- Response time <200ms for API endpoints under normal load

### Compliance Requirements
#### Security Standards
- **Requirements**: Input validation, SQL injection prevention, XSS protection
- **Implementation**: Prepared statements, CSRF tokens, content security policy
- **Verification**: Security testing and penetration testing

#### Performance Standards
- **Requirements**: Page load times <2 seconds, API response times <500ms
- **Implementation**: Caching strategies, database optimization, code profiling
- **Verification**: Performance testing and monitoring

### Audit and Review Processes
- Weekly code reviews with security and performance focus
- Monthly dependency updates and security audits
- Quarterly architecture reviews and performance analysis
- Annual comprehensive security assessment

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Memory Exhaustion in Large Data Processing
**Symptoms**: Fatal error: Allowed memory size exhausted
**Root Causes**: Loading large datasets into memory, memory leaks in loops
**Solutions**:
1. Use generators for large dataset processing
2. Implement batch processing with proper memory management
3. Use database cursors for streaming large result sets
4. Profile memory usage with Xdebug or Blackfire
**Prevention**: Regular memory profiling and generator-based data processing

#### Issue 2: SQL Injection Vulnerabilities
**Symptoms**: Unexpected database behavior, security scan alerts
**Root Causes**: String concatenation in SQL queries, improper input sanitization
**Solutions**:
1. Use prepared statements exclusively for database queries
2. Implement comprehensive input validation
3. Use parameterized queries with type checking
4. Regular security audits and penetration testing
**Prevention**: Enforce prepared statement usage through code analysis tools

### Escalation Procedures
- **Performance Issues**: Database team → Infrastructure team → Architecture review
- **Security Issues**: Security team → Legal compliance → External audit
- **Critical Bugs**: Lead developer → Product team → Customer communication

### Continuous Improvement
- Regular performance profiling and optimization
- Security training and awareness programs
- Code review process improvements
- Tool and framework evaluation and updates

## Metrics and KPIs

### Success Metrics
- **Code Quality**: PHPStan level 8 compliance, PSR-12 formatting
- **Performance**: API response times <200ms, page load times <2s
- **Security**: Zero critical vulnerabilities, regular security audits
- **Maintainability**: Code coverage >80%, documentation coverage >90%

### Monitoring and Reporting
- Real-time application performance monitoring
- Weekly security scan reports
- Monthly code quality metrics dashboard
- Quarterly architecture and performance reviews

### Benchmarking
- Industry standard performance benchmarks
- Security compliance framework alignment
- Framework and library update tracking
- Competitive performance analysis

## Integration with Other Practices

### Related Disciplines
#### Frontend Development
- **Integration Points**: API design, authentication, data formatting
- **Shared Responsibilities**: Security, performance, user experience
- **Coordination Mechanisms**: API documentation, shared data models

#### DevOps and Infrastructure
- **Integration Points**: Deployment automation, monitoring, scaling
- **Shared Responsibilities**: Performance optimization, security configuration
- **Coordination Mechanisms**: Infrastructure as code, monitoring dashboards

### Technology Integration
- CI/CD pipeline integration with automated testing
- Database migration and schema management
- Caching layer configuration and management
- Monitoring and alerting system integration

## Advanced Topics

### Scaling Considerations
- Horizontal scaling with load balancers and multiple application servers
- Database sharding and read replica strategies
- Caching layers with Redis or Memcached
- Microservices architecture for large applications

### Customization and Adaptation
- Framework selection based on project requirements
- Custom middleware and service provider development
- Domain-specific language and business rule implementation
- Integration with legacy systems and third-party services

### Innovation and Evolution
- Adoption of new PHP features and language improvements
- Framework and library evaluation and migration strategies
- Performance optimization and cutting-edge caching techniques
- Modern development patterns and architectural approaches

## AI Assistant Guidelines

When helping with PHP Development:

1. **Assessment First**: Always assess current PHP version and project requirements before recommending solutions
2. **Security Priority**: Prioritize security best practices in all code recommendations
3. **Modern Standards**: Use PHP 8+ features and modern frameworks when appropriate
4. **Performance Focus**: Include performance considerations in all architectural decisions
5. **Type Safety**: Enforce strict typing and proper type declarations
6. **Framework Integration**: Recommend appropriate frameworks based on project scale and requirements
7. **Testing Strategy**: Include testing approaches and examples in all recommendations
8. **Documentation**: Ensure comprehensive documentation for all generated code

### Decision Making Framework
When helping teams choose PHP approaches:

1. **Requirements Analysis**: Understand performance, security, and scalability needs
2. **Framework Selection**: Evaluate Laravel, Symfony, or custom solutions based on requirements
3. **Architecture Design**: Recommend appropriate patterns (MVC, Repository, Service Layer)
4. **Security Assessment**: Identify potential security risks and mitigation strategies
5. **Performance Planning**: Design for expected load and growth patterns
6. **Integration Strategy**: Plan for frontend, database, and third-party service integration

### Code Generation Rules
- Generate code using PHP 8+ features and strict typing
- Include comprehensive error handling and validation
- Use proper design patterns and SOLID principles
- Implement security best practices by default
- Include PHPDoc documentation for all public methods
- Follow PSR-12 coding standards for formatting
- Generate corresponding unit tests for business logic
- Include performance considerations and optimization hints

### Quality Enforcement
- ✅ Enforce strict types declaration in all PHP files
- ✅ Require prepared statements for all database queries
- ✅ Block string concatenation in loops for performance
- ✅ Enforce input validation and sanitization
- ✅ Require proper error handling and logging
- ✅ Promote API-first architecture with clear separation
- ✅ Enforce comprehensive testing strategies
- ✅ Require security best practices in all recommendations