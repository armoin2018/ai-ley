---
name: 'Nwjs.Instructions'
description: 'Use NW.'
keywords: [application, agent, [pattern, [concept, architecture, analysis, api, advanced, agents, alternative:]
---



# NW.js Framework Instructions for AI Agents

## When to Use NW.js

Use NW.js when you need:

- Desktop applications built with web technologies (HTML, CSS, JavaScript)
- Direct access to Node.js APIs from the browser context
- Applications requiring both DOM manipulation and file system access
- Migration from older Node-Webkit projects
- Applications needing backward compatibility with older Chromium versions
- Desktop apps with specific Node.js module dependencies
- Applications requiring fine-grained control over the Chromium runtime
- Legacy web applications that need desktop deployment

## When to Avoid NW.js

Consider alternatives when:

- Building new projects (prefer Electron for better ecosystem support)
- Need the smallest possible bundle size (use Neutralino or Tauri)
- Require modern security models with process isolation
- Working with teams unfamiliar with Node.js and Chromium internals
- Building applications with strict security requirements
- Need extensive mobile platform support alongside desktop
- Prefer frameworks with more active development and community

## Framework Overview

- **Framework**: NW.js (formerly Node-Webkit)
- **Type**: Web-based desktop application framework with Node.js integration
- **Runtime**: Chromium + Node.js in single process context
- **Languages**: JavaScript/TypeScript, HTML, CSS
- **Use Cases**: Legacy web app conversion, Node.js-heavy desktop apps, cross-platform utilities

## Installation & Setup

### ✅ Recommended: NW.js with npm Package Manager

See [example-1](./examples/nwjs/example-1.bash)

### ✅ Alternative: Using NW.js Builder for Distribution

See [example-2](./examples/nwjs/example-2.bash)

### ✅ Integration with Modern Frontend Tools

See [example-3](./examples/nwjs/example-3.bash)

### AI Agent Decision Tree

- **For new projects**: Consider Electron unless specific NW.js features are required
- **For legacy migration**: NW.js provides smoother transition from Node-Webkit
- **For Node.js heavy apps**: NW.js offers direct Node.js access in renderer
- **For smaller teams**: NW.js has simpler architecture than Electron's multi-process model
- **For specific Chromium needs**: NW.js allows more control over Chromium version

## Project Structure

### ✅ Basic NW.js Project Structure

See [example-4](./examples/nwjs/example-4.txt)

### ✅ Advanced NW.js Project with Modern Tooling

See [example-5](./examples/nwjs/example-5.txt)

### ✅ TypeScript NW.js Project Structure

See [example-6](./examples/nwjs/example-6.txt)

## Core Concepts

### Application Entry Point and Window Management

✅ **Best Practice**: Proper NW.js application structure with window management

See [example-7](./examples/nwjs/example-7.html)

### NW.js API Integration and File Management

✅ **Best Practice**: Comprehensive NW.js API usage with error handling

See [example-8](./examples/nwjs/example-8.javascript)

## Best Practices

### ✅ Do's

- Use the latest stable version of NW.js for security and performance improvements
- Implement proper error handling for all Node.js and NW.js API calls
- Use modern JavaScript features and development tools for better code quality
- Implement proper window management and state persistence
- Use native menus and dialogs for better platform integration
- Handle both NW.js environment and browser fallbacks for testing
- Implement proper security measures when accessing file system and system APIs
- Use build tools like webpack or Vite for modern development workflow

### ❌ Don'ts

- Don't use NW.js for new projects unless specific features are required
- Don't ignore security implications of Node.js access in the renderer process
- Don't use outdated NW.js versions - regularly update for security patches
- Don't forget to handle platform-specific differences in file paths and APIs
- Don't expose sensitive Node.js APIs to untrusted web content
- Don't skip proper packaging and code signing for distribution
- Don't ignore memory management - NW.js apps can consume significant resources
- Don't forget to test on all target platforms thoroughly

### Security and Performance Considerations

See [example-9](./examples/nwjs/example-9.javascript)

## Development Workflow

### ✅ NW.js Development Process

See [example-10](./examples/nwjs/example-10.bash)

### Package.json Configuration Examples

See [example-11](./examples/nwjs/example-11.json)

## AI Agent Decision Matrix

| Scenario                        | Recommended Approach              | Avoid                                   |
| ------------------------------- | --------------------------------- | --------------------------------------- |
| Legacy Node-Webkit migration    | NW.js for easier transition       | Complete rewrite to different framework |
| Node.js heavy desktop app       | NW.js for direct Node.js access   | Electron with complex IPC setup         |
| Small team, simple architecture | NW.js single-process model        | Electron multi-process complexity       |
| New project development         | Electron for better ecosystem     | NW.js (less active development)         |
| Security-critical application   | Native frameworks or Electron     | NW.js (shared process model)            |
| Minimal bundle size             | Neutralino or Tauri               | NW.js (includes full Chromium)          |
| Specific Chromium version needs | NW.js for version control         | Electron (limited version control)      |
| Enterprise application          | Electron with proper architecture | NW.js (limited enterprise support)      |

## Testing

### ✅ Unit Testing with Jest

See [example-12](./examples/nwjs/example-12.javascript)

### ✅ End-to-End Testing with Playwright

See [example-13](./examples/nwjs/example-13.javascript)

## Security Considerations

- Be aware that NW.js runs Node.js and web content in the same process context
- Validate all file paths and user inputs to prevent directory traversal attacks
- Use the `node-remote` configuration carefully to limit Node.js access
- Disable Node.js integration in child windows that load external content
- Implement proper CSP (Content Security Policy) for web content
- Avoid exposing sensitive Node.js APIs to untrusted web content
- Use HTTPS for any external web content loaded in the application
- Regular updates to NW.js framework for security patches
- Consider using iframe sandboxing for untrusted content
- Implement proper session management and data validation

## AI Agent Quick Reference

- **Project Setup**: Use NW.js CLI or npm for project initialization and dependency management
- **API Integration**: Direct Node.js access allows full system integration but requires security consideration
- **Architecture**: Single-process model simpler than Electron but less secure for complex applications
- **Development**: Use modern build tools (webpack/Vite) for better development experience
- **Testing**: Unit test with Jest, E2E test with Playwright, mock NW.js APIs for testing
- **Distribution**: Use nw-builder for cross-platform packaging and distribution
- **Security**: Careful API exposure management, input validation, and regular framework updates
- **Migration**: Good choice for Node-Webkit migration, consider Electron for new projects
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
See [example-14](./examples/nwjs/example-14.txt)[language]
// Example implementation
[code example]
See [example-15](./examples/nwjs/example-15.txt)[format]
# Configuration options
[example configuration]
See [example-16](./examples/nwjs/example-16.txt)[format]
# Configuration options
[example configuration]
See [example-17](./examples/nwjs/example-17.txt)bash
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
See [example-18](./examples/nwjs/example-18.txt)bash
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
