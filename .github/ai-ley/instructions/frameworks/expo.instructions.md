---
name: 'Expo React Native Development Platform Instructions'
description: 'Comprehensive guide for building React Native applications with Expo'
keywords: [**performance, api, **avoid, agent, **development, **common, [concept, **use, [pattern, analysis]
---


# Expo React Native Development Platform Instructions

## Framework Overview

- **Framework Name**: Expo
- **Version**: SDK 50+ (Latest stable with React Native 0.73+ support)
- **Type**: React Native Development Platform and Toolchain
- **Language**: JavaScript, TypeScript, React Native
- **Use Cases**: Rapid React Native prototyping, managed mobile development, universal apps, cross-platform deployment

## When to Use Expo

### ✅ **Use Expo When**

- Starting new React Native projects with rapid development needs
- Team wants managed development workflow without native build configuration
- Need to deploy quickly to app stores with minimal setup
- Building apps that don't require custom native modules or extensive platform-specific code
- Want to share and test apps easily with stakeholders via Expo Go
- Need universal apps that run on web, mobile, and potentially desktop
- Prototyping mobile concepts with quick iteration cycles
- Working with designers who need to see real device previews instantly

### ❌ **Avoid Expo When**

- App requires extensive custom native modules not available in Expo SDK
- Need fine-grained control over native build process and configurations
- Building apps with complex native integrations (custom cameras, specialized sensors)
- Working with existing React Native projects with significant native customizations
- Performance requirements demand highly optimized native implementations
- Need to integrate with specific enterprise SDKs not supported by Expo
- App requires background processing or native functionality beyond Expo's scope

## Installation & Setup

### Prerequisites

See [example-1](./examples/expo/example-1.bash)

### Project Initialization

See [example-2](./examples/expo/example-2.bash)

## Project Structure

See [example-3](./examples/expo/example-3.txt)

## Core Concepts

### Expo SDK and APIs

- **Purpose**: Pre-built native modules and APIs for common mobile functionality
- **Usage**: Access device features without writing native code
- **Example**:

See [example-4](./examples/expo/example-4.javascript)

### Development Workflow

- **Purpose**: Streamlined development with instant updates and easy testing
- **Usage**: Develop, test, and iterate quickly across multiple devices
- **Example**:

See [example-5](./examples/expo/example-5.bash)

### EAS Build and Deployment

- **Purpose**: Cloud-based build service for creating app store-ready builds
- **Usage**: Build and deploy apps without local native development environment
- **Example**:

See [example-6](./examples/expo/example-6.bash)

## Essential Commands

See [example-7](./examples/expo/example-7.bash)

## Best Practices

### ✅ **Development Optimization**

- **Use TypeScript** - Leverage Expo's excellent TypeScript support for better development experience
- **Optimize bundle size** - Use dynamic imports and lazy loading for better performance
- **Handle permissions properly** - Always request permissions before using device APIs
- **Use Expo SDK modules** - Prefer Expo modules over third-party alternatives when available
- **Test on real devices** - Use Expo Go for quick testing on actual hardware
- **Implement error boundaries** - Handle errors gracefully in React Native components

### ✅ **Performance Best Practices**

- **Optimize images** - Use appropriate image formats and sizes for mobile
- **Implement lazy loading** - Load screens and components on demand
- **Use FlatList for large lists** - Better performance than ScrollView for long lists
- **Minimize re-renders** - Use React.memo and useMemo appropriately
- **Profile with Flipper** - Use debugging tools to identify performance bottlenecks
- **Enable Hermes** - Use Hermes JavaScript engine for better performance

### ❌ **Common Pitfalls to Avoid**

- **Don't ignore platform differences** - Test thoroughly on both iOS and Android
- **Don't overuse Expo Go** - Build standalone apps for production testing
- **Don't skip permission handling** - Always handle permission rejections gracefully
- **Don't use large bundle sizes** - Monitor and optimize app size regularly
- **Don't ignore update strategies** - Plan for over-the-air updates and rollbacks
- **Don't neglect offline functionality** - Consider offline scenarios in app design

## AI Agent Guidelines

When helping with Expo development:

1. **Always recommend latest Expo SDK** - Use most recent stable version for new projects
2. **Suggest appropriate workflow** - Help choose between managed and bare workflow
3. **Provide TypeScript examples** - Default to TypeScript for better development experience
4. **Include permission handling** - Always show proper permission request patterns
5. **Consider cross-platform differences** - Provide platform-specific guidance when needed
6. **Recommend EAS services** - Suggest EAS Build and EAS Update for deployment
7. **Focus on developer experience** - Emphasize Expo's development speed advantages
8. **Security considerations** - Include secure storage and API communication patterns

### Code Generation Rules

- Generate TypeScript code by default for new projects
- Include proper error handling for all async operations
- Use Expo SDK modules instead of third-party alternatives when possible
- Include platform-specific code when iOS/Android differences exist
- Follow React Native best practices for component structure
- Include navigation patterns using React Navigation
- Generate responsive layouts that work on different screen sizes
- Include proper permission handling for device API usage

## Installation & Setup

See [example-8](./examples/expo/example-8.bash)

## Project Structure

See [example-9](./examples/expo/example-9.txt)

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
See [example-10](./examples/expo/example-10.txt)[language]
// Example implementation
[code example]
See [example-11](./examples/expo/example-11.txt)[format]
# Configuration options
[example configuration]
See [example-12](./examples/expo/example-12.txt)[format]
# Configuration options
[example configuration]
See [example-13](./examples/expo/example-13.txt)bash
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
See [example-14](./examples/expo/example-14.txt)bash
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
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
