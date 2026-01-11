---
name: 'Neutralino.Instructions'
description: 'See [example-1](./examples/neutralino/example-1.'
keywords: [async, agent, [pattern, [concept, architecture, analysis, api, agents, avoid, alternative:]
---



# Neutralino Framework Instructions for AI Agents

## When to Use Neutralino

Use Neutralino when you need:

- Lightweight desktop applications with minimal resource usage (alternative to Electron)
- Web-based desktop apps with native system access
- Small application bundle sizes (3-15MB vs 100MB+ for Electron)
- Cross-platform desktop apps using web technologies
- Applications requiring basic file system and OS integration
- Quick conversion of web applications to desktop format
- Desktop apps with minimal security requirements and trusted environments
- Applications targeting resource-constrained environments

## When to Avoid Neutralino

Consider alternatives when:

- Need extensive native system integration and hardware access
- Require complex security models with sandboxing
- Building applications with heavy native dependencies
- Need mature ecosystem with extensive plugin support (use Electron)
- Require offline functionality with complex local data processing
- Working with applications requiring real-time performance
- Building enterprise applications with strict security requirements

## Framework Overview

- **Framework**: Neutralino 4.0+
- **Type**: Lightweight web-based desktop application framework
- **Languages**: JavaScript/TypeScript (frontend), Any language (backend via extensions)
- **Runtime**: Custom lightweight runtime (not Chromium)
- **Use Cases**: Lightweight desktop apps, system utilities, web app conversion, prototyping

## Installation & Setup

### ✅ Recommended: Neutralino CLI with Modern Frontend

See [example-1](./examples/neutralino/example-1.bash)

### ✅ Alternative: Add Neutralino to Existing Web App

See [example-2](./examples/neutralino/example-2.bash)

### ✅ Manual Setup for Custom Configuration

See [example-3](./examples/neutralino/example-3.bash)

### AI Agent Decision Tree

- **For simple apps**: Use vanilla template for minimal overhead
- **For modern UI**: Use React/Vue/Svelte templates for component-based development
- **For existing web apps**: Initialize Neutralino in existing project
- **For system utilities**: Use minimal template with direct OS API access
- **For prototyping**: Use Neutralino for rapid desktop app conversion

## Project Structure

### ✅ Standard Neutralino Project Structure

See [example-4](./examples/neutralino/example-4.txt)

### ✅ React-based Neutralino Project

See [example-5](./examples/neutralino/example-5.txt)

### ✅ Extension-based Architecture

See [example-6](./examples/neutralino/example-6.txt)

## Core Concepts

### Neutralino Configuration

✅ **Best Practice**: Comprehensive configuration for production applications

See [example-7](./examples/neutralino/example-7.json)

### Neutralino Client API Integration

✅ **Best Practice**: Type-safe Neutralino API wrapper with error handling

See [example-8](./examples/neutralino/example-8.javascript)

### React Component with Neutralino Integration

✅ **Best Practice**: React components using Neutralino APIs with hooks

See [example-9](./examples/neutralino/example-9.jsx)

## Best Practices

### ✅ Do's

- Use the official Neutralino CLI for project management and building
- Implement proper error handling for all Neutralino API calls
- Use modern JavaScript/TypeScript with async/await patterns
- Leverage web technologies and frameworks for UI development
- Implement proper security measures despite Neutralino's lightweight nature
- Use extensions for complex native functionality that requires system access
- Follow web development best practices for performance and maintainability
- Test applications across different operating systems

### ❌ Don'ts

- Don't rely on Neutralino for applications requiring extensive native functionality
- Don't ignore security implications of the native API access
- Don't use Neutralino for performance-critical applications requiring heavy computation
- Don't expect the same level of ecosystem support as Electron
- Don't forget to configure proper native API allowlists
- Don't use outdated Neutralino versions - always use latest stable
- Don't hardcode file paths - use Neutralino's path API
- Don't forget to handle platform-specific differences

### Performance and Resource Management

See [example-10](./examples/neutralino/example-10.javascript)

## Development Workflow

### ✅ Recommended Development Process

See [example-11](./examples/neutralino/example-11.bash)

### Build Integration with Modern Frontend Tools

See [example-12](./examples/neutralino/example-12.json)

## AI Agent Decision Matrix

| Scenario                         | Recommended Approach               | Avoid                                    |
| -------------------------------- | ---------------------------------- | ---------------------------------------- |
| Simple desktop utility           | Neutralino with vanilla JS         | Heavy frameworks for simple apps         |
| Web app conversion               | Neutralino with existing codebase  | Rewriting for different framework        |
| Resource-constrained environment | Neutralino minimal setup           | Electron or heavy alternatives           |
| Quick prototyping                | Neutralino with modern frontend    | Complex native development               |
| System integration required      | Neutralino with extensions         | Pure web-based solutions                 |
| Enterprise application           | Electron or native frameworks      | Neutralino (limited enterprise features) |
| Performance-critical app         | Native frameworks                  | Any web-based solution                   |
| Complex security requirements    | Native apps with proper sandboxing | Neutralino (limited security model)      |

## Testing

### ✅ Frontend Testing with Vitest

See [example-13](./examples/neutralino/example-13.javascript)

### ✅ End-to-End Testing with Playwright

See [example-14](./examples/neutralino/example-14.javascript)

## Security Considerations

- Configure minimal native API allowlist for production applications
- Validate all user inputs before passing to Neutralino APIs
- Use HTTPS for any network communications from the web frontend
- Implement proper access controls for file system operations
- Avoid exposing sensitive system information through the web interface
- Use one-time token security mode for production deployments
- Regular updates to Neutralino framework for security patches
- Consider sandboxing limitations compared to Electron or native apps
- Implement proper session management for multi-user scenarios
- Use content security policies (CSP) for the web frontend

## AI Agent Quick Reference

- **Project Setup**: Use Neutralino CLI with modern frontend framework integration
- **API Usage**: Implement comprehensive error handling for all Neutralino API calls
- **Architecture**: Separate frontend logic from Neutralino-specific system integration
- **Performance**: Cache system calls and implement efficient resource management
- **Testing**: Unit test frontend logic, mock Neutralino APIs, use E2E for integration
- **Distribution**: Build frontend first, then use Neutralino build tools
- **Cross-platform**: Test on all target platforms, handle OS-specific differences
- **Security**: Configure minimal native API permissions, validate all system interactions
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
See [example-15](./examples/neutralino/example-15.txt)[language]
// Example implementation
[code example]
See [example-16](./examples/neutralino/example-16.txt)[format]
# Configuration options
[example configuration]
See [example-17](./examples/neutralino/example-17.txt)[format]
# Configuration options
[example configuration]
See [example-18](./examples/neutralino/example-18.txt)bash
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
See [example-19](./examples/neutralino/example-19.txt)bash
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
