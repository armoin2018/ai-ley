---
name: 'C.Instructions'
description: 'Comprehensive instructions for C development with AI coding assistants, focusing on modern C best practices, memory safety, and maintainable code.'
keywords: [api, c.instructions, common, build, compiler, architecture, allocation, avoid, cli, checklist]
---



# C Programming Instructions

Comprehensive instructions for C development with AI coding assistants, focusing on modern C best practices, memory safety, and maintainable code.

## 🧠 Context

- **Language**: C (C17/C18 preferred)
- **Common Use Cases**: System software, embedded systems, CLI tools, libraries
- **Frameworks**: POSIX, GNU libc, embedded RTOS
- **Build Systems**: Make, CMake, Autotools
- **Architecture**: Modular, layered, driver-oriented

## 📁 Project Structure

See [example-1](./examples/c/example-1.text)

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, portable C following C17 standards
- Prioritize memory safety and avoid undefined behavior
- Use modular design with clear separation of concerns
- Implement defensive programming practices
- Focus on readability and maintainability

### Code Organization
- Use header files (.h) for declarations and source files (.c) for implementations
- Keep functions small, focused, and single-purpose
- Use static functions for internal module functionality
- Implement clear interfaces between modules
- Abstract platform-specific code behind interfaces

## 📜 Naming Conventions

- **Functions**: `snake_case` (e.g., `process_user_data`)
- **Variables**: `snake_case` (e.g., `buffer_size`, `user_count`)
- **Constants**: `UPPER_SNAKE_CASE` (e.g., `MAX_BUFFER_SIZE`)
- **Types**: `snake_case_t` (e.g., `user_data_t`, `config_t`)
- **Macros**: `UPPER_SNAKE_CASE` (e.g., `ARRAY_SIZE`)
- **Global variables**: `g_snake_case` (avoid when possible)

## 🛡️ Memory Management

### Allocation Best Practices

See [example-2](./examples/c/example-2.c)

### Memory Safety Rules
- Always pair `malloc()` with `free()`
- Set pointers to `NULL` after freeing
- Check all allocation return values
- Initialize allocated memory before use
- Use `const` qualifiers for read-only data
- Implement RAII-style cleanup patterns where possible

## 🔤 String Handling

### Safe String Operations

See [example-3](./examples/c/example-3.c)

### String Safety Rules
- Always null-terminate strings
- Use `strncpy`, `strncat`, `snprintf` instead of unsafe variants
- Check buffer bounds before string operations
- Use `const char*` for read-only string parameters
- Validate string lengths before operations

## ⚠️ Error Handling

### Error Handling Patterns

See [example-4](./examples/c/example-4.c)

### Error Handling Rules
- Use consistent return codes or error enums
- Check all function return values
- Use `errno` for system call errors
- Implement proper cleanup on errors using `goto` when appropriate
- Log errors appropriately for debugging

## 🔄 Functions and APIs

### Function Design Principles

See [example-5](./examples/c/example-5.c)

### Function Guidelines
- Keep functions small and focused (ideally < 50 lines)
- Use meaningful parameter names
- Validate all input parameters
- Document function behavior with comments
- Return error codes for status indication
- Use `const` for read-only parameters
- Minimize side effects

## ⚡ Performance Guidelines

### Efficient Code Patterns

See [example-6](./examples/c/example-6.c)

## 🧪 Testing Guidelines

### Unit Testing Best Practices

See [example-7](./examples/c/example-7.c)

### Testing Rules
- Test individual functions in isolation
- Test both normal and error conditions
- Use descriptive test names
- Validate memory usage with tools like Valgrind
- Test edge cases and boundary conditions
- Mock external dependencies when needed

## 🛠️ Build and Tools

### Recommended Tools
- **Static Analysis**: `clang-static-analyzer`, `cppcheck`, `PVS-Studio`
- **Memory Debugging**: `valgrind`, `AddressSanitizer`
- **Formatting**: `clang-format`
- **Testing**: `Unity`, `CMock`, `Check`
- **Build**: `CMake`, `Make`
- **Documentation**: `Doxygen`

### Compiler Flags
See [example-8](./examples/c/example-8.makefile)

## 🚫 Common Pitfalls to Avoid

- **Buffer Overflows**: Always check bounds before array/string operations
- **Memory Leaks**: Ensure every `malloc` has a corresponding `free`
- **Double Free**: Set pointers to `NULL` after freeing
- **Uninitialized Variables**: Initialize all variables before use
- **Integer Overflow**: Check for overflow in arithmetic operations
- **Format String Vulnerabilities**: Use static format strings
- **Global State**: Minimize global variables and shared mutable state

## 📚 Standard Libraries

### Essential Headers
See [example-9](./examples/c/example-9.c)

## 🔍 Code Review Checklist

- [ ] All parameters validated
- [ ] Memory properly allocated and freed
- [ ] Error conditions handled
- [ ] Buffer bounds checked
- [ ] Return values checked
- [ ] Functions documented
- [ ] No undefined behavior
- [ ] Thread safety considered (if applicable)
- [ ] Performance implications reviewed

## 📖 References

- [ISO C Standard (C17)](https://www.iso.org/standard/74528.html)
- [GNU C Library Documentation](https://www.gnu.org/software/libc/manual/)
- [Modern C by Jens Gustedt](https://gustedt.gitlabpages.inria.fr/modern-c/)
- [CERT C Coding Standard](https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standard)
- [Unity Test Framework](https://github.com/ThrowTheSwitch/Unity)
- [Valgrind Documentation](https://valgrind.org/docs/manual/)

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
