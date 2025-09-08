# AI-LEY User Guide

Welcome to AI-LEY, the comprehensive automation framework for AI-assisted project development. This user guide provides step-by-step instructions, common workflows, and real-world examples to help you master AI-LEY across multiple AI platforms.

## 🚀 Getting Started

### Prerequisites

- AI platform of choice (GitHub Copilot, Claude, Cursor, Cline, Gemini, etc.)
- Basic understanding of project development
- Development environment set up for your technology stack

### Quick Setup

1. **Initialize AI-LEY Structure**: Set up the basic folder structure in your project
2. **Choose Your AI Platform**: Install and configure your preferred AI assistant
3. **Run Your First Command**: Start with `/ask` to define your project goals

## 🎯 Basic Workflow - First Project

### Step 1: Define Your Project Vision

Start by clearly articulating what you want to build:

```bash
/ask "Build a modern task management web application with user authentication, real-time collaboration, and mobile-responsive design. Users should be able to create projects, assign tasks, set deadlines, and track progress. Include features for team collaboration, file attachments, and notification systems."
```

**What This Does**:

- Creates or updates `{{files.ask}}` with your project requirements
- Structures your ideas in a format AI can process
- Sets the foundation for all subsequent development steps

### Step 2: Generate Comprehensive Requirements

Transform your high-level ideas into detailed technical specifications:

```bash
/requirements
```

**What This Produces**:

- Detailed `{{files.requirements}}` document with functional and non-functional requirements
- `{{files.requirements_changelog}}` tracking requirement evolution
- Clear acceptance criteria for each feature
- Technical constraints and assumptions

**Example Output Structure**:

```markdown
# Task Management Application Requirements

## Functional Requirements (R1-R15)

**R1: User Authentication System**

- Users must register with email and password
- Email verification required before account activation
- Secure login with password hashing (bcrypt)
- Password reset functionality via email

## Non-Functional Requirements (NF1-NF8)

**NF1: Performance Requirements**

- Page load time under 2 seconds
- Support 1000+ concurrent users
- 99.9% uptime requirement
```

### Step 3: Research and Learn

Conduct comprehensive research to inform your development approach:

```bash
/learn
```

**Research Areas Covered**:

- Competitive analysis of similar applications
- Technology stack recommendations
- Industry best practices and patterns
- Market opportunities and positioning
- Security and compliance considerations

### Step 4: Create Implementation Plan

Generate a detailed development roadmap:

```bash
/plan
```

**Plan Components**:

- Epic-Story-Task breakdown structure
- Development timeline with milestones
- Resource requirements and dependencies
- Risk assessment and mitigation strategies
- Quality assurance and testing approach

### Step 5: Execute Development

Begin implementation with intelligent task management:

```bash
/run
```

**Implementation Features**:

- Automated task prioritization
- Code generation following best practices
- Progress tracking and milestone management
- Quality gates and validation checkpoints

## 🌟 Complete Project Development Lifecycle

For comprehensive projects, AI-LEY provides the full build-project workflow that takes you from initial idea to market-ready product with complete business development.

### The Build-Project Master Workflow

This workflow demonstrates AI-LEY's most powerful capability - complete project development including business planning and market preparation:

```mermaid
graph TD
    A[/ask] --> B[/requirements]
    B --> C[/learn]
    C --> D[/evolve]
    D --> E{Suggestions Empty?}
    E -->|No| F[Refine Requirements]
    F --> B
    E -->|Yes| G[/build-design]
    G --> H[/build-architecture]
    H --> I[/evolve]
    I --> J[/plan]
    J --> K[/evolve]
    K --> L[/innovate]
    L --> M[/run]
    M --> N[/build-test-plan]
    N --> O[/document]

    O --> P{Parallel Business Development}
    P --> Q[/build-business-development]
    P --> R[/build-launch-plan]
    P --> S[/build-market-research]

    Q --> T[/build-marketing-strategy]
    R --> U[/build-revenue-projections]
    S --> V[/business-plan]

    T --> W[/go-to-market]
    U --> X[/lean-canvas]
    V --> Y[/pitch-deck]

    W --> Z[🎉 Market Ready Product]
    X --> Z
    Y --> Z
```

### Phase 1: Discovery & Requirements (Weeks 1-2)

#### Initial Vision Definition

```bash
/ask "Build a SaaS project management platform for creative agencies with advanced time tracking, client portal, and automated invoicing"
```

#### Requirements Generation

```bash
/requirements
```

_Generates comprehensive technical and business requirements_

#### Research & Learning

```bash
/learn
```

_Conducts competitive analysis, technology research, and market analysis_

#### Requirements Evolution

```bash
/evolve
```

_Refines requirements based on research findings_

**Expected Deliverables**:

- Comprehensive requirements document (50-100 pages)
- Competitive analysis report
- Technology stack recommendations
- Initial market sizing and opportunity assessment

### Phase 2: Design & Architecture (Weeks 3-4)

#### System Design

```bash
/build-design
```

_Creates user experience design, user flows, and system interfaces_

#### Technical Architecture

```bash
/build-architecture
```

_Defines system architecture, database design, and integration patterns_

#### Design Evolution

```bash
/evolve
```

_Integrates design feedback and architectural refinements_

#### Innovation Analysis

```bash
/innovate
```

_Identifies opportunities for competitive advantage and innovation_

**Expected Deliverables**:

- System design documentation with wireframes
- Technical architecture blueprints
- Database schema and API specifications
- Innovation opportunities report

### Phase 3: Planning & Implementation (Weeks 5-8)

#### Implementation Planning

```bash
/plan
```

_Creates detailed Epic-Story-Task breakdown with timelines_

#### Plan Evolution

```bash
/evolve
```

_Refines plan based on design and architecture insights_

#### Development Execution

```bash
/run
```

_Implements the system with automated task management_

#### Quality Assurance

```bash
/build-test-plan
```

_Creates comprehensive testing strategy and quality gates_

#### Documentation Generation

```bash
/document markdown all
```

_Generates user guides, API documentation, and technical docs_

**Expected Deliverables**:

- Working MVP with core features
- Comprehensive test suite
- Complete technical documentation
- Deployment and operation guides

### Phase 4: Business Development (Weeks 9-12)

This phase runs in parallel streams for maximum efficiency:

#### Business Strategy Stream

```bash
# Sequential execution for business foundation
/build-business-development
/build-marketing-strategy
/build-revenue-projections
/business-plan
```

#### Market Preparation Stream

```bash
# Parallel market analysis and launch prep
/build-launch-plan
/build-market-research
/go-to-market
```

#### Investor Preparation Stream

```bash
# Parallel investor materials development
/lean-canvas
/pitch-deck
```

**Expected Deliverables**:

- Complete business plan (50-75 pages)
- Go-to-market strategy and launch plan
- Financial models and revenue projections
- Professional pitch deck for investors
- Lean canvas business model
- Market research and competitive analysis

### Real-World Example: E-commerce Platform Development

Here's how a team used the complete build-project workflow for an e-commerce platform:

#### Week 1-2: Discovery

```bash
/ask "Build a sustainable fashion e-commerce platform with AR try-on, social shopping features, and carbon footprint tracking for environmentally conscious consumers"

/requirements
# Generated 127 requirements across functional, non-functional, and compliance categories

/learn
# Identified 15 direct competitors, emerging AR/VR trends, and sustainability regulations

/evolve
# Refined requirements based on market analysis, added 23 new requirements for competitive advantage
```

#### Week 3-4: Design & Architecture

```bash
/build-design
# Created mobile-first responsive design with AR integration wireframes

/build-architecture
# Designed microservices architecture with AR service, recommendation engine, and sustainability tracking

/innovate
# Identified AI-powered styling recommendations and blockchain supply chain tracking as differentiators
```

#### Week 5-8: Implementation

```bash
/plan
# Created 12 epics, 47 stories, 156 tasks with 8-week timeline

/run
# Implemented MVP with user authentication, product catalog, AR try-on, and basic social features

/build-test-plan
# Created automated testing covering 85% code coverage, AR performance testing, and user acceptance testing

/document markdown all
# Generated user guides, API documentation, and deployment guides
```

#### Week 9-12: Business Development

```bash
# Business foundation
/build-business-development
# Identified sustainable fashion partnerships, AR technology vendors, and social media influencer networks

/build-marketing-strategy
# Created omnichannel strategy focusing on social media, influencer partnerships, and sustainability messaging

/build-revenue-projections
# Developed financial models showing path to $10M ARR within 3 years

/business-plan
# Generated comprehensive 67-page business plan covering all aspects

# Market preparation
/build-launch-plan
# Created 3-phase launch: beta users (month 1), public launch (month 2), marketing campaign (month 3)

/go-to-market
# Developed partner channel strategy, pricing model, and customer acquisition plans

# Investor materials
/lean-canvas
# Created visual business model canvas highlighting value propositions and market opportunity

/pitch-deck
# Generated 14-slide investor presentation with financial projections and market analysis
```

**Final Results**:

- Fully functional e-commerce platform with AR integration
- Complete business plan and go-to-market strategy
- $2.5M seed funding secured using AI-LEY generated pitch deck
- Platform launched successfully with 10,000+ registered users in first month

## 🛠️ Platform-Specific Usage

### GitHub Copilot (VS Code)

#### Setup

1. Install GitHub Copilot extension
2. Access AI-LEY commands through command palette (`Ctrl+Shift+P`)
3. Commands available as `.github/prompts/*.prompt.md`

#### Usage Patterns

```bash
# Via command palette
> AI-LEY: Requirements Generation
> AI-LEY: Create Project Plan
> AI-LEY: Execute Implementation

# Via direct file interaction
Open: .github/prompts/requirements.prompt.md
```

#### VS Code Integration Features

- Integrated terminal execution
- File diff visualization
- Git integration for change tracking
- Extension ecosystem compatibility

### Claude Desktop/API

#### Setup

1. Configure Claude with AI-LEY command structure
2. Commands available in `.claude/commands/` directory
3. Natural language interaction with structured output

#### Usage Patterns

```bash
# Natural language command invocation
"Follow the requirements command instructions"
"Execute the build-architecture workflow"
"Run the complete build-project lifecycle"

# Direct command reference
Use .claude/commands/requirements.md
Follow .claude/commands/plan.md process
```

#### Claude-Specific Features

- Conversation continuity across sessions
- Advanced reasoning for complex decision making
- Long-form content generation
- Multi-turn workflow refinement

### Cursor AI

#### Setup

1. Install Cursor with AI-LEY integration
2. Commands work through built-in AI chat
3. Code-first development approach

#### Usage Patterns

```bash
# Integrated development workflow
@ai-ley /requirements for this codebase
@ai-ley /plan based on current architecture
@ai-ley /run next development phase
```

#### Cursor Integration Benefits

- Real-time code generation
- Context-aware suggestions
- Integrated debugging and testing
- Seamless version control

### Cline (VS Code Extension)

#### Setup

1. Install Cline extension in VS Code
2. Configure with AI-LEY command structure
3. Multi-file editing capabilities

#### Usage Patterns

```bash
# Command palette integration
Cline: Execute AI-LEY Requirements
Cline: Run AI-LEY Planning Workflow
Cline: Build Architecture with AI-LEY

# Direct file operations
Edit multiple files with /plan command
Generate documentation with /document command
```

#### Cline Advantages

- Multi-file simultaneous editing
- Terminal integration
- Project-wide refactoring
- Automated file organization

## 🎨 Advanced Workflows

### Feature Development Workflow

For adding new features to existing projects:

```bash
# Define new feature requirements
/ask "Add real-time chat functionality to the task management application with message history, file sharing, and notifications"

# Generate feature-specific requirements
/new-feature "Real-time chat system"

# Or break down manually:
/requirements  # Updates existing requirements
/plan          # Updates project plan with new feature
/run           # Implements new feature
/build-test-plan  # Updates testing strategy
```

### Maintenance & Optimization Workflow

For ongoing project improvement:

```bash
# Regular health assessment
/health-check

# Comprehensive audit
/audit

# Performance optimization
/optimize

# Benchmarking
/bench

# Update AI-LEY components
/update-instructions
/update-personas
/repair-prompts
```

### Multi-Project Portfolio Management

Managing multiple related projects:

```bash
# Project A: Web Application
cd project-a/
/ask "User-facing web application with dashboard"
/requirements
/plan
/run

# Project B: Mobile App
cd ../project-b/
/ask "Mobile companion app for web application"
/requirements
/plan
/run

# Project C: API Backend
cd ../project-c/
/ask "Shared API backend for web and mobile applications"
/requirements
/plan
/run
```

## 🔧 Troubleshooting & Tips

### Common Issues

#### Command Not Recognized

**Problem**: AI doesn't recognize AI-LEY commands
**Solution**:

- Ensure proper file structure with `.ai-ley/shared/prompts/`
- Check that reference files exist in platform-specific directories
- Run `/repair-prompts` to fix missing references

#### Incomplete Requirements Generation

**Problem**: `/requirements` produces incomplete specifications
**Solution**:

- Provide more detailed `/ask` input with specific features and constraints
- Run `/learn` first to gather additional context
- Use `/evolve` to refine and expand requirements iteratively

#### Plan Execution Stalls

**Problem**: `/run` doesn't make progress on implementation
**Solution**:

- Break large tasks into smaller, specific actions
- Ensure requirements are detailed enough for implementation
- Use `/run-next` for step-by-step execution
- Check dependencies and prerequisites

### Best Practices

#### Effective ASK Documents

```bash
# Good: Specific and detailed
/ask "Build a React-based project management application with user authentication (JWT), real-time updates (WebSocket), PostgreSQL database, REST API, responsive design for mobile and desktop, drag-and-drop task management, file upload capabilities, and email notifications"

# Avoid: Too vague
/ask "Build a web app"
```

#### Iterative Refinement

```bash
# Use the feedback loop effectively
/requirements
/learn
/evolve  # Refines requirements based on learning
/requirements  # Updates with refined understanding
```

#### Comprehensive Documentation

```bash
# Generate multiple documentation types
/document markdown user-guide
/document markdown api-docs
/document markdown deployment-guide
/document markdown troubleshooting
```

## 📊 Success Metrics & Monitoring

### Project Health Indicators

Monitor these metrics to ensure project success:

#### Development Velocity

- Requirements completion rate
- Plan execution progress
- Feature delivery timelines
- Quality gate pass rates

#### Code Quality Metrics

- Test coverage percentage
- Code review pass rates
- Bug discovery and resolution times
- Performance benchmark adherence

#### Business Readiness Metrics

- Business plan completeness
- Market research depth and accuracy
- Financial model validation
- Go-to-market strategy readiness

### Continuous Improvement

#### Weekly Reviews

```bash
/health-check  # Assess current project health
```

#### Monthly Assessments

```bash
/audit         # Comprehensive project audit
/optimize      # Identify optimization opportunities
```

#### Quarterly Planning

```bash
/evolve        # Major requirement updates based on learning
/innovate      # Identify new opportunities and improvements
```

## 🎓 Learning Path

### Beginner (Weeks 1-2)

1. Master basic commands: `/ask`, `/requirements`, `/plan`, `/run`
2. Complete first simple project using basic workflow
3. Understand file structure and variable system
4. Learn platform-specific integration (GitHub Copilot, Claude, etc.)

### Intermediate (Weeks 3-4)

1. Use complete build-project workflow
2. Integrate business development commands
3. Master multi-persona workflows
4. Create custom instruction adaptations

### Advanced (Weeks 5-8)

1. Design custom workflows and UML flows
2. Extend AI-LEY with organization-specific personas and instructions
3. Integrate with enterprise development pipelines
4. Mentor other developers in AI-LEY adoption

### Expert (Ongoing)

1. Contribute to AI-LEY community with templates and patterns
2. Develop AI-LEY extensions for specific industries or technologies
3. Lead AI-LEY adoption in large organizations
4. Innovate new workflow patterns and automation strategies

## 🚀 Next Steps

### Immediate Actions

1. **Start Your First Project**: Use the basic workflow with `/ask` → `/requirements` → `/plan` → `/run`
2. **Choose Your Platform**: Set up AI-LEY with your preferred AI assistant
3. **Join the Community**: Connect with other AI-LEY users for tips and best practices

### Expanding Usage

1. **Try Complex Workflows**: Use the complete build-project lifecycle for a comprehensive project
2. **Customize for Your Needs**: Adapt personas and instructions for your technology stack
3. **Scale Across Projects**: Apply AI-LEY to multiple projects and share learnings with your team

### Mastery Goals

1. **Workflow Innovation**: Create custom workflows for your specific industry or use case
2. **Team Leadership**: Train and mentor other developers in AI-LEY adoption
3. **Community Contribution**: Share templates, patterns, and improvements with the AI-LEY community

The AI-LEY system transforms traditional development from manual, ad-hoc processes into systematic, AI-assisted workflows that produce professional-quality results consistently across all project phases from initial concept through market-ready business launch.
