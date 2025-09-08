# AI-LEY Commands & Prompts Reference

This document provides a comprehensive reference for all available AI-LEY commands and prompts, organized by category and use case.

## 📋 Command Categories

### 🚀 Project Lifecycle Commands

Commands that manage the complete project development cycle from idea to launch.

### 🔧 Development & Implementation

Commands focused on technical implementation, coding, and system development.

### 📊 Business & Strategy

Commands for business planning, market analysis, and strategic development.

### 🛠️ Maintenance & Utilities

Commands for system maintenance, repairs, and utility functions.

---

## 🚀 Project Lifecycle Commands

### `/ask`

**Purpose**: Capture and document project requirements and ideas
**Description**: Start your project by documenting goals, features, and requirements in a structured format
**Usage**: `/ask "Build a task management app with user authentication"`
**Outputs**: Updates `{{files.ask}}` with structured project requirements

### `/requirements`

**Purpose**: Generate comprehensive technical requirements from ASK documents
**Description**: Transform high-level project ideas into detailed, actionable technical specifications
**Usage**: `/requirements`
**Prerequisites**: Must have content in `{{files.ask}}`
**Outputs**: Creates detailed `{{files.requirements}}` and `{{files.requirements_changelog}}`

### `/extract-requirements`

**Purpose**: Extract requirements from existing codebase
**Description**: Reverse-engineer requirements documentation from source code and project files
**Usage**: `/extract-requirements`
**Prerequisites**: Existing code in `src/` directory
**Outputs**: Generates `{{files.requirements}}` based on code analysis

### `/learn`

**Purpose**: Research and competitive analysis for the project
**Description**: Conduct market research, technology analysis, and competitive intelligence
**Usage**: `/learn`
**Prerequisites**: Project requirements defined
**Outputs**: Research findings and suggestions for project improvement

### `/evolve`

**Purpose**: Refine project based on learning and feedback
**Description**: Apply insights from research and testing to improve project specifications
**Usage**: `/evolve`
**Prerequisites**: Learning phase completed with suggestions
**Outputs**: Updates to requirements, design, or plan based on evolution

### `/plan`

**Purpose**: Create comprehensive project implementation plan
**Description**: Generate detailed Epic-Story-Task breakdown with timelines and dependencies
**Usage**: `/plan`
**Prerequisites**: Requirements must be defined
**Outputs**: Detailed project plan in `{{files.plan}}`

### `/run`

**Purpose**: Execute project plan with intelligent task management
**Description**: Implement the project plan with automated task execution and progress tracking
**Usage**: `/run`
**Prerequisites**: Project plan must exist
**Outputs**: Implementation progress, completed tasks, and deliverables

### `/run-next`

**Purpose**: Execute the next logical task in the project workflow
**Description**: Intelligently determine and execute the next most important task
**Usage**: `/run-next`
**Prerequisites**: Project context established
**Outputs**: Executes next task and updates project state

---

## 🎨 Design & Architecture Commands

### `/build-design`

**Purpose**: Create comprehensive system design and user experience
**Description**: Generate UI/UX designs, user flows, and visual system architecture
**Usage**: `/build-design`
**Prerequisites**: Requirements defined
**Outputs**: Design specifications, wireframes, and user experience documentation

### `/build-architecture`

**Purpose**: Create technical architecture and system design
**Description**: Generate system architecture, database design, and technical specifications
**Usage**: `/build-architecture`
**Prerequisites**: Requirements and basic design concepts
**Outputs**: Technical architecture documentation and system blueprints

### `/build-flow`

**Purpose**: Create workflow automation and process flows
**Description**: Generate UML flows, process diagrams, and automation workflows
**Usage**: `/build-flow`
**Prerequisites**: Project requirements or specific workflow needs
**Outputs**: UML diagrams and process documentation

### `/innovate`

**Purpose**: Innovation analysis and opportunity identification
**Description**: Analyze project for innovation opportunities and competitive advantages
**Usage**: `/innovate`
**Prerequisites**: Project design and architecture defined
**Outputs**: Innovation recommendations and strategic opportunities

---

## 📊 Business & Strategy Commands

### `/build-business-development`

**Purpose**: Create business development strategy and partnerships
**Description**: Generate partnership opportunities, business development plans, and growth strategies
**Usage**: `/build-business-development`
**Prerequisites**: Core product defined
**Outputs**: Business development strategy and partnership plans

### `/build-launch-plan`

**Purpose**: Create comprehensive product launch strategy
**Description**: Generate launch timeline, marketing campaigns, and go-to-market execution
**Usage**: `/build-launch-plan`
**Prerequisites**: Product development completed
**Outputs**: Detailed launch plan with timelines and milestones

### `/build-market-research`

**Purpose**: Conduct comprehensive market analysis
**Description**: Analyze target market, competition, and market opportunities
**Usage**: `/build-market-research`
**Prerequisites**: Product concept defined
**Outputs**: Market research report and competitive analysis

### `/build-marketing-strategy`

**Purpose**: Create comprehensive marketing strategy
**Description**: Generate marketing campaigns, channel strategies, and promotional plans
**Usage**: `/build-marketing-strategy`
**Prerequisites**: Market research completed
**Outputs**: Marketing strategy and campaign plans

### `/build-revenue-projections`

**Purpose**: Create financial modeling and revenue forecasts
**Description**: Generate revenue models, financial projections, and business metrics
**Usage**: `/build-revenue-projections`
**Prerequisites**: Business model defined
**Outputs**: Financial models and revenue projections

### `/business-plan`

**Purpose**: Generate comprehensive business plan
**Description**: Create investor-ready business plan with all sections and financial models
**Usage**: `/business-plan`
**Prerequisites**: Market research and financial projections completed
**Outputs**: Complete business plan document

### `/go-to-market`

**Purpose**: Create go-to-market strategy and execution plan
**Description**: Generate comprehensive market entry and scaling strategy
**Usage**: `/go-to-market`
**Prerequisites**: Product and market analysis completed
**Outputs**: Go-to-market strategy and execution roadmap

### `/lean-canvas`

**Purpose**: Create lean business model canvas
**Description**: Generate concise business model visualization using lean canvas methodology
**Usage**: `/lean-canvas`
**Prerequisites**: Basic business concept defined
**Outputs**: Lean canvas business model

### `/pitch-deck`

**Purpose**: Create investor presentation and pitch deck
**Description**: Generate compelling investor presentation with financial projections
**Usage**: `/pitch-deck`
**Prerequisites**: Business plan and financial models completed
**Outputs**: Professional pitch deck for investors

---

## 🔧 Development & Implementation Commands

### `/new-feature`

**Purpose**: End-to-end feature development workflow
**Description**: Complete feature development from requirements through implementation
**Usage**: `/new-feature "User authentication system"`
**Prerequisites**: Project structure established
**Outputs**: Feature requirements, design, implementation, and tests

### `/build-test-plan`

**Purpose**: Create comprehensive testing strategy
**Description**: Generate test plans, testing frameworks, and quality assurance processes
**Usage**: `/build-test-plan`
**Prerequisites**: Implementation plan or code exists
**Outputs**: Comprehensive test plan and testing procedures

### `/document`

**Purpose**: Generate comprehensive project documentation
**Description**: Create user guides, API documentation, and technical documentation
**Usage**: `/document markdown all`
**Prerequisites**: Project implementation exists
**Outputs**: Complete documentation set in specified format

### `/git-commit`

**Purpose**: Generate standardized commit messages
**Description**: Create consistent, descriptive Git commit messages following best practices
**Usage**: `/git-commit`
**Prerequisites**: Code changes exist
**Outputs**: Properly formatted Git commit message

---

## 🛠️ Maintenance & Utilities Commands

### `/repair-prompts`

**Purpose**: Repair missing prompt reference files across AI platforms
**Description**: Synchronize command references across GitHub, Claude, and OpenCode platforms
**Usage**: `/repair-prompts`
**Prerequisites**: Prompts exist in `.ai-ley/shared/prompts/`
**Outputs**: Missing reference files in platform-specific directories

### `/new-prompt`

**Purpose**: Create new AI-LEY command prompt
**Description**: Generate new automation command with proper structure across all platforms
**Usage**: `/new-prompt command-name "Description of the command"`
**Prerequisites**: None
**Outputs**: New command files across all AI platforms

### `/alias`

**Purpose**: Create command aliases for existing prompts
**Description**: Create shorter or alternative names for existing commands
**Usage**: `/alias existing-command short-name`
**Prerequisites**: Target command must exist
**Outputs**: Alias reference files across all platforms

### `/update-instructions`

**Purpose**: Update and maintain instruction files
**Description**: Refresh instruction content and ensure consistency across the project
**Usage**: `/update-instructions`
**Prerequisites**: Instructions exist in `{{folders.instructions}}`
**Outputs**: Updated instruction files and indexes

### `/update-personas`

**Purpose**: Update and maintain persona files
**Description**: Refresh persona definitions and ensure consistency across the project
**Usage**: `/update-personas`
**Prerequisites**: Personas exist in `{{folders.personas}}`
**Outputs**: Updated persona files and indexes

### `/audit`

**Purpose**: Comprehensive project audit and validation
**Description**: Analyze project structure, validate files, and identify issues
**Usage**: `/audit`
**Prerequisites**: AI-LEY project structure exists
**Outputs**: Audit report with findings and recommendations

### `/health-check`

**Purpose**: Project health assessment and monitoring
**Description**: Check project health, identify bottlenecks, and suggest improvements
**Usage**: `/health-check`
**Prerequisites**: Active project with some implementation
**Outputs**: Health assessment report

### `/optimize`

**Purpose**: Project optimization and performance improvement
**Description**: Analyze and optimize project performance, structure, and efficiency
**Usage**: `/optimize`
**Prerequisites**: Implementation exists to optimize
**Outputs**: Optimization recommendations and improvements

### `/bench`

**Purpose**: Performance benchmarking and testing
**Description**: Measure project performance and compare against benchmarks
**Usage**: `/bench`
**Prerequisites**: Implementation exists to benchmark
**Outputs**: Performance benchmark report

---

## 🔄 Complex Workflow Examples

### Complete Project Development Lifecycle

The most comprehensive AI-LEY workflow follows this pattern:

```bash
# Phase 1: Discovery & Requirements
/ask "Build a SaaS task management platform"
/requirements
/learn
/evolve

# Phase 2: Design & Architecture
/build-design
/build-architecture
/evolve
/innovate

# Phase 3: Planning & Implementation
/plan
/run
/build-test-plan
/document markdown all

# Phase 4: Business Development
/build-market-research
/build-business-development
/build-marketing-strategy
/build-revenue-projections
/business-plan
/go-to-market
/lean-canvas
/pitch-deck
```

### Feature Development Workflow

For adding new features to existing projects:

```bash
# Define and plan the feature
/new-feature "Advanced reporting dashboard"

# or break it down manually:
/ask "Add advanced reporting with custom dashboards"
/requirements
/plan
/run
/build-test-plan
```

### Maintenance and Optimization Cycle

Regular project maintenance and improvement:

```bash
# Health check and optimization
/health-check
/audit
/optimize
/bench

# Update project components
/update-instructions
/update-personas
/repair-prompts
```

---

## 🔗 Command Dependencies and Relationships

### Prerequisites Chain

```mermaid
graph TD
    A[/ask] --> B[/requirements]
    B --> C[/learn]
    C --> D[/evolve]
    D --> E[/build-design]
    E --> F[/build-architecture]
    F --> G[/plan]
    G --> H[/run]
    H --> I[/document]

    J[/build-market-research] --> K[/build-marketing-strategy]
    K --> L[/build-revenue-projections]
    L --> M[/business-plan]
    M --> N[/pitch-deck]
```

### Feedback Loops

- **Learning Loop**: `/learn` → `/evolve` → updates requirements → `/plan` → `/run`
- **Innovation Loop**: `/innovate` → requirements updates → design changes → plan updates
- **Quality Loop**: `/build-test-plan` → `/run` → `/health-check` → `/optimize`

---

## 🎯 Command Selection Guide

### Starting a New Project

**Primary Commands**: `/ask` → `/requirements` → `/learn` → `/plan` → `/run`

### Adding Features

**Primary Commands**: `/new-feature` or `/ask` → `/requirements` → `/plan` → `/run`

### Business Development

**Primary Commands**: `/build-market-research` → `/build-marketing-strategy` → `/business-plan`

### Project Maintenance

**Primary Commands**: `/health-check` → `/audit` → `/optimize`

### Documentation & Communication

**Primary Commands**: `/document` → `/pitch-deck` → `/lean-canvas`

---

## 🔧 Platform-Specific Usage

### GitHub Copilot

- Access commands via VS Code command palette
- Commands available in `.github/prompts/` directory
- Integrated with VS Code workflow and extensions

### Claude (Desktop/API)

- Commands available in `.claude/commands/` directory
- Natural language interaction with command execution
- Context-aware conversation continuity

### Cursor AI

- Built-in AI features with AI-LEY command integration
- Code-first approach with intelligent suggestions
- Seamless development workflow integration

### Cline (VS Code Extension)

- Command palette integration
- Terminal and editor integration
- Multi-file editing capabilities

### Gemini & Other Platforms

- Universal command structure works across platforms
- Consistent experience regardless of AI provider
- Easy integration with new AI platforms as they emerge

---

## 📈 Success Metrics

### Development Efficiency

- **Setup Time**: 60% reduction in project setup time
- **Planning Time**: 50% faster project planning phase
- **Documentation**: 70% improvement in documentation completeness

### Quality Improvements

- **Architecture**: Expert-level system design patterns
- **Testing**: Comprehensive test coverage by default
- **Best Practices**: Automated adherence to industry standards

### Business Readiness

- **Go-to-Market**: Complete business development included
- **Investor Ready**: Professional pitch decks and business plans
- **Market Analysis**: Comprehensive competitive intelligence

The AI-LEY command system transforms development from ad-hoc coding to systematic, business-ready product development with built-in intelligence and automation.
