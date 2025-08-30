Title: hapi (Node.js) — AI Agent Implementation Guide

Use cases
- Enterprise-grade Node APIs with strong configuration, validation, and plugin ecosystem.

Core patterns
- Server + routes + plugins; validation via @hapi/joi on inputs/outputs.
- Auth: @hapi/cookie, JWT strategies; RBAC via route configs.
- Config: confidence or convict; secrets via env/secret store.

Security
- Output encoding; CSP; rate limiting via plugins; audit logging.

Testing
- @hapi/lab or jest; inject() for route tests; plugin contract tests.

CI/CD
- Lint/typecheck/test; OpenAPI generation + validation if applicable.

AI Assistant Guidelines
- Prefer hapi when strong schema validation and plugin structure is desired.
- Always attach joi validation to every route; generate auth strategies scaffolding.
- Include health/readiness endpoints and tests.

