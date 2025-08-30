---
applyTo: 'symfony, symfony/framework-bundle'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Symfony 7.x with modern PHP 8.3+ features and components'
---

# Symfony Framework Instructions for AI Agents

## When to Use Symfony

Use Symfony when you need:

- Enterprise-grade PHP applications with robust architecture
- Flexible component-based development (reusable Symfony components)
- High-performance applications with advanced caching and optimization
- Complex business logic requiring dependency injection and service architecture
- Large team development with strict coding standards
- Long-term maintainability and stability
- Integration with existing enterprise systems
- API development with comprehensive tooling
- Full-stack web applications with modern frontend integration

## When to Avoid Symfony

Consider alternatives when:

- Building simple prototypes or MVPs (consider Laravel for faster development)
- Small team with limited Symfony experience
- Projects requiring rapid development cycles
- Simple content websites (consider WordPress or static generators)
- Microservices requiring minimal overhead (consider Slim or Lumen)
- Budget constraints that don't allow for learning curve investment

## Framework Overview

- **Framework**: Symfony 7.x
- **Type**: Component-based PHP web application framework
- **Architecture**: HTTP-kernel based with dependency injection container
- **Language**: PHP 8.3+ with strong OOP principles and modern features
- **Use Cases**: Enterprise web apps, APIs, microservices, console applications

## Installation & Setup

### ✅ Recommended: Symfony CLI

```bash
# Install Symfony CLI
curl -sS https://get.symfony.com/cli/installer | bash

# Create new web application
symfony new my_project --version="7.0.*" --webapp

# Create API-only application
symfony new my_api --version="7.0.*"

# Create microservice
symfony new my_service --version="7.0.*" --minimal

# Start development server
cd my_project
symfony serve -d  # Runs in background
```

### Alternative: Composer

```bash
# Web application skeleton
composer create-project symfony/skeleton:"7.0.*" my_project
cd my_project
composer require webapp

# API skeleton  
composer create-project symfony/skeleton:"7.0.*" my_api
cd my_api
composer require api

# Minimal installation
composer create-project symfony/skeleton:"7.0.*" my_minimal
```

## Project Structure

```
my_project/
├── assets/                 # Frontend assets (CSS, JS)
├── bin/                   # Executable files
│   └── console           # Symfony console
├── config/               # Configuration files
│   ├── packages/         # Package configurations
│   ├── routes/          # Routing configurations
│   └── services.yaml    # Service definitions
├── migrations/          # Database migrations
├── public/              # Web-accessible directory
│   └── index.php       # Front controller
├── src/                 # Application source code
│   ├── Controller/      # Controllers
│   ├── Entity/          # Doctrine entities
│   ├── Repository/      # Doctrine repositories
│   ├── Service/         # Business logic services
│   └── Kernel.php      # Application kernel
├── templates/           # Twig templates
├── tests/              # Unit and functional tests
├── translations/       # Internationalization files
├── var/               # Generated files (cache, logs)
├── vendor/            # Composer dependencies
├── .env               # Environment variables
├── composer.json      # Composer configuration
└── symfony.lock      # Symfony Flex lock file
```

## Core Concepts

### Dependency Injection Container

- **Purpose**: Manage service dependencies and application configuration
- **Usage**: Define services and inject dependencies automatically

```php
// config/services.yaml
services:
    _defaults:
        autowire: true
        autoconfigure: true

    App\:
        resource: '../src/'
        exclude:
            - '../src/DependencyInjection/'
            - '../src/Entity/'
            - '../src/Kernel.php'

    App\Service\EmailService:
        arguments:
            $mailerDsn: '%env(MAILER_DSN)%'
            $fromEmail: '%env(FROM_EMAIL)%'

# Service class with dependency injection
// src/Service/EmailService.php
<?php

namespace App\Service;

use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;

class EmailService
{
    public function __construct(
        private MailerInterface $mailer,
        private string $mailerDsn,
        private string $fromEmail
    ) {}

    public function sendWelcomeEmail(string $to, string $name): void
    {
        $email = (new Email())
            ->from($this->fromEmail)
            ->to($to)
            ->subject('Welcome!')
            ->text("Welcome {$name}!");

        $this->mailer->send($email);
    }
}
```

### Controllers and Routing

- **Purpose**: Handle HTTP requests and return responses
- **Usage**: Create controllers with attributes for modern routing

```php
// src/Controller/ApiController.php
<?php

namespace App\Controller;

use App\Entity\User;
use App\Service\UserService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

#[Route('/api/users', name: 'api_users_')]
class UserController extends AbstractController
{
    public function __construct(
        private UserService $userService,
        private SerializerInterface $serializer,
        private ValidatorInterface $validator
    ) {}

    #[Route('', name: 'list', methods: ['GET'])]
    public function list(): JsonResponse
    {
        $users = $this->userService->getAllUsers();
        
        return $this->json($users, context: ['groups' => 'user:read']);
    }

    #[Route('/{id}', name: 'show', methods: ['GET'])]
    public function show(User $user): JsonResponse
    {
        return $this->json($user, context: ['groups' => 'user:read']);
    }

    #[Route('', name: 'create', methods: ['POST'])]
    public function create(Request $request): JsonResponse
    {
        $user = $this->serializer->deserialize(
            $request->getContent(),
            User::class,
            'json',
            ['groups' => 'user:write']
        );

        $errors = $this->validator->validate($user);
        if (count($errors) > 0) {
            return $this->json(['errors' => (string) $errors], Response::HTTP_BAD_REQUEST);
        }

        $user = $this->userService->createUser($user);
        
        return $this->json($user, Response::HTTP_CREATED, [], ['groups' => 'user:read']);
    }
}
```

### Doctrine ORM Integration

- **Purpose**: Object-relational mapping for database operations
- **Usage**: Define entities with attributes and repositories

```php
// src/Entity/User.php
<?php

namespace App\Entity;

use App\Repository\UserRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Serializer\Annotation\Groups;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity(repositoryClass: UserRepository::class)]
#[ORM\Table(name: 'users')]
class User implements UserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(['user:read'])]
    private ?int $id = null;

    #[ORM\Column(length: 180, unique: true)]
    #[Assert\NotBlank]
    #[Assert\Email]
    #[Groups(['user:read', 'user:write'])]
    private ?string $email = null;

    #[ORM\Column]
    private array $roles = [];

    #[ORM\Column]
    #[Groups(['user:write'])]
    private ?string $password = null;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank]
    #[Assert\Length(min: 2, max: 255)]
    #[Groups(['user:read', 'user:write'])]
    private ?string $firstName = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    #[Groups(['user:read'])]
    private ?\DateTimeInterface $createdAt = null;

    public function __construct()
    {
        $this->createdAt = new \DateTime();
    }

    // Getters and setters...
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): static
    {
        $this->email = $email;
        return $this;
    }

    public function getUserIdentifier(): string
    {
        return (string) $this->email;
    }

    public function getRoles(): array
    {
        $roles = $this->roles;
        $roles[] = 'ROLE_USER';
        return array_unique($roles);
    }
}
```

## ✅ Best Practices

### Service Architecture

```php
// src/Service/UserService.php
<?php

namespace App\Service;

use App\Entity\User;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class UserService
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private UserRepository $userRepository,
        private UserPasswordHasherInterface $passwordHasher,
        private EmailService $emailService
    ) {}

    public function createUser(User $user): User
    {
        // Hash password
        $hashedPassword = $this->passwordHasher->hashPassword($user, $user->getPassword());
        $user->setPassword($hashedPassword);

        // Persist to database
        $this->entityManager->persist($user);
        $this->entityManager->flush();

        // Send welcome email
        $this->emailService->sendWelcomeEmail(
            $user->getEmail(),
            $user->getFirstName()
        );

        return $user;
    }

    public function getAllUsers(): array
    {
        return $this->userRepository->findAll();
    }

    public function findUserByEmail(string $email): ?User
    {
        return $this->userRepository->findOneBy(['email' => $email]);
    }

    public function updateUser(User $user): User
    {
        $this->entityManager->flush();
        return $user;
    }

    public function deleteUser(User $user): void
    {
        $this->entityManager->remove($user);
        $this->entityManager->flush();
    }
}
```

### Configuration Management

```yaml
# config/packages/framework.yaml
framework:
    secret: '%env(APP_SECRET)%'
    csrf_protection: true
    http_method_override: false
    handle_all_throwables: true
    trusted_hosts: ~
    trusted_proxies: ~
    trusted_headers: ['x-forwarded-for', 'x-forwarded-host', 'x-forwarded-proto', 'x-forwarded-port', 'x-forwarded-prefix']

# config/packages/doctrine.yaml
doctrine:
    dbal:
        url: '%env(resolve:DATABASE_URL)%'
        profiling_collect_backtrace: '%kernel.debug%'
    orm:
        auto_generate_proxy_classes: true
        enable_lazy_ghost_objects: true
        naming_strategy: doctrine.orm.naming_strategy.underscore_number_aware
        auto_mapping: true
        mappings:
            App:
                is_bundle: false
                dir: '%kernel.project_dir%/src/Entity'
                prefix: 'App\Entity'
                alias: App

# config/packages/security.yaml
security:
    password_hashers:
        Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface: 'auto'
    
    providers:
        app_user_provider:
            entity:
                class: App\Entity\User
                property: email
    
    firewalls:
        dev:
            pattern: ^/(_(profiler|wdt)|css|images|js)/
            security: false
        main:
            lazy: true
            provider: app_user_provider
            json_login:
                check_path: /api/login
                username_path: email
                password_path: password
            logout:
                path: /api/logout
    
    access_control:
        - { path: ^/api/login, roles: PUBLIC_ACCESS }
        - { path: ^/api/register, roles: PUBLIC_ACCESS }
        - { path: ^/api, roles: ROLE_USER }
```

### Environment Configuration

```bash
# .env
APP_ENV=dev
APP_SECRET=your-secret-key
DATABASE_URL="mysql://root:password@127.0.0.1:3306/symfony_app?serverVersion=8.0"
MAILER_DSN=smtp://localhost:1025
FROM_EMAIL=noreply@example.com

# .env.prod
APP_ENV=prod
APP_DEBUG=false
DATABASE_URL="mysql://user:pass@prod-db:3306/prod_db?serverVersion=8.0"
MAILER_DSN=smtp://smtp.gmail.com:587?encryption=tls&auth_mode=oauth&username=user&password=pass
```

## Common Patterns

### API Development with Serialization

```php
// src/Controller/ProductController.php
<?php

namespace App\Controller;

use App\Entity\Product;
use App\Service\ProductService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use OpenApi\Attributes as OA;

#[Route('/api/products')]
#[OA\Tag(name: 'Products')]
class ProductController extends AbstractController
{
    public function __construct(
        private ProductService $productService,
        private SerializerInterface $serializer,
        private ValidatorInterface $validator
    ) {}

    #[Route('', methods: ['GET'])]
    #[OA\Get(description: 'Get all products')]
    #[OA\Response(response: 200, description: 'List of products')]
    public function index(): JsonResponse
    {
        $products = $this->productService->getAllProducts();
        
        return $this->json($products, context: [
            'groups' => 'product:read'
        ]);
    }

    #[Route('', methods: ['POST'])]
    #[OA\Post(description: 'Create a new product')]
    #[OA\RequestBody(content: new OA\JsonContent(ref: '#/components/schemas/Product'))]
    public function create(Request $request): JsonResponse
    {
        $product = $this->serializer->deserialize(
            $request->getContent(),
            Product::class,
            'json',
            ['groups' => 'product:write']
        );

        $errors = $this->validator->validate($product);
        if (count($errors) > 0) {
            return $this->json(['errors' => (string) $errors], 400);
        }

        $product = $this->productService->createProduct($product);
        
        return $this->json($product, 201, [], ['groups' => 'product:read']);
    }
}
```

### Console Commands

```php
// src/Command/ImportUsersCommand.php
<?php

namespace App\Command;

use App\Service\UserImportService;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'app:import:users',
    description: 'Import users from CSV file'
)]
class ImportUsersCommand extends Command
{
    public function __construct(
        private UserImportService $importService
    ) {
        parent::__construct();
    }

    protected function configure(): void
    {
        $this
            ->addArgument('file', InputArgument::REQUIRED, 'Path to CSV file')
            ->addOption('dry-run', null, InputOption::VALUE_NONE, 'Run without persisting data')
            ->addOption('batch-size', 'b', InputOption::VALUE_OPTIONAL, 'Batch size for processing', 100);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $file = $input->getArgument('file');
        $dryRun = $input->getOption('dry-run');
        $batchSize = (int) $input->getOption('batch-size');

        if (!file_exists($file)) {
            $io->error("File not found: {$file}");
            return Command::FAILURE;
        }

        $io->title('User Import');
        
        if ($dryRun) {
            $io->note('Running in dry-run mode');
        }

        $result = $this->importService->importFromCsv($file, $batchSize, $dryRun);

        $io->success([
            "Import completed successfully!",
            "Processed: {$result['processed']} users",
            "Created: {$result['created']} users",
            "Errors: {$result['errors']} users"
        ]);

        return Command::SUCCESS;
    }
}
```

### Event Listeners and Subscribers

```php
// src/EventListener/UserCreatedListener.php
<?php

namespace App\EventListener;

use App\Event\UserCreatedEvent;
use App\Service\EmailService;
use App\Service\LoggingService;
use Symfony\Component\EventDispatcher\Attribute\AsEventListener;

class UserCreatedListener
{
    public function __construct(
        private EmailService $emailService,
        private LoggingService $loggingService
    ) {}

    #[AsEventListener(event: UserCreatedEvent::class)]
    public function onUserCreated(UserCreatedEvent $event): void
    {
        $user = $event->getUser();
        
        // Send welcome email
        $this->emailService->sendWelcomeEmail(
            $user->getEmail(),
            $user->getFirstName()
        );
        
        // Log user creation
        $this->loggingService->logUserAction('user_created', $user->getId());
    }
}
```

## Integration Points

### Doctrine Extensions Integration

- **Purpose**: Advanced ORM features (timestampable, sluggable, etc.)
- **Setup**: `composer require stof/doctrine-extensions-bundle`
- **Usage**: Configure extensions for automatic behavior
  ```yaml
  # config/packages/stof_doctrine_extensions.yaml
  stof_doctrine_extensions:
      orm:
          default:
              timestampable: true
              sluggable: true
  ```

### API Platform Integration

- **Purpose**: Rapid API development with automatic documentation
- **Setup**: `composer require api-platform/api-pack`
- **Usage**: Add attributes to entities for automatic API generation
  ```php
  #[ApiResource(
      operations: [
          new Get(),
          new GetCollection(),
          new Post(),
          new Put(),
          new Delete()
      ]
  )]
  class Product {}
  ```

## Version Compatibility

- **PHP**: 8.3+ (8.3 recommended for latest features)
- **Symfony**: 7.0+ (LTS versions recommended for production)
- **Composer**: 2.x
- **Database**: MySQL 8.0+, PostgreSQL 13+, SQLite 3.35+
- **Web Server**: Apache 2.4+, Nginx 1.18+, or Symfony CLI server

## Troubleshooting

### Debug Mode

```bash
# Enable debug mode
export APP_ENV=dev
export APP_DEBUG=1

# Clear cache
php bin/console cache:clear

# Debug container services
php bin/console debug:container
php bin/console debug:container UserService

# Debug routes
php bin/console debug:router
php bin/console debug:router app_user_list
```

### Log Analysis

- **Application logs**: `var/log/dev.log` or `var/log/prod.log`
- **Web server logs**: Check Apache/Nginx error logs
- **Database queries**: Enable Doctrine query logging in dev environment

### Common Error Messages

- **Error**: `The service "App\Service\MyService" has a dependency on a non-existent service`
  **Cause**: Service not properly registered or dependency injection misconfigured
  **Solution**: Check service configuration and ensure all dependencies are registered

- **Error**: `Cannot autowire service: argument $param has no type-hint`
  **Cause**: Missing type hint for dependency injection
  **Solution**: Add proper type hints or configure service manually in services.yaml

- **Error**: `An exception occurred in driver: SQLSTATE[42S02]`
  **Cause**: Database table doesn't exist
  **Solution**: Run migrations with `php bin/console doctrine:migrations:migrate`
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
