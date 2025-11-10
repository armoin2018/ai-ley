---
agentMode: general
applyTo: general
author: AI-LEY
description: Generate idempotent project scaffolds with architecture diagrams, schemas, and comprehensive documentation from PLAN.md
extensions:
  - .md
  - .puml
  - .mmd
  - .json
guidelines: Follow AI-LEY project standards for scaffold generation, architecture documentation, and file organization
instructionType: general
keywords:
  [scaffold, architecture, diagrams, schemas, planning, infrastructure, project-setup, idempotent]
lastUpdated: '2025-11-09T00:00:00.000000'
summaryScore: 5.0
title: Project Scaffold Generator
version: 1.0.0
---

# Copilot Command: Project Scaffold Generator

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `{{files.instructions}}` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A primary plan document at `{{files.plan}}`
- Index files in `{{folders.instructions}}/../indexes/*.md`
- Existing instructions, personas, and agents under `.ai-ley/shared/**`
- A mode variable (`plan`, `apply`, or `dry-run`)

Produce:

- Idempotent project scaffold aligned to declared technology stacks
- Architecture diagrams (PlantUML `.puml` and Mermaid `.mmd`)
- Schema files (RDBMS, OpenAPI, NoSQL, Kafka) in JSON format
- Dependency manifests and version documentation
- Updated/created instructions, personas, and agent configurations
- Comprehensive documentation and validation reports
- All artifacts under `.project/` following AI-LEY conventions

## Command

You are an expert software architect and DevOps engineer specializing in project scaffolding, infrastructure design, and automated code generation.

### 1. **Initialization & Context Gathering**

**Parse Input Variables**:

- `mode` = `{{mode|apply}}` (default: `apply`)
- `project_root` = `{{project_root|.}}` (default: `.`)
- `plan_path` = `{{plan_path|.project/PLAN.md}}` (default: `.project/PLAN.md`)
- `indexes_glob` = `{{indexes_glob|.ai-ley/shared/indexes/*.md}}` (default: `.ai-ley/shared/indexes/*.md`)
- `diag_out` = `{{diag_out|.project/architecture}}` (default: `.project/architecture`)
- `schemas_out` = `{{schemas_out|.project/architecture}}` (default: `.project/architecture`)
- `docs_out` = `{{docs_out|.project/docs}}` (default: `.project/docs`)

**Load Authoritative Sources** (in precedence order):

1. Primary plan: `{{plan_path}}`
2. Index files matching `{{indexes_glob}}`:
   - `.ai-ley/shared/indexes/instructions.md`
   - `.ai-ley/shared/indexes/personas.md`
   - `.ai-ley/shared/indexes/prompts.md`
3. Existing instructions: `.ai-ley/shared/instructions/**/*.md`
4. Existing personas: `.ai-ley/shared/personas/**/*.md`
5. Existing agents: `.ai-ley/shared/agents/**/*.md` (if applicable)

**Validate Prerequisites**:

- Verify `{{plan_path}}` exists and is readable
- Check index files are accessible
- Confirm output directories can be created
- Validate mode parameter is one of: `plan`, `apply`, `dry-run`

### 2. **Resolution & Gap Analysis**

**Identify Referenced Resources**:

- Parse `{{plan_path}}` for references to:
  - Instructions (e.g., `{{folders.instructions}}/path/to/instruction.md`)
  - Personas (e.g., `{{folders.personas}}/role/expert.md`)
  - Technology stacks, frameworks, and tools
  - Architecture patterns and design decisions

**Gap Detection**:

- For each referenced instruction/persona/agent:
  - Check if file exists at specified path
  - If missing, query indexes for best match using:
    - Keyword matching
    - Description similarity
    - Quality/summary scores
  - If still absent, mark for creation using existing templates

**Create Missing Resources**:

- Use templates from `{{folders.templates.instructions}}`, `{{folders.templates.personas}}`, etc.
- Follow naming conventions: kebab-case, descriptive filenames
- Include proper YAML frontmatter with metadata
- Add brief synopsis and version information
- **Update indexes atomically**:
  - Append new entries (maintain alphabetical order)
  - Include brief synopsis, version, and quality score
  - Preserve existing entries

**Document Assumptions**:

- Create/update `.project/ASSUMPTIONS.md` with:
  - Explicitly documented assumptions where plan is incomplete
  - Rationale for resource selections
  - Technology stack decisions and trade-offs
  - Default values and configuration choices

### 3. **Idempotency & Safety Mechanisms**

**File Collision Handling**:

- Before writing any file, check if it exists
- If file exists and differs from generated content:
  - Write to sibling `*-generated` file (e.g., `config.json` → `config-generated.json`)
  - Document diff in `.project/GENERATED_CHANGES.md` with:
    - File path
    - Timestamp
    - Brief description of differences
    - Action taken (preserved existing, created sibling)

**Machine-Generated Artifact Headers**:

All generated files MUST include a header comment in appropriate format:

```
// generated-by: ai-ley scaffold | timestamp: 2025-11-09T12:34:56Z | source: .project/PLAN.md
```

For different file types:

- `.md`: Use HTML comment: `<!-- generated-by: ... -->`
- `.json`: Include in root object: `"_generated": {"by": "ai-ley scaffold", ...}`
- `.puml`: Use PlantUML comment: `' generated-by: ...`
- `.mmd`: Use Mermaid comment: `%% generated-by: ...`
- `.yaml`/`.yml`: Use YAML comment: `# generated-by: ...`

**Version Tracking**:

- Track all generated artifacts in `.project/GENERATED_CHANGES.md`
- Include version references from `{{files.plan}}`
- Support rollback by maintaining generation history

### 4. **Architecture Diagram Generation**

**Determine Applicable Diagrams**:

Based on technology stack and requirements in `{{files.plan}}`, generate relevant diagrams:

**Create Under `{{diag_out}}/`**:

1. **Sequence Diagrams** (`sequence-{feature}.puml` and `.mmd`)

   - Key user flows and interactions
   - Authentication/authorization sequences
   - API request/response flows
   - Error handling scenarios

2. **Data Flow Diagrams** (`data-flow.puml` and `.mmd`)

   - Information flow between components
   - Data transformation pipelines
   - Integration points with external systems

3. **Interaction Diagrams** (`interaction-{context}.puml` and `.mmd`)

   - User-system interactions
   - Component collaboration patterns
   - Event-driven workflows

4. **Entity Relationship Diagrams** (`erd.puml` and `.mmd`)

   - Database schema visualization
   - Relationships and cardinality
   - Key constraints and indexes

5. **Use-Case Diagrams** (`use-case.puml` and `.mmd`)

   - Actor-system interactions
   - Feature boundaries
   - System capabilities

6. **Deployment Diagrams** (`deployment.puml` and `.mmd`)

   - Infrastructure topology
   - Server/container placement
   - Network boundaries and security zones

7. **Component Diagrams** (`component.puml` and `.mmd`)

   - System decomposition
   - Component dependencies
   - Interface contracts

8. **Class Diagrams** (`class-{module}.puml` and `.mmd`)

   - Object-oriented design
   - Class relationships and hierarchies
   - Method and property definitions

9. **Activity Diagrams** (`activity-{process}.puml` and `.mmd`)

   - Business process flows
   - Decision points and branches
   - Parallel processing paths

10. **State Machine Diagrams** (`state-{entity}.puml` and `.mmd`)

    - Object lifecycle states
    - Transition triggers and guards
    - State-based behavior

11. **C4 Model Diagrams**:

    - **Context** (`c4-context.puml` and `.mmd`): System in environment
    - **Container** (`c4-container.puml` and `.mmd`): High-level tech choices
    - **Component** (`c4-component.puml` and `.mmd`): Component decomposition
    - **Code** (optional, `c4-code-{module}.puml`): Class-level detail (only if needed)

12. **Package Diagrams** (`package-dependencies.puml` and `.mmd`)
    - Module organization
    - Package dependencies
    - Version dependencies (resolve conflicts)
    - Dependency graph visualization

**Diagram Standards**:

- Use consistent theming: `!theme plain` for PlantUML
- Include descriptive titles and legends
- Add notes for complex interactions
- Use semantic colors and styling
- Ensure diagrams are self-documenting

**Render Instructions**:

Create `{{diag_out}}/RENDER.md`:

```markdown
# Architecture Diagram Rendering

## PlantUML Diagrams

Render `.puml` files using PlantUML:

\`\`\`bash

# Install PlantUML

brew install plantuml # macOS

# or download from https://plantuml.com/

# Render individual diagram

plantuml sequence-auth.puml

# Render all diagrams

plantuml \*.puml

# Generate PNG with custom DPI

plantuml -Sdpi=300 -tpng \*.puml
\`\`\`

## Mermaid Diagrams

Render `.mmd` files using Mermaid CLI:

\`\`\`bash

# Install Mermaid CLI

npm install -g @mermaid-js/mermaid-cli

# Render individual diagram

mmdc -i data-flow.mmd -o data-flow.png

# Render all diagrams

for file in \*.mmd; do mmdc -i "$file" -o "${file%.mmd}.png"; done

# Custom theme and background

mmdc -i diagram.mmd -o diagram.svg -t dark -b transparent
\`\`\`

## Automation

Add to CI/CD pipeline or use pre-commit hooks to auto-generate images.
```

### 5. **Schema & Specification Generation**

**Only generate schemas applicable to the technology stack identified in `{{files.plan}}`**:

#### 5.1 Relational Database Schemas

**If RDBMS is in stack**, create `{{schemas_out}}/schema-rdbms.json`:

```json
{
  "_generated": {
    "by": "ai-ley scaffold",
    "timestamp": "2025-11-09T12:34:56Z",
    "source": ".project/PLAN.md"
  },
  "database": "postgresql",
  "version": "15.0",
  "tables": [
    {
      "name": "users",
      "description": "User accounts and authentication",
      "columns": [
        {
          "name": "id",
          "type": "UUID",
          "nullable": false,
          "primary_key": true,
          "default": "gen_random_uuid()"
        },
        {
          "name": "email",
          "type": "VARCHAR(255)",
          "nullable": false,
          "unique": true
        },
        {
          "name": "password_hash",
          "type": "VARCHAR(255)",
          "nullable": false
        },
        {
          "name": "created_at",
          "type": "TIMESTAMP",
          "nullable": false,
          "default": "CURRENT_TIMESTAMP"
        }
      ],
      "indexes": [
        {
          "name": "idx_users_email",
          "columns": ["email"],
          "unique": true
        }
      ],
      "constraints": []
    }
  ],
  "foreign_keys": [
    {
      "from_table": "profiles",
      "from_column": "user_id",
      "to_table": "users",
      "to_column": "id",
      "on_delete": "CASCADE",
      "on_update": "CASCADE",
      "rationale": "Profile is dependent on user account; cascade deletes maintain referential integrity"
    }
  ]
}
```

**Include DDL Preview** in `{{schemas_out}}/schema-rdbms-ddl.sql`:

```sql
-- generated-by: ai-ley scaffold | timestamp: 2025-11-09T12:34:56Z | source: .project/PLAN.md

-- Users table: User accounts and authentication
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX idx_users_email ON users(email);

-- Foreign key rationale notes included in comments
```

**Pretty-print version**: Create `{{schemas_out}}/schema-rdbms-pretty.json` with indentation.

#### 5.2 API Specifications (OpenAPI 3.1)

**If REST API is in stack**, create `{{schemas_out}}/openapi-spec.json`:

```json
{
  "openapi": "3.1.0",
  "info": {
    "title": "Project API",
    "version": "1.0.0",
    "description": "API specification for project services"
  },
  "_generated": {
    "by": "ai-ley scaffold",
    "timestamp": "2025-11-09T12:34:56Z",
    "source": ".project/PLAN.md"
  },
  "servers": [
    {
      "url": "https://api.example.com/v1",
      "description": "Production server"
    }
  ],
  "components": {
    "schemas": {
      "User": {
        "type": "object",
        "required": ["id", "email"],
        "properties": {
          "id": { "type": "string", "format": "uuid" },
          "email": { "type": "string", "format": "email" },
          "created_at": { "type": "string", "format": "date-time" }
        }
      },
      "Error": {
        "type": "object",
        "required": ["code", "message"],
        "properties": {
          "code": { "type": "string" },
          "message": { "type": "string" },
          "details": { "type": "object" },
          "traceId": { "type": "string" }
        }
      }
    },
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "bearerFormat": "JWT"
      },
      "apiKey": {
        "type": "apiKey",
        "in": "header",
        "name": "X-API-Key"
      }
    }
  },
  "paths": {
    "/users": {
      "get": {
        "summary": "List users",
        "operationId": "listUsers",
        "security": [{ "bearerAuth": [] }],
        "parameters": [
          {
            "name": "limit",
            "in": "query",
            "schema": { "type": "integer", "default": 20, "maximum": 100 }
          }
        ],
        "responses": {
          "200": {
            "description": "Successful response",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "properties": {
                    "data": {
                      "type": "array",
                      "items": { "$ref": "#/components/schemas/User" }
                    }
                  }
                },
                "examples": {
                  "success": {
                    "value": {
                      "data": [
                        {
                          "id": "123e4567-e89b-12d3-a456-426614174000",
                          "email": "user@example.com",
                          "created_at": "2025-11-09T12:00:00Z"
                        }
                      ]
                    }
                  }
                }
              }
            }
          },
          "401": {
            "description": "Unauthorized",
            "content": {
              "application/json": {
                "schema": { "$ref": "#/components/schemas/Error" },
                "examples": {
                  "unauthorized": {
                    "value": {
                      "code": "UNAUTHORIZED",
                      "message": "Authentication required",
                      "traceId": "abc-123-def-456"
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
```

**Include standard HTTP status codes**:

- 200 OK, 201 Created, 204 No Content
- 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found
- 409 Conflict, 422 Unprocessable Entity, 429 Too Many Requests
- 500 Internal Server Error, 502 Bad Gateway, 503 Service Unavailable

**Pretty-print version**: Create `{{schemas_out}}/openapi-spec-pretty.json`.

#### 5.3 NoSQL Schemas

**If NoSQL database is in stack**, create `{{schemas_out}}/{collection}-schema-nosql.json`:

```json
{
  "_generated": {
    "by": "ai-ley scaffold",
    "timestamp": "2025-11-09T12:34:56Z",
    "source": ".project/PLAN.md"
  },
  "database": "mongodb",
  "collection": "users",
  "validation": {
    "$jsonSchema": {
      "bsonType": "object",
      "required": ["email", "createdAt"],
      "properties": {
        "_id": { "bsonType": "objectId" },
        "email": {
          "bsonType": "string",
          "pattern": "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        },
        "passwordHash": { "bsonType": "string" },
        "profile": {
          "bsonType": "object",
          "properties": {
            "firstName": { "bsonType": "string" },
            "lastName": { "bsonType": "string" }
          }
        },
        "createdAt": { "bsonType": "date" },
        "updatedAt": { "bsonType": "date" }
      }
    }
  },
  "indexes": [{ "key": { "email": 1 }, "unique": true }, { "key": { "createdAt": -1 } }],
  "sample_documents": [
    {
      "_id": "507f1f77bcf86cd799439011",
      "email": "user@example.com",
      "passwordHash": "$2b$10$...",
      "profile": {
        "firstName": "John",
        "lastName": "Doe"
      },
      "createdAt": "2025-11-09T12:00:00Z",
      "updatedAt": "2025-11-09T12:00:00Z"
    }
  ]
}
```

**Pretty-print version**: Create `{{schemas_out}}/{collection}-schema-nosql-pretty.json`.

#### 5.4 Kafka Schema Registry

**If Kafka is in stack**, create `{{schemas_out}}/{topic}-schema-kafka.json`:

```json
{
  "_generated": {
    "by": "ai-ley scaffold",
    "timestamp": "2025-11-09T12:34:56Z",
    "source": ".project/PLAN.md"
  },
  "subject": "user-events-value",
  "topic": "user-events",
  "format": "AVRO",
  "compatibility": "BACKWARD",
  "naming_strategy": "TopicNameStrategy",
  "schema": {
    "type": "record",
    "name": "UserEvent",
    "namespace": "com.example.events",
    "fields": [
      {
        "name": "eventId",
        "type": "string",
        "doc": "Unique event identifier (UUID)"
      },
      {
        "name": "userId",
        "type": "string",
        "doc": "User identifier"
      },
      {
        "name": "eventType",
        "type": {
          "type": "enum",
          "name": "EventType",
          "symbols": ["CREATED", "UPDATED", "DELETED"]
        }
      },
      {
        "name": "timestamp",
        "type": "long",
        "logicalType": "timestamp-millis"
      },
      {
        "name": "payload",
        "type": ["null", "string"],
        "default": null,
        "doc": "JSON-encoded event payload"
      }
    ]
  }
}
```

**Supported formats**: AVRO, JSON Schema, Protobuf
**Compatibility modes**: BACKWARD, FORWARD, FULL, NONE

**Pretty-print version**: Create `{{schemas_out}}/{topic}-schema-kafka-pretty.json`.

### 6. **Dependency Management**

**Create Consolidated Manifest** at `.project/dependencies/MANIFEST.md`:

```markdown
# Dependency Manifest

<!-- generated-by: ai-ley scaffold | timestamp: 2025-11-09T12:34:56Z | source: .project/PLAN.md -->

## Runtime Dependencies

### Node.js / JavaScript

- `express@^4.18.0` - Web framework
- `pg@^8.11.0` - PostgreSQL client
- `jsonwebtoken@^9.0.0` - JWT authentication

### Python

- `fastapi==0.104.0` - API framework
- `sqlalchemy==2.0.23` - ORM
- `pydantic==2.5.0` - Data validation

## Build Dependencies

### Node.js

- `typescript@^5.3.0` - Type safety
- `esbuild@^0.19.0` - Fast bundler

### Python

- `pytest==7.4.3` - Testing framework
- `black==23.11.0` - Code formatter

## Development Dependencies

### Node.js

- `eslint@^8.54.0` - Linter
- `prettier@^3.1.0` - Code formatter

### Python

- `mypy==1.7.0` - Type checker
- `ruff==0.1.6` - Fast linter

## Transitive Dependency Conflicts

### Conflict 1: lodash version mismatch

- **Package A** requires `lodash@^4.17.0`
- **Package B** requires `lodash@^3.10.0`
- **Resolution Option 1**: Force `lodash@^4.17.21` (latest 4.x, backward compatible)
  - **Tradeoff**: May have minor breaking changes for Package B
- **Resolution Option 2**: Use separate instances (npm overrides/resolutions)
  - **Tradeoff**: Increased bundle size
- **Recommendation**: Option 1 (test Package B thoroughly)

## Version Pinning Rationale

See `versions.lock.advisory.md` for detailed explanations.
```

**Create Version Lock Advisory** at `.project/dependencies/versions.lock.advisory.md`:

```markdown
# Version Lock Advisory

<!-- generated-by: ai-ley scaffold | timestamp: 2025-11-09T12:34:56Z | source: .project/PLAN.md -->

## Why Specific Versions Are Pinned

### express@4.18.2 (exact pin)

- **Rationale**: Security vulnerability CVE-2024-XXXXX in 4.18.0-4.18.1
- **Review Date**: 2025-12-01
- **Action**: Monitor for 4.19.0 release with fix

### typescript@^5.3.0 (caret range)

- **Rationale**: Allow minor updates for bug fixes while staying on 5.x
- **Constraint**: Major version 5 required for specific language features
- **Review Date**: Ongoing

### pg@8.11.0 (exact pin)

- **Rationale**: Breaking changes in 8.12.0 affecting connection pooling
- **Action**: Update application code before upgrading
- **Review Date**: 2025-11-15

## Dependency Update Policy

- **Security patches**: Apply immediately
- **Minor updates**: Review weekly, apply after testing
- **Major updates**: Quarterly review, plan migration
```

### 7. **Validation & Quality Checks**

**JSON Schema Validators**:

Create `{{schemas_out}}/validators/README.md`:

```markdown
# Schema Validation

## JSON Schema Validation

Validate generated schemas against JSON Schema drafts:

\`\`\`bash

# Install validator

npm install -g ajv-cli

# Validate OpenAPI spec

ajv validate -s openapi-3.1-schema.json -d openapi-spec.json

# Validate NoSQL schemas

ajv validate -s json-schema-draft-07.json -d users-schema-nosql.json
\`\`\`

## OpenAPI Linting

Lint OpenAPI specifications:

\`\`\`bash

# Install OpenAPI linter

npm install -g @stoplight/spectral-cli

# Lint with default rules

spectral lint openapi-spec.json

# Custom ruleset

spectral lint openapi-spec.json --ruleset .spectral.yaml
\`\`\`

## Validation Results Summary

- ✅ All schemas pass JSON Schema validation
- ✅ OpenAPI spec passes spectral linting
- ⚠️ Minor style warnings (non-blocking)
```

### 8. **Documentation Generation**

**Create Scaffold README** at `{{docs_out}}/Scaffold-README.md`:

```markdown
# Project Scaffold Documentation

<!-- generated-by: ai-ley scaffold | timestamp: 2025-11-09T12:34:56Z | source: .project/PLAN.md -->

## Purpose

This scaffold was automatically generated from `{{files.plan}}` to provide a complete, idempotent project structure aligned with the declared technology stacks.

## Generated Artifacts

### Architecture Diagrams

- **Location**: `{{diag_out}}/`
- **Formats**: PlantUML (`.puml`), Mermaid (`.mmd`)
- **Lifecycle Owner**: Architecture team
- **How to Use**: See `{{diag_out}}/RENDER.md` for rendering instructions
- **Purpose**: Visualize system structure, interactions, and data flows

### Database Schemas

- **Location**: `{{schemas_out}}/schema-rdbms.json`
- **Lifecycle Owner**: Database team
- **How to Use**: Use DDL preview to create database tables
- **Purpose**: Define relational data model and constraints

### API Specifications

- **Location**: `{{schemas_out}}/openapi-spec.json`
- **Lifecycle Owner**: API team
- **How to Use**: Import into Swagger UI or generate client/server code
- **Purpose**: Document REST API contracts and examples

### Dependency Manifests

- **Location**: `.project/dependencies/`
- **Lifecycle Owner**: DevOps team
- **How to Use**: Reference for package installation and conflict resolution
- **Purpose**: Track dependencies, versions, and conflicts

## Lifecycle Management

### Updating the Scaffold

1. Update `{{files.plan}}` with new requirements or changes
2. Re-run scaffold command: `scaffold` (or specific mode)
3. Review generated changes in `.project/GENERATED_CHANGES.md`
4. Merge `-generated` files as needed

### Idempotency Guarantees

- Existing hand-edited files are **never overwritten**
- Conflicts create sibling `-generated` files
- All changes are tracked in `.project/GENERATED_CHANGES.md`

### Maintenance Schedule

- **Weekly**: Review dependency updates and security advisories
- **Monthly**: Validate architecture diagrams against implementation
- **Quarterly**: Update schemas for new features and data models

## Next Steps

1. Review generated diagrams and schemas
2. Validate against project requirements
3. Update `.project/ASSUMPTIONS.md` if needed
4. Implement features using generated artifacts as reference
5. Keep diagrams and schemas in sync with code changes
```

**Create Assumptions Document** at `.project/ASSUMPTIONS.md`:

```markdown
# Project Assumptions

<!-- generated-by: ai-ley scaffold | timestamp: 2025-11-09T12:34:56Z | source: .project/PLAN.md -->

## Technology Stack Assumptions

### Database

- **Assumption**: PostgreSQL 15.x for relational data
- **Rationale**: Plan specified RDBMS with ACID compliance
- **Alternative**: MySQL 8.x if licensing is a concern

### API Framework

- **Assumption**: REST API with JSON payloads
- **Rationale**: Plan mentioned API endpoints but not specific protocol
- **Alternative**: GraphQL if client requirements change

### Authentication

- **Assumption**: JWT-based authentication with refresh tokens
- **Rationale**: Standard for stateless API authentication
- **Alternative**: OAuth2 for third-party integrations

## Architecture Assumptions

### Deployment Model

- **Assumption**: Container-based deployment (Docker/Kubernetes)
- **Rationale**: Scalability requirements in plan
- **Alternative**: Serverless if traffic is highly variable

### Data Storage

- **Assumption**: Single PostgreSQL instance with read replicas
- **Rationale**: Cost-effectiveness for initial phase
- **Alternative**: Distributed database if global presence required

## Default Configuration Values

### API Rate Limiting

- **Default**: 100 requests/minute per user
- **Rationale**: Balance between usability and abuse prevention

### Session Timeout

- **Default**: 24 hours for JWT tokens
- **Rationale**: Standard security practice

### Cache TTL

- **Default**: 5 minutes for frequently accessed data
- **Rationale**: Balance between freshness and performance

## Incomplete Plan Areas

### Monitoring & Observability

- **Gap**: Plan doesn't specify monitoring tools
- **Assumption**: Prometheus + Grafana for metrics, ELK for logs
- **Action**: Confirm with stakeholders

### CI/CD Pipeline

- **Gap**: Deployment automation not detailed
- **Assumption**: GitHub Actions for CI, ArgoCD for CD
- **Action**: Review with DevOps team
```

**Create Generated Changes Tracker** at `.project/GENERATED_CHANGES.md`:

```markdown
# Generated Changes Log

<!-- generated-by: ai-ley scaffold | timestamp: 2025-11-09T12:34:56Z | source: .project/PLAN.md -->

## 2025-11-09T12:34:56Z - Initial Scaffold

### Files Created

- `.project/architecture/*.puml` (12 diagrams)
- `.project/architecture/*.mmd` (12 diagrams)
- `.project/architecture/schema-rdbms.json`
- `.project/architecture/openapi-spec.json`
- `.project/dependencies/MANIFEST.md`
- `.project/dependencies/versions.lock.advisory.md`
- `.project/docs/Scaffold-README.md`
- `.project/ASSUMPTIONS.md`

### Files Preserved (Existing)

- None (initial generation)

### Files with Conflicts

- None (initial generation)

### Indexes Updated

- `.ai-ley/shared/indexes/instructions.md` - Added 3 new entries
- `.ai-ley/shared/indexes/personas.md` - Added 2 new entries

### Missing Resources Created

- `{{folders.instructions}}/database/postgresql-best-practices.md`
- `{{folders.personas}}/architect/api-architect.md`
```

### 9. **Mode-Specific Execution**

#### Mode: `plan` (Analyze Only)

**When `mode=plan`**:

1. Parse `{{files.plan}}` and analyze requirements
2. Identify all artifacts that would be generated
3. Detect gaps and missing resources
4. **Do NOT write any files**
5. Output proposed changes to console and `.project/SCAFFOLD_PLAN.md`:

```markdown
# Scaffold Execution Plan

## Proposed Artifacts

### Architecture Diagrams (24 files)

- Sequence diagrams: 3 files
- Data flow diagrams: 2 files
- ERD: 1 file
- C4 diagrams: 4 files
- ...

### Schemas (4 files)

- RDBMS schema JSON (+ DDL + pretty)
- OpenAPI spec JSON (+ pretty)

### Documentation (5 files)

- Scaffold README
- ASSUMPTIONS.md
- MANIFEST.md
- versions.lock.advisory.md
- RENDER.md

### Missing Resources to Create

- `{{folders.instructions}}/api/rest-design.md`
- `{{folders.personas}}/developer/backend-engineer.md`

## Estimated Time

- Generation: ~2 minutes
- Validation: ~1 minute
- Total: ~3 minutes

## Next Steps

1. Review proposed artifacts
2. Update `{{files.plan}}` if needed
3. Run with `mode=apply` to generate files
```

#### Mode: `dry-run` (Simulate)

**When `mode=dry-run`**:

1. Perform all generation steps
2. **Do NOT write files to disk**
3. Output diffs to console and `.project/GENERATED_CHANGES.md`
4. Show what would be created/modified:

```markdown
# Dry-Run Results

## Files that WOULD be created:

### .project/architecture/sequence-auth.puml

\`\`\`diff

- @startuml
- !theme plain
- title Authentication Sequence
- ...
- @enduml
  \`\`\`

### .project/architecture/schema-rdbms.json

\`\`\`diff

- {
- "\_generated": {...},
- "database": "postgresql",
- ...
- }
  \`\`\`

## Files that WOULD be modified:

- None (initial generation)

## Files that WOULD be preserved:

- None (no conflicts)
```

#### Mode: `apply` (Execute, Default)

**When `mode=apply`**:

1. Generate all artifacts as specified
2. Write files to disk following idempotency rules
3. Update indexes atomically
4. Create documentation
5. Generate final report at `.project/REPORT.md`

### 10. **Final Report Generation**

**Create Comprehensive Report** at `.project/REPORT.md`:

```markdown
# Scaffold Execution Report

<!-- generated-by: ai-ley scaffold | timestamp: 2025-11-09T12:34:56Z | source: .project/PLAN.md -->

## Execution Summary

- **Mode**: apply
- **Start Time**: 2025-11-09T12:34:56Z
- **End Time**: 2025-11-09T12:37:23Z
- **Duration**: 2m 27s
- **Status**: ✅ Success

## Inputs Used

### Primary Plan

- **Path**: `.project/PLAN.md`
- **Size**: 45 KB
- **Last Modified**: 2025-11-09T10:00:00Z

### Indexes

- `.ai-ley/shared/indexes/instructions.md` (127 entries)
- `.ai-ley/shared/indexes/personas.md` (89 entries)
- `.ai-ley/shared/indexes/prompts.md` (42 entries)

### Existing Resources

- Instructions: 127 files
- Personas: 89 files
- Agents: 0 files

## Assumptions Made

### Technology Stack

- Database: PostgreSQL 15.x (inferred from RDBMS requirement)
- API: REST with JSON (default for web services)
- Authentication: JWT tokens (standard practice)

See `.project/ASSUMPTIONS.md` for full details.

## Files Written

### Architecture Diagrams (24 files)

- ✅ 12 PlantUML diagrams (`.puml`)
- ✅ 12 Mermaid diagrams (`.mmd`)

### Schemas (8 files)

- ✅ RDBMS schema (JSON + DDL + pretty)
- ✅ OpenAPI spec (JSON + pretty)
- ✅ NoSQL schemas (JSON + pretty, 2 collections)

### Dependencies (2 files)

- ✅ MANIFEST.md
- ✅ versions.lock.advisory.md

### Documentation (4 files)

- ✅ Scaffold-README.md
- ✅ ASSUMPTIONS.md
- ✅ GENERATED_CHANGES.md
- ✅ RENDER.md

### Resources Created (5 files)

- ✅ `{{folders.instructions}}/database/postgresql-best-practices.md`
- ✅ `{{folders.instructions}}/api/rest-design-patterns.md`
- ✅ `{{folders.personas}}/architect/database-architect.md`
- ✅ `{{folders.personas}}/architect/api-architect.md`
- ✅ `{{folders.personas}}/engineer/devops-engineer.md`

### Indexes Updated (2 files)

- ✅ `.ai-ley/shared/indexes/instructions.md` (+3 entries)
- ✅ `.ai-ley/shared/indexes/personas.md` (+2 entries)

## Files Preserved

- None (initial generation with no conflicts)

## Next Actions

### Immediate (Today)

1. ✅ Review generated architecture diagrams
2. ✅ Validate schemas against requirements
3. ⏳ Set up diagram rendering pipeline
4. ⏳ Import OpenAPI spec into Swagger UI

### Short-term (This Week)

1. ⏳ Implement database migrations from DDL
2. ⏳ Generate API client/server code from OpenAPI
3. ⏳ Review and resolve dependency conflicts
4. ⏳ Update assumptions document with stakeholder input

### Long-term (This Month)

1. ⏳ Keep diagrams in sync with implementation
2. ⏳ Set up automated schema validation in CI/CD
3. ⏳ Review dependency update policy
4. ⏳ Plan for C4 Code-level diagrams (if needed)

## Validation Status

### JSON Schema Validation

- ✅ All schemas valid against JSON Schema Draft 2020-12
- ✅ OpenAPI spec valid against OpenAPI 3.1.0

### Linting Results

- ✅ OpenAPI spec passes spectral linting (0 errors, 2 warnings)
- ⚠️ Warning: Missing response examples for 404 errors (non-blocking)

### Diagram Rendering

- ⏳ PlantUML diagrams (not rendered yet - see RENDER.md)
- ⏳ Mermaid diagrams (not rendered yet - see RENDER.md)

## Deliverables Checklist

- [x] Updated/created instructions/personas/agents
- [x] Updated indexes
- [x] Architecture diagrams (.puml / .mmd)
- [x] RDBMS schema JSON (+ DDL preview)
- [x] OpenAPI 3.1 spec
- [x] NoSQL schema(s)
- [ ] Kafka schema(s) (not applicable to stack)
- [x] MANIFEST.md and versions.lock.advisory.md
- [x] RENDER.md and REPORT.md
- [x] Scaffold-README.md and ASSUMPTIONS.md
- [x] GENERATED_CHANGES.md
```

### 11. **Conventions & Standards**

**File Naming**:

- Use kebab-case for filenames: `user-management.md`
- Use descriptive names: `sequence-authentication.puml` not `seq1.puml`
- Group related files with prefixes: `c4-context.puml`, `c4-container.puml`

**Path Standards**:

- Use POSIX paths (forward slashes)
- Always use absolute paths or variable references
- Never use `..` relative paths

**File Encoding**:

- UTF-8 encoding for all text files
- LF line endings (Unix style)
- No BOM (Byte Order Mark)

**JSON Standards**:

- Minified JSON for consumption: `schema.json`
- Pretty-printed JSON for readability: `schema-pretty.json` (2-space indent)
- Include `_generated` metadata in root object

**Diagram Standards**:

- Both PlantUML and Mermaid for each diagram type
- Consistent naming: `{type}-{context}.puml` and `{type}-{context}.mmd`
- Include comments with purpose and ownership

## Examples

### Example 1: Basic Usage (Default Mode)

**Command**:

```
scaffold
```

**Expected Output**:

```
✅ Scaffold generation complete

Files created:
- 24 architecture diagrams (.puml and .mmd)
- 8 schema files (JSON + pretty versions)
- 6 documentation files
- 5 new instruction/persona files

Indexes updated:
- +3 instructions
- +2 personas

See .project/REPORT.md for full details.
```

### Example 2: Plan Mode

**Command**:

```
scaffold mode=plan
```

**Expected Output**:

```
📋 Scaffold execution plan generated

Proposed artifacts:
- Architecture diagrams: 24 files
- Schemas: 8 files
- Documentation: 6 files
- New resources: 5 files

No files written. See .project/SCAFFOLD_PLAN.md for details.

Next: Run with mode=apply to generate files
```

### Example 3: Dry-Run Mode

**Command**:

```
scaffold mode=dry-run
```

**Expected Output**:

```
🔍 Dry-run simulation complete

Would create:
- Architecture diagrams: 24 files
- Schemas: 8 files
- Documentation: 6 files

Diffs available in .project/GENERATED_CHANGES.md

No files written to disk.
```

### Example 4: Custom Paths

**Command**:

```
scaffold plan_path=.project/custom-plan.md diag_out=docs/diagrams
```

**Expected Output**:

```
✅ Scaffold generation complete

Using custom paths:
- Plan: .project/custom-plan.md
- Diagrams: docs/diagrams/

See .project/REPORT.md for details.
```

## Notes

### Important Considerations

- **Idempotency**: Running scaffold multiple times is safe; existing files are preserved
- **Conflict Resolution**: Hand-edited files are never overwritten; conflicts create `-generated` siblings
- **Index Updates**: Indexes are updated atomically in alphabetical order
- **Validation**: All schemas are validated before writing
- **Performance**: Large projects may take several minutes to generate all artifacts
- **Dependencies**: Requires PlantUML and Mermaid CLI for diagram rendering (optional)

### Best Practices

- **Review ASSUMPTIONS.md**: Always review and validate assumptions before proceeding with implementation
- **Keep Diagrams Updated**: Architecture diagrams should evolve with code; re-run scaffold after major changes
- **Validate Schemas**: Run validation tools (ajv, spectral) in CI/CD pipelines
- **Track Changes**: Monitor `.project/GENERATED_CHANGES.md` for drift between generated and actual files
- **Version Control**: Commit generated artifacts to track evolution over time

### Common Pitfalls to Avoid

- **Don't Edit Generated Files Directly**: Always update source (`{{files.plan}}`) and re-run scaffold
- **Don't Skip Validation**: Invalid schemas can cause runtime errors
- **Don't Ignore Conflicts**: Review `-generated` files promptly and merge as needed
- **Don't Forget Dependencies**: Update `MANIFEST.md` when adding new packages
- **Don't Skip Documentation**: Keep `Scaffold-README.md` in sync with changes

### Extensibility

- **Custom Diagram Types**: Add new diagram types by extending step 4
- **Additional Schemas**: Support new schema formats (e.g., Protobuf) by adding to step 5
- **Custom Validators**: Add validation tools to step 7
- **Platform-Specific Artifacts**: Extend for cloud-specific configurations (AWS, Azure, GCP)

## Troubleshooting

### Issue: Missing instruction/persona files

**Solution**: Check indexes for best matches; if absent, scaffold will create from templates

### Issue: Schema validation failures

**Solution**: Review schema against JSON Schema draft version; fix structural issues

### Issue: Diagram rendering errors

**Solution**: Verify PlantUML/Mermaid CLI installed; check diagram syntax

### Issue: Dependency conflicts unresolved

**Solution**: Review MANIFEST.md for proposed resolutions; test thoroughly before applying

### Issue: Generated files differ from expected

**Solution**: Review `.project/ASSUMPTIONS.md`; update `{{files.plan}}` and re-run scaffold
