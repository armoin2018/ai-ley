---
name: 'Azure Function App.Instructions'
description: 'Development guidelines and best practices for Azure Function App.Instructions'
keywords: [api, app.instructions, context, follow, async, example, architecture, copilot, avoid, azure]
---



# GitHub Copilot Instructions

These instructions define how GitHub Copilot should assist with this Node.js TypeScript Azure Functions project. The goal is to ensure consistent, high-quality code generation aligned with Azure Functions conventions, our stack, and TypeScript best practices.

## 🧠 Context

- **Project Type**: Serverless REST API / Event-Driven Function App
- **Language**: TypeScript (Node.js)
- **Framework / Libraries**: Azure Functions SDK, TypeScript, Zod, dotenv, esbuild
- **Architecture**: Modular / Handler-Based / Event-Driven / Clean Separation of Concerns

## 🔧 General Guidelines

- Use idiomatic TypeScript with `strict` mode enabled.
- Use `async/await` for all I/O operations and avoid `.then()` chains.
- Export named handler functions that follow the Azure Functions signature.
- Validate inputs using Zod schemas and return structured error responses.
- Format code using Prettier and organize imports with ESLint or import-sort.
- Prefer `const` and `readonly` where possible. Avoid `any`.

## 📁 File Structure

Use this structure as a guide when creating or updating files:

See [example-1](./examples/azure-function-app/example-1.text)

## 🧶 Patterns

### ✅ Patterns to Follow

- Use the Azure Functions v4 isolated worker model or standard Node.js v4 API structure.
- Validate request bodies and query parameters with Zod or equivalent.
- Structure code with clear separation: function file → controller → service → repository.
- Use `context.log` for output.
- Store environment configs in `local.settings.json` for local dev, and App Settings in Azure.
- Structure function files to only include bindings and delegate logic to controllers/services.
- Use dependency injection through function context or factory patterns (when needed).

### 🚫 Patterns to Avoid

- Don’t place business logic directly in Azure Function files.
- Don’t hardcode settings—use `process.env` or config wrappers.
- Avoid top-level `console.log`—use contextual logging or log providers.
- Don’t ignore type errors—always use proper interfaces and types.
- Avoid creating one monolithic function with all logic inside it.

## 🧪 Testing Guidelines

- Use `Jest` or `Vitest` for unit and integration testing.
- Mock `context` and `req` objects when testing Azure Function handlers.
- Isolate business logic into services to make them testable without function bindings.
- Prefer test-driven development for reusable modules (schemas, services, utils).
- Mock external services (DB, APIs) using tools like `jest.mock()` or custom stubs.

## 🧩 Example Prompts

- `Copilot, create a TypeScript Azure Function that receives a POST request with a user object and validates it using Zod.`
- `Copilot, write a controller for creating a user that delegates to a UserService and returns an HTTP 201.`
- `Copilot, define a Zod schema for a product with id, name, price, and optional description.`
- `Copilot, write a Jest test for an Azure Function handler that returns 400 if the body is invalid.`
- `Copilot, generate a middleware that logs incoming requests and their duration.`

## 🔁 Iteration & Review

- Copilot output should be reviewed and tested locally using `func start`.
- Add comments to guide Copilot for complex validation, binding types, or logs.
- Refactor repetitive logic (e.g., validation, error handling) into shared utils.
- Run Prettier, ESLint, and type checking in CI/CD before merging.

## 📚 References

- [Azure Functions Node.js Developer Guide](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-node)
- [Azure Functions Bindings Reference](https://learn.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings)
- [Zod Documentation](https://zod.dev/)
- [TypeScript ESLint Rules](https://typescript-eslint.io/)
- [Jest Testing Docs](https://jestjs.io/docs/getting-started)
- [esbuild Docs](https://esbuild.github.io/)

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
