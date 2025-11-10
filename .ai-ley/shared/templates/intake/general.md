---
templateType: intake
category: general
version: 1.0.0
author: AI-LEY
created: 2025-11-09T00:00:00.000000
description: General-purpose interactive intake template for any type of project
---

# General Project Intake

## Project Overview

### Q1: Project Name

**Question**: What is the name of your project?
**Type**: text
**Required**: yes

### Q2: Project Description

**Question**: Provide a brief description of the project (1-2 paragraphs). What problem does it solve and who are the target users or stakeholders?
**Type**: textarea
**Required**: yes

### Q3: Project Type

**Question**: What type of project is this?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Software application
- Web service/API
- Data pipeline
- Infrastructure/DevOps
- Library/SDK/Framework
- CLI tool
- Desktop application
- Integration/Middleware
- Automation/Scripting
- Research/POC
- Documentation
- Migration/Modernization
- Other (please specify)

### Q4: Project Goals

**Question**: What are the primary goals and objectives?
**Type**: list
**Required**: yes
**Suggestions**:

- Improve efficiency or productivity
- Reduce costs
- Increase revenue
- Enhance user experience
- Replace legacy system
- Enable new capabilities
- Improve reliability or performance
- Meet compliance requirements
- Support business growth
- Solve technical debt
- Improve security
- Enable innovation

## Technical Context

### Q5: Technology Stack

**Question**: What technologies, languages, and frameworks will be used?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/tech-stack.md`
**Allow Custom**: yes

**Common Categories**:

Programming Languages:

- JavaScript/TypeScript
- Python
- Java
- C#/.NET
- Go
- Ruby
- PHP
- Rust
- Swift/Kotlin
- C/C++

Frameworks:

- React/Vue/Angular
- Node.js/Express
- Django/Flask/FastAPI
- Spring Boot
- .NET Core
- Ruby on Rails
- Laravel

Databases:

- PostgreSQL
- MySQL
- MongoDB
- Redis
- Elasticsearch
- Cassandra
- DynamoDB

Infrastructure:

- Docker
- Kubernetes
- AWS/Azure/GCP
- Terraform
- Ansible
- CI/CD tools

### Q6: Target Platform(s)

**Question**: What platforms or environments will the project target?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Web (browser-based)
- Server/Backend
- Mobile (iOS/Android)
- Desktop (Windows/Mac/Linux)
- Cloud (AWS/Azure/GCP)
- On-premise
- Edge/IoT
- Containers/Kubernetes
- Serverless
- Hybrid (multiple platforms)

### Q7: System Architecture

**Question**: What architectural patterns or styles will be used?
**Type**: multi-select
**Required**: no
**Suggestions**:

- Monolithic application
- Microservices
- Serverless/Functions
- Event-driven architecture
- Service-oriented architecture (SOA)
- Layered/N-tier architecture
- Client-server
- Peer-to-peer
- Batch processing
- Stream processing
- CQRS
- Event sourcing
- Modular monolith

## Features & Functionality

### Q8: Core Features

**Question**: What are the essential features that must be delivered?
**Type**: list
**Required**: yes
**Note**: List the key capabilities and functionality

### Q9: User Personas

**Question**: Who are the primary users or personas?
**Type**: list
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/personas.md`
**Allow Custom**: yes
**Create If Missing**: yes (persona)
**Examples**:

- End users (consumers)
- Business users
- Administrators
- Developers (if API/SDK)
- Data analysts
- System operators
- External partners
- Internal teams

### Q10: Integration Requirements

**Question**: What systems, services, or APIs need to be integrated?
**Type**: list
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/integrations.md`
**Allow Custom**: yes
**Examples**:

- Third-party APIs
- Internal systems
- Databases
- Authentication providers
- Payment gateways
- Communication services
- Cloud services
- Legacy systems
- Data sources

## Non-Functional Requirements

### Q11: Performance Requirements

**Question**: What are the performance expectations and targets?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Response time targets
- Throughput requirements
- Concurrent user capacity
- Data processing volume
- Batch processing time
- Query performance
- Resource utilization limits
  **Format**: Specify measurable targets (e.g., "API response time < 200ms for 95% of requests")

### Q12: Scalability Requirements

**Question**: What are the scalability needs and growth projections?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Current scale (users, transactions, data volume)
- Projected growth (6 months, 12 months, 2 years)
- Peak load patterns
- Geographic distribution
- Scaling strategy (vertical, horizontal, auto-scaling)
  **Format**: Provide current and future scale estimates

### Q13: Availability & Reliability

**Question**: What are the availability and reliability requirements?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Uptime SLA (e.g., 99.9%, 99.99%)
- Maximum acceptable downtime
- Disaster recovery requirements (RTO/RPO)
- Backup and restore requirements
- Failover/redundancy needs
- Geographic redundancy
  **Format**: Specify SLA targets and recovery objectives

### Q14: Security Requirements

**Question**: What security measures and standards must be implemented?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Authentication (methods and protocols)
- Authorization (RBAC, ABAC, etc.)
- Data encryption (at rest, in transit)
- Security protocols (HTTPS, TLS, etc.)
- Input validation and sanitization
- Secure coding practices
- Security audits and testing
- Vulnerability scanning
- Penetration testing
- Security certifications
- Secure development lifecycle

### Q15: Compliance & Regulatory Requirements

**Question**: What compliance standards or regulations must be met?
**Type**: multi-select
**Required**: no
**Suggestions**:

- GDPR (data protection)
- CCPA (California privacy)
- HIPAA (healthcare)
- PCI DSS (payment data)
- SOC 2 (security controls)
- ISO 27001 (information security)
- WCAG (accessibility)
- Industry-specific regulations
- Corporate security policies
- Data residency requirements
- Audit requirements

## Data & Content

### Q16: Data Requirements

**Question**: What are the data management and storage requirements?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Types of data (user data, transactional, analytical, etc.)
- Data volume (current and projected)
- Data retention policies
- Data backup requirements
- Data migration needs
- Data import/export capabilities
- Data validation requirements
- Master data management
  **Format**: Describe data types, volumes, and lifecycle

### Q17: Data Privacy

**Question**: What data privacy and protection measures are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Personally Identifiable Information (PII) handling
- Data anonymization/pseudonymization
- User consent management
- Right to access/deletion (GDPR)
- Data minimization
- Privacy by design
- Data classification
- Access logging and auditing
- Data retention and purging
- Privacy impact assessment

## Team & Resources

### Q18: Team Composition

**Question**: What roles and expertise are available on the team?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/personas.md`
**Allow Custom**: yes
**Create If Missing**: yes (persona)
**Common Roles**:

- Software Engineer/Developer
- Frontend Developer
- Backend Developer
- Full-stack Developer
- DevOps Engineer
- Database Administrator
- QA/Test Engineer
- UI/UX Designer
- Product Manager
- Project Manager
- Technical Lead/Architect
- Security Engineer
- Data Engineer

### Q19: Required Instructions

**Question**: What technical guidance, standards, and best practices will the team need?
**Type**: multi-select
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/instructions.md`
**Allow Custom**: yes
**Create If Missing**: yes (instruction)
**Common Instructions**:

- Coding standards and style guides
- Code review process
- Testing strategies
- Deployment procedures
- Security guidelines
- Performance optimization
- Documentation standards
- Git workflow
- CI/CD practices
- Monitoring and logging

### Q20: Development Tools & Practices

**Question**: What development tools, practices, and methodologies will be used?
**Type**: multi-select
**Required**: no
**Suggestions**:

- Version control (Git, GitHub, GitLab, Bitbucket)
- CI/CD (Jenkins, GitHub Actions, GitLab CI, CircleCI)
- Project management (Jira, Asana, Linear, Trello)
- Communication (Slack, Teams, Discord)
- Code quality (SonarQube, ESLint, Prettier)
- Testing frameworks
- Documentation tools (Confluence, Notion, Markdown)
- Development methodology (Agile, Scrum, Kanban, Waterfall)
- Code review tools
- Issue tracking

## Testing & Quality Assurance

### Q21: Testing Strategy

**Question**: What testing approaches and coverage are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Unit testing (target coverage %)
- Integration testing
- End-to-end testing
- Manual testing
- Automated testing
- Regression testing
- Performance testing
- Load/stress testing
- Security testing
- Accessibility testing
- User acceptance testing (UAT)
- Smoke testing
- Exploratory testing

### Q22: Quality Standards

**Question**: What quality standards and metrics will be enforced?
**Type**: multi-select
**Required**: no
**Suggestions**:

- Code coverage targets (e.g., 80%)
- Code quality metrics (complexity, duplication)
- Performance benchmarks
- Security vulnerability thresholds
- Documentation completeness
- Code review requirements
- Definition of Done criteria
- Acceptance criteria standards
- Bug severity classifications
- Technical debt tracking

## Deployment & Operations

### Q23: Deployment Strategy

**Question**: How will the project be deployed and released?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Manual deployment
- Automated deployment (CI/CD)
- Blue-green deployment
- Canary deployment
- Rolling deployment
- Feature flags
- A/B testing
- Scheduled releases
- Continuous deployment
- On-demand releases
- Staged rollout

### Q24: Environment Requirements

**Question**: What environments are needed?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Development
- Testing/QA
- Staging/Pre-production
- Production
- Sandbox/Demo
- Disaster Recovery
- Performance testing
- User acceptance testing (UAT)

### Q25: Monitoring & Observability

**Question**: What monitoring, logging, and observability capabilities are needed?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Application logs
- Error tracking and alerting
- Performance monitoring (APM)
- Infrastructure monitoring
- Security monitoring
- User analytics
- Business metrics
- Distributed tracing
- Log aggregation
- Custom dashboards
- Alerting and notifications
- Health checks
- SLA/SLO tracking

## Documentation

### Q26: Documentation Requirements

**Question**: What documentation must be created and maintained?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- User documentation/guides
- API documentation
- Technical architecture documentation
- Developer documentation
- Deployment/operations runbooks
- Troubleshooting guides
- FAQ/Knowledge base
- Code comments and inline documentation
- Design documentation
- Database schema documentation
- Security documentation
- Compliance documentation
- Change log/release notes

## Constraints & Dependencies

### Q27: Timeline

**Question**: What is the target timeline and key milestones?
**Type**: textarea
**Required**: yes
**Format**:

```
Project Start: [date]
Key Milestones:
- Milestone 1: [description] - [date]
- Milestone 2: [description] - [date]
- Milestone 3: [description] - [date]
MVP/Beta: [date]
Production Release: [date]
```

### Q28: Budget

**Question**: What is the project budget or budget range?
**Type**: text
**Required**: no
**Note**: Include development, infrastructure, tools, and operational costs

### Q29: Technical Constraints

**Question**: Are there any technical constraints or limitations?
**Type**: textarea
**Required**: no
**Suggestions**:

- Must use existing infrastructure
- Technology mandates or restrictions
- Legacy system compatibility
- Performance constraints
- Resource limitations (compute, storage, bandwidth)
- Platform/browser/OS version requirements
- Existing authentication/authorization systems
- Network or connectivity constraints
- Offline requirements
- Backwards compatibility needs

### Q30: Dependencies

**Question**: What external dependencies, systems, or stakeholders exist?
**Type**: list
**Required**: no
**Suggestions**:

- External vendors or partners
- Third-party services or APIs
- Internal systems or teams
- Infrastructure dependencies
- Regulatory approvals
- Budget approvals
- Stakeholder decisions
- Other projects or initiatives
- Data sources
- Shared resources

### Q31: Risks & Assumptions

**Question**: What are the key risks and assumptions for this project?
**Type**: textarea
**Required**: no
**Format**:

```
Risks:
- Risk 1: [description] - Impact: [H/M/L] - Mitigation: [strategy]
- Risk 2: [description] - Impact: [H/M/L] - Mitigation: [strategy]

Assumptions:
- Assumption 1: [description]
- Assumption 2: [description]
```

## Success Criteria

### Q32: Key Performance Indicators

**Question**: How will project success be measured? What are the key metrics?
**Type**: list
**Required**: yes
**Suggestions**:

- User adoption/engagement metrics
- Performance metrics (response time, throughput)
- Reliability metrics (uptime, error rate)
- Business metrics (revenue, cost savings, efficiency)
- Quality metrics (bug rate, test coverage)
- User satisfaction (NPS, CSAT)
- Time to market
- Development velocity
- Technical debt reduction
- Security posture improvements

### Q33: Success Criteria

**Question**: What specific outcomes would indicate the project is successful?
**Type**: textarea
**Required**: yes
**Format**: List specific, measurable success criteria
**Examples**:

- "Achieve 99.9% uptime within 3 months of launch"
- "Reduce processing time by 50%"
- "Support 10,000 concurrent users"
- "Complete migration within 6 months"
- "Achieve 80% code coverage"
- "Zero critical security vulnerabilities"
- "Reduce operational costs by 30%"
- "Maintain customer satisfaction score above 4.5/5"

### Q34: Definition of Done

**Question**: What constitutes "done" for this project?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- All acceptance criteria met
- Code reviewed and approved
- All tests passing (unit, integration, E2E)
- Documentation complete
- Security review completed
- Performance benchmarks met
- Deployed to production
- User acceptance testing passed
- Monitoring and alerts configured
- Runbooks and operational docs complete
- Stakeholder sign-off received
- Post-launch support plan in place
