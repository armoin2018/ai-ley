---
name: 'Kotlin.Instructions'
description: 'Comprehensive Kotlin development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.'
keywords: [api, concurrency, common, async, cli, architecture, analysis, avoid, best-practices, clean]
---



# Kotlin Programming Instructions

Comprehensive Kotlin development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.

## 🧠 Context

- **Language**: Kotlin (1.9+)
- **Environments**: JVM, Android, Native, JavaScript/WASM
- **Common Frameworks**: Ktor, Spring Boot, Jetpack Compose, Coroutines, Exposed
- **Package Managers**: Gradle, Maven
- **Build Tools**: Gradle Kotlin DSL, Maven
- **Testing**: JUnit 5, Kotest, MockK, Turbine

## 📁 Project Structure

See [example-1](./examples/kotlin/example-1.text)

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern Kotlin following established conventions
- Prioritize code readability and maintainability over cleverness
- Implement clear separation of concerns and modularity
- Use consistent formatting with ktlint or detekt
- Follow the principle of least surprise
- Leverage Kotlin's null safety and type system effectively
- Prefer immutable data structures and pure functions

### Modern Language Features
- Use data classes for simple data containers
- Leverage sealed classes for representing restricted hierarchies
- Employ extension functions for clean, readable APIs
- Utilize coroutines for asynchronous programming
- Apply scope functions (let, run, with, apply, also) appropriately
- Use delegation patterns (by lazy, by observable)
- Leverage inline functions for performance-critical code

## 📜 Code Style and Conventions

### Naming Conventions

See [example-2](./examples/kotlin/example-2.kotlin)

### Function Design

See [example-3](./examples/kotlin/example-3.kotlin)

## 🏗️ Architecture Patterns

### Clean Architecture Design

See [example-4](./examples/kotlin/example-4.kotlin)

### MVVM Pattern Implementation

See [example-5](./examples/kotlin/example-5.kotlin)

## 🔄 Coroutines Programming

### Structured Concurrency Best Practices

See [example-6](./examples/kotlin/example-6.kotlin)

### Error Handling

See [example-7](./examples/kotlin/example-7.kotlin)

## 🛡️ Memory Management

### Efficient Resource Handling

See [example-8](./examples/kotlin/example-8.kotlin)

## ⚡ Performance Optimization

### Efficient Code Patterns

See [example-9](./examples/kotlin/example-9.kotlin)

## 🧪 Testing Guidelines

### Unit Testing Best Practices

See [example-10](./examples/kotlin/example-10.kotlin)

### Integration Testing

See [example-11](./examples/kotlin/example-11.kotlin)

## 🛠️ Development Environment

### Recommended Configuration

See [example-12](./examples/kotlin/example-12.kotlin)

### Essential Tools
- **Formatter**: ktlint - Kotlin code formatter with consistent styling rules
- **Linter**: detekt - Static code analysis for Kotlin with customizable rules
- **Build Tool**: Gradle Kotlin DSL - Type-safe build scripts with IDE support
- **Package Manager**: Gradle - Comprehensive dependency management and build automation
- **Testing**: JUnit 5 + Kotest + MockK - Modern testing framework with powerful assertions

## 🔍 Code Quality Standards

### Static Analysis

See [example-13](./examples/kotlin/example-13.kotlin)

### Documentation Standards

See [example-14](./examples/kotlin/example-14.kotlin)

## 🚫 Common Pitfalls to Avoid

- **Overusing scope functions**: Don't chain multiple scope functions unnecessarily
- **Ignoring null safety**: Always handle nullable types explicitly
- **Blocking coroutines**: Avoid blocking calls in suspend functions
- **Memory leaks**: Properly cancel coroutines and clean up resources
- **Platform violations**: Don't perform long-running operations on the main thread

## 📚 Essential Libraries

### Standard Library
See [example-15](./examples/kotlin/example-15.kotlin)

### Recommended Third-Party Libraries
- **Ktor**: Modern HTTP client and server framework
- **Exposed**: Lightweight SQL library for Kotlin
- **Koin**: Lightweight dependency injection framework
- **Kotest**: Comprehensive testing framework with powerful matchers
- **Arrow**: Functional programming library with advanced type safety

## 🚦 AI Enforcement Summary

### Code Quality Rules
- ✅ Enforce immutable data classes and val over var
- ✅ Require null safety with proper null handling
- ✅ Block platform-specific Android code in shared modules
- ✅ Enforce camelCase naming for functions and variables
- ✅ Require KDoc documentation for public APIs
- ✅ Block inefficient string concatenation in loops
- ✅ Enforce proper coroutine scope usage
- ✅ Auto-fix import organization and formatting

### Performance Enforcement
- 🚫 Block blocking calls in coroutines (runBlocking in production)
- 🚫 Block inefficient collection operations on large datasets
- ✅ Promote lazy initialization for expensive resources
- ✅ Promote sequence usage for large collection processing

### Security Enforcement
- 🔒 Enforce input validation for user-provided data
- 🔒 Block hardcoded secrets and credentials
- 🔒 Require proper exception handling with specific types

## 📖 References

- [Kotlin Official Documentation](https://kotlinlang.org/docs/home.html)
- [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html)
- [Coroutines Best Practices](https://kotlinlang.org/docs/coroutines-best-practices.html)
- [Android Kotlin Style Guide](https://developer.android.com/kotlin/style-guide)
- [Effective Kotlin](https://kt.academy/book/effectivekotlin)

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
