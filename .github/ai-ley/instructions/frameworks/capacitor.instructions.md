---
name: 'Capacitor.Instructions'
description: 'See [example-1](./examples/capacitor/example-1.'
keywords: [api, agent, capacitor.instructions, agents, alternative:, architecture, authentication, capacitor, avoid, (capacitor.config.ts)]
---



# Capacitor Framework Instructions for AI Agents

## When to Use Capacitor

Use Capacitor when you need:

- Native mobile app deployment from web applications
- Modern replacement for Apache Cordova/PhoneGap
- Progressive Web Apps (PWAs) with native capabilities
- Cross-platform development with web technologies
- Bridge between web app and native mobile features
- Existing web application that needs mobile deployment
- Live reload and debugging in native environment

## When to Avoid Capacitor

Consider alternatives when:

- Building native-first applications (use native frameworks)
- Need maximum native performance (consider React Native/Flutter)
- Working with complex native integrations requiring custom code
- Team has no web development experience
- App requires intensive graphics or gaming features
- Pure web application without mobile deployment needs

## Framework Overview

- **Framework**: Capacitor 5.x
- **Type**: Native bridge layer for web applications
- **Architecture**: Web-to-native runtime with plugin system
- **Language**: JavaScript/TypeScript with web frameworks
- **Use Cases**: Hybrid mobile apps, PWAs with native features, web-to-mobile conversion

## Installation & Setup

### ✅ Recommended: Add Capacitor to Existing Web App

See [example-1](./examples/capacitor/example-1.bash)

### ✅ Alternative: Start with Capacitor Template

See [example-2](./examples/capacitor/example-2.bash)

### AI Agent Decision Tree

- **For existing web app**: Add Capacitor incrementally
- **For new project**: Start with web framework + Capacitor
- **For Ionic projects**: Capacitor is default (preferred over Cordova)
- **For React/Vue/Angular**: Add Capacitor after initial setup
- **For PWA enhancement**: Add native plugins as needed

## Project Structure

### ✅ Capacitor Project Structure

See [example-3](./examples/capacitor/example-3.txt)

### ✅ Configuration File (capacitor.config.ts)

See [example-4](./examples/capacitor/example-4.typescript)

## Core Concepts

### Native Plugin System

✅ **Best Practice**: Using official Capacitor plugins

See [example-5](./examples/capacitor/example-5.typescript)

### Local Storage and Preferences

✅ **Best Practice**: Secure data storage with Capacitor

See [example-6](./examples/capacitor/example-6.typescript)

### Push Notifications

✅ **Best Practice**: Implementing push notifications

See [example-7](./examples/capacitor/example-7.typescript)

## Best Practices

### ✅ Do's

- Use official Capacitor plugins whenever possible
- Test thoroughly on actual devices, not just simulators
- Handle network connectivity changes gracefully
- Implement proper error handling for all native operations
- Use TypeScript for better development experience
- Follow platform-specific UI guidelines and patterns
- Optimize for both iOS and Android platform differences
- Implement proper app lifecycle management

### ❌ Don'ts

- Don't rely solely on web browser testing for native features
- Don't ignore platform-specific permissions and security models
- Don't forget to handle offline scenarios appropriately
- Don't mix Capacitor with Cordova plugins (use migration guide)
- Don't ignore memory management in long-running background tasks
- Don't hardcode platform-specific values in shared code
- Don't skip testing on different device sizes and OS versions
- Don't ignore app store guidelines and requirements

### Performance Optimization

See [example-8](./examples/capacitor/example-8.typescript)

## Development Workflow

### ✅ Recommended Development Process

See [example-9](./examples/capacitor/example-9.bash)

### AI Agent Decision Matrix

| Scenario                    | Recommended Approach           | Avoid                        |
| --------------------------- | ------------------------------ | ---------------------------- |
| Existing web app            | Add Capacitor incrementally    | Complete rewrite             |
| New mobile project          | Web framework + Capacitor      | Native-only development      |
| Native performance critical | Consider native alternatives   | Heavy web frameworks         |
| Cross-platform requirement  | Capacitor with shared codebase | Separate native apps         |
| Web + mobile deployment     | PWA with Capacitor enhancement | Separate web and mobile apps |
| Plugin needed               | Official Capacitor plugins     | Custom native code initially |
| Team web-focused            | Leverage existing web skills   | Learning native development  |
| Rapid prototyping           | Capacitor with web frameworks  | Complex native setup         |

## Testing

### ✅ Unit Testing Native Features

See [example-10](./examples/capacitor/example-10.typescript)

## Security Considerations

- Validate all data received from native plugins before processing
- Use secure storage (Preferences with encryption) for sensitive data
- Implement certificate pinning for critical API communications
- Follow platform security guidelines (iOS App Transport Security, Android Network Security Config)
- Use proper authentication and session management
- Implement biometric authentication where appropriate
- Validate file uploads and downloads from device storage
- Use HTTPS for all network communications
- Implement proper error handling that doesn't leak sensitive information

## Error Handling and Debugging

See [example-11](./examples/capacitor/example-11.typescript)

## AI Agent Quick Reference

- **Project Setup**: Add Capacitor to existing web app or start with template
- **Configuration**: Configure capacitor.config.ts for platform-specific settings
- **Plugin Integration**: Use official plugins with proper TypeScript types
- **Development**: Use live reload for rapid development and testing
- **Testing**: Mock native plugins for unit tests, use actual devices for integration testing
- **Performance**: Implement lazy loading, image optimization, and proper caching
- **Security**: Use secure storage, validate inputs, follow platform guidelines
- **Deployment**: Build and test on actual devices before app store submission

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
