---
name: 'Fastify.Instructions'
description: 'Development guidelines and best practices for Fastify.Instructions'
keywords: [cloud, application, common, architecture, api, caching, authorization, assistant, commands, authentication]
---



# Fastify Web Framework Instructions

## Framework Overview
- **Framework Name**: Fastify
- **Version**: 4.24+ (Latest stable)
- **Type**: Fast and low overhead web framework
- **Language**: Node.js/TypeScript
- **Use Cases**: REST APIs, microservices, high-performance web applications

## Installation & Setup
See [example-1](./examples/fastify/example-1.bash)

## Project Structure
See [example-2](./examples/fastify/example-2.txt)

## Core Concepts

### Application Setup
- **Purpose**: Initialize Fastify instance with configuration
- **Usage**: Set up server, plugins, and routes
- **Example**:
See [example-3](./examples/fastify/example-3.typescript)

### Route Definition with Schema Validation
- **Purpose**: Define API endpoints with validation and serialization
- **Usage**: Create type-safe routes with automatic documentation
- **Example**:
See [example-4](./examples/fastify/example-4.typescript)

### Plugin Development
- **Purpose**: Encapsulate functionality and promote reusability
- **Usage**: Create custom plugins for business logic
- **Example**:
See [example-5](./examples/fastify/example-5.typescript)

## Development Workflow
1. **Setup**: Initialize Fastify app with TypeScript configuration
2. **Development**: Create routes, plugins, and services with hot reload
3. **Testing**: Write comprehensive tests for routes and business logic
4. **Building**: Compile TypeScript and prepare for deployment
5. **Deployment**: Deploy with PM2, Docker, or cloud platforms

## Best Practices

### Error Handling and Logging
See [example-6](./examples/fastify/example-6.typescript)

### Authentication and Authorization
See [example-7](./examples/fastify/example-7.typescript)

## Common Patterns

### Service Layer Pattern
See [example-8](./examples/fastify/example-8.typescript)

## Configuration
### TypeScript Configuration
See [example-9](./examples/fastify/example-9.json)

### Environment Configuration
See [example-10](./examples/fastify/example-10.typescript)

## Essential Commands
See [example-11](./examples/fastify/example-11.json)

## Common Issues & Solutions

### Issue 1: Schema Validation Errors
**Problem**: TypeBox schema validation failures
**Solution**: Ensure proper schema definitions and error handling
See [example-12](./examples/fastify/example-12.typescript)

### Issue 2: Plugin Loading Order
**Problem**: Plugins loading in wrong order causing dependencies issues
**Solution**: Use proper plugin dependencies and registration order
See [example-13](./examples/fastify/example-13.typescript)

## Performance Optimization

### Caching and Compression
See [example-14](./examples/fastify/example-14.typescript)

## Security Considerations
- Always validate input using schemas
- Implement proper authentication and authorization
- Use HTTPS in production
- Configure CORS appropriately
- Implement rate limiting
- Sanitize database queries to prevent injection

## Useful Resources
- **Official Documentation**: https://www.fastify.io/docs/
- **TypeScript Guide**: https://www.fastify.io/docs/latest/Reference/TypeScript/
- **Plugin Ecosystem**: https://www.fastify.io/ecosystem/
- **GitHub Repository**: https://github.com/fastify/fastify

## Framework-Specific Guidelines

### Code Style
- Use TypeScript for type safety and better development experience
- Implement comprehensive error handling and logging
- Use plugins for reusable functionality
- Follow RESTful API design principles

### Architecture Patterns
- Separate routes, services, and data access layers
- Use dependency injection through Fastify decorators
- Implement proper configuration management
- Create reusable plugins for common functionality

## Integration Points

### Database Integration
- **Purpose**: Data persistence and querying
- **Setup**: Use appropriate database drivers (pg, mysql2, mongodb)
- **Usage**: Implement repository pattern with connection pooling

### Testing Integration
- **Purpose**: Comprehensive testing of routes and business logic
- **Setup**: Jest with Fastify testing utilities
- **Usage**: Unit, integration, and end-to-end testing

## Troubleshooting

### Debug Mode
See [example-15](./examples/fastify/example-15.typescript)

## AI Assistant Guidelines
When helping with Fastify implementation:

1. **Always use TypeScript** for better type safety and development experience
2. **Implement schema validation** for all routes using TypeBox
3. **Use plugins** for code organization and reusability
4. **Include proper error handling** and logging throughout the application
5. **Suggest appropriate security measures** including authentication and rate limiting
6. **Recommend performance optimizations** like compression and caching
7. **Provide testing strategies** for routes and business logic
8. **Reference official documentation** for best practices and advanced features

### Code Generation Rules
- Generate type-safe routes with comprehensive schema validation
- Include proper error handling and logging in all generated code
- Use Fastify plugins for organizing functionality
- Follow TypeScript best practices and naming conventions
- Include security considerations in generated code
- Provide performance-optimized implementations
- Generate comprehensive tests for all functionality

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
