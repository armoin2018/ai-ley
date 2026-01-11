---
name: 'Flutter.Instructions'
description: 'See [example-1](./examples/flutter/example-1.'
keywords: [agent, [pattern, architecture, analysis, api, authorization, agents, avoid, analyze, authentication]
---



# Flutter Framework Instructions for AI Agents

## When to Use Flutter

Use Flutter when you need:

- Single codebase for iOS, Android, web, desktop, and embedded platforms
- High-performance mobile apps with native-like user interfaces
- Consistent UI across all platforms with pixel-perfect control
- Fast development with hot reload and excellent tooling
- Custom animations and complex UI designs
- Apps requiring 60fps performance and smooth animations
- Team wanting to learn a modern, growing ecosystem

## When to Avoid Flutter

Consider alternatives when:

- Need extensive platform-specific integrations (consider native development)
- Working with legacy code that requires deep platform integration
- Team has no experience with Dart language
- App requires minimal UI and maximum platform-specific functionality
- Budget allows for separate native development teams
- Need immediate access to latest platform APIs (may have delays in Flutter)

## Framework Overview

- **Framework**: Flutter 3.x
- **Type**: UI toolkit for cross-platform applications
- **Architecture**: Widget-based declarative UI with Dart runtime
- **Language**: Dart 3.0+
- **Use Cases**: Mobile apps, web apps, desktop applications, embedded systems

## Installation & Setup

### ✅ Recommended: Flutter SDK Installation

See [example-1](./examples/flutter/example-1.bash)

### ✅ Development Environment Setup

See [example-2](./examples/flutter/example-2.bash)

### AI Agent Decision Tree

- **For mobile-first apps**: Start with iOS/Android, expand to other platforms
- **For web apps**: Consider if Flutter web meets your SEO/performance needs
- **For desktop**: Evaluate against native solutions (Electron, .NET, etc.)
- **For prototyping**: Flutter's hot reload provides excellent rapid development

## Project Structure

### ✅ Standard Flutter Project Structure

See [example-3](./examples/flutter/example-3.txt)

## Core Concepts

### Widgets and State Management

✅ **Best Practice**: Stateless and Stateful widgets with proper state management

See [example-4](./examples/flutter/example-4.dart)

See [example-5](./examples/flutter/example-5.dart)

### State Management with Provider

✅ **Best Practice**: Provider pattern for state management

See [example-6](./examples/flutter/example-6.dart)

### Navigation and Routing

✅ **Best Practice**: Named routes with go_router

See [example-7](./examples/flutter/example-7.dart)

### HTTP Requests and Error Handling

✅ **Best Practice**: Structured API service with error handling

See [example-8](./examples/flutter/example-8.dart)

## Best Practices

### ✅ Do's

- Use `const` constructors for widgets whenever possible
- Implement proper state management (Provider, Bloc, Riverpod)
- Use `ListView.builder` for long lists instead of `Column` with `SingleChildScrollView`
- Handle all possible states (loading, error, empty, success)
- Implement proper error boundaries and user feedback
- Use proper naming conventions (camelCase for variables, PascalCase for classes)
- Test widgets, logic, and integration scenarios
- Use `SafeArea` for proper screen boundary handling

### ❌ Don'ts

- Don't ignore Flutter doctor warnings
- Don't use `setState` for complex state management
- Don't forget to dispose controllers and streams
- Don't use hardcoded values for responsive design
- Don't ignore accessibility features
- Don't block the UI thread with heavy computations
- Don't forget to handle keyboard appearance on forms
- Don't ignore platform-specific design guidelines

### Performance Optimization

See [example-9](./examples/flutter/example-9.dart)

## Development Workflow

### ✅ Recommended Development Setup

See [example-10](./examples/flutter/example-10.bash)

### IDE Configuration

- **VS Code Extensions**: Flutter, Dart, Flutter Widget Snippets
- **Android Studio**: Flutter and Dart plugins
- **Settings**: Enable hot reload, format on save, show performance overlay

### AI Agent Decision Matrix

| Scenario      | Recommended Approach             | Avoid                            |
| ------------- | -------------------------------- | -------------------------------- |
| Simple state  | StatefulWidget + setState        | Complex state management         |
| Complex state | Provider/Bloc/Riverpod           | setState for global state        |
| Navigation    | go_router or Navigator 2.0       | Legacy Navigator 1.0             |
| HTTP requests | http package with error handling | dio for simple apps              |
| Local storage | shared_preferences/sqflite       | Complex database for simple data |
| Animations    | AnimatedWidget/Controller        | Heavy third-party packages       |
| Testing       | flutter_test + integration       | Manual testing only              |

## Integration Guidelines

- **With APIs**: Use proper HTTP client with error handling and timeouts
- **With databases**: Use sqflite for local storage, Firebase for cloud
- **With authentication**: Implement secure token storage and validation
- **With push notifications**: Use Firebase Cloud Messaging
- **With analytics**: Integrate Firebase Analytics or similar
- **With crash reporting**: Use Firebase Crashlytics for production apps

## Testing

### ✅ Widget Testing

See [example-11](./examples/flutter/example-11.dart)

### ✅ Integration Testing

See [example-12](./examples/flutter/example-12.dart)

## Security Considerations

- Store sensitive data securely using flutter_secure_storage
- Validate all user inputs and sanitize data
- Use HTTPS for all network requests
- Implement proper authentication and authorization
- Obfuscate code for production releases
- Use certificate pinning for critical APIs
- Handle biometric authentication securely
- Implement proper session management

## Error Handling

See [example-13](./examples/flutter/example-13.dart)

## AI Agent Quick Reference

- **Project Setup**: Use `flutter create` with appropriate template for target platforms
- **Widget Development**: Focus on composition, const constructors, and proper state management
- **State Management**: Use Provider for medium complexity, Bloc for complex apps
- **Navigation**: Implement declarative routing with go_router
- **Data Fetching**: Use http package with proper error handling and loading states
- **Performance**: Use ListView.builder, const widgets, and compute for heavy operations
- **Testing**: Write widget tests, unit tests, and integration tests
- **Deployment**: Use `flutter build` for platform-specific releases

### [Pattern Name]

```[language]
// Example implementation
[code example]
See [example-14](./examples/flutter/example-14.txt)[language]
// Example implementation
[code example]
See [example-15](./examples/flutter/example-15.txt)[format]
# Configuration options
[example configuration]
See [example-16](./examples/flutter/example-16.txt)[format]
# Configuration options
[example configuration]
See [example-17](./examples/flutter/example-17.txt)bash
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
See [example-18](./examples/flutter/example-18.txt)dart
  await Firebase.initializeApp();
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  See [example-19](./examples/flutter/example-19.txt)dart
  final response = await http.get(Uri.parse('https://api.example.com/data'));
  final data = json.decode(response.body);
  See [example-20](./examples/flutter/example-20.txt)dart
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('key', 'value');
  See [example-21](./examples/flutter/example-21.txt)dart
  static const platform = MethodChannel('com.example.app/battery');
  final batteryLevel = await platform.invokeMethod('getBatteryLevel');
  See [example-22](./examples/flutter/example-22.txt)bash
# Run app in debug mode
flutter run --debug

# Enable verbose logging
flutter run --verbose

# Profile performance
flutter run --profile

# Analyze code
flutter analyze

# Check doctor for setup issues
flutter doctor -v
```

### Log Analysis

- **Console logs**: Use `print()` statements or `debugPrint()` for debug output
- **Flutter Inspector**: Use DevTools for widget tree inspection
- **Performance**: Monitor frame rendering and memory usage in DevTools
- **Crash logs**: Check platform-specific crash reports (Crashlytics, Bugsnag)

### Common Error Messages

- **Error**: `RenderFlex overflowed by X pixels`
  **Cause**: Widget content exceeds available space
  **Solution**: Wrap with `Expanded`, `Flexible`, or `SingleChildScrollView`

- **Error**: `setState() called after dispose()`
  **Cause**: Attempting to update state on a disposed widget
  **Solution**: Check `mounted` property before calling `setState()`

- **Error**: `A RenderFlex overflowed by X pixels on the right`
  **Cause**: Row widget children exceed horizontal space
  **Solution**: Use `Expanded` widgets or reduce content size

- **Error**: `Could not resolve all artifacts for configuration ':app:debugRuntimeClasspath'`
  **Cause**: Gradle dependency resolution issues
  **Solution**: Run `flutter clean` and `flutter pub get`, check gradle version compatibility

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
