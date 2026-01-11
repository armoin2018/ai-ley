---
name: 'Qwik.Instructions'
description: 'Development guidelines and best practices for Qwik.Instructions'
keywords: [common, cli, caching, concepts, assistant, actions, additional, commands, authentication, adapters]
---



# Qwik Framework Instructions

## Framework Overview
- **Framework Name**: Qwik
- **Version**: 1.6+ (Latest stable)
- **Type**: Resumable frontend framework with instant loading
- **Language**: TypeScript/JavaScript (with JSX)
- **Use Cases**: High-performance web applications, instant loading, edge-first development

## Installation & Setup

### Project Creation
See [example-1](./examples/qwik/example-1.bash)

### Additional Packages
See [example-2](./examples/qwik/example-2.bash)

## Project Structure
See [example-3](./examples/qwik/example-3.txt)

## Core Concepts

### Resumability and Lazy Loading
- **Purpose**: Qwik's unique resumability approach for instant loading
- **Usage**: Components and functions are lazy-loaded and resumable
- **Example**:
See [example-4](./examples/qwik/example-4.tsx)

### Qwik City Routing
- **Purpose**: File-based routing with server-side rendering and streaming
- **Usage**: Create pages in routes directory with automatic routing
- **Example**:
See [example-5](./examples/qwik/example-5.tsx)

### State Management and Stores
- **Purpose**: Manage application state with reactive stores and signals
- **Usage**: Create context-based state management with useStore and useSignal
- **Example**:
See [example-6](./examples/qwik/example-6.tsx)

## Development Workflow
1. **Setup**: Create Qwik project with City routing
2. **Development**: Build resumable components with $ syntax
3. **Routing**: Create file-based routes with data loaders
4. **State**: Implement reactive state management
5. **Deploy**: Deploy to edge platforms with appropriate adapters

## Best Practices

### Server Actions and Forms
See [example-7](./examples/qwik/example-7.tsx)

### Performance Optimization
See [example-8](./examples/qwik/example-8.tsx)

## Common Patterns

### Data Fetching and Caching
See [example-9](./examples/qwik/example-9.tsx)

## Configuration
### Vite Configuration
See [example-10](./examples/qwik/example-10.typescript)

### Deployment Adapters
See [example-11](./examples/qwik/example-11.typescript)

## Essential Commands
See [example-12](./examples/qwik/example-12.json)

## Common Issues & Solutions

### Issue 1: Serialization Errors
**Problem**: Objects not serializable between server and client
**Solution**: Use serializable data types and avoid closures
See [example-13](./examples/qwik/example-13.tsx)

### Issue 2: Hydration Mismatches
**Problem**: Server and client render differently
**Solution**: Use isServer check and proper data fetching
See [example-14](./examples/qwik/example-14.tsx)

## Security Considerations
- Validate all server actions and route loaders
- Use HTTPS for production deployments
- Implement proper authentication and CSRF protection
- Sanitize user inputs to prevent XSS attacks
- Use environment variables for sensitive configuration

## AI Assistant Guidelines
When helping with Qwik implementation:

1. **Always use the $ suffix** for lazy-loaded functions and event handlers
2. **Emphasize resumability benefits** over traditional hydration
3. **Use proper TypeScript typing** throughout the application
4. **Implement server actions** for form handling and data mutations
5. **Leverage route loaders** for server-side data fetching
6. **Follow Qwik City conventions** for file-based routing
7. **Include proper error handling** and loading states
8. **Reference Qwik documentation** for advanced optimization techniques

### Code Generation Rules
- Generate components using component$ with proper $ syntax
- Use useSignal and useStore for reactive state management
- Implement server actions with proper validation using zod$
- Follow Qwik City routing conventions and file structure
- Include proper TypeScript interfaces and type safety
- Use routeLoader$ for server-side data fetching
- Generate edge-optimized code suitable for deployment
- Include performance optimizations and lazy loading patterns

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
