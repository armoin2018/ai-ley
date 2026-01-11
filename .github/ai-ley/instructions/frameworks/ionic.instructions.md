---
name: 'Ionic.Instructions'
description: 'See [example-1](./examples/ionic/example-1.'
keywords: [(angular), angular, agent, [pattern, architecture, analysis, api, agents, avoid, authentication]
---



# Ionic Framework Instructions for AI Agents

## When to Use Ionic

Use Ionic when you need:

- Cross-platform apps using web technologies (HTML, CSS, JavaScript)
- Leveraging existing web framework skills (Angular, React, Vue)
- Rapid prototyping with native-like UI components
- Progressive Web Apps (PWAs) with mobile deployment
- Cost-effective cross-platform development
- Apps that require web deployment alongside mobile
- Teams with strong web development experience

## When to Avoid Ionic

Consider alternatives when:

- Building performance-critical games or graphics-intensive apps
- Need deep native platform integrations (consider React Native/Flutter)
- Team lacks web development experience
- App requires complex native functionality
- Maximum native performance is essential
- Working with AR/VR or complex animations

## Framework Overview

- **Framework**: Ionic 7.x with Capacitor 5.x
- **Type**: Hybrid mobile app framework using web technologies
- **Architecture**: Web components with native bridge via Capacitor
- **Language**: JavaScript/TypeScript with Angular, React, or Vue
- **Use Cases**: Cross-platform mobile apps, PWAs, hybrid applications

## Installation & Setup

### ✅ Recommended: Ionic CLI with Framework of Choice

See [example-1](./examples/ionic/example-1.bash)

### ✅ Capacitor Setup for Native Deployment

See [example-2](./examples/ionic/example-2.bash)

### AI Agent Decision Tree

- **For Angular teams**: Use Ionic Angular for familiar patterns
- **For React teams**: Use Ionic React with React Router
- **For Vue teams**: Use Ionic Vue with Vue Router
- **For web-first**: Start with PWA, add native later
- **For native-first**: Use Capacitor from the beginning

## Project Structure

### ✅ Ionic Angular Project Structure

See [example-3](./examples/ionic/example-3.txt)

### ✅ Ionic React Project Structure

See [example-4](./examples/ionic/example-4.txt)

## Core Concepts

### Ionic Components with Angular

✅ **Best Practice**: Ionic UI components with Angular patterns

See [example-5](./examples/ionic/example-5.typescript)

See [example-6](./examples/ionic/example-6.html)

### Ionic Components with React

✅ **Best Practice**: Ionic React with hooks and TypeScript

See [example-7](./examples/ionic/example-7.typescript)

### Capacitor Native Integration

✅ **Best Practice**: Using Capacitor plugins for native functionality

See [example-8](./examples/ionic/example-8.typescript)

### Navigation and Routing

✅ **Best Practice**: Ionic navigation with framework-specific routing

See [example-9](./examples/ionic/example-9.typescript)

See [example-10](./examples/ionic/example-10.typescript)

## Best Practices

### ✅ Do's

- Use Ionic UI components for consistent native-like experience
- Implement proper navigation patterns with framework-specific routing
- Leverage Capacitor plugins for native device functionality
- Use TypeScript for better development experience and type safety
- Implement proper error handling and loading states
- Follow platform-specific design guidelines (iOS/Android)
- Use lazy loading for better performance
- Test on actual devices, not just browser/simulator

### ❌ Don'ts

- Don't mix Ionic components with other UI frameworks (Bootstrap, Material UI)
- Don't ignore platform-specific UI patterns and guidelines
- Don't forget to handle offline scenarios and network errors
- Don't use complex animations that may affect performance
- Don't ignore accessibility features and proper ARIA labels
- Don't skip testing on actual mobile devices
- Don't forget to optimize for different screen sizes and orientations
- Don't use deprecated Cordova plugins (use Capacitor instead)

### Performance Optimization

See [example-11](./examples/ionic/example-11.typescript)

See [example-12](./examples/ionic/example-12.typescript)

## Development Workflow

### ✅ Recommended Development Setup

See [example-13](./examples/ionic/example-13.bash)

### IDE Configuration

- **VS Code Extensions**: Ionic Extension Pack, Angular/React/Vue extensions
- **Settings**: Enable Ionic IntelliSense, TypeScript strict mode
- **Tools**: Ionic DevApp for testing, Chrome DevTools for debugging

### AI Agent Decision Matrix

| Scenario             | Recommended Approach          | Avoid                          |
| -------------------- | ----------------------------- | ------------------------------ |
| Web-first app        | Start with PWA, add native    | Native-first development       |
| Angular team         | Ionic Angular                 | Learning new framework         |
| React team           | Ionic React                   | Angular or Vue versions        |
| Vue team             | Ionic Vue                     | React or Angular versions      |
| Native functionality | Capacitor plugins             | Cordova plugins                |
| Performance critical | Consider React Native/Flutter | Heavy web frameworks           |
| Simple UI            | Ionic components              | Custom CSS frameworks          |
| Complex state        | Framework state management    | Ionic-specific state solutions |

## Integration Guidelines

- **With APIs**: Use framework-specific HTTP clients (HttpClient, Axios, fetch)
- **With databases**: Use SQLite via Capacitor or cloud solutions
- **With authentication**: Implement secure token storage with Capacitor Preferences
- **With push notifications**: Use Capacitor Push Notifications plugin
- **With analytics**: Integrate Firebase Analytics or similar
- **With social login**: Use Capacitor Community plugins

## Testing

### ✅ Component Testing (Angular)

See [example-14](./examples/ionic/example-14.typescript)

### ✅ E2E Testing

See [example-15](./examples/ionic/example-15.typescript)

## Security Considerations

- Store sensitive data securely using Capacitor Preferences with encryption
- Validate all user inputs and sanitize data before processing
- Use HTTPS for all API communications
- Implement proper authentication and session management
- Use Capacitor Security plugin for additional security features
- Enable CSP (Content Security Policy) for web deployments
- Obfuscate and minify code for production builds
- Implement certificate pinning for critical API calls

## Error Handling

See [example-16](./examples/ionic/example-16.typescript)

## AI Agent Quick Reference

- **Project Setup**: Use Ionic CLI with framework of choice (Angular/React/Vue)
- **Component Development**: Leverage Ionic UI components for native-like experience
- **Navigation**: Implement framework-specific routing patterns
- **Native Integration**: Use Capacitor plugins for device functionality
- **State Management**: Use framework-specific state management solutions
- **Performance**: Implement virtual scrolling, lazy loading, and image optimization
- **Testing**: Write unit tests with framework testing tools, E2E tests with Protractor/Cypress
- **Deployment**: Build for web and native platforms with appropriate optimizations

### [Pattern Name]

```[language]
// Example implementation
[code example]
See [example-17](./examples/ionic/example-17.txt)[language]
// Example implementation
[code example]
See [example-18](./examples/ionic/example-18.txt)[format]
# Configuration options
[example configuration]
See [example-19](./examples/ionic/example-19.txt)[format]
# Configuration options
[example configuration]
See [example-20](./examples/ionic/example-20.txt)bash
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
See [example-21](./examples/ionic/example-21.txt)typescript
  import { AngularFireAuth } from '@angular/fire/compat/auth';
  import { AngularFirestore } from '@angular/fire/compat/firestore';
  See [example-22](./examples/ionic/example-22.txt)typescript
  import { Camera } from '@capacitor/camera';
  import { Geolocation } from '@capacitor/geolocation';
  See [example-23](./examples/ionic/example-23.txt)bash
# Enable debug logging
ionic capacitor run ios --livereload --external
ionic capacitor run android --livereload --external

# Chrome DevTools for web debugging
ionic serve --lab

# Native debugging
ionic capacitor open ios  # Opens Xcode
ionic capacitor open android  # Opens Android Studio
```

### Log Analysis

- **Web**: Browser DevTools Console tab
- **iOS**: Xcode Console when running on device/simulator
- **Android**: Android Studio Logcat when running on device/emulator
- **Capacitor**: Check native logs for plugin-related issues

### Common Error Messages

- **Error**: `Cannot resolve dependency 'cordova-plugin-*'`
  **Cause**: Trying to use Cordova plugins instead of Capacitor
  **Solution**: Use equivalent Capacitor plugins or community plugins

- **Error**: `Module not found: Error: Can't resolve '@ionic/angular'`
  **Cause**: Ionic packages not installed or incorrect import path
  **Solution**: `npm install @ionic/angular` and verify import statements

- **Error**: `Platform 'ios' is not installed`
  **Cause**: iOS platform not added to Capacitor project
  **Solution**: `ionic capacitor add ios` then `ionic capacitor sync`

- **Error**: `Could not find valid entry point 'main'`
  **Cause**: Build output directory mismatch between framework and Capacitor
  **Solution**: Update `capacitor.config.ts` with correct `webDir` path

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
