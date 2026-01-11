---
name: 'Rust.Instructions'
description: 'Development guidelines and best practices for Rust.Instructions'
keywords: [api, coding, async, gui, architecture, hints), cli, (with, guide, framework]
---



# Rust Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for Rust development. These include AI linting hints to automatically enforce style rules and maintain clean, performant, and memory-safe Rust code.

⸻

📂 Project Architecture

✅ Rule: Enforce memory-safe architecture

- Leverage Rust's ownership system for automatic memory management
- Use borrowing and lifetimes to avoid data races and memory leaks
- Implement zero-cost abstractions for performance-critical code
- Design APIs that make incorrect usage difficult or impossible

✅ Rule: Strict separation of concerns

- Rust → Systems programming, performance-critical business logic
- Configuration → TOML files for Cargo.toml and app config
- Documentation → Rustdoc comments and external markdown files
- Testing → Unit tests, integration tests, and documentation tests

✅ Rule: Crate Organization

- Organize code into logical modules with `mod.rs` or `module.rs` files
- Use `pub` visibility modifiers appropriately for API boundaries
- Implement proper trait definitions for shared behavior
- Use workspace structure for multi-crate projects

✅ Rule: Dependency Management

- Use `Cargo.toml` for all dependency specification
- Prefer well-maintained crates from crates.io
- Pin versions for production builds
- Use feature flags to minimize binary size and compile time

✅ Rule: Variable Functions & Traits

- Use trait objects and generics instead of large match statements
- Implement consistent patterns for extensibility and type safety

⸻

📜 Standard Libraries & Frameworks

✅ Rule: Prefer standard library when possible

- Use `std::collections` for data structures (Vec, HashMap, BTreeMap)
- Use `std::fs` and `std::path` for file operations
- Use `std::thread` and `std::sync` for concurrency
- Use `std::error` for error handling

✅ Rule: Approved external crates

- **Async Runtime**: `tokio`, `async-std` for asynchronous programming
- **Serialization**: `serde` with `serde_json`, `toml`, `bincode`
- **HTTP**: `reqwest` for clients, `hyper`, `axum`, `actix-web` for servers
- **CLI**: `clap` for command-line parsing, `env_logger` for logging
- **Testing**: `criterion` for benchmarking, `proptest` for property testing
- **Utility**: `anyhow` for error handling, `thiserror` for custom errors

✅ Rule: Build and Development Tools

- Use `cargo fmt` for consistent code formatting
- Use `cargo clippy` for lint checking and code improvement
- Use `cargo test` for running all test types
- Use `cargo doc` for generating documentation

⸻

🖋 Rust Coding Standards

✅ Ownership and Borrowing

- Prefer borrowing over owned values when possible
- Use `&str` instead of `String` for function parameters when read-only
- Return owned values when transferring ownership is intended
- Use `Cow<str>` for APIs that may or may not need to allocate

✅ Example:

See [example-1](./examples/rust/example-1.rust)

⸻

✅ Error Handling

- Use `Result<T, E>` for fallible operations
- Implement custom error types with `thiserror` for complex applications
- Use `?` operator for error propagation
- Provide meaningful error messages with context

✅ Example:

See [example-2](./examples/rust/example-2.rust)

⸻

✅ Loops & Memory (Rust)

- Use iterators instead of index-based loops for better performance and safety
- 🚫 Avoid string concatenation inside loops:
  - Do not use `+=` with `String` in loops
  - Do not use `Vec::push` with `String` for simple concatenation

❌ Bad:

See [example-3](./examples/rust/example-3.rust)

✅ Good:

See [example-4](./examples/rust/example-4.rust)

⸻

✅ Variable Functions & Traits (Rust)

- Use trait objects and generics instead of large match statements
- Implement message-passing patterns with enums and traits
- Enable extensible architectures through trait composition

✅ Example:

See [example-5](./examples/rust/example-5.rust)

✅ Variable Structs & Traits (Rust)

- Implement consistent interfaces using traits
- Use builder patterns for complex initialization
- Enable dynamic behavior through trait objects

✅ Example:

See [example-6](./examples/rust/example-6.rust)

⸻

✅ Concurrency and Async Programming

- Use `async`/`await` for I/O-bound operations
- Use `tokio` or `async-std` for async runtime
- Implement proper error handling in async contexts
- Use channels for communication between tasks

✅ Example:

See [example-7](./examples/rust/example-7.rust)

⸻

🧠 Performance & Safety

- Use `cargo clippy` to catch common performance issues
- Profile with `cargo flamegraph` or similar tools
- Use `#[inline]` judiciously for hot code paths
- Prefer zero-cost abstractions and compile-time optimization

✅ Example:

See [example-8](./examples/rust/example-8.rust)

⸻

🧪 Testing Standards

✅ Comprehensive Testing

- Write unit tests for all public functions and methods
- Use integration tests for testing module interactions
- Include documentation tests in rustdoc comments
- Use property-based testing for complex algorithms

✅ Example:

See [example-9](./examples/rust/example-9.rust)
/// use myapp::ProcessData;
/// 
/// let input = ProcessData {
///     value: 21,
///     metadata: "test".to_string(),
/// };
/// 
/// let result = myapp::process_data(input).unwrap();
/// assert_eq!(result.value, 42);
/// assert_eq!(result.metadata, "test_processed");
/// See [example-10](./examples/rust/example-10.txt)

⸻

⚡ Performance Rules

✅ Rust-Specific Optimization

- 🚫 Avoid string concatenation in loops using `+=`
- 🚫 Avoid unnecessary Vec building for simple string operations
- ✅ Use iterators and `collect()` for data transformation
- ✅ Use `&str` instead of `String` for function parameters when possible
- ✅ Leverage zero-cost abstractions and compile-time optimization
- ✅ Profile with cargo flamegraph before optimizing

⸻

✍️ Commit Message Conventions

- Prefix commits with: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `perf:`, `test:`
- Example: `feat: add async data processing with tokio runtime`

⸻

🚦 AI Enforcement Summary

✅ Enforce memory safety through ownership and borrowing
✅ Block string concatenation in loops (`+=`)
✅ Block Vec building for simple string concatenation
✅ Require proper error handling with Result types
✅ Enforce trait-based dispatch over large match statements
✅ Require comprehensive documentation with rustdoc
✅ Prefer iterators over index-based loops
✅ Enforce consistent trait implementations across types
✅ Require async/await for I/O-bound operations
✅ Use cargo clippy for automated lint checking
✅ Auto-fix cargo fmt formatting violations where possible

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
