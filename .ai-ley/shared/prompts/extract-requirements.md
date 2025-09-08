---
agentMode: general
applyTo: general
author: AI-LEY
description: Scans through the src/ folder to gather requirements, outputs a clear, concise and robust set of requirements to {{files.requirements}}
extensions:
  - .md
guidelines: Follow AI-LEY project standards and Universal Project Coding & Management Guide
instructionType: general
keywords: [requirements, extraction, analysis, src, codebase, documentation]
lastUpdated: '2025-09-08T00:00:00.000000'
summaryScore: 4.0
title: Extract Requirements
version: 1.0.0
---

# Copilot Command: Extract Requirements

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Given:

- Source code and documentation files in `{{folders.src}}` directory
- Configuration files, scripts, and project structure
- Existing project documentation and README files
- Code comments, docstrings, and inline documentation

Produce:

- Comprehensive, production-ready `{{files.requirements}}` document with extracted specifications
- Clear mapping from code features to functional requirements
- Non-functional requirements derived from implementation patterns
- Technical requirements based on existing architecture and dependencies
- Updated `{{files.requirements_changelog}}` documenting extraction process

## Command

You are an expert software architect, requirements analyst, and reverse engineering specialist with deep expertise in extracting business and technical requirements from existing codebases.

### 1. **Source Code Discovery and Analysis**

**Discovery Actions**:

- Scan all files in `{{folders.src}}` recursively
- Identify Python files, configuration files, documentation, and assets
- Load main application files (\*.py, package.json, requirements.txt, etc.)
- Examine project structure and architectural patterns
- Read README.md, documentation files, and inline comments
- Analyze configuration files and environment settings

**Analysis Tasks**:

- Identify core functionality and business logic
- Extract user-facing features and capabilities
- Discover data models, schemas, and database requirements
- Map API endpoints, interfaces, and integration points
- Identify security implementations, authentication, and authorization
- Extract performance considerations, caching, and optimization patterns
- Analyze error handling, logging, and monitoring implementations

### 2. **Feature Extraction and Categorization**

**Functional Requirements Extraction**:

For each identified feature or capability:

- Extract user-facing functionality from code
- Identify input/output requirements from function signatures
- Map user workflows from application logic
- Extract business rules from validation code
- Identify data processing and transformation requirements
- Document API endpoints and their purposes
- Extract reporting and analytics capabilities

**Code Pattern Analysis**:

- Authentication and user management systems
- Data validation and business rule enforcement
- File processing and data import/export capabilities
- Search, filtering, and query functionality
- User interface components and interactions
- Integration patterns with external systems
- Workflow automation and background processing

**Documentation Mining**:

- Extract requirements from code comments and docstrings
- Analyze TODO comments and planned features
- Review configuration files for system requirements
- Parse README files for feature descriptions
- Extract API documentation and usage patterns

### 3. **Requirements Synthesis and Organization**

**Create structured requirements document with the following format**:

#### 3.1 Executive Summary

- Project purpose and scope derived from codebase analysis
- Key capabilities and core features identified
- Technical architecture summary
- Business value and use cases extracted from implementation

#### 3.2 Functional Requirements (R1, R2, R3...)

**Format each requirement as**:

```markdown
**R[X]: [Requirement Title]**

- **Description**: Clear description of functionality found in codebase
- **Implementation Evidence**: Reference to specific files, functions, or code sections
- **Acceptance Criteria**:
  - [ ] Specific behavior observed in code
  - [ ] Input/output patterns identified
  - [ ] Business rules enforced in implementation
- **Priority**: Derived from code prominence and complexity
- **Source**: File paths and line references where functionality is implemented
```

#### 3.3 Non-Functional Requirements (NF1, NF2, NF3...)

**Performance Requirements**:

- Response time patterns from code analysis
- Scalability considerations from architecture
- Database query optimization patterns
- Caching strategies implemented
- Resource utilization patterns

**Security Requirements**:

- Authentication mechanisms implemented
- Authorization patterns and access controls
- Data validation and sanitization
- Encryption and security measures
- Session management and security headers

**Reliability Requirements**:

- Error handling and exception management patterns
- Logging and monitoring implementations
- Data backup and recovery mechanisms
- Fault tolerance patterns in code

**Maintainability Requirements**:

- Code organization and modularity patterns
- Documentation standards observed
- Testing frameworks and patterns used
- Configuration management approaches

#### 3.4 Technical Requirements (T1, T2, T3...)

**Architecture Requirements**:

- System architecture patterns identified
- Component dependencies and relationships
- Database design and data model requirements
- API design patterns and interfaces
- Integration patterns with external systems

**Technology Stack Requirements**:

- Programming languages and versions used
- Framework dependencies and versions
- Database technologies and requirements
- Third-party libraries and services
- Infrastructure and deployment requirements

**Data Requirements**:

- Data models and schema structures
- Data validation and integrity rules
- Data processing and transformation logic
- Storage and retrieval patterns
- Data migration and versioning needs

### 4. **Implementation Analysis**

**For each Python file analyzed, extract**:

```markdown
**File**: `path/to/file.py`
**Purpose**: [Derived from code analysis]
**Key Functions**:

- `function_name()`: [Purpose and requirements derived]
- `class_name`: [Responsibilities and requirements]

**Requirements Extracted**:

- R[X]: [Functional requirement from this file]
- NF[Y]: [Non-functional requirement identified]
- T[Z]: [Technical requirement derived]

**Dependencies**: [External libraries, services, files]
**Interfaces**: [APIs, inputs, outputs identified]
```

**Configuration Analysis**:

- Environment variables and configuration requirements
- Database connection and setup requirements
- External service integrations and API keys
- Security configuration and encryption requirements
- Performance tuning and optimization settings

### 5. **Validation and Cross-Reference**

**Validation Checks**:

- [ ] All major code files have been analyzed
- [ ] Requirements trace back to specific code implementations
- [ ] No duplicate or conflicting requirements identified
- [ ] All external dependencies are documented as requirements
- [ ] Configuration requirements are captured
- [ ] Security and performance patterns are documented

**Cross-Reference Analysis**:

- Map requirements to specific code locations
- Identify interdependencies between requirements
- Validate requirement completeness against codebase features
- Check for missing or implied requirements
- Ensure technical requirements match implementation

### 6. **Requirements Documentation**

**Create `{{files.requirements}}` with the following structure**:

```markdown
# Project Requirements (Extracted from Codebase)

## Extraction Summary

- **Source**: Codebase analysis of `{{folders.src}}`
- **Date**: [Current date]
- **Files Analyzed**: [Count and list of key files]
- **Requirements Extracted**: [Counts by category]

## Functional Requirements

[All R1-RN requirements with code references]

## Non-Functional Requirements

[All NF1-NFN requirements with implementation evidence]

## Technical Requirements

[All T1-TN requirements with architecture details]

## Implementation Mapping

[Detailed mapping of requirements to code locations]

## Dependencies and Integrations

[External dependencies and integration requirements]

## Configuration Requirements

[Environment and configuration needs derived from code]

## Future Enhancements

[TODO items and planned features found in code]
```

### 7. **Changelog Documentation**

**Create `{{files.requirements_changelog}}`**:

```markdown
# Requirements Changelog

## Version 1.0 - [Current Date] - Initial Extraction

### Extracted from Codebase

**Functional Requirements**: R1-R[N]

- [List of major functional areas identified]

**Non-Functional Requirements**: NF1-NF[N]

- [Performance, security, reliability patterns found]

**Technical Requirements**: T1-T[N]

- [Architecture, technology, data requirements]

### Source Analysis Summary

- **Files Analyzed**: [Count] Python files, [Count] config files, [Count] docs
- **Code Lines Reviewed**: [Approximate count]
- **Features Identified**: [Count] major features
- **Integration Points**: [Count] external integrations

### Code Patterns Identified

- Authentication and user management: [Files and patterns]
- Data processing: [Key capabilities found]
- API endpoints: [Count and categories]
- Database operations: [Models and operations]
- Configuration management: [Patterns and requirements]

### Extraction Notes

- [Any assumptions made during extraction]
- [Areas requiring clarification or additional analysis]
- [Limitations of current codebase analysis]
```

### 8. **Quality Assurance**

**Completeness Checks**:

- [ ] All major functionality in `{{folders.src}}` is represented in requirements
- [ ] Configuration and deployment requirements are captured
- [ ] Security and performance implementations are documented
- [ ] External dependencies are listed as requirements
- [ ] Code architecture is reflected in technical requirements

**Accuracy Validation**:

- [ ] Requirements accurately reflect code implementation
- [ ] No requirements contradict existing code
- [ ] Technical requirements match actual technology stack
- [ ] Performance requirements align with code optimizations
- [ ] Security requirements match implemented controls

## Examples

### Example 1: Python Function Analysis

**Code Found**:

```python
def authenticate_user(username, password):
    """Authenticate user with bcrypt password hashing."""
    user = User.query.filter_by(username=username).first()
    if user and bcrypt.check_password_hash(user.password, password):
        return user
    return None
```

**Extracted Requirement**:

```markdown
**R1: User Authentication**

- **Description**: System must authenticate users using username/password with secure password hashing
- **Implementation Evidence**: `auth/models.py:45-52` - authenticate_user() function
- **Acceptance Criteria**:
  - [ ] Users authenticate with username and password
  - [ ] Passwords are hashed using bcrypt algorithm
  - [ ] Failed authentication returns None
  - [ ] Successful authentication returns user object
- **Priority**: High (core security function)
- **Source**: `src/auth/models.py` lines 45-52
```

### Example 2: Configuration Analysis

**Configuration Found**:

```python
DATABASE_URL = os.environ.get('DATABASE_URL', 'sqlite:///app.db')
SECRET_KEY = os.environ.get('SECRET_KEY', 'dev-key-change-in-production')
```

**Extracted Requirements**:

```markdown
**T1: Database Configuration**

- **Description**: System must support configurable database connections via environment variables
- **Implementation Evidence**: `config/settings.py:12` - DATABASE_URL configuration
- **Acceptance Criteria**:
  - [ ] DATABASE_URL environment variable support
  - [ ] SQLite default for development
  - [ ] Support for PostgreSQL/MySQL in production
- **Priority**: High
- **Source**: `src/config/settings.py` line 12

**NF1: Security Configuration**

- **Description**: Application must use configurable secret keys for session security
- **Implementation Evidence**: `config/settings.py:13` - SECRET_KEY configuration
- **Acceptance Criteria**:
  - [ ] SECRET_KEY configurable via environment
  - [ ] Default development key provided
  - [ ] Production deployment requires custom secret
- **Priority**: High (security requirement)
- **Source**: `src/config/settings.py` line 13
```

### Example 3: API Endpoint Analysis

**Code Found**:

```python
@app.route('/api/users', methods=['GET'])
@login_required
def get_users():
    """Return paginated list of users."""
    page = request.args.get('page', 1, type=int)
    users = User.query.paginate(page=page, per_page=20)
    return jsonify([user.to_dict() for user in users.items])
```

**Extracted Requirement**:

```markdown
**R5: User List API**

- **Description**: System must provide paginated API endpoint for retrieving user lists
- **Implementation Evidence**: `api/users.py:25-31` - get_users() endpoint
- **Acceptance Criteria**:
  - [ ] GET /api/users endpoint available
  - [ ] Authentication required via @login_required
  - [ ] Pagination support with page parameter
  - [ ] 20 users per page default
  - [ ] JSON response format
- **Priority**: Medium
- **Source**: `src/api/users.py` lines 25-31
```

## Notes

- Focus on extracting requirements that are actually implemented in code
- Include file references and line numbers for traceability
- Distinguish between implemented features and TODO comments
- Consider both explicit functionality and implicit requirements
- Document configuration and deployment requirements from code analysis
- Extract performance and security patterns as non-functional requirements
- Map database models and schemas to data requirements
- Include API patterns and integration requirements
- Note any incomplete or deprecated functionality found in code
