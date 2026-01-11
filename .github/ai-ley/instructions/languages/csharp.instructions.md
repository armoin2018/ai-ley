---
name: 'Csharp.Instructions'
description: 'See [example-1](./examples/csharp/example-1.'
keywords: [api, async, architecture, authentication, backend, database, cli, azure, csharp.instructions, framework]
---



C# Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for C# projects. These include AI linting hints to automatically enforce style rules and maintain clean, performant, and maintainable code across multiple project types.

⸻

📂 Project Architecture

✅ Rule: Enforce API-first architecture

- Backend (C#) should provide API logic and return JSON/structured data. Separate business logic from presentation.
- Frontend should consume API data and render UI. Avoid embedding business logic in views.
- Use dependency injection for loose coupling and testability.

✅ Rule: Strict separation of concerns

- Controllers → API endpoints and request/response handling
- Services → Business logic and domain operations  
- Models → Data structures and domain entities
- Views → UI presentation (MVC/Razor) or client-side rendering
- Data Access → Repository pattern or Entity Framework

✅ Rule: Namespaces and Organization

- Organize code into logical namespaces (e.g., `ProjectName.Api`, `ProjectName.Services`, `ProjectName.Models`).
- Use consistent folder structure matching namespace hierarchy.
- Follow .NET naming conventions (PascalCase for public members, camelCase for private fields).

✅ Rule: Dependency Injection

- Register services in Program.cs or Startup.cs for .NET Core/.NET 5+.
- Use interfaces for service contracts to enable testing and flexibility.
- Prefer constructor injection over service locator pattern.

✅ Rule: Configuration Management

- Use IConfiguration for application settings.
- Store sensitive data in user secrets (development) or Azure Key Vault (production).
- Use strongly-typed configuration classes with IOptions<T>.


⸻

📦 Package Management

✅ Rule: Use approved NuGet packages

**Core Packages:**
- Microsoft.AspNetCore.* for web APIs
- Entity Framework Core for data access
- AutoMapper for object mapping
- FluentValidation for input validation
- Serilog for structured logging
- xUnit for unit testing
- Moq for mocking in tests

**Frontend (if applicable):**
- SignalR for real-time communication
- Swagger/OpenAPI for API documentation

✅ Rule: Package Versioning

- Keep packages up to date but test thoroughly before major version upgrades.
- Use package lock files (packages.lock.json) for reproducible builds.


⸻

🖋 C# Coding Standards

✅ String Handling

- Use string interpolation (`$""`) for simple variable embedding.
- Use StringBuilder for multiple concatenations or loop-based string building.
- Use verbatim strings (`@""`) for file paths and multi-line strings.
- Define constants for repeated string values.

✅ Example:

See [example-1](./examples/csharp/example-1.csharp)

⸻

✅ Async/Await Patterns

- Use async/await for I/O operations (database, HTTP calls, file operations).
- Always return Task or Task<T> from async methods.
- Use ConfigureAwait(false) in library code to avoid deadlocks.
- Never use .Result or .Wait() - use await instead.

✅ Example:

See [example-2](./examples/csharp/example-2.csharp)

⸻

✅ Loops & Memory (C#)

- Use LINQ methods (Select, Where, etc.) instead of manual loops when appropriate.
- 🚫 Avoid string concatenation inside loops using += operator.
- 🚫 Avoid repeatedly calling List.Add() for large collections - use List constructor with capacity or AddRange.
- ✅ Use StringBuilder, string.Join(), or LINQ for string operations.

❌ Bad:

See [example-3](./examples/csharp/example-3.csharp)

❌ Also Bad:

See [example-4](./examples/csharp/example-4.csharp)

✅ Good:

See [example-5](./examples/csharp/example-5.csharp)

⸻

✅ Pattern Matching & Polymorphism (C#)

- Use pattern matching instead of lengthy switch statements when appropriate.
- Follow Strategy pattern: use interfaces and dependency injection instead of switch/case.
- Implement consistent message processing patterns for flexibility.

✅ Example:

See [example-6](./examples/csharp/example-6.csharp)

✅ Base Classes & Interfaces (C#)

- Implement consistent interfaces: IDisposable for cleanup, standard CRUD operations.
- Use abstract base classes for shared functionality.
- Follow Repository and Unit of Work patterns for data access.

✅ Example:

See [example-7](./examples/csharp/example-7.csharp)

⸻

✅ Error Handling & Logging

- Use structured logging with Serilog or Microsoft.Extensions.Logging.
- Implement proper exception handling with specific exception types.
- Use Result pattern or custom response types instead of throwing exceptions for business logic failures.
- Always log at appropriate levels (Debug, Information, Warning, Error, Critical).

✅ Example:

See [example-8](./examples/csharp/example-8.csharp)

⸻

🧠 Performance

- Use async/await for I/O operations to improve scalability.
- Minimize database round trips with eager loading or projection.
- Use caching (IMemoryCache, IDistributedCache) for frequently accessed data.
- Implement pagination for large data sets.
- Use value types (structs) for small, immutable data.

✅ Example:

See [example-9](./examples/csharp/example-9.csharp)

⸻

✅ Testing Standards

- Use xUnit for unit tests with descriptive test method names.
- Follow AAA pattern: Arrange, Act, Assert.
- Use Moq for mocking dependencies.
- Aim for high code coverage but focus on critical business logic.
- Use integration tests for API endpoints.

✅ Example:

See [example-10](./examples/csharp/example-10.csharp)

⸻

⚡ Performance Rules

✅ Unified String Building Rules

- 🚫 Avoid string concatenation inside loops using += operator.
- 🚫 Avoid repeated List.Add() operations for large collections without capacity planning.
- ✅ Use StringBuilder, string.Join(), or LINQ methods for string operations.
- ✅ Use List<T> constructor with capacity for known collection sizes.

⸻

✍️ Commit Message Conventions

- Prefix commits with: `style:`, `perf:`, `refactor:`, `fix:`, `feat:`, `test:`, or `docs:`
- Example: `feat: add user authentication service`
- Example: `perf: optimize database queries for user lookup`

⸻

🚦 AI Enforcement Summary

✅ Enforce API-first architecture with proper separation of concerns
✅ Enforce async/await patterns for I/O operations  
✅ Block string concatenation in loops and inefficient collection operations
✅ Enforce dependency injection and interface-based design
✅ Enforce proper error handling and structured logging
✅ Prefer pattern matching and strategy pattern over switch statements
✅ Enforce consistent naming conventions and code organization
✅ Enforce proper testing patterns with AAA structure
✅ Auto-fix violations where possible

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
