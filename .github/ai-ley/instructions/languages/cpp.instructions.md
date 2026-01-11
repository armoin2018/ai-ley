---
name: 'Cpp.Instructions'
description: 'Comprehensive C++ development guidelines for AI coding assistants, emphasizing modern C++ best practices, RAII principles, performance optimization, and maintainable code patterns.'
keywords: [context, cmake, comprehensive, concurrency, common, architecture, configuration, analysis, avoid, conventions]
---



# C++ Programming Instructions

Comprehensive C++ development guidelines for AI coding assistants, emphasizing modern C++ best practices, RAII principles, performance optimization, and maintainable code patterns.

## 🧠 Context

- **Language**: C++ (C++17/C++20 preferred, C++23 features where available)
- **Environments**: Native binaries, embedded systems, high-performance computing, game engines
- **Common Frameworks**: STL, Boost, Qt, FLTK, wxWidgets, Unreal Engine, Godot
- **Package Managers**: Conan, vcpkg, CPM.cmake
- **Build Tools**: CMake, Bazel, Make, Ninja, MSBuild
- **Testing**: Google Test, Catch2, doctest, Boost.Test

## 📁 Project Structure

See [example-1](./examples/cpp/example-1.text)

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern C++ following C++ Core Guidelines
- Prioritize RAII (Resource Acquisition Is Initialization) for all resource management
- Implement clear separation of concerns and modular design
- Use consistent formatting with clang-format
- Follow the principle of least surprise and explicit intent
- Prefer composition over inheritance
- Embrace zero-cost abstractions and compile-time computation

### Modern C++ Features
- Use `auto` for type deduction where it improves readability
- Prefer range-based for loops over traditional iterator loops
- Leverage lambda expressions for local functionality and algorithms
- Use structured bindings (C++17) for multiple return values
- Utilize `std::optional` and `std::variant` for safer nullable and union types
- Apply `constexpr` and `consteval` for compile-time evaluation
- Use concepts (C++20) for template constraints and better error messages

## 📜 Code Style and Conventions

### Naming Conventions

See [example-2](./examples/cpp/example-2.cpp)

### Function Design

See [example-3](./examples/cpp/example-3.cpp)

## 🏗️ Architecture Patterns

### RAII and Resource Management

See [example-4](./examples/cpp/example-4.cpp)

### Smart Pointer Management

See [example-5](./examples/cpp/example-5.cpp)

## 🔄 Concurrency and Threading

### Thread-Safe Programming Best Practices

See [example-6](./examples/cpp/example-6.cpp)

### Error Handling

See [example-7](./examples/cpp/example-7.cpp)

## ⚡ Performance Optimization

### Efficient Code Patterns

See [example-8](./examples/cpp/example-8.cpp)

## 🧪 Testing Guidelines

### Comprehensive Testing with Google Test

See [example-9](./examples/cpp/example-9.cpp)

## 🛠️ Development Environment

### CMake Configuration Best Practices

See [example-10](./examples/cpp/example-10.cmake)

### Essential Development Tools

- **Formatter**: clang-format - Automatic code formatting with consistent style
- **Linter**: clang-tidy - Static analysis and modernization suggestions  
- **Sanitizers**: AddressSanitizer, ThreadSanitizer, UndefinedBehaviorSanitizer
- **Build System**: CMake - Modern, portable build configuration
- **Package Manager**: Conan or vcpkg - Dependency management
- **Profiler**: perf, Valgrind, or vendor-specific tools

## 🔍 Code Quality Standards

### Static Analysis Configuration

See [example-11](./examples/cpp/example-11.cpp)

### Documentation Standards

See [example-12](./examples/cpp/example-12.cpp)cpp
 * DataManager<int> manager;
 * manager.add_data(42);
 * auto result = manager.get_data(0);
 * See [example-13](./examples/cpp/example-13.txt)

## 🚫 Common C++ Pitfalls to Avoid

- **Manual Memory Management**: Always use RAII and smart pointers instead of raw `new`/`delete`
- **Rule of 3/5/0 Violations**: Properly implement or explicitly delete copy/move operations
- **Raw Array Usage**: Prefer `std::array`, `std::vector`, or `std::span` over C-style arrays
- **Const-Incorrectness**: Apply `const` wherever logically appropriate
- **Resource Leaks**: Ensure all resources are managed by RAII objects
- **Premature Optimization**: Profile before optimizing, focus on algorithmic improvements first
- **C-Style Casts**: Use C++ cast operators (`static_cast`, `dynamic_cast`, etc.)
- **Exception Unsafe Code**: Design for exception safety using RAII and strong exception guarantee
- **Undefined Behavior**: Be aware of common UB sources (signed overflow, dangling pointers, etc.)
- **Thread Safety Assumptions**: Explicitly design for thread safety or document thread requirements

## 📚 Essential Libraries

### Standard Library Mastery
See [example-14](./examples/cpp/example-14.cpp)

### Recommended Third-Party Libraries
- **Boost**: Peer-reviewed portable C++ libraries
- **fmt**: Modern formatting library (std::format predecessor)
- **spdlog**: Fast C++ logging library  
- **nlohmann/json**: Modern JSON library for C++
- **Catch2 or Google Test**: Testing frameworks
- **Eigen**: Linear algebra and mathematical computations

## 🚦 AI Enforcement Summary

### Code Quality Rules
- ✅ Enforce RAII for all resource management
- ✅ Require smart pointers over raw pointers for ownership
- ✅ Block manual `new`/`delete` without corresponding RAII wrapper
- ✅ Enforce const-correctness in all contexts
- ✅ Require `noexcept` specification for functions that don't throw
- ✅ Block C-style casts in favor of C++ cast operators
- ✅ Enforce modern C++ feature usage (auto, range-for, lambdas)
- ✅ Require proper exception safety guarantees

### Performance Enforcement
- 🚫 Block string concatenation in loops without pre-allocation
- 🚫 Block inefficient container operations (repeated push_front on vector)
- ✅ Promote move semantics and perfect forwarding
- ✅ Promote compile-time computation with constexpr/consteval
- ✅ Enforce container reserve() calls when size is known
- ✅ Promote string_view for read-only string parameters

### Security Enforcement
- 🔒 Enforce bounds checking for array access
- 🔒 Block unsafe string functions (strcpy, sprintf)
- 🔒 Require input validation for all public interfaces
- 🔒 Enforce thread-safety annotations and practices
- 🔒 Block potential undefined behavior patterns

### Modern C++ Enforcement
- ✅ Promote C++17/20 features over legacy alternatives
- ✅ Enforce structured bindings for multiple return values
- ✅ Require concepts for template constraints (C++20)
- ✅ Promote ranges library usage (C++20)
- ✅ Enforce designated initializers for aggregate types (C++20)

## 📖 References

- [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/) - Authoritative best practices
- [cppreference.com](https://en.cppreference.com/) - Comprehensive language and library reference
- [Effective Modern C++ by Scott Meyers](https://www.oreilly.com/library/view/effective-modern-c/9781491908419/) - Essential modern C++ practices
- [C++ Concurrency in Action by Anthony Williams](https://www.manning.com/books/c-plus-plus-concurrency-in-action-second-edition) - Threading and concurrency
- [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html) - Industry-standard style guide
- [Clang-Tidy Checks Reference](https://clang.llvm.org/extra/clang-tidy/checks/list.html) - Static analysis rules
- [CMake Documentation](https://cmake.org/documentation/) - Modern build system practices
- [Boost Libraries](https://www.boost.org/) - High-quality C++ libraries

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
