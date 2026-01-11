---
name: 'Symfony.Instructions'
description: 'See [example-1](./examples/symfony/example-1.'
keywords: [[pattern, [concept, architecture, analysis, api, cli, agents, avoid, building, alternative:]
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

See [example-1](./examples/symfony/example-1.bash)

### Alternative: Composer

See [example-2](./examples/symfony/example-2.bash)

## Project Structure

See [example-3](./examples/symfony/example-3.txt)

## Core Concepts

### Dependency Injection Container

- **Purpose**: Manage service dependencies and application configuration
- **Usage**: Define services and inject dependencies automatically

See [example-4](./examples/symfony/example-4.php)

### Controllers and Routing

- **Purpose**: Handle HTTP requests and return responses
- **Usage**: Create controllers with attributes for modern routing

See [example-5](./examples/symfony/example-5.php)

### Doctrine ORM Integration

- **Purpose**: Object-relational mapping for database operations
- **Usage**: Define entities with attributes and repositories

See [example-6](./examples/symfony/example-6.php)

## ✅ Best Practices

### Service Architecture

See [example-7](./examples/symfony/example-7.php)

### Configuration Management

See [example-8](./examples/symfony/example-8.yaml)

### Environment Configuration

See [example-9](./examples/symfony/example-9.bash)

## Common Patterns

### API Development with Serialization

See [example-10](./examples/symfony/example-10.php)

### Console Commands

See [example-11](./examples/symfony/example-11.php)

### Event Listeners and Subscribers

See [example-12](./examples/symfony/example-12.php)

## Integration Points

### Doctrine Extensions Integration

- **Purpose**: Advanced ORM features (timestampable, sluggable, etc.)
- **Setup**: `composer require stof/doctrine-extensions-bundle`
- **Usage**: Configure extensions for automatic behavior
  See [example-13](./examples/symfony/example-13.yaml)

### API Platform Integration

- **Purpose**: Rapid API development with automatic documentation
- **Setup**: `composer require api-platform/api-pack`
- **Usage**: Add attributes to entities for automatic API generation
  See [example-14](./examples/symfony/example-14.php)

## Version Compatibility

- **PHP**: 8.3+ (8.3 recommended for latest features)
- **Symfony**: 7.0+ (LTS versions recommended for production)
- **Composer**: 2.x
- **Database**: MySQL 8.0+, PostgreSQL 13+, SQLite 3.35+
- **Web Server**: Apache 2.4+, Nginx 1.18+, or Symfony CLI server

## Troubleshooting

### Debug Mode

See [example-15](./examples/symfony/example-15.bash)

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
See [example-16](./examples/symfony/example-16.txt)[language]
// Example implementation
[code example]
See [example-17](./examples/symfony/example-17.txt)[format]
# Configuration options
[example configuration]
See [example-18](./examples/symfony/example-18.txt)[format]
# Configuration options
[example configuration]
See [example-19](./examples/symfony/example-19.txt)bash
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
See [example-20](./examples/symfony/example-20.txt)bash
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
