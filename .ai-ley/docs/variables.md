# AI-LEY Variables & Folder Structure System

This document provides comprehensive documentation for the AI-LEY variable system and standardized folder structure management, covering the organization patterns, variable definitions, and file management conventions used throughout the AI-LEY ecosystem.

## 🗂️ What is the AI-LEY Variables System?

The AI-LEY variables system provides a standardized way to reference files and folders across all AI-LEY commands, personas, and instructions. It ensures consistent project organization and enables reliable automation by providing predictable file locations and naming conventions.

### Key Benefits

- **Consistency**: Standardized folder structure across all projects
- **Automation-Friendly**: Predictable file locations for AI commands
- **Multi-Platform**: Works across different operating systems and environments
- **Scalable**: Easy to extend for new project types and requirements
- **Maintainable**: Centralized definition of all file and folder locations

## 📁 Core Folder Structure

The variables system is defined in `.ai-ley/shared/variables/folder-structure.yaml`:

```yaml
folders:
  project: .project
  prompts: .ai-ley/shared/prompts
  instructions: .ai-ley/shared/instructions
  personas: .ai-ley/shared/personas
  tests: .project/tests
  performance: .project/tests/performance
  plan: .project/plan
  src: src/
  build: build/
  docs: src/docs
  wiki: src/wiki
  architecture: .project/plan/architecture
  api: src/wiki/api
  diff: .project/diff
  md5sums: .ai-ley/shared/md5sums
  assets:
    base: src/assets
    js: src/assets/js
    css: src/assets/css
    images: src/assets/images
    schema: src/assets/schema
  templates:
    base: .ai-ley/shared/templates
    ask: .ai-ley/shared/templates/ask
    instructions: .ai-ley/shared/templates/instructions
    personas: .ai-ley/shared/templates/personas
    prompts: .ai-ley/shared/templates/prompts

files:
  readme: README.md
  audit-report: .project/AUDIT-REPORT.md
  test-plan: .project/TEST-PLAN.md
  health-check: .project/HEALTH-CHECK.md
  gitignore: .gitignore
  license: LICENSE
  contributing: CONTRIBUTING.md
  code_of_conduct: CODE_OF_CONDUCT.md
  changelog: .project/CHANGELOG.md
  whitelist: .project/WHITELIST.md
  blacklist: .project/BLACKLIST.md
  review: .project/REVIEW.md
  history: HISTORY.md
  requirements: .project/REQUIREMENTS.md
  requirements_changelog: .project/REQUIREMENTS-CHANGELOG.md
  ask: .project/ASK.md
  suggestions: .project/SUGGESTIONS.md
  instructions-request: .project/INSTRUCTIONS-REQUEST.md
  personas-request: .project/PERSONAS-REQUEST.md
  registry: .ai-ley/shared/variables/registry.db
  registry_json: .ai-ley/shared/variables/registry.json
  bugs: .project/BUGS.md
  errors: .project/ERRORS.md
  plan: .project/PLAN.md
  todo: .project/TODO.md
  instructions: .ai-ley/shared/global-instructions.md
  tests: .project/tests/README.md
  performance: .project/PERFORMANCE-SUGGESTIONS.md
  indexes:
    instructions: .ai-ley/shared/indexes/instructions.md
    personas: .ai-ley/shared/indexes/personas.md
    prompts: .ai-ley/shared/indexes/prompts.md
  md5sums:
    instructions: .ai-ley/shared/md5sums/instructions.md5
    personas: .ai-ley/shared/md5sums/personas.md5
    prompts: .ai-ley/shared/md5sums/prompts.md5
```

## 🔧 Variable Usage & Mustache Syntax

### In Commands and Prompts

Variables are referenced using Mustache syntax `{{variable.path}}`:

```markdown
# Example from requirements.md prompt

Given:

- Raw ideas, goals, and requests from `{{files.ask}}`
- Enhancement suggestions from `{{files.suggestions}}`
- Existing requirements from `{{files.requirements}}` (if present)

Produce:

- Comprehensive, production-ready `{{files.requirements}}` document
- Updated `{{files.requirements_changelog}}` documenting all changes
```

### In Instructions and Documentation

```markdown
# Example from instruction files

Store test results in `{{folders.tests}}` directory
Generate performance reports in `{{files.performance}}`
Update project documentation in `{{folders.docs}}`
```

### In Personas

```markdown
# Example persona reference

When working with project planning:

- Load requirements from `{{files.requirements}}`
- Save plan to `{{files.plan}}`
- Update task tracking in `{{folders.plan}}`
```

---

## 📂 Detailed Folder Categories

### 🏗️ Project Management Folders

#### `.project/` - Project Management Hub

**Purpose**: Central location for all project management files and documentation
**Contents**:

- Planning documents and roadmaps
- Test plans and quality assurance
- Project tracking and status reports
- Audit and review documentation

**Key Subfolders**:

```yaml
folders:
  project: .project
  tests: .project/tests
  performance: .project/tests/performance
  plan: .project/plan
  architecture: .project/plan/architecture
  diff: .project/diff
```

**Usage Examples**:

- Project plans and milestones: `{{files.plan}}`
- Test documentation: `{{files.test-plan}}`
- Architecture documentation: `{{folders.architecture}}`
- Performance metrics: `{{files.performance}}`

#### Project Management Files

```yaml
files:
  requirements: .project/REQUIREMENTS.md
  requirements_changelog: .project/REQUIREMENTS-CHANGELOG.md
  plan: .project/PLAN.md
  todo: .project/TODO.md
  test-plan: .project/TEST-PLAN.md
  health-check: .project/HEALTH-CHECK.md
  audit-report: .project/AUDIT-REPORT.md
  changelog: .project/CHANGELOG.md
  review: .project/REVIEW.md
  bugs: .project/BUGS.md
  errors: .project/ERRORS.md
  ask: .project/ASK.md
  suggestions: .project/SUGGESTIONS.md
```

### 🤖 AI-LEY System Folders

#### `.ai-ley/shared/` - AI-LEY Knowledge Base

**Purpose**: Central repository for all AI-LEY system components
**Contents**:

- Personas for specialized AI roles
- Instructions for domain-specific guidance
- Prompts for automation commands
- Templates for consistent structure

**Key Components**:

```yaml
folders:
  prompts: .ai-ley/shared/prompts
  instructions: .ai-ley/shared/instructions
  personas: .ai-ley/shared/personas
  md5sums: .ai-ley/shared/md5sums
  templates:
    base: .ai-ley/shared/templates
    ask: .ai-ley/shared/templates/ask
    instructions: .ai-ley/shared/templates/instructions
    personas: .ai-ley/shared/templates/personas
    prompts: .ai-ley/shared/templates/prompts
```

**System Files**:

```yaml
files:
  instructions: .ai-ley/shared/global-instructions.md
  registry: .ai-ley/shared/variables/registry.db
  registry_json: .ai-ley/shared/variables/registry.json
  indexes:
    instructions: .ai-ley/shared/indexes/instructions.md
    personas: .ai-ley/shared/indexes/personas.md
    prompts: .ai-ley/shared/indexes/prompts.md
  md5sums:
    instructions: .ai-ley/shared/md5sums/instructions.md5
    personas: .ai-ley/shared/md5sums/personas.md5
    prompts: .ai-ley/shared/md5sums/prompts.md5
```

### 💻 Source Code Folders

#### `src/` - Source Code Repository

**Purpose**: Primary source code and development assets
**Organization**: Language and framework agnostic structure

```yaml
folders:
  src: src/
  docs: src/docs
  wiki: src/wiki
  api: src/wiki/api
  assets:
    base: src/assets
    js: src/assets/js
    css: src/assets/css
    images: src/assets/images
    schema: src/assets/schema
```

**Asset Management**:

- **JavaScript**: `{{folders.assets.js}}` - Client-side scripts and modules
- **CSS**: `{{folders.assets.css}}` - Stylesheets and design assets
- **Images**: `{{folders.assets.images}}` - Graphics, icons, and media
- **Schema**: `{{folders.assets.schema}}` - Data schemas and specifications

### 🏭 Build & Distribution

#### `build/` - Build Artifacts

**Purpose**: Compiled code, distribution packages, and deployment assets
**Usage**: Output location for build processes and CI/CD pipelines

```yaml
folders:
  build: build/
```

**Common Build Patterns**:

- Compiled JavaScript bundles
- Optimized CSS and assets
- Docker images and containers
- Distribution packages (zip, tar, etc.)

---

## 🎯 Variable Categories & Usage Patterns

### Primary File Types

#### Core Project Files

Essential files that define project structure and information:

```yaml
# Project Identity
files:
  readme: README.md
  license: LICENSE
  contributing: CONTRIBUTING.md
  code_of_conduct: CODE_OF_CONDUCT.md
  gitignore: .gitignore
```

**Usage in Commands**:

- `/document` command updates `{{files.readme}}`
- License selection updates `{{files.license}}`
- Contributing guidelines in `{{files.contributing}}`

#### Development Lifecycle Files

Files that track project progress and status:

```yaml
# Development Tracking
files:
  requirements: .project/REQUIREMENTS.md
  plan: .project/PLAN.md
  changelog: .project/CHANGELOG.md
  history: HISTORY.md
  todo: .project/TODO.md
```

**Command Integration**:

- `/requirements` → `{{files.requirements}}`
- `/plan` → `{{files.plan}}`
- Git integration → `{{files.changelog}}`

#### Quality Assurance Files

Files for testing, validation, and quality control:

```yaml
# Quality & Testing
files:
  test-plan: .project/TEST-PLAN.md
  health-check: .project/HEALTH-CHECK.md
  audit-report: .project/AUDIT-REPORT.md
  bugs: .project/BUGS.md
  errors: .project/ERRORS.md
  performance: .project/PERFORMANCE-SUGGESTIONS.md
```

**Integration Patterns**:

- `/build-test-plan` → `{{files.test-plan}}`
- `/health-check` → `{{files.health-check}}`
- `/audit` → `{{files.audit-report}}`

### Index & Registry Files

#### Knowledge Indexes

Organized catalogs of AI-LEY system components:

```yaml
files:
  indexes:
    instructions: .ai-ley/shared/indexes/instructions.md
    personas: .ai-ley/shared/indexes/personas.md
    prompts: .ai-ley/shared/indexes/prompts.md
```

**Maintenance Integration**:

- `/update-instructions` updates `{{files.indexes.instructions}}`
- `/update-personas` updates `{{files.indexes.personas}}`
- System maintenance updates all indexes

#### File Integrity Tracking

MD5 checksums for change detection and validation:

```yaml
files:
  md5sums:
    instructions: .ai-ley/shared/md5sums/instructions.md5
    personas: .ai-ley/shared/md5sums/personas.md5
    prompts: .ai-ley/shared/md5sums/prompts.md5
```

**Automated Integration**:

- Registry building process updates checksums
- Change detection triggers updates
- Validation ensures file integrity

---

## 🔄 Dynamic Variable Resolution

### Context-Aware Path Resolution

Variables are resolved based on project context and current working directory:

```yaml
# Base resolution from project root
{{folders.src}} → src/
{{files.readme}} → README.md

# Nested folder resolution
{{folders.assets.js}} → src/assets/js/
{{files.indexes.personas}} → .ai-ley/shared/indexes/personas.md
```

### Environment-Specific Overrides

Variables can be customized for different environments:

```yaml
# Development environment
folders:
  build: build/dev/

# Production environment
folders:
  build: build/prod/

# Testing environment
folders:
  build: build/test/
```

### Platform Compatibility

Variables work across different platforms and shells:

```bash
# Unix/Linux/macOS
{{folders.src}} → src/
{{files.plan}} → .project/PLAN.md

# Windows
{{folders.src}} → src\
{{files.plan}} → .project\PLAN.md
```

---

## 🛠️ Working with Variables

### In AI-LEY Commands

Commands use variables to ensure consistent file operations:

```markdown
# /requirements command

## Goal

Given:

- Raw ideas from `{{files.ask}}`
- Enhancement suggestions from `{{files.suggestions}}`

Produce:

- Comprehensive `{{files.requirements}}` document
- Updated `{{files.requirements_changelog}}`
```

### In Custom Templates

Create templates using the variable system:

```markdown
# Custom project template

## Project Structure

- Source code: `{{folders.src}}`
- Documentation: `{{folders.docs}}`
- Tests: `{{folders.tests}}`

## Key Files

- Requirements: `{{files.requirements}}`
- Plan: `{{files.plan}}`
- Todo: `{{files.todo}}`
```

### In Automation Scripts

Scripts can reference variables for reliable paths:

```bash
#!/bin/bash
# Build script using AI-LEY variables

# Source from {{folders.src}}
SRC_DIR="src/"

# Build to {{folders.build}}
BUILD_DIR="build/"

# Update {{files.changelog}}
CHANGELOG=".project/CHANGELOG.md"
```

---

## 📊 Variable Management & Maintenance

### Extending the Variable System

Add new variables by updating `folder-structure.yaml`:

```yaml
# Add new folder category
folders:
  deployment:
    staging: deployment/staging/
    production: deployment/production/
    rollback: deployment/rollback/

# Add new file types
files:
  deployment-config: deployment/config.yml
  rollback-plan: deployment/ROLLBACK.md
```

### Variable Validation

Ensure variables are properly defined and accessible:

```yaml
# Validation rules
validation:
  required_folders:
    - src
    - project
    - build
  required_files:
    - readme
    - requirements
    - plan
  path_format: 'relative'
  case_sensitivity: false
```

### Version Management

Track variable system changes:

```yaml
metadata:
  version: '2.1.0'
  last_updated: '2025-09-08'
  compatibility: 'AI-LEY v1.0+'
  breaking_changes: []
  deprecated_variables: []
```

---

## 🎯 Best Practices

### Variable Naming Conventions

- **Descriptive Names**: Use clear, descriptive variable names
- **Hierarchical Organization**: Use nested structure for related items
- **Consistent Patterns**: Follow established naming patterns
- **Avoid Conflicts**: Ensure unique names across categories

### Path Management

- **Relative Paths**: Use relative paths from project root
- **Platform Neutral**: Use forward slashes, let system handle conversion
- **No Hardcoding**: Always use variables instead of hardcoded paths
- **Consistent Structure**: Maintain consistent folder hierarchy

### Integration Guidelines

- **Command Design**: Design commands to work with standard variables
- **Template Creation**: Use variables in all templates and examples
- **Documentation**: Reference variables in all documentation
- **Testing**: Test variable resolution across platforms

---

## 🚀 Advanced Variable Patterns

### Conditional Variables

Variables that change based on context:

```yaml
# Environment-specific variables
folders:
  logs: ${NODE_ENV === 'production' ? 'logs/prod/' : 'logs/dev/'}
  config: ${NODE_ENV === 'production' ? 'config/prod/' : 'config/dev/'}
```

### Computed Variables

Variables derived from other variables:

```yaml
# Computed paths
folders:
  build_output: '${folders.build}/output/'
  test_reports: '${folders.tests}/reports/'

files:
  build_log: '${folders.build}/build.log'
  test_results: '${folders.tests}/results.json'
```

### Variable Inheritance

Projects can inherit and extend base variables:

```yaml
# Base variables (from AI-LEY core)
extends: 'ai-ley://variables/base.yaml'

# Project-specific extensions
folders:
  custom_assets: 'assets/custom/'
  integrations: 'src/integrations/'

files:
  project_config: 'config/project.json'
  api_spec: 'docs/api-spec.yaml'
```

The AI-LEY variables system provides a robust, extensible foundation for consistent project organization and reliable automation across all development activities and AI-assisted workflows.
