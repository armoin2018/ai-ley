---
name: 'Koa.Instructions'
description: 'Title: Koa (Node.'
keywords: [testing, api, security, koa.instructions, async, gui, sync, frameworks]
---



Title: Koa (Node.js) — AI Agent Implementation Guide

Use cases
- Minimal, middleware-first HTTP services; custom stacks where Express/Nest are too prescriptive.

Key patterns
- Use async/await middleware; avoid legacy generator-based code.
- Composition: small middlewares for auth, validation (zod/yup), logging, and error handling.
- Routing: @koa/router; input validation per-route; response schemas.
- Config: env → typed config; no secrets in code; use dotenv in dev only.

Security
- helmet equivalents via @koa/* middlewares; CORS scoped; rate limiting.
- Input validation mandatory; sanitize outputs; audit logging with redaction.

Testing
- supertest for HTTP; contract tests for OpenAPI if present; unit-test middlewares.

CI/CD
- Lint/typecheck/test; build with tsup/esbuild; containerize with distroless node.

AI Assistant Guidelines
- Prefer NestJS for enterprise defaults; propose Koa only when minimalism is required.
- Always generate an error-handling middleware, request validation, and security headers.
- Provide OpenAPI if API surface is non-trivial; include smoke tests.

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
