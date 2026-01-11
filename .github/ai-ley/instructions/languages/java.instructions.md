---
name: 'Java.Instructions'
description: 'Comprehensive Java development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.'
keywords: [api, context, common, completablefuture, architecture, authentication, configuration, analysis, avoid, concurrent]
---



# Java Programming Instructions

Comprehensive Java development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.

## 🧠 Context

- **Language**: Java (17+)
- **Environments**: JVM, Spring Boot, Jakarta EE, Android
- **Common Frameworks**: Spring Framework, Spring Boot, Hibernate, JUnit, Mockito
- **Package Managers**: Maven, Gradle
- **Build Tools**: Maven, Gradle, Ant
- **Testing**: JUnit 5, Mockito, TestNG, AssertJ

## 📁 Project Structure

See [example-1](./examples/java/example-1.text)

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern Java following established conventions
- Prioritize code readability and maintainability over cleverness
- Implement clear separation of concerns and modularity
- Use consistent formatting with google-java-format
- Follow the principle of least surprise
- Embrace SOLID principles and clean architecture patterns
- Use proper encapsulation with private fields and public methods

### Modern Language Features
- Leverage Java 17+ features (sealed classes, pattern matching, text blocks)
- Use Optional for nullable returns and better null safety
- Implement streams and lambda expressions for functional programming
- Utilize record classes for immutable data carriers
- Take advantage of var keyword for local variable type inference

## 📜 Code Style and Conventions

### Naming Conventions

See [example-2](./examples/java/example-2.java)

### Function Design

See [example-3](./examples/java/example-3.java)

## 🏗️ Architecture Patterns

### Object-Oriented Design

See [example-4](./examples/java/example-4.java)

### Repository Pattern Implementation

See [example-5](./examples/java/example-5.java)

## 🔄 Concurrent Programming

### CompletableFuture Best Practices

See [example-6](./examples/java/example-6.java)

### Error Handling

See [example-7](./examples/java/example-7.java)

## 🛡️ Memory Management

### Efficient Resource Handling

See [example-8](./examples/java/example-8.java)

## ⚡ Performance Optimization

### Efficient Code Patterns

See [example-9](./examples/java/example-9.java)

## 🧪 Testing Guidelines

### Unit Testing Best Practices

See [example-10](./examples/java/example-10.java)

### Integration Testing

See [example-11](./examples/java/example-11.java)

## 🛠️ Development Environment

### Recommended Configuration

See [example-12](./examples/java/example-12.xml)

### Essential Tools
- **Formatter**: google-java-format - Consistent code formatting across projects
- **Linter**: Checkstyle, SpotBugs, PMD - Static analysis and code quality checks
- **Type Checker**: Built-in javac - Compile-time type checking and inference
- **Build Tool**: Maven/Gradle - Dependency management and build automation
- **Package Manager**: Maven Central/JCenter - Library dependency resolution

## 🔍 Code Quality Standards

### Static Analysis

See [example-13](./examples/java/example-13.java)

### Documentation Standards

See [example-14](./examples/java/example-14.java)

## 🚫 Common Pitfalls to Avoid

- **Raw Types Usage**: Always use generics for type safety and avoid raw collections
- **Field Injection**: Use constructor injection instead of @Autowired on fields for better testability
- **Exposing Entities**: Never expose JPA entities directly; always use DTOs for API responses
- **Ignoring Exceptions**: Always handle or properly propagate exceptions with meaningful messages
- **Static Utility Overuse**: Avoid static methods for business logic; prefer dependency injection
- **God Classes**: Keep classes focused on single responsibility; split large classes into smaller ones
- **Premature Optimization**: Write clear, readable code first; optimize only when performance issues are identified

## 📚 Essential Libraries

### Standard Library
See [example-15](./examples/java/example-15.java)

### Recommended Third-Party Libraries
- **Spring Framework**: Comprehensive framework for enterprise Java development
- **Hibernate/JPA**: Object-relational mapping for database persistence
- **Jackson**: JSON processing and data binding for REST APIs
- **SLF4J + Logback**: Structured logging with performance optimization
- **AssertJ**: Fluent assertions for more readable test code
- **Testcontainers**: Integration testing with real database instances

## 🚦 AI Enforcement Summary

### Code Quality Rules
- ✅ Enforce proper encapsulation with private fields and public methods
- ✅ Require @Override annotations for all inherited method implementations
- ✅ Block raw types usage and enforce proper generic type parameters
- ✅ Enforce proper equals() and hashCode() implementation for entity classes
- ✅ Require comprehensive Javadoc for all public classes and methods
- ✅ Block deprecated Date/Calendar usage in favor of java.time API
- ✅ Enforce immutability with final keyword and builder patterns
- ✅ Auto-fix common formatting violations with google-java-format

### Performance Enforcement
- 🚫 Block string concatenation in loops without StringBuilder
- 🚫 Block inefficient collection operations (e.g., repeated List.contains())
- ✅ Promote stream operations for data processing and filtering
- ✅ Promote proper resource management with try-with-resources

### Security Enforcement
- 🔒 Enforce input validation with Bean Validation annotations
- 🔒 Block exposure of sensitive data in logs and API responses
- 🔒 Require proper password encoding and secure authentication

## 📖 References

- [Oracle Java Documentation](https://docs.oracle.com/en/java/)
- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- [Spring Framework Documentation](https://spring.io/guides)
- [JUnit 5 User Guide](https://junit.org/junit5/docs/current/user-guide/)
- [Java Performance: The Definitive Guide](https://www.oreilly.com/library/view/java-performance-the/9781449363512/)

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
