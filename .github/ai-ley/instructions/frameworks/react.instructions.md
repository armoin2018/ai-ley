---
name: 'React.Instructions'
description: 'Development guidelines and best practices for React.Instructions'
keywords: [architecture, analysis, api, cli, authorization, (experimental), assistant, actions, commands, authentication]
---



# React Framework Instructions

## Framework Overview
- **Framework Name**: React
- **Version**: 19.x (Current), 18.x LTS
- **Type**: JavaScript UI Library/Framework
- **Language**: JavaScript/TypeScript
- **Use Cases**: Single-page applications, component-based UIs, mobile apps with React Native

## Installation & Setup
See [example-1](./examples/react/example-1.bash)

## Project Structure
See [example-2](./examples/react/example-2.txt)

## Core Concepts
### Components
- **Purpose**: Reusable UI building blocks
- **Usage**: Create functional components with hooks
- **Example**:
See [example-3](./examples/react/example-3.tsx)

### State Management
- **Purpose**: Manage component and application state
- **Usage**: Use useState for local state, useReducer for complex state
- **Example**:
See [example-4](./examples/react/example-4.tsx)

### Effects and Side Effects
- **Purpose**: Handle side effects like API calls, subscriptions
- **Usage**: Use useEffect for lifecycle events
- **Example**:
See [example-5](./examples/react/example-5.tsx)

## Development Workflow
1. **Setup**: Initialize project with Create React App or Vite
2. **Development**: Run development server with hot reload
3. **Testing**: Write unit tests with Jest and React Testing Library
4. **Building**: Build optimized production bundle
5. **Deployment**: Deploy to hosting platforms

## Best Practices
### Component Design
- Keep components small and focused on a single responsibility
- Use composition over inheritance
- Implement proper prop validation with TypeScript or PropTypes
- Extract reusable logic into custom hooks

### Performance Optimization
- Use React.memo for expensive component re-renders
- Implement useMemo and useCallback for expensive computations
- Lazy load components with React.lazy and Suspense
- Optimize bundle size with code splitting

### State Management
- Keep state as local as possible
- Use Context API for global state that doesn't change frequently
- Consider external libraries (Redux Toolkit, Zustand) for complex state

## Common Patterns
### Custom Hooks
See [example-6](./examples/react/example-6.tsx)

### Context Provider Pattern
See [example-7](./examples/react/example-7.tsx)

## Configuration
### Package.json Scripts
See [example-8](./examples/react/example-8.json)

### ESLint Configuration
See [example-9](./examples/react/example-9.json)

## Essential Commands
See [example-10](./examples/react/example-10.bash)

## Common Issues & Solutions
### State Updates Not Reflecting
**Problem**: Component doesn't re-render when state changes
**Solution**: Ensure state updates are immutable and use functional updates

### Memory Leaks
**Problem**: Components continue to update after unmounting
**Solution**: Clean up subscriptions and cancel pending requests in useEffect cleanup

### Performance Issues
**Problem**: Unnecessary re-renders causing slow performance
**Solution**: Use React DevTools Profiler, implement memoization strategies

## Performance Optimization
### Code Splitting
See [example-11](./examples/react/example-11.tsx)

### Memoization
See [example-12](./examples/react/example-12.tsx)

## Security Considerations
- Sanitize user inputs to prevent XSS attacks
- Use HTTPS for all API communications
- Implement proper authentication and authorization
- Validate data on both client and server sides

## Useful Resources
- **Official Documentation**: https://react.dev/
- **React DevTools**: Browser extension for debugging
- **Testing Library**: https://testing-library.com/docs/react-testing-library/intro/
- **React Patterns**: https://reactpatterns.com/
- **Awesome React**: https://github.com/enaqx/awesome-react

## Framework-Specific Guidelines
### Code Style
- Use functional components over class components
- Prefer hooks over higher-order components
- Use TypeScript for better type safety
- Follow consistent naming conventions (PascalCase for components)

### Architecture Patterns
- Implement container/presentational component pattern
- Use compound components for complex UI patterns
- Implement proper error boundaries for error handling
- Use render props pattern for shared logic

## Integration Points
### React Router
- **Purpose**: Client-side routing for single-page applications
- **Setup**: Install react-router-dom and configure routes
- **Usage**: Define routes and navigation components

### State Management Libraries
- **Purpose**: Manage global application state
- **Setup**: Choose between Redux Toolkit, Zustand, or Context API
- **Usage**: Connect components to global state

## Version Compatibility
- **Node.js**: 16.0+
- **TypeScript**: 4.5+
- **Browser Support**: Modern browsers (ES2015+)
- **React Native**: Compatible for mobile development

## Troubleshooting
### Debug Mode
See [example-13](./examples/react/example-13.bash)

### Log Analysis
- Use React DevTools for component debugging
- Implement error boundaries for error catching
- Use browser DevTools for performance profiling

### Common Error Messages
- **Error**: `Cannot read property of undefined`
  **Cause**: Accessing properties of null/undefined objects
  **Solution**: Use optional chaining or null checks

- **Error**: `Maximum update depth exceeded`
  **Cause**: Infinite re-render loops
  **Solution**: Check useEffect dependencies and state updates

## React 19 Modern Features
### React Compiler (Experimental)
See [example-14](./examples/react/example-14.tsx)

### Server Components Integration
See [example-15](./examples/react/example-15.tsx)

### Actions and Form Handling
See [example-16](./examples/react/example-16.tsx)

## AI Assistant Guidelines
When helping with React:

1. **Always use functional components with hooks over class components**
2. **Prioritize TypeScript for type safety and better developer experience**
3. **Implement proper error boundaries for production applications**
4. **Suggest modern patterns: hooks, context, and composition over inheritance**
5. **Include accessibility considerations in component design**
6. **Recommend React 19 features when appropriate (Server Components, Compiler)**
7. **Provide testing examples with React Testing Library**
8. **Include performance optimization strategies**

### Code Generation Rules
- Generate functional components with TypeScript interfaces
- Include proper error handling and loading states
- Use semantic HTML and ARIA attributes for accessibility
- Implement proper key props for lists
- Include ESLint and Prettier configuration suggestions
- Provide both development and production optimization examples
- Use modern React patterns (hooks, suspense, error boundaries)
- Include unit test examples for generated components

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
