# Universal Project Coding & Management Guide

This guide defines universal coding standards and project management workflows to account for clarity, traceability, compliance, and coordination practices for multi-language development projects. The following guidelines outline how requirements, plans, instructions, personas, documentation, testing and library usage are managed.

## Requirements

- All project requirements must be defined in `project/REQUIREMENTS.md`.
- Each task references relevant requirements from this file

## Execution Plans

- Detailed execution plans are created in `project/PLAN.md` based on the requirements in `project/REQUIREMENTS.md`.
- Use Agile methodology by creating Epics, Stories and Tasks
- Each Epic, Story or Task should include user stories, priority, and acceptance criteria.
- The `project/PLAN.md` should provide a detailed outline of tasks, milestones, deliverables and acceptance criteria.
- The `.github/copilot-instructions.md` should be used to guide the creation and execution of these plans.
- Each Agile Epic, Story or Task references necessary instruction files stored under the `.github/instructions/` directory.
- Each Agile Epic, Story or Task may also reference relevant personas from the `.github/personas/` directory.
- If additional context or clarification is needed, team members should consult the relevant instruction files or personas.
- If personas are not sufficient, generate new ones as needed.
- If instructions are not sufficient, create new ones as needed.

## Change Tracking

- Keep track of the progress using `project/HISTORY.md` referencing the version to allow resuming, replay and rollback.
- Create Difference (diff/patch) files under `diff/` to allow for patching and rollback to specific versions.
- A summary of changes should be tracked and documented in `project/CHANGELOG.md` with most recent at the top.
- Version Format `YYYY.MM.DD-<#####>` (e.g. `2023.03.15-00001`)
- Each entry must include: version, date, description of changes, instructions used, personas used.

## Documentation

- Project documentation is maintained as a GitHub Wiki under `wiki/`
- Project client documentation is maintained as GitHub Pages under `docs/`
- Functions should be documented with meaningful comments
- Architecture diagrams and design documents should be stored in `wiki/architecture/` using PlantUML
- Swagger JSON file for REST APIs should be stored in `wiki/api/`

## Library Management

- Approved libraries and modules are listed in `project/WHITELIST.md`
- Prohibited/deprecated modules and practices are listed in `project/BLACKLIST.md`
- If a new library is needed, it must be added to `project/WHITELIST.md` with justification.

---

## Code Style Guidelines

### General Principles

- Use descriptive variable, class and function names
- Follow language-specific style guides under `.github/instructions/`
- Use task specific personas from `.github/personas/`
- Keep functions small and focused on a single reusable task.
- Use meaningful comments to explain "why" something is done, not "what" is done.
- Use meaningful comments to explain complex logic.
- Avoid unnecessary complexity and over-engineering.
- Use consistent naming conventions (e.g., camelCase, snake_case).
- Consistent indentation and formatting are required.
- Keep code DRY (Don't Repeat Yourself) by abstracting common functionality.
- Write unit tests for all new features and bug fixes.

### File Organization

- Organize code into modules/packages by feature or functionality.
- Keep related files (e.g., tests, documentation) close to the code they reference.
- Use consistent naming conventions for files and directories.
- Avoid deep nesting of directories; keep the structure flat and intuitive.
- Use consistent import/export patterns
- Maintain logical file structure following established patterns

### Code Formatting

- Follow language-specific style guides under `.github/instructions/`
- Set a maximum line length of 100 characters, utilize optimal breaking points for readability.
- Use training commas in multi-line structures
- Follow prettier/eslint configurations when available

---

## GitHub Copilot Best Practices

### Prompt Engineering

- Be specific and detailed in your prompts to get the best results.
- Provide context and background information when necessary.
- Use examples to illustrate your points and guide the model.
- Experiment with different phrasings and structures to find what works best.

### Code Review

- Ensure code adheres to style guidelines and best practices.
- Log suggestions and enhancements to `project/SUGGESTIONS.md`.
- Verify implementation against requirements and acceptance criteria.
- Ensure code is well-tested and covers edge cases.
- Verify that suggested libraries are approved and listed in `project/WHITELIST.md`.
- Use pull requests for all code changes to facilitate review.
- Document all code changes in the pull request description.
- Assign other relevant personas to review and enhance code changes.
- Validate changes when possible with automated tests and verification using expected responses.

### Context Management

- Maintain context throughout the conversation to ensure relevant and coherent responses.
- Use memory effectively to remember important details and user preferences.
- Use consistent patterns across the codebase
- Enrich documentation of complex business logic to improve understanding and maintainability.
- Encourage collaboration and sharing among personas.
- Clear memory between logical working units to prevent context pollution and ensure fresh perspective on new tasks:
  - Clear context when switching between different projects or repositories
  - Reset memory when moving from one major feature to another unrelated feature
  - Clean slate approach when transitioning between different programming languages or frameworks
  - Purge temporary variables and intermediate results after completing a discrete unit of work
  - Maintain only essential project-level context (requirements, standards, personas) across unit boundaries

### Task Chunking & Size Limit Handling

- If a request fails due to size limits (token limits, context window overflow, or processing constraints), automatically break down the task into smaller, manageable chunks
- Identify logical breakpoints for chunking based on:
  - File boundaries (process one file at a time)
  - Function/class boundaries (process individual components)
  - Feature boundaries (implement one feature per chunk)
  - Test boundaries (write tests for one module at a time)
- Maintain consistency across chunks by:
  - Preserving naming conventions and coding standards
  - Ensuring proper imports and dependencies between chunks
  - Maintaining architectural patterns across all pieces
- After completing each chunk, verify integration and compatibility with previously completed chunks
- Provide clear progress updates showing which chunks have been completed and what remains
- Resume from the last successful chunk if the process is interrupted

---

## Testing Requirements

### Unit Tests

- All new functions must have corresponding unit tests
- Aim for at least 80% code coverage
- Use descriptive test names that explain the scenario being tested
- Follow the Arrange-Act-Assert (AAA) pattern for structuring tests

### Integration Tests

- Integration tests must cover interactions between multiple components or systems.
- Use realistic test data and scenarios to validate end-to-end functionality.
- Aim for high coverage of critical user journeys and workflows.
- Mock external dependencies appropriately.
- When testing database interactions, use transactions to ensure a clean state.
- Include performance tests for critical components.
- Test for security vulnerabilities and compliance with best practices.
- Ensure all tests are automated and can be run in CI/CD pipelines.
- Include tests for edge cases and error conditions.
- Continuously monitor and improve test coverage and quality.
- Refactor tests as needed to maintain clarity and effectiveness.
- Document all tests and their purpose under `tests/README.md`.
- On CRUD operations, include tests for all four actions: Create, Read, Update, and Delete. Create sample data and validate the responses.
- Ensure proper cleanup after tests.
- Support rollback mechanisms where applicable.

### Test Organization

- Test should be stored in `tests/` directory.
- Use descriptive names for test files and directories.
- Include a clear README.md file in the `tests/` directory to explain the testing structure and guidelines.
- Group related tests using subdirectories.
- Relate tests to specific versions and builds

---

## Security Guidelines

### Input Validation

- Always validate user input on both client and server sides.
- Use whitelisting approaches to define acceptable input formats.
- Sanitize and escape all user-generated content to prevent injection attacks.
- Validate all user inputs and external data
- Use Parameterized Queries (Prepared Statements) for database access.
- Sanitize and escape all output data to prevent XSS attacks.

### Authentication & Authorization

- Implement strong authentication mechanisms (e.g., OAuth, JWT).
- Enforce role-based access control (RBAC) for sensitive operations.
- Regularly review and update permissions and access controls.
- Never hardcode credentials or API keys in the codebase.

### Data Protection

- Encrypt sensitive data at rest and in transit.
- Implement logging and monitoring for access to sensitive data.
- Regularly audit and review data access logs.
- Use HTTPS for all external communications.
- Use mTLS when possible.
- Ensure sensitive data is not exposed in logs or error messages.
- Encrypt sensitive data before storing it.
- Follow GDPR and other relevant data protection regulations.
- Implement data minimization principles.
- Regularly review and update data protection measures.
- Produce test scripts to validate data protection measures under 'tests/data_protection/'.

---

## Performance Considerations

### Optimization

- Identify and eliminate performance bottlenecks.
- Optimize database queries and use indexing appropriately.
- Implement caching strategies to reduce load times.
- Minimize network requests and payload sizes.
- Use asynchronous processing for long-running tasks.
- Continuously monitor performance metrics and adjust as needed.
- Avoid unnecessary database queries (e.g., N+1 queries).
- Avoid unnecessary data processing and transformations.
- Avoid blocking operations in the main thread.
- Avoid synchronous calls to external services.
- Avoid long-running computations on the main thread.
- Avoid memory leaks and excessive resource consumption.
- Avoid unnecessary object creation and retain cycles.
- Avoid deep nesting of callbacks or promises.
- Avoid repetitive computations, function calls, and data processing.
- Monitor performance metrics and logs for anomalies.
- Create profiling test scripts and reports under `tests/performance/`.

### Resource Managment

- Close database connections, socket connections, and file handles properly and timely.
- Use Connection pooling for database operations
- Implement proper memory management practices
- Pass by reference when possible

## Error Handling

### Standards

- Always return meaningful error messages (avoid generic messages).
- Use structured error handling (try/catch/finally).
- Create custom error types for domain-specific errors.
- Return meaningful error messages to users.
- Include error codes for programmatic error handling.
- Log all errors with sufficient context for debugging.
- Implement centralized error handling (e.g., middleware).
- Regularly review and update error handling practices.

### Logging

- Establish a centralized logging configuration to define storage format, levels, and destination (e.g., file, database, external service).
- Implement structured logging (e.g., JSON format) for all log messages.
- Include request metadata (e.g., user ID, timestamp) in all logs.
- Regularly review and analyze log data for anomalies.
- Implement log rotation and retention policies.
- Use consistent logging levels (DEBUG, INFO, WARN, ERROR)
- Include correlation IDs for tracing requests across services.
- Avoid logging sensitive information (e.g., passwords, credit card numbers).

---

## Code Review Process

### Before Submitting

- Ensure all code is properly tested (unit/integration tests).
- Update documentation (e.g., README, wiki) as needed.
- Include clear and concise commit messages.
- Run all tests (unit/integration) locally before submitting.
- Check code coverage and ensure it meets the project's standards.
- Ensure code follows style guidelines (e.g., linting, formatting).
- Address any code "smells" or technical debt.

### Review Criteria

- Code is well-structured and follows established design patterns.
- All new features are covered by tests (unit/integration).
- No critical or high-severity issues are present.
- Code is efficient and performs well under expected load.
- Documentation is clear, complete, and up-to-date.
- Code adheres to style guidelines and best practices.
- Any trade-offs or limitations are clearly documented.
- Code is modular and reusable.
- Code is easy to understand and maintain.
- Code is well-documented (e.g., comments, README).
- Code is free of unnecessary complexity.
- Code is reviewed for security vulnerabilities.

---

## Compliance and Standards

### Legal Considerations

- Ensure all code complies with licensing requirements.
- Focus on utilizing approved libraries and frameworks.
- Prioritize MIT-licensed libraries and frameworks.
- Avoid using Copyrighted, proprietary or unlicensed code.
- Follow fair use guidelines for any third-party content.

### Industry Standards

- Follow industry best practices for security, performance, and reliability.
- Stay up-to-date with relevant regulations and compliance requirements (e.g., GDPR, HIPAA).
- Adhere to established coding standards and guidelines (e.g., OWASP Top Ten).
- Participate in industry forums and communities to share knowledge and learn from peers.
- Implement accessibility standards (e.g., WCAG) in all projects.
- Use semantic versioning for all releases.

---

## UI/UX Standards

### Design Principles

- Prioritize user-centered design and usability.
- Ensure consistency in design elements (e.g., colors, typography).
- Implement responsive design for various screen sizes.
- Conduct user research and testing to validate design decisions.
- Allow Dark Mode and other accessibility features.
- Allow for customization and personalization options through Theme settings.

### Layered Architecture (UI/Style/Model/Logic/Data)

- Strict separation of concerns across layers:
  - UI (HTML/templates) = structure only; no inline JS or business logic.
  - Style (CSS/SCSS) = presentation only; no behavior.
  - Client Logic (JavaScript) = interacts with APIs, handles state/UI events; no embedded HTML generation beyond templating and DOM updates.
  - Server Logic (e.g., Node/PHP) = API endpoints and domain logic; no HTML rendering in API services.
  - Data Layer (DB/cache/queues) = persistence and messaging; accessed only via service layer.
- File placement conventions:
  - Place JS under `assets/js/`, CSS under `assets/css/`, images under `assets/images/`.
  - Keep templates/views separate from server logic code.
- UI communicates with the system exclusively via APIs (no direct DB/file access from UI).
- Favor composition and small modules; avoid deeply nested directories.

---

## API & Microservices Standards

### Design Principles

- Follow REST API design principles (e.g., resource naming, versioning).
- Implement rate limiting and throttling for APIs.
- Use pagination for large datasets.
- Provide clear and concise API documentation (e.g., OpenAPI/Swagger).
- Include error handling and validation in API design.

### API documentation & Swagger/OpenAPI

- Maintain an authoritative OpenAPI (Swagger) spec at repo root (e.g., `wiki/api/openapi.yaml` or `openapi.yaml`).
- Expose machine-readable schema at `/openapi.json` or `/openapi.yaml` and interactive docs at `/docs` (Swagger UI or Redoc).
- Validate the OpenAPI spec in CI; fail builds on schema errors.
- Generate server/client stubs using OpenAPI Generator where practical to reduce drift.
- Document standard error schema, pagination, sorting, and filtering patterns.

#### HTTP response codes & error schema

- Every endpoint MUST document and return appropriate HTTP status codes with descriptions:
  - 200 OK for successful retrieval
  - 201 Created for successful creation (include Location header when applicable)
  - 202 Accepted for async operations
  - 204 No Content for successful operations with no body
  - 400 Bad Request for validation errors
  - 401 Unauthorized when authentication is required/invalid
  - 403 Forbidden when authenticated but not authorized
  - 404 Not Found for missing resources
  - 409 Conflict for versioning/state conflicts
  - 422 Unprocessable Entity for semantic validation failures
  - 429 Too Many Requests for rate limits
  - 5xx for server-side errors (prefer 500, 502, 503, 504 as appropriate)
- Define a standard error object (documented in OpenAPI):
  - `code` (string, machine-readable error code)
  - `message` (human-readable summary)
  - `details` (optional structured info e.g., field validation errors)
  - `traceId` (correlation ID for support)
- Ensure examples in OpenAPI include both success and error responses.

### Auth & API keys

- Support API keys as a first-class auth mechanism where appropriate (alongside OAuth2/JWT).
- Keys are environment-managed secrets; never hardcode. Store in secret managers or env vars only.
- Define key scope (read/write), rate limits/quotas, and expiration/rotation policies.
- Accept API keys via `Authorization: Bearer <key>` or `x-api-key` header (documented in OpenAPI).
- Log auth events (issued, rotated, revoked) with correlation IDs; never log full keys.

### Realtime & async interfaces

- For push-style updates, provide Webhooks, WebSockets, or Server-Sent Events (SSE) with auth.
- Publish event schemas for notifications; reuse domain event types from EDA where possible.
- Document retry, idempotency, and signature verification for webhooks.

### Service design and boundaries

- Prefer small, loosely coupled services with clear ownership and SLAs.
- Define service contracts first (API-first via OpenAPI); generate clients/servers where practical.
- Keep data ownership within a single service; expose via APIs rather than shared DB access.

### Versioning and compatibility

- Prefer backward-compatible changes; when breaking, introduce a new version (e.g., /v2).
- Deprecate with notices and timelines; provide migration guides in `wiki/`.

### Resilience and scalability

- Enforce timeouts, retries with backoff, and circuit breakers at clients and gateways.
- Support idempotency (Idempotency-Key header) for POST/PUT to enable safe retries.
- Use API Gateway for routing, auth, quotas, and monitoring; consider a service mesh for east-west traffic.

### Observability

- Emit structured logs (JSON), metrics, and traces (OpenTelemetry). Propagate correlation/trace IDs end-to-end.
- Expose health/readiness endpoints and SLOs; include error budgets in service docs.

### Security

- Adopt Zero Trust: mTLS between services, JWT/OAuth2 for authN/Z, least privilege for data access.
- Validate inputs at the edge; sanitize outputs; never expose stack traces to clients.

### Contract and consumer-driven testing

- Maintain contract tests (e.g., Pact) to ensure providers and consumers remain compatible.
- Automate contract verification in CI before deployment.

### Event-Driven Architecture (EDA)

- Use events to decouple services for asynchronous workflows; prefer at-least-once delivery with idempotent handlers.
- Standardize event schemas (e.g., CloudEvents) and version them; publish schema docs in `wiki/api/`.
- Implement the transactional outbox pattern for reliable event publishing with databases.
- Provide dead-letter queues (DLQs) and retry policies; include visibility into failure reasons.
- Avoid synchronous chains across many services; compose via events or sagas for long-running transactions.
- Prefer event-first design for workflows tolerant to eventual consistency; default to API sync only when strict request/response is required.

## AI & Intelligent Systems Standards

### AI-first architecture

- Design a thin AI abstraction layer so product code depends on interfaces, not vendors.
- Support multiple AI interfaces: chat/completions, embeddings, image, audio, tool/function-calling, RAG.
- Prefer event-driven workflows for long-running inference (enqueue → worker → callback/notification).
- All UI access to AI goes through API services; the UI never calls AI providers directly.

### Configurable AI providers

- Configure provider and model via environment variables and `ai.config.(json|yaml)` at repo root.
- Required keys (superset across providers):
  - `provider` (e.g., azureopenai|openai|anthropic|google|ollama|hf)
  - `endpoint`, `region` (if applicable), `model`, `apiKey` (via env), `organization` (optional)
  - runtime: `temperature`, `topP`, `maxTokens`, `seed`, `timeoutMs`, `retries`, `stream`
  - features: `enableTools`, `toolsAllowlist`, `safety` (categories, thresholds), `telemetry` (sampling)
- Hot-swap providers/models without code changes; use adapter pattern per provider.
- Provide a single API surface (REST and/or WebSocket) with stable contracts independent of provider.

### Guardrails & safety

- Implement input/output validation and PII redaction; never log raw secrets or full prompts.
- Apply content filters at the edge; block prompt injection via strict tool allowlists and schema validation.
- Version prompt templates; store in repo with change history and owners.

### Observability & evaluation

- Trace requests with OpenTelemetry; include model, tokens, latency, cache status (no PII).
- Maintain golden prompts and offline eval suites; require eval gates before model/prompt changes ship.
- Record prompt/template version in responses for reproducibility.

### Reliability & cost controls

- Provide fallback chains (primary → secondary model/provider) with circuit breakers.
- Implement caching (embeddings, RAG chunks, response caching where safe) with TTLs and invalidation.
- Enforce quotas and budgets; alert on anomaly spend or latency.
- Support per-tenant API keys for AI endpoints with scoped quotas and usage reporting.

### Data & RAG

- Separate retrieval layer from generation; use typed schemas and deterministic chunking.
- Track document/source lineage in responses; surface citations when applicable.
- Respect data residency and retention policies; purge on request.

---

## Troubleshooting

### Common Issues

- If Copilot suggests seems off-context, check file organization and naming
- For poor test suggestions, ensure test files follow naming conventions and are located in the correct directories.
- If security vulnerabilities are detected, prioritize fixing them before proceeding with other tasks.

### Getting Help

- Refer to personas for role-specific guidance
- Check instruction files for task-specific guidance
- Consult project documentation for additional context
- Review similar implementation for reference
