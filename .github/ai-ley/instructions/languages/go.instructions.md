---
name: 'Go.Instructions'
description: 'Comprehensive Go development guidelines emphasizing idiomatic Go code, performance, and maintainability for AI coding assistants.'
keywords: [api, context, concurrency, common, async, configuration, avoid, cli, channels, conventions]
---



# Go Programming Instructions

Comprehensive Go development guidelines emphasizing idiomatic Go code, performance, and maintainability for AI coding assistants.

## 🧠 Context

- **Language**: Go (1.19+)
- **Common Frameworks**: Gin, Echo, Gorilla/Mux, Cobra (CLI)
- **Standard Libraries**: net/http, database/sql, encoding/json, context
- **Testing**: testing package, testify, GoMock
- **Build Tools**: go mod, go build, Makefile
- **Deployment**: Docker, Kubernetes, serverless

## 📁 Project Structure

See [example-1](./examples/go/example-1.text)

## 🔧 General Guidelines

### Core Principles
- Follow idiomatic Go conventions from Effective Go
- Write simple, readable, and maintainable code
- Use composition over inheritance
- Handle errors explicitly and gracefully
- Leverage Go's concurrency primitives appropriately
- Keep interfaces small and focused

### Go Idioms
- Use short variable names in limited scopes
- Return errors as the last return value
- Use named return parameters sparingly
- Prefer synchronous APIs, use async when beneficial
- Use channels for communication, mutexes for synchronization

## 📜 Code Style and Conventions

### Naming Conventions

See [example-2](./examples/go/example-2.go)

### Error Handling

See [example-3](./examples/go/example-3.go)

## 🏗️ Struct and Interface Design

### Struct Best Practices

See [example-4](./examples/go/example-4.go)

### Interface Design

See [example-5](./examples/go/example-5.go)

## ⚡ Concurrency Patterns

### Goroutines and Channels

See [example-6](./examples/go/example-6.go)

## 🔒 Memory Management and Performance

### Efficient Memory Usage

See [example-7](./examples/go/example-7.go)

## 🧪 Testing Guidelines

### Unit Testing Best Practices

See [example-8](./examples/go/example-8.go)

### HTTP Handler Testing

See [example-9](./examples/go/example-9.go)

## 🔧 Configuration and Deployment

### Configuration Management

See [example-10](./examples/go/example-10.go)

## 🛠️ Development Tools

### Recommended Tooling

See [example-11](./examples/go/example-11.makefile)

### golangci-lint Configuration

See [example-12](./examples/go/example-12.yaml)

## 🚫 Common Pitfalls to Avoid

- **Goroutine leaks**: Always ensure goroutines can exit
- **Channel deadlocks**: Be careful with unbuffered channels
- **Race conditions**: Use proper synchronization
- **Memory leaks**: Close files, connections, and channels
- **Ignoring errors**: Always handle or explicitly ignore errors
- **Premature optimization**: Profile before optimizing
- **Global state**: Minimize package-level variables

## 📚 Resources

- [Effective Go](https://go.dev/doc/effective_go)
- [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
- [Go Memory Model](https://go.dev/ref/mem)
- [Go Concurrency Patterns](https://blog.golang.org/pipelines)
- [Standard Library Documentation](https://pkg.go.dev/std)
- [Go Testing Package](https://pkg.go.dev/testing)

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
