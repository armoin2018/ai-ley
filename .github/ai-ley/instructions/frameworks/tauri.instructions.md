---
name: 'Tauri.Instructions'
description: 'See [example-1](./examples/tauri/example-1.'
keywords: [api, application, agent, agents, alternative:, architecture, [pattern, authentication, analysis, advanced]
---



# Tauri Framework Instructions for AI Agents

## When to Use Tauri

Use Tauri when you need:

- Lightweight desktop applications with minimal resource usage
- Native performance with web frontend technologies
- Strong security with Rust backend and isolated frontend
- Small application bundle sizes (under 10MB vs 100MB+ for Electron)
- Cross-platform desktop apps with platform-specific optimizations
- Applications requiring deep system integration with security
- Modern web frontend (React, Vue, Svelte) with native backend capabilities

## When to Avoid Tauri

Consider alternatives when:

- Team has no Rust experience and complex backend requirements
- Need extensive Node.js ecosystem integration
- Building simple web-only applications
- Require mature ecosystem with extensive plugins (use Electron)
- Working with legacy web technologies or IE compatibility
- Need rapid prototyping without backend development
- Complex multimedia processing requiring specialized libraries

## Framework Overview

- **Framework**: Tauri 2.0+
- **Type**: Native desktop application framework with web frontend
- **Architecture**: Rust backend + Web frontend with secure IPC bridge
- **Language**: Rust (backend) + JavaScript/TypeScript (frontend)
- **Use Cases**: Native desktop apps, system tools, secure applications, performance-critical desktop software

## Installation & Setup

### ✅ Recommended: Tauri CLI with Frontend Framework

See [example-1](./examples/tauri/example-1.bash)

### ✅ Alternative: Add Tauri to Existing Frontend

See [example-2](./examples/tauri/example-2.bash)

### AI Agent Decision Tree

- **For new projects**: Use create-tauri-app with TypeScript template
- **For existing web apps**: Add Tauri incrementally with minimal changes
- **For performance-critical apps**: Choose Tauri over Electron
- **For security-focused apps**: Leverage Rust's memory safety and Tauri's security model
- **For lightweight distribution**: Tauri provides significantly smaller bundle sizes

## Project Structure

### ✅ Tauri Project Structure

See [example-3](./examples/tauri/example-3.txt)

### ✅ Advanced Project Structure

See [example-4](./examples/tauri/example-4.txt)

## Core Concepts

### Tauri Commands (IPC Bridge)

✅ **Best Practice**: Type-safe communication between Rust backend and frontend

See [example-5](./examples/tauri/example-5.rust)

### Application State Management

✅ **Best Practice**: Rust-based state management with thread-safe access

See [example-6](./examples/tauri/example-6.rust)

### Main Application Setup

✅ **Best Practice**: Comprehensive application initialization with error handling

See [example-7](./examples/tauri/example-7.rust)

### Frontend Integration with TypeScript

✅ **Best Practice**: Type-safe frontend communication with Rust backend

See [example-8](./examples/tauri/example-8.typescript)

### React Component Integration

✅ **Best Practice**: React hooks for Tauri integration with error handling

See [example-9](./examples/tauri/example-9.typescript)

## Best Practices

### ✅ Do's

- Use Rust's ownership system for memory safety and performance
- Implement proper error handling with Result types in Rust
- Use Tauri's secure IPC system with type-safe commands
- Leverage Rust's ecosystem for backend functionality
- Implement proper logging and debugging capabilities
- Use TypeScript for frontend type safety
- Follow Rust naming conventions and idiomatic patterns
- Implement comprehensive testing for both Rust and frontend code

### ❌ Don'ts

- Don't expose unsafe Rust operations to the frontend
- Don't ignore Rust's borrowing rules and lifetime management
- Don't use unwrap() extensively in production code
- Don't skip error handling in IPC communication
- Don't ignore Tauri's security model and CSP requirements
- Don't forget to handle cross-platform differences
- Don't skip code signing for production releases
- Don't ignore bundle size optimization opportunities

### Security and Performance

See [example-10](./examples/tauri/example-10.rust)

## Development Workflow

### ✅ Recommended Development Process

See [example-11](./examples/tauri/example-11.bash)

### Configuration and Optimization

See [example-12](./examples/tauri/example-12.json)

### AI Agent Decision Matrix

| Scenario                      | Recommended Approach            | Avoid                          |
| ----------------------------- | ------------------------------- | ------------------------------ |
| Lightweight desktop app       | Tauri with minimal dependencies | Electron (larger bundle)       |
| Security-critical application | Leverage Rust's memory safety   | Languages with runtime errors  |
| Performance-sensitive app     | Native Rust backend             | Heavy JavaScript processing    |
| Cross-platform requirement    | Tauri with platform detection   | Platform-specific code         |
| Team with Rust experience     | Full Tauri capabilities         | Avoiding backend complexity    |
| Simple web app conversion     | Gradual Tauri integration       | Complete rewrite               |
| System integration needs      | Rust native capabilities        | Web-only solutions             |
| Small distribution size       | Tauri optimization              | Frameworks with large runtimes |

## Testing

### ✅ Rust Testing

See [example-13](./examples/tauri/example-13.rust)

### ✅ Frontend Testing with Vitest

See [example-14](./examples/tauri/example-14.typescript)

## Security Considerations

- Implement least privilege principle with Tauri allowlist configuration
- Use Rust's memory safety features to prevent buffer overflows and memory leaks
- Validate all input data in Rust commands before processing
- Implement proper authentication and session management
- Use Content Security Policy (CSP) to prevent XSS attacks
- Keep Tauri and Rust dependencies updated to latest secure versions
- Implement secure communication channels for sensitive operations
- Use proper error handling that doesn't leak sensitive information
- Follow secure coding practices in both Rust and frontend code

## AI Agent Quick Reference

- **Project Setup**: Use create-tauri-app with TypeScript template for modern development
- **Architecture**: Rust backend with secure IPC communication to web frontend
- **Performance**: Leverage Rust's zero-cost abstractions and memory safety
- **Security**: Use Tauri's allowlist and Rust's safety features
- **Development**: Combine Rust tooling (cargo) with frontend tools (npm/yarn)
- **Testing**: Implement both Rust unit tests and frontend integration tests
- **Distribution**: Build lightweight native applications with small bundle sizes
- **Cross-platform**: Handle platform differences in Rust code with conditional compilation

### [Pattern Name]

```[language]
// Example implementation
[code example]
See [example-15](./examples/tauri/example-15.txt)[language]
// Example implementation
[code example]
See [example-16](./examples/tauri/example-16.txt)[format]
# Configuration options
[example configuration]
See [example-17](./examples/tauri/example-17.txt)[format]
# Configuration options
[example configuration]
See [example-18](./examples/tauri/example-18.txt)bash
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
See [example-19](./examples/tauri/example-19.txt)bash
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
