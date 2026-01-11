---
name: 'Laravel PHP Web Framework Instructions'
description: 'Comprehensive guide for Laravel framework with Eloquent ORM, Artisan'
keywords: [agent, [pattern, [concept, analysis, api, authorization, **use, assessment, **avoid, authentication]
---


# Laravel PHP Web Framework Instructions

## Framework Overview

- **Framework Name**: Laravel
- **Version**: 10.x+ (Latest stable with PHP 8.1+ support and improved performance)
- **Type**: Full-Stack PHP Web Framework
- **Language**: PHP, Blade templating, JavaScript, CSS
- **Use Cases**: Web applications, APIs, e-commerce platforms, content management systems, enterprise applications

## When to Use Laravel

### ✅ **Use Laravel When**

- Building full-featured web applications with complex business logic
- Need rapid development with built-in authentication, routing, and ORM
- Team has PHP expertise and prefers mature, well-documented frameworks
- Building APIs that require robust features like rate limiting and API resources
- Need comprehensive testing tools and development environment (Sail, Valet)
- Developing applications requiring real-time features (broadcasting, queues)
- Building e-commerce platforms or content management systems
- Need excellent package ecosystem and community support
- Working on projects requiring strong security features and CSRF protection

### ❌ **Avoid Laravel When**

- Building simple static websites that don't need dynamic functionality
- Performance is absolutely critical and framework overhead is unacceptable
- Team lacks PHP experience or strongly prefers other languages
- Building microservices where lighter frameworks might be more appropriate
- Working with legacy PHP codebases that can't be modernized
- Need extremely fine-grained control over every aspect of the application
- Building real-time applications where Node.js might be more suitable

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type         | Laravel Recommendation                     | Key Strengths                        |
| -------------------- | ------------------------------------------ | ------------------------------------ |
| E-commerce Platform  | ✅ **Excellent** - Complete feature set    | Payment integration, user management |
| Content Management   | ✅ **Perfect** - Admin panels, CRUD        | Eloquent ORM, file management        |
| Business Application | ✅ **Ideal** - Complex business logic      | Form validation, authorization       |
| API Backend          | ✅ **Recommended** - API resources, auth   | Rate limiting, JSON responses        |
| Simple Blog          | 🔄 **Overkill** - Too much for basic needs | WordPress might be better            |
| Real-time App        | 🔄 **Consider** - Broadcasting available   | Node.js might be more suitable       |

### Team Expertise Assessment

| Team Background           | Laravel Suitability                   | Learning Curve                   |
| ------------------------- | ------------------------------------- | -------------------------------- |
| **PHP Experience**        | ✅ **Perfect** - Natural progression  | 1-2 weeks to productivity        |
| **MVC Frameworks**        | ✅ **Excellent** - Familiar patterns  | 1 week to understand Laravel way |
| **JavaScript Background** | 🔄 **Moderate** - Different paradigms | 2-4 weeks PHP learning           |
| **Complete Beginners**    | ✅ **Good** - Excellent documentation | 4-8 weeks comprehensive learning |

## Installation & Setup

See [example-1](./examples/laravel/example-1.bash)

## Project Structure

See [example-2](./examples/laravel/example-2.txt)

## Core Concepts

### [Concept 1]

- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
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
See [example-3](./examples/laravel/example-3.txt)[language]
// Example implementation
[code example]
See [example-4](./examples/laravel/example-4.txt)[format]
# Configuration options
[example configuration]
See [example-5](./examples/laravel/example-5.txt)[format]
# Configuration options
[example configuration]
See [example-6](./examples/laravel/example-6.txt)bash
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
See [example-7](./examples/laravel/example-7.txt)bash
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
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
