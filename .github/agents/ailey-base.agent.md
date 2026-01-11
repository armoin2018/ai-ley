---
name: 'AI-ley Base Agent'
description: 'Foundational behaviors, variables, and standards for all AI-ley agents'
keywords: [base, foundation, variables, standards, core, reference, mustache, configuration]
---

# AI-ley Base Agent

**Extends:** None (foundational agent)

This is the foundational agent that defines core behaviors, variable systems, and standards inherited by all AI-ley agents.

---

## Variable System

### Variable Sources

Variables are defined in `.github/ai-ley/ai-ley.yaml` and referenced using mustache syntax: `{{folders.plan}}`, `{{files.requirements}}`, etc.

### File Organization

- Organize code by feature or functionality
- Keep related files (tests, docs) close to source code
- Use consistent naming conventions
- Avoid deep directory nesting
- Follow established import/export patterns

### Documentation Standards

**Content Organization:**

- Project documentation in `{{folders.wiki}}` (GitHub Wiki)
- Client documentation in `{{folders.docs}}` (GitHub Pages)
- Architecture diagrams in `{{folders.architecture}}` using PlantUML
- API specifications in `{{folders.api}}` using Swagger/OpenAPI

**Formatting Rules (CRITICAL - Do Not Mix):**

1. **Sequences**: Use numbered format (`1.`, `2.`, `3.`) for ordered steps
2. **Checklists**: Use `[ ]` format for task tracking and completion items
3. **Lists**: Use `-` (dash) format for unordered items and bullet points
4. **Never stack or combine**: Do not use `- [ ]` or mix formats; choose one per context
5. **Clarity over complexity**: Single format per section reduces token count and improves AI parsing

**External Reference Pattern:**

- **No Embedded Code**: Do not embed scripts or examples in documentation/instruction files
- **External References**: Place code in subdirectories relative to the documentation file
- **Path Pattern**: `./(examples|scripts)/{{(agent|instruction|persona)name}}/`
- **Example Structure**:
  - Documentation: `.github/agents/ailey-tester.agent.md`
  - Examples: `.github/agents/examples/ailey-tester/`
  - Scripts: `.github/agents/scripts/ailey-tester/`
- **Linking**: Reference external files using relative markdown links: `[example](./examples/ailey-tester/unit-test-example.js)`

---

## Resource Management

### Instruction Files

Instruction files are indexed in `.github/ai-ley/indexes/instructions.md` with:

- Quality scores and effectiveness ratings
- Keywords for rapid selection
- Domain and use-case categorization

### Personas

Personas are cataloged in `.github/ai-ley/indexes/personas.md` organized by:

- Domain expertise (developer, architect, security, etc.)
- Skill specialization
- Role and responsibility scope

### Library Management

- **Approved Libraries**: Listed in `{{files.whitelist}}` with justification
- **Prohibited Modules**: Listed in `{{files.blacklist}}` with reasons
- **New Libraries**: Must be added to whitelist before use
- **License Priority**: Prefer MIT-licensed libraries

---

## Workflow Standards

### Requirements Management

- All requirements defined in `{{files.requirements}}`
- Each task references specific requirements
- Requirements follow user story format with acceptance criteria

### Change Tracking

- Progress tracked in `{{files.history}}`
- Version format: `YYYY.MM.DD-<#####>` (e.g., `2025.01.10-00001`)
- Changes documented in `{{files.changelog}}` (most recent first)
- Each entry includes: version, date, description, instructions used, personas used
- Difference files stored in `{{folders.diff}}` for patching/rollback

### Testing Requirements

- Unit tests for all new functions (≥80% coverage)
- Integration tests for component interactions
- Follow Arrange-Act-Assert (AAA) pattern
- Tests organized in `{{folders.tests}}` by type
- Include edge cases and error conditions

---

## Security & Performance

### Security Guidelines

- Validate all user input (client and server side)
- Use parameterized queries for database access
- Never hardcode credentials or API keys
- Encrypt sensitive data at rest and in transit
- Implement role-based access control (RBAC)
- Follow OWASP Top Ten security practices

### Performance Considerations

- Identify and eliminate bottlenecks
- Optimize database queries with proper indexing
- Implement caching strategies
- Minimize network requests and payload sizes
- Use asynchronous processing for long-running tasks
- Close connections and resources properly

---

## Error Handling & Logging

### Error Standards

- Return meaningful error messages
- Use structured error handling (try/catch/finally)
- Create custom error types for domain-specific errors
- Include error codes for programmatic handling
- Log all errors with sufficient context

### Logging Standards

- Use consistent logging levels (DEBUG, INFO, WARN, ERROR)
- Implement structured logging (JSON format)
- Include correlation IDs for request tracing
- Never log sensitive information (passwords, tokens, PII)
- Implement log rotation and retention policies

---

## API & Architecture Standards

### API Design

- Follow REST principles for resource naming and versioning
- Document with OpenAPI/Swagger specs in `{{folders.assets.schema}}`
- Implement rate limiting and pagination
- Use standard HTTP status codes appropriately
- Support API key authentication where applicable

### Layered Architecture

**Strict separation of concerns with API-based communication:**

1. **UI Layer (HTML)**: Structure only - no inline JavaScript, no inline CSS, no business logic
2. **Style Layer (CSS)**: Presentation only - separate files, no behavior, no dynamic logic
3. **Client Logic (JavaScript)**: API interaction, state management, UI events - calls TypeScript APIs
4. **Server Logic (TypeScript)**: REST/RESTful API endpoints, domain logic, business rules
5. **Data Layer**: Persistence accessed only through service layer APIs

**API Communication Requirements:**

- JavaScript → TypeScript: All calls through defined REST/RESTful APIs
- Follow REST principles: resource-based URLs, standard HTTP methods (GET, POST, PUT, DELETE)
- Use RESTful patterns when pure REST constraints don't apply
- No direct database access from client code
- All cross-layer communication through well-defined API contracts

---

## Compliance & Standards

### Legal Considerations

- Ensure code complies with licensing requirements
- Prioritize MIT-licensed libraries and frameworks
- Avoid copyrighted, proprietary, or unlicensed code
- Follow fair use guidelines for third-party content

### Industry Standards

- Follow security best practices (OWASP, NIST)
- Adhere to relevant regulations (GDPR, HIPAA where applicable)
- Implement accessibility standards (WCAG)
- Use semantic versioning for releases

---

version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 4.5
