---
name: 'React Native.Instructions'
description: 'See [example-1](./examples/react-native/example-1.'
keywords: [async, agent, [pattern, architecture, (managed, analysis, api, (bare, agents, alternative:]
---



# React Native Framework Instructions for AI Agents

## When to Use React Native

Use React Native when you need:

- Cross-platform mobile apps with shared codebase (iOS + Android)
- Leveraging existing React knowledge and ecosystem
- Rapid prototyping and MVP development
- Apps requiring native performance and platform features
- Team already skilled in React/JavaScript/TypeScript
- Integration with existing React web applications
- Over-the-air updates and continuous deployment

## When to Avoid React Native

Consider alternatives when:

- Building platform-specific apps requiring deep native optimization
- Complex animations and high-performance graphics (consider Flutter/native)
- Extensive use of platform-specific APIs
- Team lacks React experience
- Budget allows for separate native development teams
- Apps requiring maximum performance (games, AR/VR)

## Framework Overview

- **Framework**: React Native 0.72+ with Expo SDK 49+
- **Type**: Cross-platform mobile application framework
- **Architecture**: JavaScript bridge with native components
- **Language**: JavaScript/TypeScript with React patterns
- **Use Cases**: Cross-platform mobile apps, MVPs, business applications

## Installation & Setup

### ✅ Recommended: Expo (Managed workflow)

See [example-1](./examples/react-native/example-1.bash)

### ✅ Alternative: React Native CLI (Bare workflow)

See [example-2](./examples/react-native/example-2.bash)

### ❌ Avoid: Outdated CLI tools

See [example-3](./examples/react-native/example-3.bash)

### AI Agent Decision Tree

- **For beginners**: Use Expo managed workflow
- **For rapid prototyping**: Use Expo with EAS Build
- **For complex native requirements**: Use bare React Native
- **For existing apps**: Progressive adoption or brownfield integration

## Project Structure

### ✅ Expo Project Structure

See [example-4](./examples/react-native/example-4.txt)

### ✅ Component Architecture

See [example-5](./examples/react-native/example-5.txt)

## Core Concepts

### Components and Styling

✅ **Best Practice**: TypeScript components with StyleSheet

See [example-6](./examples/react-native/example-6.typescript)

### Navigation with Expo Router

✅ **Best Practice**: File-based routing with TypeScript

See [example-7](./examples/react-native/example-7.typescript)

See [example-8](./examples/react-native/example-8.typescript)

### Custom Hooks for Data Management

✅ **Best Practice**: Extract business logic into custom hooks

See [example-9](./examples/react-native/example-9.typescript)

### State Management with Context

✅ **Best Practice**: Context for global state

See [example-10](./examples/react-native/example-10.typescript)

## Best Practices

### ✅ Do's

- Use TypeScript for better development experience and error prevention
- Implement proper error boundaries and loading states
- Use FlatList for performance with large datasets
- Optimize images with proper resizing and caching
- Use Expo SDK for faster development and easier deployment
- Implement proper navigation patterns with deep linking
- Use native device features through Expo APIs
- Test on both iOS and Android devices regularly

### ❌ Don'ts

- Don't use ScrollView for long lists (use FlatList/VirtualizedList)
- Don't ignore memory management for images and components
- Don't forget to handle keyboard avoiding for forms
- Don't use inline styles extensively (prefer StyleSheet)
- Don't ignore accessibility (a11y) requirements
- Don't forget to handle different screen sizes and orientations
- Don't skip error handling for network requests
- Don't ignore platform-specific UI differences

### Performance Optimization

See [example-11](./examples/react-native/example-11.typescript)

See [example-12](./examples/react-native/example-12.typescript)

## Development Workflow

### ✅ Recommended Development Setup

See [example-13](./examples/react-native/example-13.bash)

### IDE Configuration

- **VS Code Extensions**: React Native Tools, Expo Tools, TypeScript
- **Settings**: Enable TypeScript strict mode, React Native debugging
- **Debugging**: Use Flipper or React Native Debugger

### AI Agent Decision Matrix

| Scenario             | Recommended Approach        | Avoid                 |
| -------------------- | --------------------------- | --------------------- |
| New app              | Expo managed workflow       | Bare React Native     |
| Rapid prototyping    | Expo with EAS               | Native development    |
| Complex native needs | Expo dev build or bare      | Ejecting from Expo    |
| State management     | Context + useReducer        | Redux for simple apps |
| Navigation           | Expo Router                 | React Navigation v5-  |
| Styling              | StyleSheet + responsive     | Inline styles         |
| Testing              | Jest + React Native Testing | Manual testing only   |

## Integration Guidelines

- **With APIs**: Use proper error handling and loading states
- **With databases**: Use SQLite or remote APIs, avoid direct database connections
- **With authentication**: Implement secure token storage with AsyncStorage/Keychain
- **With push notifications**: Use Expo Notifications for managed workflow
- **With analytics**: Integrate Firebase Analytics or similar
- **With payments**: Use Stripe or platform-specific payment solutions

## Testing

### ✅ Component Testing

See [example-14](./examples/react-native/example-14.typescript)

### ✅ Integration Testing

See [example-15](./examples/react-native/example-15.typescript)

## Security Considerations

- Store sensitive data in Keychain/Keystore, not AsyncStorage
- Implement certificate pinning for API requests
- Validate and sanitize all user inputs
- Use secure authentication flows (OAuth2, JWT)
- Implement proper session management
- Enable network security config for production
- Use obfuscation for sensitive code

## Error Handling

See [example-16](./examples/react-native/example-16.typescript)

## AI Agent Quick Reference

- **Project Setup**: Use Expo for faster development, bare React Native for complex native needs
- **Component Creation**: Focus on TypeScript, StyleSheet, and proper prop interfaces
- **Navigation**: Implement file-based routing with Expo Router
- **State Management**: Use Context + useReducer for global state, custom hooks for data fetching
- **Performance**: Use FlatList for lists, optimize images, implement proper loading states
- **Testing**: Use React Native Testing Library for components, Detox for E2E
- **Deployment**: Use EAS Build and Submit for streamlined app store deployment

### [Pattern Name]

```[language]
// Example implementation
[code example]
See [example-17](./examples/react-native/example-17.txt)[language]
// Example implementation
[code example]
See [example-18](./examples/react-native/example-18.txt)[format]
# Configuration options
[example configuration]
See [example-19](./examples/react-native/example-19.txt)[format]
# Configuration options
[example configuration]
See [example-20](./examples/react-native/example-20.txt)bash
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
See [example-21](./examples/react-native/example-21.txt)bash
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
