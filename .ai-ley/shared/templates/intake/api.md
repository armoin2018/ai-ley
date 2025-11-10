---
templateType: intake
category: api
version: 1.0.0
author: AI-LEY
created: 2025-11-09T00:00:00.000000
description: Interactive intake template for API and microservices projects
---

# API / Microservices Project Intake

## Project Overview

### Q1: API Name

**Question**: What is the name of your API or service?
**Type**: text
**Required**: yes

### Q2: API Description

**Question**: Provide a brief description of the API (1-2 paragraphs). What functionality does it provide and who are the consumers?
**Type**: textarea
**Required**: yes

### Q3: API Goals

**Question**: What are the primary goals and objectives for this API?
**Type**: list
**Required**: yes
**Suggestions**:

- Enable third-party integrations
- Support mobile/web applications
- Facilitate microservices communication
- Expose business capabilities externally
- Replace legacy APIs
- Improve performance and scalability
- Enable partner ecosystem
- Support internal tool development
- Provide data access layer
- Enable real-time capabilities

## API Architecture & Design

### Q4: API Type

**Question**: What type of API are you building?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- RESTful API
- GraphQL API
- gRPC API
- WebSocket API (real-time)
- Webhook provider
- Event-driven API
- SOAP API (legacy integration)
- Hybrid (multiple protocols)

### Q5: API Style & Patterns

**Question**: What architectural patterns will be used?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Microservices architecture
- Monolithic API
- API Gateway pattern
- Backend for Frontend (BFF)
- Service mesh
- CQRS (Command Query Responsibility Segregation)
- Event sourcing
- Saga pattern
- Circuit breaker pattern
- API composition

### Q6: Technology Stack

**Question**: What technologies will be used for the API implementation?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/tech-stack.md`
**Allow Custom**: yes

**Common API Stack Options**:

Runtime/Framework:

- Node.js/Express
- Node.js/Fastify
- Node.js/NestJS
- Python/FastAPI
- Python/Django REST Framework
- Python/Flask
- Java/Spring Boot
- Go/Gin
- Go/Echo
- Ruby/Rails API
- .NET Core Web API
- PHP/Laravel

Database:

- PostgreSQL
- MySQL
- MongoDB
- Redis
- DynamoDB
- Cassandra
- Elasticsearch
- Neo4j

Message Queue/Event Bus:

- RabbitMQ
- Apache Kafka
- AWS SQS
- Redis Pub/Sub
- NATS
- Google Pub/Sub

Infrastructure:

- Docker
- Kubernetes
- AWS (ECS, Lambda, API Gateway)
- Azure (Container Apps, Functions)
- GCP (Cloud Run, Cloud Functions)

## API Capabilities

### Q7: Core Resources & Endpoints

**Question**: What are the primary resources/entities exposed by this API?
**Type**: list
**Required**: yes
**Examples**:

- Users, Authentication, Profiles
- Products, Inventory, Catalog
- Orders, Payments, Transactions
- Content, Media, Documents
- Analytics, Reports, Metrics
- Notifications, Messages
- Configurations, Settings

### Q8: Data Operations

**Question**: What data operations must be supported?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Create (POST)
- Read/Retrieve (GET)
- Update (PUT/PATCH)
- Delete (DELETE)
- Bulk operations
- Batch processing
- Search and filtering
- Pagination
- Sorting
- Field selection/sparse fieldsets
- Data aggregation
- Real-time subscriptions

### Q9: API Features

**Question**: What specific API features are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Versioning (URL, header, or content negotiation)
- Rate limiting and throttling
- Caching (client-side, server-side, CDN)
- Webhooks for event notifications
- File upload/download
- Streaming responses
- Server-sent events (SSE)
- GraphQL subscriptions
- Batch requests
- HATEOAS (hypermedia links)
- ETags for conditional requests
- Partial responses
- Compression (gzip, brotli)

## Authentication & Security

### Q10: Authentication Methods

**Question**: What authentication mechanisms will be supported?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- API Keys
- OAuth 2.0
- JWT (JSON Web Tokens)
- Basic Authentication
- Bearer tokens
- mTLS (Mutual TLS)
- SAML
- OpenID Connect
- Custom token schemes
- Multi-factor authentication (MFA)

### Q11: Authorization & Access Control

**Question**: What authorization and access control patterns are needed?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Role-based access control (RBAC)
- Attribute-based access control (ABAC)
- Scope-based permissions
- Resource-based permissions
- API key permissions
- Organization/tenant isolation
- User-level permissions
- IP whitelisting
- Geographic restrictions

### Q12: Security Requirements

**Question**: What security measures must be implemented?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- HTTPS/TLS encryption (minimum version)
- Input validation and sanitization
- SQL injection prevention
- NoSQL injection prevention
- XSS protection
- CORS configuration
- Rate limiting per client
- DDoS protection
- Request signing
- Encryption at rest
- Encryption in transit
- Security headers
- API security audits
- Penetration testing
- OWASP API Security Top 10 compliance

## Performance & Scalability

### Q13: Performance Requirements

**Question**: What are the performance targets and SLAs?
**Type**: textarea
**Required**: yes
**Format**:

```
Response Time:
- p50: [target, e.g., 100ms]
- p95: [target, e.g., 500ms]
- p99: [target, e.g., 1000ms]

Throughput:
- Requests per second: [target]
- Concurrent connections: [target]

Availability:
- Uptime SLA: [e.g., 99.9%]
- Max downtime per month: [calculated]
```

### Q14: Scalability & Load

**Question**: What are the expected load and scaling requirements?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Current request volume
- Projected request volume (6 months, 12 months)
- Peak traffic patterns (daily, seasonal)
- Geographic distribution of clients
- Horizontal scaling strategy
- Auto-scaling triggers and thresholds
- Database scaling approach
- Caching strategy
- CDN requirements

## Data & Integration

### Q15: Data Sources

**Question**: What data sources will the API integrate with?
**Type**: list
**Required**: yes
**Suggestions**:

- Primary database(s)
- Cache layers (Redis, Memcached)
- External APIs/services
- Message queues
- File storage systems
- Data warehouses
- Legacy systems
- Third-party SaaS platforms

### Q16: External Integrations

**Question**: What third-party services or APIs need to be integrated?
**Type**: list
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/integrations.md`
**Allow Custom**: yes
**Common API Integrations**:

- Payment processors (Stripe, PayPal)
- Email services (SendGrid, Mailgun)
- SMS providers (Twilio, Vonage)
- Cloud storage (S3, Azure Blob, GCS)
- Authentication providers (Auth0, Okta)
- Monitoring (Datadog, New Relic, Prometheus)
- Logging (Splunk, ELK, CloudWatch)
- Error tracking (Sentry, Rollbar)

### Q17: Data Consistency

**Question**: What are the data consistency and transaction requirements?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Strong consistency (ACID transactions)
- Eventual consistency
- Distributed transactions (2PC, Saga)
- Idempotency guarantees
- Optimistic locking
- Pessimistic locking
- Conflict resolution strategies
- Data replication requirements

## Documentation & Developer Experience

### Q18: API Documentation

**Question**: What documentation and specifications are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- OpenAPI/Swagger specification
- GraphQL schema
- Postman collections
- Code examples (multiple languages)
- Interactive API console
- Getting started guides
- Authentication flow diagrams
- Error handling documentation
- Webhook documentation
- Changelog and versioning
- Migration guides
- SDK/client library documentation

### Q19: Developer Tools

**Question**: What developer tools and SDKs should be provided?
**Type**: multi-select
**Required**: no
**Suggestions**:

- Official SDKs (JavaScript, Python, Go, Java, etc.)
- CLI tools
- Postman/Insomnia collections
- Mock servers for testing
- Sandbox/test environment
- API playground
- Code generators (OpenAPI Generator, etc.)
- Webhook testing tools
- Rate limit dashboards

## Team & Resources

### Q20: Team Composition

**Question**: What roles and expertise are available on the team?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/personas.md`
**Allow Custom**: yes
**Create If Missing**: yes (persona)
**Common Roles**:

- Backend Developer
- API Architect
- DevOps Engineer
- Site Reliability Engineer (SRE)
- Database Administrator
- Security Engineer
- Technical Writer
- QA/Test Engineer
- Platform Engineer

### Q21: Required Instructions

**Question**: What technical guidance and best practices will the team need?
**Type**: multi-select
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/instructions.md`
**Allow Custom**: yes
**Create If Missing**: yes (instruction)
**Common Instructions**:

- API design best practices
- RESTful API guidelines
- GraphQL schema design
- Error handling standards
- Testing strategies
- Security hardening
- Performance optimization
- Database optimization
- Monitoring and observability

## Testing & Quality

### Q22: Testing Requirements

**Question**: What testing strategies and coverage are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Unit tests (target coverage %)
- Integration tests
- Contract tests (Pact, Spring Cloud Contract)
- End-to-end tests
- Load testing (JMeter, k6, Gatling)
- Stress testing
- Security testing (OWASP ZAP, Burp Suite)
- Chaos engineering
- Mutation testing
- API fuzzing

### Q23: Monitoring & Observability

**Question**: What monitoring and observability capabilities are needed?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Request/response logging
- Performance metrics (latency, throughput)
- Error tracking and alerting
- Distributed tracing (Jaeger, Zipkin, OpenTelemetry)
- Application metrics (Prometheus, Grafana)
- Health checks and readiness probes
- Custom business metrics
- Log aggregation (ELK, Splunk, CloudWatch)
- Audit trails
- Real-time dashboards
- Anomaly detection
- SLA monitoring and reporting

## Compliance & Governance

### Q24: Compliance Requirements

**Question**: What regulatory or compliance standards must be met?
**Type**: multi-select
**Required**: no
**Suggestions**:

- GDPR (data protection)
- CCPA (privacy)
- HIPAA (healthcare)
- PCI DSS (payment data)
- SOC 2 (security controls)
- ISO 27001 (information security)
- FIPS 140-2 (cryptographic modules)
- Data residency requirements
- Industry-specific regulations

### Q25: API Governance

**Question**: What API governance policies and standards apply?
**Type**: textarea
**Required**: no
**Suggestions**:

- Naming conventions
- Versioning strategy
- Deprecation policy
- Breaking change procedures
- API review and approval process
- Design consistency standards
- Documentation requirements
- SLA commitments
- Support and maintenance policies

## Constraints & Timeline

### Q26: Timeline

**Question**: What is the target timeline and key milestones?
**Type**: textarea
**Required**: yes
**Format**:

```
Alpha/Internal Testing: [date]
Beta/Partner Access: [date]
General Availability: [date]
Key Milestones:
- Milestone 1: [description] - [date]
- Milestone 2: [description] - [date]
```

### Q27: Budget

**Question**: What is the project budget or budget range?
**Type**: text
**Required**: no

### Q28: Technical Constraints

**Question**: Are there any technical, infrastructure, or platform constraints?
**Type**: textarea
**Required**: no
**Suggestions**:

- Must use existing infrastructure
- Legacy system integration requirements
- Specific technology mandates
- Network or bandwidth limitations
- Latency requirements for specific regions
- Existing authentication/authorization to integrate with

## Success Metrics

### Q29: Key Performance Indicators

**Question**: How will API success be measured? What are the key metrics?
**Type**: list
**Required**: yes
**Suggestions**:

- API adoption rate (active developers/applications)
- Request volume growth
- Error rate (4xx, 5xx responses)
- Average response time
- p95/p99 latency
- Uptime percentage
- Time to first successful request (developer onboarding)
- API call success rate
- Developer satisfaction score
- Time to integrate (average)
- Support ticket volume

### Q30: Success Criteria

**Question**: What specific outcomes would indicate the project is successful?
**Type**: textarea
**Required**: yes
**Examples**:

- "Support 1M requests per day within 3 months"
- "Achieve 99.95% uptime SLA"
- "Onboard 100 partner integrations in first year"
- "Maintain p95 latency under 200ms"
- "Zero critical security vulnerabilities"
