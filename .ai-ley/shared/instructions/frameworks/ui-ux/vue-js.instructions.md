---
title: 'Vue.js Progressive Web Framework Instructions'
description: 'Comprehensive guide for Vue.js progressive framework with Composition API, TypeScript, and modern development patterns'
category: 'Frontend Frameworks'

tags:
  [
    'vue',
    'vue3',
    'composition-api',
    'javascript',
    'typescript',
    'frontend',
    'spa',
    'pinia',
    'router',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/vue.config.js'
  - '**/vite.config.*'
  - '**/*.vue'
  - '**/package.json'
  - '**/tsconfig.json'
  - '**/src/**'
---

# Vue.js Progressive Web Framework Instructions

## Framework Overview

- **Framework Name**: Vue.js
- **Version**: 3.4+ (Latest stable with improved performance and TypeScript support)
- **Type**: Progressive JavaScript Framework for Building User Interfaces
- **Language**: JavaScript, TypeScript, HTML, CSS
- **Use Cases**: Single-page applications, progressive web apps, component libraries, full-stack applications with Nuxt.js

## When to Use Vue.js

### ✅ **Use Vue.js When**

- Building single-page applications with component-based architecture
- Need gentle learning curve for developers new to modern frameworks
- Want excellent TypeScript support with minimal configuration
- Building progressive web apps with offline capabilities
- Need flexible framework that can be adopted incrementally
- Working on projects requiring good performance with smaller bundle sizes
- Want comprehensive ecosystem with official libraries (Router, Pinia, DevTools)
- Building applications requiring reactive data binding and declarative rendering
- Team values developer experience and well-documented APIs

### ❌ **Avoid Vue.js When**

- Building simple static websites that don't need interactivity
- Team is already expert in React and has large React codebase
- Need maximum performance for heavy computational applications
- Working with strict enterprise requirements for Facebook-backed technologies
- Building mobile-first applications where React Native ecosystem is preferred
- Need extensive third-party component libraries (React has more options)

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type        | Vue.js Recommendation                                   | Alternative Consideration      |
| ------------------- | ------------------------------------------------------- | ------------------------------ |
| Admin Dashboard     | ✅ **Excellent** - Great form handling and data display | Vue DevTools exceptional       |
| E-commerce Frontend | ✅ **Recommended** - Nuxt.js for SSR/SSG                | Next.js if React preferred     |
| Content Management  | ✅ **Great Choice** - Flexible, progressive enhancement | Consider SSG with Nuxt         |
| Enterprise SPA      | ✅ **Recommended** - TypeScript, maintainable           | Angular for large teams        |
| Marketing Website   | 🔄 **Consider** - Nuxt.js for static generation         | Gatsby/Next.js alternatives    |
| Real-time App       | ✅ **Good** - Reactive system handles updates well      | Consider WebSocket integration |

### Team Expertise Assessment

| Experience Level     | Vue.js Suitability                               | Learning Path            |
| -------------------- | ------------------------------------------------ | ------------------------ |
| **Beginner**         | ✅ **Ideal** - Gentle learning curve             | Start with Options API   |
| **Intermediate**     | ✅ **Excellent** - Full framework benefits       | Learn Composition API    |
| **Advanced**         | ✅ **Great** - Advanced patterns and performance | Custom directives, SSR   |
| **React Background** | 🔄 **Consider** - Concepts transfer              | Focus on Vue differences |

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
