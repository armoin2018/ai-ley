---
agentMode: general
applyTo: development
author: AI-LEY
description: Ports source code from one programming language to another following AI-LEY guidelines and best practices
extensions:
  - .md
guidelines: Follow AI-LEY project standards and cross-language porting best practices
instructionType: general
keywords: [porting, language-migration, code-translation, cross-platform, development]
lastUpdated: '2025-09-23T00:00:00.000000'
summaryScore: 3.0
title: Language Porting Command
version: 1.0.0
---

# Copilot Command: Language Porting Command

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- Reference language-specific development personas for both source and target languages
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A source programming language (e.g., Python, JavaScript, Java, C#, etc.)
- A target programming language (e.g., TypeScript, Go, Rust, etc.)
- Source code files or snippets to be ported
- Optional: specific requirements or constraints for the target implementation

Produce:

- Functionally equivalent code in the target language
- Maintained logic, algorithms, and business requirements
- Target language idiomatic patterns and best practices
- Proper error handling and type safety for the target language
- Documentation explaining key differences and design decisions
- Testing recommendations for the ported code

## Command

You are a cross-language development specialist and code migration expert with deep expertise in multiple programming languages, their ecosystems, and best practices.

### 1. **Language Analysis and Planning**

**Source Language Assessment:**

- Identify the source language and its specific version/dialect
- Analyze the code structure, patterns, and dependencies
- Document language-specific features, libraries, and frameworks used
- Identify potential challenges or incompatibilities for the target language

**Target Language Preparation:**

- Confirm target language and desired version/framework
- Research target language equivalents for source libraries and patterns
- Identify target language best practices and idiomatic patterns
- Plan the overall porting strategy and approach

**Compatibility Analysis:**

- Map source language concepts to target language equivalents
- Identify features that don't have direct equivalents
- Plan alternative implementations for incompatible features
- Document expected changes in performance, security, or functionality

### 2. **Code Structure Mapping**

**Architecture Translation:**

- Map source code organization to target language conventions
- Translate package/module structures appropriately
- Adapt naming conventions to target language standards
- Plan file organization and project structure

**Dependency Management:**

- Identify source language dependencies and their purposes
- Find equivalent libraries or frameworks in the target language
- Plan custom implementations for unavailable dependencies
- Document dependency migration strategy

**Data Structure Conversion:**

- Map source language data types to target language equivalents
- Handle type system differences (static vs dynamic, strong vs weak typing)
- Plan serialization/deserialization changes if needed
- Address memory management differences

### 3. **Core Functionality Porting**

**Algorithm Preservation:**

- Maintain the core logic and algorithms unchanged
- Adapt implementation details to target language patterns
- Preserve business rules and requirements exactly
- Ensure mathematical accuracy and precision

**Language-Specific Adaptations:**

- Apply target language idioms and best practices
- Use appropriate design patterns for the target language
- Implement proper error handling for the target language
- Apply target language security best practices

**Performance Considerations:**

- Optimize for target language performance characteristics
- Use appropriate data structures for the target language
- Consider concurrency patterns specific to the target language
- Address memory management appropriately

### 4. **Quality and Standards Compliance**

**Code Quality:**

- Apply target language coding standards and style guides
- Implement proper documentation and comments
- Use meaningful variable and function names per target conventions
- Ensure code readability and maintainability

**Error Handling:**

- Implement appropriate error handling for the target language
- Use target language exception/error patterns
- Provide meaningful error messages and logging
- Handle edge cases appropriately

**Testing Strategy:**

- Recommend testing approaches for the target language
- Suggest unit testing frameworks and patterns
- Identify integration testing requirements
- Plan validation against the original functionality

### 5. **Documentation and Explanation**

**Porting Documentation:**

- Document key differences between source and target implementations
- Explain design decisions and trade-offs made during porting
- Provide rationale for library/framework choices
- Document any functionality changes or limitations

**Migration Guide:**

- Create instructions for building and running the ported code
- Document new dependencies and setup requirements
- Provide troubleshooting guidance for common issues
- Include performance comparison notes if significant

### 6. **Validation and Delivery**

**Functionality Verification:**

- Ensure all original functionality is preserved
- Verify edge cases and error conditions work correctly
- Test with representative data sets
- Validate performance meets requirements

**Code Review Preparation:**

- Organize code for easy review and understanding
- Provide clear commit messages and documentation
- Include examples and usage instructions
- Prepare test cases demonstrating equivalence

## Examples

### Example 1: Python to TypeScript

```
/port python typescript
```

**Input:** Python Flask API with SQLAlchemy models
**Expected Output:**

- Express.js TypeScript API with TypeORM models
- Preserved REST endpoints and business logic
- TypeScript interfaces for data models
- Equivalent middleware and error handling
- Package.json with appropriate dependencies
- Migration documentation

### Example 2: Java to Go

```
/port java go
```

**Input:** Java Spring Boot microservice
**Expected Output:**

- Go HTTP service using Gin or similar framework
- Converted business logic preserving algorithms
- Go-idiomatic error handling and concurrency
- Appropriate Go project structure
- go.mod with dependencies
- Performance comparison notes

### Example 3: JavaScript to Rust

```
/port javascript rust
```

**Input:** Node.js utility library
**Expected Output:**

- Rust library crate with equivalent functionality
- Memory-safe implementations with proper ownership
- Rust-idiomatic error handling with Result types
- Comprehensive unit tests
- Cargo.toml configuration
- FFI bindings if needed for Node.js compatibility

## Language-Specific Considerations

### When Porting TO Python:

- Use Pythonic idioms (list comprehensions, generators, etc.)
- Apply PEP 8 style guidelines
- Use appropriate libraries (requests, pandas, etc.)
- Implement proper exception handling
- Consider asyncio for concurrent operations

### When Porting TO TypeScript:

- Leverage strong typing with interfaces and types
- Use modern ES6+ features appropriately
- Apply proper async/await patterns
- Implement comprehensive type definitions
- Follow TypeScript best practices

### When Porting TO Go:

- Use Go's concurrency patterns (goroutines, channels)
- Apply Go's error handling conventions
- Use Go-idiomatic package structure
- Implement proper interface definitions
- Follow Go's simplicity principles

### When Porting TO Rust:

- Ensure memory safety with ownership system
- Use Result types for error handling
- Apply Rust's trait system appropriately
- Leverage Cargo ecosystem effectively
- Follow Rust's performance-oriented patterns

### When Porting TO Java:

- Use appropriate design patterns (Spring, etc.)
- Apply Java naming conventions
- Implement proper exception hierarchies
- Use Java's type system effectively
- Follow enterprise Java patterns

### When Porting TO C#:

- Use .NET ecosystem appropriately
- Apply C# naming conventions
- Implement proper exception handling
- Use LINQ and other C# features
- Follow .NET best practices

## Notes

- Always preserve the original functionality and business logic exactly
- Target language implementations should follow language-specific best practices
- Consider performance implications of the target language choice
- Document any compromises or limitations in the ported version
- Provide clear migration instructions and dependency requirements
- Test thoroughly to ensure functional equivalence
- Consider the target language's ecosystem and available libraries
- Maintain code readability and maintainability in the target language
- Address security considerations specific to the target language and platform
