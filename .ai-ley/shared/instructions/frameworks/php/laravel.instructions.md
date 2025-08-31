---
title: 'Laravel PHP Web Framework Instructions'
description: 'Comprehensive guide for Laravel framework with Eloquent ORM, Artisan CLI, and modern PHP development patterns'
category: 'PHP Frameworks'

tags: ['laravel', 'php', 'eloquent', 'artisan', 'mvc', 'web-framework', 'api', 'full-stack']
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/artisan'
  - '**/composer.json'
  - '**/config/**'
  - '**/app/**'
  - '**/routes/**'
  - '**/database/**'
  - '**/resources/views/**'
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

```bash
# Installation commands
[package manager install command]

# Project initialization
[framework CLI or setup commands]
```

## Project Structure

```
project-root/
├── [typical folder structure]
├── [configuration files]
├── [source directories]
└── [other important directories]
```

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
