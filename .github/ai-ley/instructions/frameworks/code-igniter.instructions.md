---
name: 'Code Igniter.Instructions'
description: 'See [example-1](./examples/code-igniter/example-1.'
keywords: [[pattern, [concept, architecture, analysis, api, authorization, agents, avoid, building, authentication]
---



# CodeIgniter Framework Instructions for AI Agents

## When to Use CodeIgniter

Use CodeIgniter when you need:

- Rapid web application development with minimal configuration
- Small to medium-sized projects with straightforward requirements
- Learning-friendly PHP framework with excellent documentation
- Lightweight framework with small footprint and fast performance
- Easy migration from legacy PHP applications
- Simple MVC architecture without complex abstractions
- Quick prototyping and MVP development
- Teams new to PHP frameworks seeking gentle learning curve
- Projects requiring minimal hosting requirements

## When to Avoid CodeIgniter

Consider alternatives when:

- Building large enterprise applications (consider Symfony or Laravel)
- Need advanced features like dependency injection or service containers
- Working with complex business logic requiring sophisticated architecture
- Building APIs requiring extensive validation and serialization (consider Laravel API)
- Need comprehensive testing tools and modern development practices
- Working with microservices architecture
- Require extensive third-party package ecosystem

## Framework Overview

- **Framework**: CodeIgniter 4.x
- **Type**: Lightweight PHP web application framework
- **Architecture**: Model-View-Controller (MVC) with simple structure
- **Language**: PHP 8.0+ with modern language features support
- **Use Cases**: Web applications, REST APIs, content management systems, small business websites

## Installation & Setup

### ✅ Recommended: Composer Installation

See [example-1](./examples/code-igniter/example-1.bash)

### Manual Installation

See [example-2](./examples/code-igniter/example-2.bash)

## Project Structure

See [example-3](./examples/code-igniter/example-3.txt)

## Core Concepts

### Controllers

- **Purpose**: Handle HTTP requests and coordinate application flow
- **Usage**: Create controllers extending BaseController

See [example-4](./examples/code-igniter/example-4.php)

### Models

- **Purpose**: Interact with database using active record pattern
- **Usage**: Create models extending Model class

See [example-5](./examples/code-igniter/example-5.php)

### Views and Templating

- **Purpose**: Render HTML output with data from controllers
- **Usage**: Create PHP templates with built-in parser or third-party engines

See [example-6](./examples/code-igniter/example-6.php)

## ✅ Best Practices

### Configuration Management

See [example-7](./examples/code-igniter/example-7.php)

### Routing Configuration

See [example-8](./examples/code-igniter/example-8.php)

### Request Handling and Validation

See [example-9](./examples/code-igniter/example-9.php)

## Common Patterns

### Authentication and Authorization

See [example-10](./examples/code-igniter/example-10.php)

### Database Migration and Seeding

See [example-11](./examples/code-igniter/example-11.php)

## Integration Points

### Third-Party Library Integration

- **Purpose**: Integrate external libraries and packages
- **Setup**: Use Composer for dependency management
- **Usage**: 
  See [example-12](./examples/code-igniter/example-12.bash)

### RESTful API Development

- **Purpose**: Build APIs with proper HTTP methods and status codes
- **Setup**: Use ResourceController and ResponseTrait
- **Usage**: 
  See [example-13](./examples/code-igniter/example-13.php)

## Version Compatibility

- **PHP**: 8.0+ (8.1+ recommended for better performance)
- **MySQL**: 5.7+ or MariaDB 10.3+
- **PostgreSQL**: 10.0+
- **SQLite**: 3.7.17+
- **Apache**: 2.4+ with mod_rewrite
- **Nginx**: 1.7+

## Troubleshooting

### Debug Mode

See [example-14](./examples/code-igniter/example-14.bash)

### Log Analysis

- **Application logs**: `writable/logs/log-YYYY-MM-DD.log`
- **Error logs**: Check web server error logs
- **Database logs**: Enable query logging in Database config

### Common Error Messages

- **Error**: `The action you requested is not allowed`
  **Cause**: CSRF protection triggered or missing CSRF token
  **Solution**: Include `<?= csrf_field() ?>` in forms or disable CSRF for specific routes

- **Error**: `Class 'App\Models\MyModel' not found`
  **Cause**: Incorrect namespace or file not found
  **Solution**: Check namespace declaration and file location match PSR-4 standards

- **Error**: `Unable to connect to your database server`
  **Cause**: Database configuration incorrect or server unavailable
  **Solution**: Verify database credentials and server status in `app/Config/Database.php`
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
See [example-15](./examples/code-igniter/example-15.txt)[language]
// Example implementation
[code example]
See [example-16](./examples/code-igniter/example-16.txt)[format]
# Configuration options
[example configuration]
See [example-17](./examples/code-igniter/example-17.txt)[format]
# Configuration options
[example configuration]
See [example-18](./examples/code-igniter/example-18.txt)bash
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
See [example-19](./examples/code-igniter/example-19.txt)bash
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
