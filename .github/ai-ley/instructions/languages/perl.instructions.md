---
name: 'Perl.Instructions'
description: 'Development guidelines and best practices for Perl.Instructions'
keywords: [languages, coding, gui, architecture, authentication, database, hints), (with, guide, framework]
---



# Perl Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for Perl development. These include AI linting hints to automatically enforce style rules and maintain clean, performant, and maintainable Perl code.

⸻

📂 Project Architecture

✅ Rule: Enforce modular architecture

- Organize code into modules with proper package declarations
- Use `lib/` directory for application modules
- Separate scripts, modules, and tests into distinct directories
- Follow standard Perl directory structure conventions

✅ Rule: Strict separation of concerns

- Perl → Business logic, data processing, and system integration
- Templates → Structural markup only (Template Toolkit, Mason)
- Configuration → External config files (YAML, JSON, INI)
- Documentation → POD (Plain Old Documentation) embedded in modules

✅ Rule: Module Organization

- Use meaningful package names following hierarchy (e.g., `MyApp::User::Manager`)
- Implement proper `use`/`require` statements with version requirements
- Export only necessary functions and variables
- Use namespaces effectively to avoid pollution

✅ Rule: CPAN Integration

- Use `cpanfile` or `Makefile.PL` for dependency management
- Prefer stable CPAN modules over custom implementations
- Document module dependencies clearly
- Use proper versioning for module releases

✅ Rule: Variable Functions & Subroutines

- Use symbolic references and dispatch tables instead of large if/elsif chains
- Implement consistent patterns for flexibility and reduced code changes

⸻

📜 Standard Libraries & Frameworks

✅ Rule: Prefer core modules when possible

- Use `strict` and `warnings` pragmas in all code
- Use `Carp` for error reporting instead of `die` and `warn`
- Use `File::Spec` for portable file path operations
- Use `Getopt::Long` for command-line argument processing

✅ Rule: Approved CPAN modules

- **Web Frameworks**: Mojolicious, Catalyst, Dancer2
- **Database**: DBI with DBD drivers, DBIx::Class ORM
- **Testing**: Test::More, Test::Exception, Test::Deep
- **HTTP**: LWP::UserAgent, HTTP::Tiny for web requests
- **JSON/XML**: JSON::XS, XML::LibXML for data processing
- **Templates**: Template Toolkit, Mason, Text::Template

✅ Rule: Development Tools

- Use `Perl::Critic` for code quality analysis
- Use `Perl::Tidy` for consistent code formatting
- Use `Devel::NYTProf` for performance profiling
- Use `prove` for running test suites

⸻

🖋 Perl Coding Standards

✅ Pragmas and Declarations

- Always use `strict` and `warnings` pragmas
- Use `use v5.10` or higher for modern Perl features
- Declare variables with appropriate scope (`my`, `our`, `local`)
- Use `state` variables for persistent function-scoped data

✅ Example:

See [example-1](./examples/perl/example-1.perl)

⸻

✅ Variable Declarations and Naming

- Use descriptive variable names that indicate content and scope
- Follow Perl conventions: `$scalar`, `@array`, `%hash`
- Use underscore_separated names for variables and subroutines
- Declare variables in the smallest applicable scope

✅ Example:

See [example-2](./examples/perl/example-2.perl)

⸻

✅ Loops & Memory (Perl)

- Cache expensive operations outside loops when possible
- 🚫 Avoid string concatenation inside loops:
  - Do not use `.=` for string building in loops
  - Do not use `push @array, $string` followed by `join` for simple concatenations

❌ Bad:

See [example-3](./examples/perl/example-3.perl)

✅ Good:

See [example-4](./examples/perl/example-4.perl)

⸻

✅ Variable Functions (Perl)

- Use dispatch tables and symbolic references instead of large if/elsif chains
- Implement consistent message-passing patterns
- Enable dynamic subroutine calls for extensible architectures

✅ Example:

See [example-5](./examples/perl/example-5.perl)

✅ Variable Classes (Perl)

- Implement consistent object interface using blessed references
- Use Moose or Moo for modern object-oriented programming
- Enable dynamic class instantiation and polymorphism

✅ Example:

See [example-6](./examples/perl/example-6.perl)

⸻

✅ Error Handling and Exceptions

- Use `Carp` module for proper error reporting
- Implement exception handling with `Try::Tiny` or `Feature::Try`
- Validate input parameters and return meaningful error messages
- Use proper logging with `Log::Log4perl` or similar

✅ Example:

See [example-7](./examples/perl/example-7.perl)

⸻

✅ Documentation and Testing

- Write POD documentation for all modules and complex subroutines
- Use Test::More for comprehensive unit testing
- Test both success and failure scenarios
- Include usage examples in documentation

✅ Example:

See [example-8](./examples/perl/example-8.perl)

⸻

🧠 Performance & Best Practices

- Use references to avoid copying large data structures
- Implement lazy evaluation where appropriate
- Use compiled regular expressions for repeated pattern matching
- Profile code with Devel::NYTProf to identify bottlenecks

✅ Example:

See [example-9](./examples/perl/example-9.perl)

⸻

🧪 Testing Standards

✅ Comprehensive Testing with Test::More

- Write unit tests for all public subroutines and methods
- Use descriptive test names that explain expected behavior
- Test edge cases, error conditions, and boundary values
- Use Test::Exception for exception testing

✅ Example:

See [example-10](./examples/perl/example-10.perl)

⸻

⚡ Performance Rules

✅ Perl-Specific Optimization

- 🚫 Avoid string concatenation in loops using `.=`
- 🚫 Avoid unnecessary array building for simple string operations
- ✅ Use `join` and `map` for string operations
- ✅ Cache compiled regular expressions with `state`
- ✅ Use references to avoid copying large data structures
- ✅ Profile with Devel::NYTProf before optimizing

⸻

✍️ Commit Message Conventions

- Prefix commits with: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `perf:`, `test:`
- Example: `feat: add user authentication with session management`

⸻

🚦 AI Enforcement Summary

✅ Enforce strict and warnings pragmas in all code
✅ Block string concatenation in loops (`.=`)
✅ Block array building for simple string concatenation
✅ Require proper variable scoping with my/our/local
✅ Enforce Carp usage over die/warn for error reporting
✅ Prefer dispatch tables over long if/elsif chains
✅ Enforce consistent object interfaces (BUILD, DEMOLISH, accessors)
✅ Require POD documentation for all public subroutines
✅ Enforce comprehensive testing with Test::More
✅ Use Perl::Critic for automated code quality checks
✅ Auto-fix Perl::Tidy formatting violations where possible

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
