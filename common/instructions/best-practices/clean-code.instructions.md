# Clean Code Style Guide (based on Robert C. Martin)

This guide distills core principles from Robert C. Martin’s Clean Code into practical, enforceable rules for daily development. Use this with your language-specific linters and tests. Prefer clarity and correctness over cleverness. Small, focused changes win.

## Core values
- Readability over brevity
- Single responsibility at every level
- Express intent explicitly
- Eliminate duplication
- Prefer composition over inheritance
- Design for testability and evolvability

## Naming
- Use intention-revealing names; encode the why, not the type or implementation detail.
- Avoid noise words: `data`, `info`, `obj`, `tmp`, `manager`, `util`.
- Prefer pronounceable, searchable names: `maxRetries`, `primaryEmail`.
- Booleans read as predicates: `isEnabled`, `hasAccess`.
- Avoid encodings (Hungarian notation) and prefixes.

## Functions
- Do one thing; do it well; do it only. If you can extract a nameable operation, do it.
- Keep functions small (ideally < 20 lines). Smaller is often better.
- Use descriptive names; avoid long parameter lists (≤ 3, prefer objects for complex inputs).
- Avoid output parameters; return values instead.
- Prefer pure functions; minimize side effects and hidden state.
- Use early returns to reduce nesting; avoid deep conditionals.

## Comments
- Prefer self-explanatory code over comments. Comments don’t make bad code good.
- Use comments to explain why, not what. Link to requirements/tickets for context.
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
- Replace switch/case with polymorphism or dispatch maps where practical.
- Avoid deep nesting; prefer guard clauses.
- Prefer declarative constructs (map/filter/reduce) over index-based loops.

## State and side effects
- Minimize shared mutable state; prefer local state.
- Make side effects explicit; name functions to reflect effects (e.g., `saveUser` vs `getUser`).
- Avoid hidden temporal coupling; document ordering requirements or redesign to remove them.

## Tests (Clean Tests)
- Tests must be: Fast, Independent, Repeatable, Self-validating, Timely (FIRST).
- One assert concept per test; descriptive names explain the scenario.
- Use Arrange-Act-Assert; avoid logic in tests.
- Test behaviors/contract, not private implementation details.
- Keep tests clean: refactor test code; remove duplication with builders/fixtures.

## Concurrency (if applicable)
- Keep shared data immutable or synchronized; prefer message passing.
- Partition data to minimize locking; avoid long-held locks.
- Write tests for race conditions (use stress/fuzz tools where available).

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

Use this guide as the default lens during reviews. If you must violate a rule, state the reason in the PR with a clear trade-off and a follow-up plan.
