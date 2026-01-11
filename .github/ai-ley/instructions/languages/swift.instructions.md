---
name: 'Swift.Instructions'
description: 'Comprehensive Swift development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.'
keywords: [api, context, concurrency, common, async, async/await, architecture, configuration, analysis, avoid]
---



# Swift Programming Instructions

Comprehensive Swift development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.

## 🧠 Context

- **Language**: Swift (5.9+)
- **Environments**: iOS, iPadOS, macOS, watchOS, tvOS, Linux, Server-side
- **Common Frameworks**: SwiftUI, UIKit, Combine, Foundation, Core Data, Vapor, Alamofire
- **Package Managers**: Swift Package Manager, CocoaPods, Carthage
- **Build Tools**: Xcode, swift build, Bazel
- **Testing**: XCTest, Quick/Nimble, SnapshotTesting

## 📁 Project Structure

See [example-1](./examples/swift/example-1.text)

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern Swift following established conventions
- Prioritize code safety with optionals and error handling
- Implement clear separation of concerns and modularity
- Use consistent formatting with SwiftLint and swift-format
- Follow the principle of protocol-oriented programming
- Leverage value types (structs, enums) over reference types when appropriate
- Prefer composition over inheritance for better flexibility

### Modern Language Features
- Use async/await for asynchronous programming
- Leverage property wrappers for clean, declarative code
- Employ result builders for domain-specific languages
- Utilize concurrency features with actors and TaskGroups
- Apply generics and associated types for type safety
- Use computed properties and property observers effectively

## 📜 Code Style and Conventions

### Naming Conventions

See [example-2](./examples/swift/example-2.swift)

### Function Design

See [example-3](./examples/swift/example-3.swift)

## 🏗️ Architecture Patterns

### MVVM with SwiftUI

See [example-4](./examples/swift/example-4.swift)

### SwiftUI View and ViewModel Pattern

See [example-5](./examples/swift/example-5.swift)

## 🔄 Concurrency Programming

### Modern async/await Patterns

See [example-6](./examples/swift/example-6.swift)

### Error Handling

See [example-7](./examples/swift/example-7.swift)

## 🛡️ Memory Management

### Efficient Resource Handling

See [example-8](./examples/swift/example-8.swift)

## ⚡ Performance Optimization

### Efficient Code Patterns

See [example-9](./examples/swift/example-9.swift)

## 🧪 Testing Guidelines

### Unit Testing Best Practices

See [example-10](./examples/swift/example-10.swift)

### SwiftUI Testing

See [example-11](./examples/swift/example-11.swift)

## 🛠️ Development Environment

### Recommended Configuration

See [example-12](./examples/swift/example-12.swift)

### Essential Tools
- **Formatter**: swift-format - Official Swift code formatter
- **Linter**: SwiftLint - Comprehensive Swift linting with customizable rules
- **Build Tool**: Xcode / swift build - Native Swift build tools
- **Package Manager**: Swift Package Manager - Native dependency management
- **Testing**: XCTest + Quick/Nimble - Comprehensive testing framework

## 🔍 Code Quality Standards

### Static Analysis

See [example-13](./examples/swift/example-13.swift)

### Documentation Standards

See [example-14](./examples/swift/example-14.swift)

## 🚫 Common Pitfalls to Avoid

- **Force unwrapping**: Avoid using `!` except in truly safe scenarios
- **Retain cycles**: Be careful with strong references in closures
- **Blocking the main thread**: Never perform long-running operations on the main queue
- **Ignoring optionals**: Always handle optional values explicitly
- **Over-using classes**: Prefer structs and value types when possible

## 📚 Essential Libraries

### Standard Library
See [example-15](./examples/swift/example-15.swift)

### Recommended Third-Party Libraries
- **Alamofire**: Modern HTTP networking library
- **SwiftLint**: Code style and consistency enforcement
- **Quick/Nimble**: Behavior-driven development testing framework
- **SnapKit**: Auto Layout DSL for programmatic UI
- **Kingfisher**: Image downloading and caching library

## 🚦 AI Enforcement Summary

### Code Quality Rules
- ✅ Enforce immutable properties with `let` over `var`
- ✅ Require proper optional handling without force unwrapping
- ✅ Block retain cycles in closures
- ✅ Enforce PascalCase naming for types and camelCase for variables
- ✅ Require documentation for public APIs
- ✅ Block blocking operations on main thread
- ✅ Enforce proper error handling with Result types
- ✅ Auto-fix import organization and formatting

### Performance Enforcement
- 🚫 Block inefficient string concatenation in loops
- 🚫 Block retain cycles and memory leaks
- ✅ Promote lazy initialization for expensive operations
- ✅ Promote value types over reference types when appropriate

### Security Enforcement
- 🔒 Enforce input validation for user-provided data
- 🔒 Block hardcoded secrets and credentials
- 🔒 Require proper keychain usage for sensitive data

## 📖 References

- [Swift Official Documentation](https://docs.swift.org/swift-book/)
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [SwiftUI Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/swiftui)
- [Swift Concurrency Documentation](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [Swift Package Manager Guide](https://swift.org/package-manager/)

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
