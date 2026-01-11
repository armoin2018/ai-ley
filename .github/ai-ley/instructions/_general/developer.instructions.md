---
name: developer-general-instructions
description: General developer instructions for AI-ley agents.
keywords: [developer, coding-standards, clean-code, best-practices]
---

# Clean Code Style Guide (based on Robert C. Martin)

This guide distills core development principles into practical, enforceable rules for development. Prefer efficiency, clarity and correctness over cleverness. Small, focused changes win.


## Core Standards

### Core values
- Readability over brevity
- Single responsibility at every level
- Express intent explicitly
- Eliminate duplication
- Prefer composition over inheritance
- Design for testability and evolvability

### Code Quality Principles

- **Descriptive Naming**: Use clear, meaningful names for variables, functions, and classes
- **Single Responsibility**: Keep functions focused on one task
- **DRY Principle**: Don't Repeat Yourself - abstract common functionality
- **Meaningful Comments**: Explain "why" not "what"; document complex logic
- **Consistent Style**: Follow language-specific style guides from `{{folders.instructions}}`

### Documentation Standards

**List Formatting (CRITICAL - Never Mix):**

1. **Numbered lists** (`1.`, `2.`, `3.`): Use for sequences, ordered steps, or procedures
2. **Checkboxes** (`[ ]`, `[x]`): Use for task tracking and completion items
3. **Dashes** (`-`): Use for unordered lists and bullet points
4. **Never stack or combine**: Do not use `- [ ]` or mix formats within a section
5. **Clarity over complexity**: Single format per context reduces token count and improves AI parsing

**External Reference Pattern:**

- **No embedded code**: Do not embed scripts or examples in documentation/instruction files
- **External references**: Place code in subdirectories: `./(examples|scripts)/{{(agent|instruction|persona)name}}/`
- **Linking**: Reference external files using relative markdown links
- **See also**: Language-specific guides in `{{folders.instructions}}`

### **CRITICAL RULE** Strict Separation of Concerns

**Layer Isolation:**

- Keep CSS, HTML, JavaScript, and TypeScript in separate files
- Never use inline CSS in HTML files
- Never embed JavaScript/TypeScript in HTML files
- Avoid HTML strings in JavaScript/TypeScript (use templates)
- Each layer (UI, style, client logic, server logic, data) remains independent

**API-Based Communication:**

- Frontend to backend calls must go through defined APIs
- Favor REST architecture; use RESTful when pure REST constraints don't apply
- Standard HTTP methods: GET (read), POST (create), PUT (replace), PATCH (update), DELETE (remove)
- Resource-based URLs: `/users/{id}`, `/orders/{id}/items` (nouns, not verbs)
- Standard status codes: 2xx (success), 4xx (client error), 5xx (server error)
- JavaScript → TypeScript communication through REST/RESTful APIs only

## Naming
- Use intention-revealing names; encode the why, not the type or implementation detail.
- Avoid noise words: `data`, `info`, `obj`, `tmp`, `manager`, `util`.
- Prefer pronounceable, searchable names: `maxRetries`, `primaryEmail`.
- Booleans read as predicates: `isEnabled`, `hasAccess`.
- Avoid encodings (Hungarian notation) and prefixes.

## Functions
- Do one thing; do it well; do it only. If you can extract a nameable operation, do it.
- Reuse functions to abstract common patterns and reduce duplication.
- Keep functions small and focused (target < 20 lines).
- Use descriptive names; avoid long parameter lists (≤ 3, prefer objects for complex inputs).
- **Message object pattern**: Reduce function arguments by passing a single `msg` or context object (Node-RED style: `{payload, topic, metadata}`). Return updated msg object.
- Avoid output parameters; return values or msg object with updated payload, state, or errors.
- Prefer pure functions; minimize side effects and hidden state.
- Use early returns to reduce nesting; avoid deep conditionals.
- **Array joins**: Use `array.join(separator)` instead of string concatenation loops or repeated output calls.
- **Traceability**: Write code that's easy to trace through debuggers; avoid overly abstract or magical patterns.

## Comments
- Prefer self-explanatory code over comments. Comments don’t make bad code good.
- Comment after writing code to explain intent to reduce token usage.
- Use comments to explain why, not what. 
- Reference Requirements and Agile Epic/Story/Task for traceability.
- Remove outdated, misleading, or redundant comments.
- Use TODO/FIXME with an owner or ticket reference.

## Formatting
- Keep consistent formatting (use Prettier/linters). Max line length ~100.
- Group related code; separate concepts with blank lines.
- Keep vertical density low: small files, small classes, small functions.
- Keep horizontal density low: avoid long expressions; extract variables.

## Objects and data structures
- Hide implementation details; expose small, cohesive interfaces.
- Tell, don’t ask: prefer methods that act over getters followed by external logic.
- Prefer immutability for value types; minimize mutability elsewhere.
- Avoid exposing internal collections directly; return copies or read-only views.

## Error handling
- Use exceptions (or language equivalents) over error codes.
- One try/catch per logical operation; narrow catch scope; rethrow with context.
- Don’t return null; return empty objects/collections or use Option/Maybe patterns.
- Fail fast with clear messages; avoid swallowing errors.

## Boundaries
- Isolate third-party code behind adapters/ports to reduce coupling.
- Define contracts (interfaces) at boundaries; hide vendor-specific types.
- Write contract/consumer tests to pin behavior at boundaries.

## Dependency management
- Depend on abstractions, not concretions (DIP).
- Invert dependencies for pluggability; use DI containers or manual injection.
- Keep constructors light; avoid doing work during construction.

## Classes and modules
- Single Responsibility Principle (SRP): one reason to change.
- Open/Closed Principle (OCP): open for extension, closed for modification.
- Liskov Substitution Principle (LSP): subtypes must be substitutable.
- Interface Segregation Principle (ISP): many small interfaces over fat ones.
- Dependency Inversion Principle (DIP): high-level modules shouldn’t depend on low-level details.

## Control flow
- **Variable functions over conditionals**: Use function references, dispatch maps, or polymorphism instead of large if-then-else or switch blocks.
- **Inline logic appropriately**: Apply logic within functions rather than separate logic-gate functions for cleaner, traceable code. Extract to separate functions only when logic is reused elsewhere.
- **Guard clauses over nesting**: Exit early to avoid deep conditional nesting.
- **Declarative over imperative**: Use map/filter/reduce instead of index-based loops.

## Profiling and Performance
- Profile before optimizing; identify real bottlenecks.
- Optimize algorithms and data structures first.
- Cache results of expensive operations when appropriate.
- Minimize I/O operations; batch requests when possible.
- Parallelize independent tasks to leverage concurrency.
- Use lazy loading and initialization to defer work until necessary.
- Take multipass optimization approach: first correctness, then performance, then readability.
  - Favor performance over readability, but strive for balance.
  - Operationally systems should be stable, reliable, and scalable.
  - The exponential cost of poor performance outweighs the linear cost of reduced readability.
- Leverage built-in/native capabilities when possible for most efficiency.
- Measure impacts and improvements with benchmarks and profiling tools.

## State and side effects
- Minimize shared mutable state; prefer local state.
- Make side effects explicit; name functions to reflect effects (e.g., `saveUser` vs `getUser`).
- Avoid hidden temporal coupling; document ordering requirements or redesign to remove them.

## Tests (Clean Tests)

### Core Principles

- Tests must be: Fast, Independent, Repeatable, Self-validating, Timely (FIRST).
- One assert concept per test; descriptive names explain the scenario.
- Use Arrange-Act-Assert; avoid logic in tests.
- Test behaviors/contract, not private implementation details.
- Keep tests clean: refactor test code; remove duplication with builders/fixtures.

### Test Infrastructure

- **Integrated and reusable**: Create test scripts that can be imported and reused across projects.
- **API-accessible**: Expose tests through REST endpoints for automated execution and monitoring.
- **Comprehensive coverage**: Provide unit tests, regression tests, health checks, and end-to-end synthetic transactions.
- **Performance tracking**: Return performance metrics (response time, throughput, resource usage) with component health status.
- **Optimization history**: Store performance data in `.project/performance.json` as JSON array to track improvements across optimization runs.
- **Load testing support**: Design tests to support concurrent execution and stress testing scenarios.

### End-to-End Synthetic Transactions

- Perform complete CRUD operations: Create, Read, Update, Delete.
- Include cleanup: Remove test data after execution to avoid pollution.
- Verify full user workflows: Authentication, business logic, data persistence, error handling.
- Test idempotency: Ensure operations can be safely retried.

### Performance Data Schema:

```
{
  "timestamp": "ISO8601",
  "version": "semver",
  "testSuite": "string",
  "metrics": {
    "responseTime": "ms",
    "throughput": "req/s",
    "errorRate": "%",
    "cpuUsage": "%",
    "memoryUsage": "MB"
  },
  "componentHealth": {"component": "status"}
}
```

### Best Practices:

- **Categorization**: Tag tests by type (unit, integration, e2e, smoke, regression) for selective execution.
- **Test data management**: Use builders/factories for consistent setup; store reusable datasets in `.project/testdata/`.
- **Expressive assertions**: Use assertion libraries (Chai, Jest matchers) over basic assertions.
- **Parallelization**: Design tests to run concurrently; avoid shared state and resource conflicts.
- **Flaky test handling**: Implement retry logic with exponential backoff for network tests; flag persistent flakes.
- **Contract testing**: Add consumer-driven contract tests (Pact, Spring Cloud Contract) for API boundaries.
- **Performance baselines**: Define acceptable thresholds; fail tests when degradation exceeds tolerance (e.g., >10% slower).
- **Test reporting**: Generate reports with coverage metrics, failure analysis, and trend visualization.
- **Continuous testing**: Integrate into CI/CD pipeline stages: smoke → unit → integration → e2e.
- **Security testing**: Include OWASP test cases (SQL injection, XSS, CSRF) in regression suite.

## Concurrency (if applicable)
- Keep shared data immutable or synchronized; prefer message passing.
- Partition data to minimize locking; avoid long-held locks.
- Write tests for race conditions (use stress/fuzz tools where available).

## Distributed Systems (if applicable)
- Design for failure and recovery; expect and handle partial failures.
- Use idempotent operations to allow safe retries.
- Implement backoff strategies and circuit breakers to prevent cascading failures.
- Fail-Forward-Fast and degrade gracefully under load.
- Ensure failures are captured, replayable, and observable.

## Logging and Observability
- Use structured logging (JSON format) with consistent levels: DEBUG, INFO, WARN, ERROR.
- Include correlation IDs for request tracing across distributed systems.
- Never log sensitive information (passwords, tokens, API keys, PII).
- Log all errors with sufficient context (stack traces, request IDs, user context).
- Implement log rotation and retention policies.
- Use metrics and tracing for performance monitoring and debugging.
- Make systems observable: expose health checks, metrics endpoints, and status dashboards.

## Code smells and remedies
- Long function/class → extract function/class; apply SRP.
- Large parameter list → introduce parameter object; encapsulate data.
- Duplicated code → extract function/module; DRY.
- Feature envy (method uses another object’s data excessively) → move method.
- Data clumps → encapsulate into a dedicated type.
- Primitive obsession → introduce value objects.
- Shotgun surgery → consolidate responsibility; improve cohesion.
- Inappropriate intimacy → reduce coupling; hide internals.
- Comments explaining complex logic → refactor to intention-revealing code.

## Refactoring workflow
- Red → Green → Refactor. Keep commits small and reversible.
- Use characterization tests before refactoring legacy code.
- Prefer mechanical refactors first (rename/extract), then structural changes.
- Maintain behavior; improve design incrementally.

## Enforceability checklist
- Linters: enforce formatting, complexity, max params, max depth.
- CI gates: lint, typecheck, tests must pass; block on coverage regressions.
- Code reviews: require SRP, naming clarity, small functions/modules.
- Docs: update README/wiki and OpenAPI when public contracts change.

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 4.8
