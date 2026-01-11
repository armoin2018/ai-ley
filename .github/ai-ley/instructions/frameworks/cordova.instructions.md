---
name: 'Apache Cordova Mobile Development Framework Instructions'
description: 'Comprehensive guide for Apache Cordova hybrid mobile app development'
keywords: [**security, async, agent, **common, api, apache, **performance, **use, assessment, **avoid]
---


# Apache Cordova Mobile Development Framework Instructions

## Framework Overview

- **Framework Name**: Apache Cordova
- **Version**: 12.0+ (Latest stable with platform improvements and security updates)
- **Type**: Hybrid Mobile Framework
- **Language**: HTML, CSS, JavaScript, TypeScript
- **Use Cases**: Cross-platform mobile apps, web-to-mobile conversion, rapid prototyping, enterprise mobile solutions

## When to Use Cordova

### ✅ **Use Cordova When**

- Converting existing web applications to mobile apps quickly
- Team has strong web development skills but limited native mobile experience
- Need to support multiple platforms with single codebase
- Building content-focused apps that don't require intensive native performance
- Working with legacy web technologies that need mobile deployment
- Budget constraints require cost-effective cross-platform solution
- Enterprise apps requiring standard UI components and basic device integration
- Prototyping mobile concepts before committing to native development

### ❌ **Avoid Cordova When**

- Building performance-critical applications (games, AR/VR, heavy animations)
- Need advanced native UI components and platform-specific design patterns
- Requiring complex device integrations beyond basic plugin capabilities
- Target audience expects native app performance and responsiveness
- Working with real-time applications requiring low latency
- Team has strong native development expertise and resources
- App stores are rejecting hybrid apps in your category

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type        | Cordova Recommendation                      | Alternative Consideration   |
| ------------------- | ------------------------------------------- | --------------------------- |
| Content/News App    | ✅ **Recommended** - Web content works well | Consider PWA first          |
| Business/Enterprise | ✅ **Good Choice** - Forms and data entry   | React Native for better UX  |
| E-commerce          | 🔄 **Consider** - Performance important     | Native for complex checkout |
| Gaming              | ❌ **Avoid** - Performance critical         | Unity, native frameworks    |
| Social Media        | 🔄 **Consider** - UX expectations high      | React Native, Flutter       |
| Utility/Tools       | ✅ **Good Choice** - Simple functionality   | PWA might be sufficient     |

### Complexity Assessment

| Factor                       | Low Complexity        | Medium Complexity                | High Complexity                  |
| ---------------------------- | --------------------- | -------------------------------- | -------------------------------- |
| **Setup Time**               | 4 hours (basic app)   | 2 days (plugins + customization) | 1 week (complex integrations)    |
| **Platform Support**         | Android + iOS         | + Windows, Browser               | + Custom platforms               |
| **Plugin Dependencies**      | 0-3 basic plugins     | 4-8 plugins with customization   | 9+ plugins or custom development |
| **Performance Requirements** | Basic content display | Moderate interactivity           | High performance needs           |

## Installation & Setup

### Prerequisites

See [example-1](./examples/cordova/example-1.bash)

### Global Cordova Installation

See [example-2](./examples/cordova/example-2.bash)

### Project Initialization

See [example-3](./examples/cordova/example-3.bash)

## Project Structure

See [example-4](./examples/cordova/example-4.txt)

## Core Concepts

### Device Ready Event

- **Purpose**: Ensures Cordova APIs are loaded before use
- **Usage**: Critical initialization point for all Cordova applications
- **Example**:

See [example-5](./examples/cordova/example-5.javascript)

### Plugin System

- **Purpose**: Extends web apps with native device functionality
- **Usage**: Bridge between JavaScript and native mobile platform APIs
- **Example**:

See [example-6](./examples/cordova/example-6.bash)

See [example-7](./examples/cordova/example-7.javascript)

## Development Workflow

1. **Setup**: Initialize project and add target platforms
2. **Development**: Code in www/ directory using web technologies
3. **Testing**: Test in browser, then device emulators and real devices
4. **Building**: Compile platform-specific applications
5. **Deployment**: Distribute through app stores or enterprise channels

## Essential Commands

See [example-8](./examples/cordova/example-8.bash)

## Best Practices

### ✅ **Performance Optimization**

- **Minimize DOM manipulation** - Cache DOM references and batch updates
- **Use CSS transforms** instead of changing layout properties for animations
- **Implement lazy loading** for images and content to improve initial load time
- **Optimize images** - Use appropriate formats and sizes for mobile screens
- **Use requestAnimationFrame** for smooth animations and transitions
- **Minimize plugin usage** - Only include plugins you actually need

### ✅ **Security Best Practices**

- **Content Security Policy** - Implement strict CSP headers
- **Validate all inputs** - Never trust data from device APIs or user input
- **Secure storage** - Use plugins for sensitive data storage
- **HTTPS only** - Always use secure connections for network requests
- **Plugin auditing** - Regularly audit and update plugins for security issues
- **Whitelist domains** - Restrict network access to known domains

### ❌ **Common Pitfalls to Avoid**

- **Don't access device APIs before deviceready** - Always wait for the event
- **Don't use synchronous operations** - Use callbacks and promises for async operations
- **Don't ignore platform differences** - Test thoroughly on each target platform
- **Don't create memory leaks** - Properly clean up event listeners and timers
- **Don't rely on browser-specific features** - Ensure cross-platform compatibility
- **Don't skip error handling** - Plugin operations can fail on different devices

## AI Agent Guidelines

When helping with Apache Cordova development:

1. **Always check deviceready first** - Ensure proper Cordova initialization
2. **Recommend modern alternatives** - Suggest Capacitor or native solutions when appropriate
3. **Focus on cross-platform compatibility** - Provide solutions that work on multiple platforms
4. **Include error handling** - Always wrap plugin calls in try-catch or promise chains
5. **Suggest performance optimizations** - Recommend best practices for hybrid app performance
6. **Security awareness** - Include CSP and secure storage recommendations
7. **Plugin ecosystem guidance** - Help select appropriate plugins and avoid deprecated ones
8. **Testing strategies** - Emphasize testing on real devices, not just emulators

### Code Generation Rules

- Generate code that waits for deviceready event before using Cordova APIs
- Include proper error handling for all plugin operations
- Provide cross-platform compatible solutions
- Follow modern JavaScript practices (ES6+, async/await, promises)
- Include fallbacks for when plugins are not available
- Generate responsive CSS that works on various screen sizes
- Include performance optimization techniques in generated code
- Follow Cordova's security best practices in all generated examples

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
