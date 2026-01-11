---
name: 'Python.Instructions'
description: 'Modern Python development guidelines for AI coding assistants, emphasizing Python 3.9+ features, best practices, and maintainable code patterns.'
keywords: [api, asynchronous, assurance, classes, common, async, async/await, architecture, assistant, avoid]
---



# Python Programming Instructions

Modern Python development guidelines for AI coding assistants, emphasizing Python 3.9+ features, best practices, and maintainable code patterns.

## 🧠 Context

- **Language**: Python (3.9+)
- **Environments**: CPython, PyPy, Virtual environments
- **Common Frameworks**: FastAPI, Django, Flask, Pydantic, SQLAlchemy
- **Package Managers**: pip, poetry, pipenv
- **Build Tools**: setuptools, wheel, build, hatch
- **Testing**: pytest, unittest, hypothesis, coverage
- **Type Checking**: mypy, pyright, pylance

## 📁 Project Structure

See [example-1](./examples/python/example-1.text)

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, Pythonic code following PEP 8
- Use type hints for better code documentation and IDE support
- Prefer composition over inheritance
- Follow the principle of least surprise
- Implement proper error handling and logging
- Use context managers for resource management
- Favor explicit over implicit

### Modern Python Features
- Use type hints with `typing` module and `from __future__ import annotations`
- Leverage dataclasses and Pydantic models for data structures
- Use async/await for I/O-bound operations
- Utilize pathlib for file system operations
- Use f-strings for string formatting
- Employ match statements (Python 3.10+) when appropriate

## 📜 Code Style and Conventions

### Variable and Function Naming

See [example-2](./examples/python/example-2.python)

### Function Design with Type Hints

See [example-3](./examples/python/example-3.python)

## 🔄 Asynchronous Programming

### Async/Await Best Practices

See [example-4](./examples/python/example-4.python)

## 🛡️ Error Handling and Logging

### Custom Exception Classes

See [example-5](./examples/python/example-5.python)

## 🏗️ Object-Oriented Programming

### Classes with Modern Python Features

See [example-6](./examples/python/example-6.python)

## 🔧 Functional Programming Patterns

### Higher-Order Functions and Utilities

See [example-7](./examples/python/example-7.python)

## 🎯 Performance Optimization

### Efficient Code Patterns

See [example-8](./examples/python/example-8.python)

## 🧪 Testing Guidelines

### Comprehensive Testing with pytest

See [example-9](./examples/python/example-9.python)

## 📦 Package Management and Project Structure

### Modern Dependency Management

See [example-10](./examples/python/example-10.python)

## 🛠️ Development Tools and Configuration

### Code Quality Tools

See [example-11](./examples/python/example-11.python)

## 🚫 Common Pitfalls to Avoid

### Anti-Patterns and Best Practices

See [example-12](./examples/python/example-12.python)

## 📚 Essential Libraries and Tools

### Recommended Python Ecosystem

See [example-13](./examples/python/example-13.python)

## 🎯 Performance Guidelines

### Memory and Execution Optimization

- **Avoid string concatenation in loops**: Use `''.join()` for combining multiple strings
- **Use generators for large datasets**: Memory-efficient iteration over large collections
- **Cache expensive computations**: Use `@lru_cache` or custom caching strategies
- **Prefer list comprehensions**: More efficient than equivalent for loops for simple operations
- **Use `__slots__`**: For classes with many instances to reduce memory usage
- **Profile before optimizing**: Use `cProfile`, `line_profiler`, or `memory_profiler`
- **Async for I/O operations**: Use async/await for network and file I/O
- **Connection pooling**: Reuse database and HTTP connections

## 📊 Testing and Quality Assurance

### Testing Strategy

1. **Unit Tests**: Test individual functions and methods in isolation
2. **Integration Tests**: Test component interactions and external dependencies
3. **Property-Based Testing**: Use Hypothesis for generating test cases
4. **Performance Tests**: Benchmark critical code paths
5. **Coverage**: Aim for 80%+ test coverage on core business logic
6. **Mutation Testing**: Use tools like `mutmut` to test your tests

### Code Quality Metrics

- **Cyclomatic Complexity**: Keep functions simple (complexity < 10)
- **Line Length**: Maximum 88 characters (Black standard)
- **Function Length**: Keep functions focused and under 20-30 lines
- **Module Length**: Split large modules into smaller, focused ones
- **Documentation**: Document all public APIs with comprehensive docstrings

## 📚 Resources and References

- [Python Enhancement Proposals (PEPs)](https://peps.python.org/)
- [Python Developer's Guide](https://devguide.python.org/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Pydantic Documentation](https://docs.pydantic.dev/)
- [pytest Documentation](https://docs.pytest.org/)
- [mypy Documentation](https://mypy.readthedocs.io/)
- [Structlog Documentation](https://structlog.org/)
- [Python Patterns](https://python-patterns.guide/)
- [Effective Python by Brett Slatkin](https://effectivepython.com/)
- [Architecture Patterns with Python](https://www.cosmicpython.com/)

## AI Assistant Guidelines
When helping with Python:

1. **Always use modern Python features and type hints (3.9+)**
2. **Prioritize code readability and maintainability over performance optimizations**
3. **Include proper error handling with specific exception types**
4. **Suggest appropriate design patterns for the problem domain**
5. **Include comprehensive testing examples with pytest**
6. **Recommend async/await for I/O-bound operations**
7. **Provide configuration and environment management guidance**
8. **Include logging and monitoring best practices**

### Code Generation Rules
- Generate code with comprehensive type hints using modern syntax
- Include proper error handling with logging and structured exceptions
- Use dataclasses or Pydantic models for data structures
- Implement proper resource management with context managers
- Include docstrings for all public functions and classes
- Follow PEP 8 and use Black formatting standards
- Provide both synchronous and asynchronous examples where applicable
- Include unit test examples for generated functions and classes
- Use modern Python idioms (f-strings, pathlib, dataclasses, etc.)
- Consider security implications (input validation, SQL injection prevention)

### Performance Enforcement
- ✅ Promote list comprehensions over for loops for simple operations
- ✅ Suggest generators for memory-efficient iteration
- ✅ Recommend `@lru_cache` for expensive computations
- 🚫 Block string concatenation in loops without suggesting `join()`
- 🚫 Block bare `except:` clauses without specific exception handling
- ✅ Promote async/await for I/O operations
- ✅ Suggest connection pooling for database and HTTP operations

### Security Enforcement
- 🔒 Enforce parameterized queries for database operations
- 🔒 Block direct string formatting in SQL queries
- 🔒 Require input validation for user data
- 🔒 Promote secure random generation with `secrets` module
- 🔒 Suggest environment variables for sensitive configuration

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
