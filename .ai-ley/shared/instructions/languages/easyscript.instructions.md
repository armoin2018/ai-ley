# EasyScript — AI Assistant Guidelines (Internal DSL / Simplified Scripting)

Purpose: Implement lightweight automation or domain-specific logic with a constrained, safe syntax. Favor clarity, determinism, and guardrails.

## When to use
- You need a minimal DSL for configuration, rules, or small automations editable by non-developers.
- Scripts must be sandboxed with predictable resource limits and no filesystem/network by default.

## When to avoid
- Complex programs requiring full language features, types, or concurrency.
- Security-sensitive tasks where sandbox guarantees can’t be proven or enforced.

## Execution model
- Deterministic evaluation with explicit inputs/outputs (pure functions preferred).
- No global state; pass environment as an immutable object. Return a result object with diagnostics.
- Time and randomness injected via interfaces to enable reproducible tests.

## Safety
- Sandbox interpreter: disable I/O and reflection; allow only whitelisted intrinsics.
- CPU/memory/time quotas per script; hard fail on limit breach with structured error.
- Validate AST before execution; disallow unbounded loops or recursion depth > N.

## Testing and validation
- Unit tests: golden I/O samples; property tests for invariants.
- Static checks: lint DSL for forbidden constructs; schema-validate inputs.
- Coverage: report branch/path coverage for critical rules.

## AI Assistant rules
- Generate readable scripts with small, composable functions; avoid cleverness.
- Emit an execution contract (inputs, outputs, constraints, limits) alongside the script.
- Produce a sandbox config and minimal runner with tests; do not enable I/O by default.

## Observability
- Structured logs with correlation IDs; redact secrets.
- Metrics: execution count, latency, success/failure, limit breaches.
