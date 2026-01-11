---
name: 'Electron.Instructions'
description: 'See [example-1](./examples/electron/example-1.'
keywords: [agent, [pattern, architecture, analysis, api, assurance, advanced, agents, alternative:, (modern]
---



# Electron Framework Instructions for AI Agents

## When to Use Electron

Use Electron when you need:

- Cross-platform desktop applications using web technologies
- Leveraging existing web development skills for desktop apps
- Rapid desktop app development with familiar tools (HTML, CSS, JavaScript)
- Access to native desktop APIs while maintaining web-based UI
- Consistent user experience across Windows, macOS, and Linux
- Desktop apps with rich multimedia, complex layouts, or web integrations
- Converting existing web applications to desktop applications

## When to Avoid Electron

Consider alternatives when:

- Building performance-critical applications (games, CAD, video editing)
- Memory usage is a primary concern (Electron apps use more RAM)
- Creating simple utility apps (consider native solutions or Tauri)
- Building mobile applications (use React Native, Flutter, or native)
- Maximum startup time performance is critical
- Working with security-sensitive applications requiring maximum isolation

## Framework Overview

- **Framework**: Electron 28.x+
- **Type**: Cross-platform desktop application framework
- **Architecture**: Chromium + Node.js runtime with main/renderer process architecture
- **Language**: JavaScript/TypeScript, HTML, CSS
- **Use Cases**: Desktop apps, IDEs, productivity tools, media applications

## Installation & Setup

### ✅ Recommended: Electron Forge (Modern Toolchain)

See [example-1](./examples/electron/example-1.bash)

### ✅ Alternative: Manual Setup

See [example-2](./examples/electron/example-2.bash)

### AI Agent Decision Tree

- **For new projects**: Use Electron Forge with TypeScript template
- **For existing web apps**: Add Electron manually with minimal configuration
- **For complex builds**: Use Electron Builder for advanced packaging
- **For simple apps**: Start with basic setup and add complexity incrementally
- **For team development**: Use TypeScript and ESLint configuration

## Project Structure

### ✅ Electron Forge Project Structure

See [example-3](./examples/electron/example-3.txt)

### ✅ Advanced Project Structure

See [example-4](./examples/electron/example-4.txt)

## Core Concepts

### Main Process and Renderer Processes

✅ **Best Practice**: Proper process architecture with IPC communication

See [example-5](./examples/electron/example-5.typescript)

### Preload Scripts for Security

✅ **Best Practice**: Secure communication between main and renderer processes

See [example-6](./examples/electron/example-6.typescript)

### Renderer Process with TypeScript

✅ **Best Practice**: Type-safe renderer process with proper error handling

See [example-7](./examples/electron/example-7.typescript)

## Best Practices

### ✅ Do's

- Use context isolation and disable node integration for security
- Implement proper IPC communication with preload scripts
- Handle window state persistence for better user experience
- Use TypeScript for better development experience and type safety
- Implement proper error handling and user feedback
- Follow platform-specific UI guidelines (macOS, Windows, Linux)
- Use Electron Forge or similar tools for build management
- Implement auto-updater for production applications

### ❌ Don'ts

- Don't disable security features without understanding implications
- Don't expose the entire Node.js API to renderer processes
- Don't ignore memory management and potential memory leaks
- Don't forget to handle platform-specific behaviors
- Don't skip code signing for production applications
- Don't ignore app size optimization and bundle analysis
- Don't forget to handle network connectivity issues
- Don't mix synchronous IPC calls in performance-critical code

### Security Best Practices

See [example-8](./examples/electron/example-8.typescript)

## Development Workflow

### ✅ Recommended Development Process

See [example-9](./examples/electron/example-9.bash)

### Testing and Quality Assurance

See [example-10](./examples/electron/example-10.typescript)

### AI Agent Decision Matrix

| Scenario                   | Recommended Approach          | Avoid                         |
| -------------------------- | ----------------------------- | ----------------------------- |
| Cross-platform desktop app | Electron with TypeScript      | Native apps for each platform |
| Simple utility app         | Consider Tauri or native      | Electron (overhead)           |
| Web app conversion         | Electron with minimal changes | Complete rewrite              |
| Performance-critical app   | Native or Tauri               | Electron                      |
| Enterprise application     | Electron with security focus  | Web-only solutions            |
| Media/Graphics intensive   | Native frameworks             | Web-based solutions           |
| Rapid prototyping          | Electron with hot reload      | Complex native setup          |
| Team with web skills       | Leverage existing knowledge   | Learning native development   |

## Integration Guidelines

- **With React**: Use Electron + React for familiar component patterns
- **With Vue**: Integrate Vue.js for reactive UI development
- **With databases**: Use SQLite, IndexedDB, or remote databases
- **With APIs**: Implement secure API communication with proper authentication
- **With file systems**: Use Node.js fs APIs through IPC channels
- **With native modules**: Use @electron/rebuild for native dependencies
- **With CI/CD**: Automate builds and code signing in pipelines

## Testing

### ✅ Unit Testing with Jest

See [example-11](./examples/electron/example-11.typescript)

### ✅ E2E Testing with Playwright

See [example-12](./examples/electron/example-12.typescript)

## Performance Optimization

- Implement code splitting and lazy loading for large applications
- Use virtual scrolling for large lists and data sets
- Optimize bundle size with tree shaking and dead code elimination
- Implement proper memory management and cleanup
- Use web workers for CPU-intensive tasks
- Optimize startup time with preload optimization
- Implement efficient state management patterns
- Use native modules only when necessary

## Security Considerations

- Enable context isolation and disable node integration by default
- Use content security policy (CSP) in renderer processes
- Validate all data received from IPC channels
- Implement proper authentication and session management
- Use HTTPS for all network communications
- Keep Electron and dependencies updated to latest secure versions
- Implement proper error handling that doesn't leak sensitive information
- Use code signing for production builds
- Follow principle of least privilege for IPC exposed APIs

## AI Agent Quick Reference

- **Project Setup**: Use Electron Forge with TypeScript template for modern development
- **Architecture**: Separate main process, preload scripts, and renderer process logic
- **Security**: Always use context isolation and preload scripts for IPC communication
- **Development**: Leverage TypeScript, ESLint, and modern tooling for quality
- **Testing**: Implement unit tests for logic and E2E tests for user workflows
- **Distribution**: Use Electron Builder or Forge for cross-platform packaging
- **Performance**: Optimize bundle size, implement lazy loading, and use native modules judiciously
- **Updates**: Implement auto-updater for seamless user experience

### [Pattern Name]

```[language]
// Example implementation
[code example]
See [example-13](./examples/electron/example-13.txt)[language]
// Example implementation
[code example]
See [example-14](./examples/electron/example-14.txt)[format]
# Configuration options
[example configuration]
See [example-15](./examples/electron/example-15.txt)[format]
# Configuration options
[example configuration]
See [example-16](./examples/electron/example-16.txt)bash
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
See [example-17](./examples/electron/example-17.txt)bash
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
