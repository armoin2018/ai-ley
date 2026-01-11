---
name: 'Slim.Instructions'
description: 'See [example-1](./examples/slim/example-1.'
keywords: [api, application, agents, [concept, (eloquent, architecture, authentication, [pattern, analysis, avoid]
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

See [example-1](./examples/slim/example-1.bash)

### Manual Setup

See [example-2](./examples/slim/example-2.bash)

## Project Structure

See [example-3](./examples/slim/example-3.txt)

## Core Concepts

### Application Setup and Configuration

- **Purpose**: Initialize Slim application with middleware and routes
- **Usage**: Configure application in entry point with dependency injection

See [example-4](./examples/slim/example-4.php)

### Routing and Controllers

- **Purpose**: Define API endpoints and handle HTTP requests
- **Usage**: Create RESTful routes with controller methods

See [example-5](./examples/slim/example-5.php)

### Controllers and Request Handling

- **Purpose**: Handle business logic and return JSON responses
- **Usage**: Create controller classes with dependency injection

See [example-6](./examples/slim/example-6.php)

## ✅ Best Practices

### Middleware Implementation

See [example-7](./examples/slim/example-7.php)

### Service Layer and Business Logic

See [example-8](./examples/slim/example-8.php)

### Dependency Injection Configuration

See [example-9](./examples/slim/example-9.php)

## Common Patterns

### JSON API Response Helper

See [example-10](./examples/slim/example-10.php)

### Request Validation

See [example-11](./examples/slim/example-11.php)

### JWT Authentication Service

See [example-12](./examples/slim/example-12.php)

## Integration Points

### Database Integration (Eloquent ORM)

- **Purpose**: Database operations with Laravel's Eloquent ORM
- **Setup**: `composer require illuminate/database`
- **Usage**: 
  See [example-13](./examples/slim/example-13.php)

### Caching Integration

- **Purpose**: Improve performance with Redis or file-based caching
- **Setup**: `composer require predis/predis`
- **Usage**: 
  See [example-14](./examples/slim/example-14.php)

## Version Compatibility

- **PHP**: 8.1+ (8.2+ recommended for latest features)
- **Composer**: 2.x
- **PSR**: PSR-7, PSR-15, PSR-11 compliant
- **Database**: MySQL 8.0+, PostgreSQL 13+, SQLite 3.35+
- **Web Server**: Apache 2.4+, Nginx 1.18+, or PHP built-in server

## Troubleshooting

### Debug Mode

See [example-15](./examples/slim/example-15.bash)

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
See [example-16](./examples/slim/example-16.txt)[language]
// Example implementation
[code example]
See [example-17](./examples/slim/example-17.txt)[format]
# Configuration options
[example configuration]
See [example-18](./examples/slim/example-18.txt)[format]
# Configuration options
[example configuration]
See [example-19](./examples/slim/example-19.txt)bash
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
See [example-20](./examples/slim/example-20.txt)bash
[debug commands]
```

### Log Analysis
- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages
- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
