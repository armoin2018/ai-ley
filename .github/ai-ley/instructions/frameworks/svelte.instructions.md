---
name: 'Svelte.Instructions'
description: 'See [example-9](./examples/svelte/example-9.'
keywords: [api, agent, (lightweight), agents, (full, alternative:, architecture, authentication, authorization, (sveltekit)]
---



# Svelte Framework Instructions for AI Agents

## When to Use Svelte
Use Svelte when you need:
- Minimal bundle sizes with compile-time optimizations
- Excellent performance with zero runtime overhead
- Simple, intuitive syntax without virtual DOM complexity
- Fast prototyping with less boilerplate code
- Progressive web apps with SvelteKit
- Component libraries with minimal overhead
- Real-time applications with built-in reactivity

## When to Avoid Svelte
Consider alternatives when:
- Large enterprise applications with extensive tooling needs (Angular)
- Massive ecosystem requirements (React)
- Team already skilled in other frameworks
- Need for extensive third-party component libraries
- Legacy browser support requirements (IE11)
- Complex state management needs (consider React/Redux)

## Framework Overview
- **Framework**: Svelte 4.x with SvelteKit 1.x
- **Type**: Compile-time framework with optional meta-framework
- **Architecture**: Component-based with compile-time optimizations
- **Language**: JavaScript/TypeScript with enhanced syntax
- **Use Cases**: SPAs, static sites, PWAs, component libraries

## Installation & Setup

### ✅ Recommended: SvelteKit (Full-stack framework)
See [example-1](./examples/svelte/example-1.bash)

### ✅ Alternative: Vite + Svelte (Lightweight)
See [example-2](./examples/svelte/example-2.bash)

### ❌ Avoid: Standalone Svelte for new projects
See [example-3](./examples/svelte/example-3.bash)

### AI Agent Decision Tree
- **For full applications**: Use SvelteKit (routing, SSR, API routes)
- **For component libraries**: Use Vite + Svelte
- **For prototyping**: Use SvelteKit with adapter-static
- **For existing apps**: Progressive adoption with standalone Svelte

## Project Structure

### ✅ SvelteKit Structure
See [example-4](./examples/svelte/example-4.txt)

### ✅ Component Architecture
See [example-5](./examples/svelte/example-5.txt)

## Core Concepts

### Components with Script, Markup, and Style
✅ **Best Practice**: Single-file components with TypeScript
See [example-6](./examples/svelte/example-6.svelte)

### Reactivity and Stores
✅ **Best Practice**: Reactive statements and stores for state management
See [example-7](./examples/svelte/example-7.typescript)

### SvelteKit Routing and Data Loading
✅ **Best Practice**: File-based routing with load functions
See [example-8](./examples/svelte/example-8.typescript)

See [example-9](./examples/svelte/example-9.svelte)

### API Routes (SvelteKit)
✅ **Best Practice**: Type-safe API routes
See [example-10](./examples/svelte/example-10.typescript)

## Best Practices

### ✅ Do's
- Use TypeScript for better development experience
- Leverage Svelte's built-in reactivity instead of external state management
- Use stores for shared state across components
- Implement proper error boundaries and loading states
- Use SvelteKit for full applications with routing needs
- Follow the single responsibility principle for components
- Use CSS custom properties for theming
- Implement proper accessibility (a11y) practices

### ❌ Don'ts
- Don't use external state management for simple applications
- Don't ignore Svelte's reactivity patterns
- Don't make components too large (>200 lines)
- Don't forget to handle loading and error states
- Don't use jQuery or DOM manipulation libraries
- Don't ignore TypeScript warnings
- Don't skip testing for critical functionality

### Performance Optimization
See [example-11](./examples/svelte/example-11.svelte)

See [example-12](./examples/svelte/example-12.typescript)

## Development Workflow

### ✅ Recommended Development Setup
See [example-13](./examples/svelte/example-13.bash)

### IDE Configuration
- **VS Code Extensions**: Svelte for VS Code, TypeScript Svelte Plugin
- **Settings**: Enable TypeScript strict mode, Svelte IntelliSense
- **Debugging**: Use browser DevTools with Svelte DevTools extension

### AI Agent Decision Matrix
| Scenario         | Recommended Approach          | Avoid                         |
| ---------------- | ----------------------------- | ----------------------------- |
| New application  | SvelteKit + TypeScript        | Standalone Svelte             |
| Component lib    | Vite + Svelte + TypeScript    | SvelteKit (overkill)          |
| State management | Svelte stores                 | External libraries            |
| Styling          | Scoped CSS + CSS variables    | CSS-in-JS libraries           |
| Testing          | Vitest + Testing Library      | Jest without proper setup     |
| Deployment       | Adapter-based (Vercel/Netlify) | Manual server configuration  |

## Integration Guidelines
- **With APIs**: Use SvelteKit load functions for SSR data
- **With databases**: Implement proper data layer separation
- **With authentication**: Use SvelteKit hooks for session management
- **With CSS frameworks**: Prefer utility-first (Tailwind) over component libraries
- **With backend**: Design API-first architecture with proper error handling

## Common Patterns
See [example-14](./examples/svelte/example-14.svelte)

## Testing

### ✅ Component Testing
See [example-15](./examples/svelte/example-15.typescript)

### ✅ Integration Testing
See [example-16](./examples/svelte/example-16.typescript)

## Security Considerations
- Implement proper input validation and sanitization
- Use CSRF protection for forms
- Sanitize user-generated content
- Implement proper authentication and authorization
- Use environment variables for sensitive configuration
- Enable Content Security Policy (CSP)
- Validate and sanitize all API inputs

## Error Handling
See [example-17](./examples/svelte/example-17.svelte)

## AI Agent Quick Reference
- **Component Creation**: Focus on single-file components with TypeScript
- **State Management**: Use Svelte stores for shared state, reactive statements for local state
- **Routing**: Implement file-based routing with SvelteKit
- **Data Fetching**: Use load functions for SSR, stores for client-side state
- **Performance**: Leverage Svelte's compile-time optimizations
- **Testing**: Use Testing Library with Vitest for component tests
- **Deployment**: Use appropriate SvelteKit adapters for target platforms

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
