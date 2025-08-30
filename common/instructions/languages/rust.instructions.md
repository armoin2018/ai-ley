---
applyTo: "**/*.rs"
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

```rust
// Good: Borrowing for read-only operations
fn process_text(text: &str) -> String {
    text.to_uppercase()
}

// Good: Owned values for data transformation
fn parse_config(content: String) -> Result<Config, ConfigError> {
    // Process and return owned config
    Ok(Config::from_string(content)?)
}

// Good: Using Cow for flexible APIs
use std::borrow::Cow;

fn normalize_path(path: Cow<str>) -> Cow<str> {
    if path.contains('\\') {
        Cow::Owned(path.replace('\\', "/"))
    } else {
        path
    }
}
```

⸻

✅ Error Handling

- Use `Result<T, E>` for fallible operations
- Implement custom error types with `thiserror` for complex applications
- Use `?` operator for error propagation
- Provide meaningful error messages with context

✅ Example:

```rust
use thiserror::Error;

#[derive(Error, Debug)]
pub enum ProcessingError {
    #[error("Invalid input format: {message}")]
    InvalidFormat { message: String },
    
    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),
    
    #[error("Parse error at line {line}: {message}")]
    Parse { line: usize, message: String },
}

fn process_file(path: &std::path::Path) -> Result<ProcessedData, ProcessingError> {
    let content = std::fs::read_to_string(path)?;
    
    if content.is_empty() {
        return Err(ProcessingError::InvalidFormat {
            message: "File is empty".to_string(),
        });
    }
    
    parse_content(&content)
}
```

⸻

✅ Loops & Memory (Rust)

- Use iterators instead of index-based loops for better performance and safety
- 🚫 Avoid string concatenation inside loops:
  - Do not use `+=` with `String` in loops
  - Do not use `Vec::push` with `String` for simple concatenation

❌ Bad:

```rust
let mut result = String::new();
for line in lines {
    result += &line; // prohibited in loops
}

// Also bad - vector building for simple string concatenation
let mut parts = Vec::new();
for line in lines {
    parts.push(line); // prohibited for simple string building
}
let result = parts.join("");
```

✅ Good:

```rust
let result = lines.join("");

// For more complex operations
let result: String = lines
    .iter()
    .map(|line| line.trim())
    .collect::<Vec<_>>()
    .join("\n");

// Or using itertools
use itertools::Itertools;
let result = lines.iter().join("\n");
```

⸻

✅ Variable Functions & Traits (Rust)

- Use trait objects and generics instead of large match statements
- Implement message-passing patterns with enums and traits
- Enable extensible architectures through trait composition

✅ Example:

```rust
// Bad: Large match statement
fn process_action(action: &str, data: ProcessData) -> Result<ProcessData, ProcessError> {
    match action {
        "validate" => validate_data(data),
        "transform" => transform_data(data),
        "save" => save_data(data),
        _ => Err(ProcessError::UnknownAction(action.to_string())),
    }
}

// Good: Trait-based dispatch
trait MessageHandler {
    fn handle(&self, msg: Message) -> Result<Message, ProcessError>;
}

struct ValidateHandler;
impl MessageHandler for ValidateHandler {
    fn handle(&self, mut msg: Message) -> Result<Message, ProcessError> {
        msg.payload = validate_data(msg.payload)?;
        Ok(msg)
    }
}

struct ProcessorRegistry {
    handlers: std::collections::HashMap<String, Box<dyn MessageHandler>>,
}

impl ProcessorRegistry {
    fn new() -> Self {
        let mut handlers: std::collections::HashMap<String, Box<dyn MessageHandler>> = 
            std::collections::HashMap::new();
        
        handlers.insert("validate".to_string(), Box::new(ValidateHandler));
        // Add other handlers...
        
        Self { handlers }
    }
    
    fn process_message(&self, action: &str, msg: Message) -> Result<Message, ProcessError> {
        self.handlers
            .get(action)
            .ok_or_else(|| ProcessError::UnknownAction(action.to_string()))?
            .handle(msg)
    }
}
```

✅ Variable Structs & Traits (Rust)

- Implement consistent interfaces using traits
- Use builder patterns for complex initialization
- Enable dynamic behavior through trait objects

✅ Example:

```rust
trait Processor {
    type Config;
    type Error;
    
    fn new(config: Self::Config) -> Result<Self, Self::Error>
    where
        Self: Sized;
    
    fn process(&mut self, msg: Message) -> Result<Message, Self::Error>;
}

// Consistent implementation across different processors
struct DataValidator {
    rules: Vec<ValidationRule>,
}

impl Processor for DataValidator {
    type Config = ValidationConfig;
    type Error = ValidationError;
    
    fn new(config: Self::Config) -> Result<Self, Self::Error> {
        Ok(Self {
            rules: config.into_rules()?,
        })
    }
    
    fn process(&mut self, mut msg: Message) -> Result<Message, Self::Error> {
        for rule in &self.rules {
            msg.payload = rule.apply(msg.payload)?;
        }
        Ok(msg)
    }
}

// Dynamic processor creation
fn create_processor(
    processor_type: &str,
    config: ProcessorConfig,
) -> Result<Box<dyn Processor<Error = ProcessError>>, ProcessError> {
    match processor_type {
        "validator" => Ok(Box::new(DataValidator::new(config.validation)?)),
        "transformer" => Ok(Box::new(DataTransformer::new(config.transformation)?)),
        _ => Err(ProcessError::UnknownProcessor(processor_type.to_string())),
    }
}
```

⸻

✅ Concurrency and Async Programming

- Use `async`/`await` for I/O-bound operations
- Use `tokio` or `async-std` for async runtime
- Implement proper error handling in async contexts
- Use channels for communication between tasks

✅ Example:

```rust
use tokio::{sync::mpsc, time::Duration};
use anyhow::Result;

#[derive(Debug)]
struct Task {
    id: u64,
    data: String,
}

async fn process_tasks(mut receiver: mpsc::Receiver<Task>) -> Result<()> {
    while let Some(task) = receiver.recv().await {
        // Process task asynchronously
        let result = process_single_task(task).await?;
        
        // Handle result
        println!("Processed task with result: {:?}", result);
    }
    
    Ok(())
}

async fn process_single_task(task: Task) -> Result<ProcessResult> {
    // Simulate async work
    tokio::time::sleep(Duration::from_millis(100)).await;
    
    // Process the task
    Ok(ProcessResult {
        task_id: task.id,
        output: task.data.to_uppercase(),
    })
}

#[tokio::main]
async fn main() -> Result<()> {
    let (sender, receiver) = mpsc::channel(32);
    
    // Spawn task processor
    let processor_handle = tokio::spawn(process_tasks(receiver));
    
    // Send some tasks
    for i in 0..10 {
        sender.send(Task {
            id: i,
            data: format!("task_{}", i),
        }).await?;
    }
    
    // Close sender and wait for processing to complete
    drop(sender);
    processor_handle.await??;
    
    Ok(())
}
```

⸻

🧠 Performance & Safety

- Use `cargo clippy` to catch common performance issues
- Profile with `cargo flamegraph` or similar tools
- Use `#[inline]` judiciously for hot code paths
- Prefer zero-cost abstractions and compile-time optimization

✅ Example:

```rust
use std::hint::black_box;

// Efficient data processing with iterators
fn process_large_dataset(data: &[DataItem]) -> Vec<ProcessedItem> {
    data.par_iter() // Use rayon for parallel processing
        .filter(|item| item.is_valid())
        .map(|item| item.process())
        .collect()
}

// Benchmark critical functions
#[cfg(test)]
mod benches {
    use super::*;
    use criterion::{criterion_group, criterion_main, Criterion};
    
    fn benchmark_process_dataset(c: &mut Criterion) {
        let data: Vec<DataItem> = (0..1000)
            .map(|i| DataItem::new(i))
            .collect();
        
        c.bench_function("process_dataset", |b| {
            b.iter(|| black_box(process_large_dataset(black_box(&data))))
        });
    }
    
    criterion_group!(benches, benchmark_process_dataset);
    criterion_main!(benches);
}
```

⸻

🧪 Testing Standards

✅ Comprehensive Testing

- Write unit tests for all public functions and methods
- Use integration tests for testing module interactions
- Include documentation tests in rustdoc comments
- Use property-based testing for complex algorithms

✅ Example:

```rust
#[cfg(test)]
mod tests {
    use super::*;
    use proptest::prelude::*;
    
    #[test]
    fn test_process_valid_data() {
        let input = ProcessData {
            value: 42,
            metadata: "test".to_string(),
        };
        
        let result = process_data(input).unwrap();
        assert_eq!(result.value, 84); // 42 * 2
        assert_eq!(result.metadata, "test_processed");
    }
    
    #[test]
    fn test_process_invalid_data_returns_error() {
        let input = ProcessData {
            value: -1, // Invalid value
            metadata: "test".to_string(),
        };
        
        let result = process_data(input);
        assert!(result.is_err());
        
        match result.unwrap_err() {
            ProcessError::InvalidValue { value } => assert_eq!(value, -1),
            _ => panic!("Expected InvalidValue error"),
        }
    }
    
    // Property-based test
    proptest! {
        #[test]
        fn test_process_data_never_panics(
            value in any::<i32>(),
            metadata in ".*"
        ) {
            let input = ProcessData { value, metadata };
            let _ = process_data(input); // Should never panic
        }
        
        #[test]
        fn test_positive_values_always_succeed(
            value in 1i32..1000,
            metadata in ".*"
        ) {
            let input = ProcessData { value, metadata };
            let result = process_data(input);
            prop_assert!(result.is_ok());
        }
    }
}

// Documentation test example
/// Processes data by doubling the value and appending "_processed" to metadata.
///
/// # Examples
///
/// ```
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
/// ```
pub fn process_data(input: ProcessData) -> Result<ProcessData, ProcessError> {
    // Implementation
}
```

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
