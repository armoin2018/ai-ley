---
name: 'Nuxt Js.Instructions'
description: 'Development guidelines and best practices for Nuxt Js.Instructions'
keywords: [api, commands, common, bundle, assistant, authentication, architecture, backend, analysis, cli]
---



# Nuxt.js Vue Framework Instructions

## Framework Overview
- **Framework Name**: Nuxt.js
- **Version**: 3.8+ (Latest stable)
- **Type**: Full-stack Vue.js framework
- **Language**: Vue.js/TypeScript/JavaScript
- **Use Cases**: SSR/SSG applications, JAMstack sites, universal web apps

## Installation & Setup
See [example-1](./examples/nuxt-js/example-1.bash)

## Project Structure
See [example-2](./examples/nuxt-js/example-2.txt)

## Core Concepts

### Pages and Routing
- **Purpose**: File-based routing system with automatic code splitting
- **Usage**: Create Vue components in pages directory for automatic routing
- **Example**:
See [example-3](./examples/nuxt-js/example-3.vue)

### Components and Auto-imports
- **Purpose**: Reusable Vue components with automatic registration
- **Usage**: Create components that are automatically available globally
- **Example**:
See [example-4](./examples/nuxt-js/example-4.vue)

### Server API Routes
- **Purpose**: Full-stack development with server-side API endpoints
- **Usage**: Create API routes in server directory for backend functionality
- **Example**:
See [example-5](./examples/nuxt-js/example-5.typescript)

## Development Workflow
1. **Setup**: Initialize Nuxt project with TypeScript configuration
2. **Development**: Create pages, components, and API routes with hot reload
3. **Testing**: Write comprehensive tests for components and server functions
4. **Building**: Generate static or server-side rendered builds
5. **Deployment**: Deploy to various platforms (Vercel, Netlify, etc.)

## Best Practices

### State Management with Pinia
See [example-6](./examples/nuxt-js/example-6.typescript)

### Composables for Reusable Logic
See [example-7](./examples/nuxt-js/example-7.typescript)

## Common Patterns

### Layout System
See [example-8](./examples/nuxt-js/example-8.vue)

### Middleware for Authentication
See [example-9](./examples/nuxt-js/example-9.typescript)

## Configuration
### Nuxt Configuration
See [example-10](./examples/nuxt-js/example-10.typescript)

## Essential Commands
See [example-11](./examples/nuxt-js/example-11.json)

## Common Issues & Solutions

### Issue 1: Hydration Mismatch
**Problem**: Client-side rendering differs from server-side
**Solution**: Use `<ClientOnly>` component or ensure data consistency
See [example-12](./examples/nuxt-js/example-12.vue)

### Issue 2: SEO Meta Tags Not Working
**Problem**: Meta tags not properly set for dynamic content
**Solution**: Use `useSeoMeta` composable correctly
See [example-13](./examples/nuxt-js/example-13.typescript)

## Performance Optimization

### Image Optimization
See [example-14](./examples/nuxt-js/example-14.vue)

### Bundle Analysis
See [example-15](./examples/nuxt-js/example-15.bash)

## Security Considerations
- Validate all user inputs on server-side
- Use CSRF protection for forms
- Implement proper authentication middleware
- Sanitize HTML content to prevent XSS
- Use environment variables for sensitive data

## Useful Resources
- **Official Documentation**: https://nuxt.com/docs
- **Nuxt Modules**: https://nuxt.com/modules
- **Vue.js Guide**: https://vuejs.org/guide/
- **GitHub Repository**: https://github.com/nuxt/nuxt

## Framework-Specific Guidelines

### Code Style
- Use Composition API with `<script setup>` syntax
- Implement proper TypeScript typing throughout
- Use auto-imports for better developer experience
- Follow Vue.js style guide and naming conventions

### Architecture Patterns
- Organize code using Nuxt's directory structure
- Use composables for reusable logic
- Implement proper state management with Pinia
- Create reusable components with proper prop validation

## Integration Points

### Database Integration
- **Purpose**: Server-side data persistence and querying
- **Setup**: Use Prisma, Drizzle, or other ORMs with server API routes
- **Usage**: Implement CRUD operations in server directory

### Testing Integration
- **Purpose**: Comprehensive testing of components and server functions
- **Setup**: Vitest with @nuxt/test-utils
- **Usage**: Unit, integration, and E2E testing strategies

## Troubleshooting

### Debug Mode
See [example-16](./examples/nuxt-js/example-16.typescript)

## AI Assistant Guidelines
When helping with Nuxt.js implementation:

1. **Always use TypeScript** for better type safety and development experience
2. **Leverage auto-imports** for components, composables, and utilities
3. **Use server API routes** for full-stack functionality
4. **Implement proper SEO** with useSeoMeta and structured data
5. **Suggest appropriate rendering strategy** (SSR, SSG, SPA) based on use case
6. **Include proper error handling** and loading states
7. **Recommend performance optimizations** like lazy loading and code splitting
8. **Reference official Nuxt documentation** for best practices

### Code Generation Rules
- Generate type-safe Vue components with proper prop definitions
- Use Composition API with `<script setup>` syntax consistently
- Include comprehensive error handling and loading states
- Follow Nuxt's directory structure and naming conventions
- Implement proper SEO and meta tag management
- Use modern Vue.js patterns and best practices
- Generate server API routes with proper validation and error handling

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
