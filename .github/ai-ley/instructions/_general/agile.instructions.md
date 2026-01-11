---
name: 'Agile.Instructions'
description: 'Development guidelines and best practices for Agile.Instructions'
keywords: [audit, checklist, agile, backlog, agile.instructions, architecture, assistant, avoid, azure, benefits]
---

# Agile Development Instructions

## Overview
- **Domain**: Agile Software Development Methodologies
- **Purpose**: Guide iterative, collaborative, and adaptive software development practices
- **Applicable To**: Software development teams, product development, and project management
- **Integration Level**: Core development methodology affecting all aspects of software delivery

## Core Principles

### Fundamental Concepts
1. **Individuals and Interactions** over processes and tools
2. **Working Software** over comprehensive documentation
3. **Customer Collaboration** over contract negotiation
4. **Responding to Change** over following a plan

### Key Benefits
- Faster time-to-market with iterative delivery
- Higher customer satisfaction through continuous feedback
- Improved team collaboration and communication
- Better adaptability to changing requirements
- Reduced project risk through frequent inspection and adaptation

### Common Misconceptions
- **Myth**: Agile means no planning or documentation
  **Reality**: Agile emphasizes just-enough planning and documentation that adds value
- **Myth**: Agile is only for software development
  **Reality**: Agile principles apply to many types of knowledge work and product development
- **Myth**: Agile means faster delivery at all costs
  **Reality**: Agile focuses on delivering value early and often, with sustainable pace

## Implementation Framework

### Getting Started
#### Prerequisites
- Team commitment to collaboration and transparency
- Product owner availability for regular feedback
- Development team with cross-functional skills
- Organizational support for iterative delivery

#### Initial Setup
1. **Team Formation**: Establish cross-functional development team (5-9 members)
2. **Role Definition**: Define Product Owner, Scrum Master, and Development Team roles
3. **Tool Setup**: Configure project management tools (Jira, Azure DevOps, etc.)
4. **Workspace Design**: Create collaborative physical or virtual workspaces

### Core Methodologies
#### Scrum Framework
- **Purpose**: Structured approach to iterative development with defined roles, events, and artifacts
- **When to Use**: Teams new to Agile, complex product development, established organizations
- **Implementation Steps**:
  1. Form Scrum team with Product Owner, Scrum Master, and Developers
  2. Create and maintain Product Backlog with user stories and acceptance criteria
  3. Plan 1-4 week sprints with Sprint Planning, Daily Standups, Sprint Review, and Retrospective
  4. Deliver potentially shippable product increment each sprint
- **Success Metrics**: Sprint completion rate, velocity trends, customer satisfaction

#### Kanban Method
- **Purpose**: Visualize workflow and optimize for continuous delivery
- **When to Use**: Maintenance teams, continuous delivery environments, variable demand
- **Implementation Steps**:
  1. Visualize current workflow on Kanban board
  2. Set work-in-progress (WIP) limits for each workflow stage
  3. Manage flow by measuring cycle time and throughput
  4. Continuously improve through regular workflow optimization
- **Success Metrics**: Cycle time, throughput, flow efficiency

### Process Integration
#### Development Workflow Integration
See [example-1](./examples/agile/example-1.bash)

#### Continuous Integration Integration
See [example-2](./examples/agile/example-2.yaml)

#### Documentation Requirements
- User stories with acceptance criteria
- Sprint goals and retrospective notes
- Architecture decision records (ADRs)
- Definition of Done and team working agreements

## Best Practices

### Sprint Planning and Management
#### User Story Writing
See [example-3](./examples/agile/example-3.gherkin)

#### Sprint Goal Definition
See [example-4](./examples/agile/example-4.markdown)

### Daily Standups and Communication
#### Effective Daily Standup Format
See [example-5](./examples/agile/example-5.markdown)

### Backlog Management
#### Story Prioritization Framework
See [example-6](./examples/agile/example-6.javascript)

## Common Patterns and Examples

### Pattern 1: Feature Toggle Implementation
**Scenario**: Deploying incomplete features without impacting users
**Implementation**:
See [example-7](./examples/agile/example-7.javascript)
**Expected Outcomes**: Continuous delivery without user-facing regressions

### Pattern 2: Definition of Ready Checklist
**Scenario**: Ensuring user stories are prepared before sprint planning
**Implementation**:
See [example-8](./examples/agile/example-8.markdown)
**Expected Outcomes**: Improved sprint predictability and reduced mid-sprint blockers

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Sprint Commitment Overload
- **Description**: Consistently overcommitting to work in sprints
- **Why It's Problematic**: Leads to rushed work, technical debt, and team burnout
- **Better Approach**: Use historical velocity data and buffer time for unexpected work

#### Anti-Pattern 2: Skipping Retrospectives
- **Description**: Skipping or rushing retrospective meetings
- **Why It's Problematic**: Misses opportunities for team improvement and issue resolution
- **Better Approach**: Regular, well-facilitated retrospectives with concrete action items

## Tools and Resources

### Essential Tools
#### Project Management Tools
- **Jira**: Enterprise agile project management with robust reporting
- **Azure DevOps**: Integrated DevOps platform with agile planning tools
- **GitHub Projects**: Simple kanban boards integrated with code repositories

#### Collaboration Tools
- **Miro/Mural**: Digital whiteboards for collaborative planning and retrospectives
- **Slack/Teams**: Team communication with integration to development tools
- **Confluence**: Documentation and knowledge sharing platform

#### Metrics and Reporting
See [example-9](./examples/agile/example-9.javascript)

### Templates and Checklists
#### Sprint Retrospective Template
See [example-10](./examples/agile/example-10.markdown)

### Learning Resources
- [Scrum Guide](https://scrumguides.org/)
- [Agile Alliance](https://www.agilealliance.org/)
- [Scaled Agile Framework (SAFe)](https://www.scaledagileframework.com/)
- [Atlassian Agile Coach](https://www.atlassian.com/agile)

## Quality and Compliance

### Quality Standards
- Sprint goals achieved 80%+ of the time
- Team velocity stabilizes within 20% variance after 6 sprints
- Customer satisfaction scores consistently above 4/5
- Technical debt remains below 20% of total development effort

### Compliance Requirements
#### Regulatory Environments
- **Requirements**: Maintain traceability from requirements to implementation
- **Implementation**: Use tools that link user stories to code commits and test results
- **Verification**: Regular audits of requirement traceability matrix

#### Documentation Standards
- **Requirements**: Maintain just-enough documentation for compliance
- **Implementation**: Living documentation that evolves with the product
- **Verification**: Documentation reviews as part of Definition of Done

### Audit and Review Processes
- Monthly agile maturity assessments
- Quarterly retrospective of retrospectives
- Annual agile coaching and training evaluation
- Continuous feedback collection from team members and stakeholders

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Unstable Velocity
**Symptoms**: Wide variation in story points completed across sprints
**Root Causes**: Inconsistent story sizing, changing team composition, external dependencies
**Solutions**:
1. Improve story sizing techniques with planning poker
2. Break large stories into smaller, more predictable pieces
3. Address external dependencies during sprint planning
4. Track and analyze velocity trends over time
**Prevention**: Regular estimation calibration sessions and dependency management

#### Issue 2: Low Team Engagement
**Symptoms**: Poor attendance at ceremonies, limited participation in discussions
**Root Causes**: Meeting fatigue, lack of psychological safety, unclear purpose
**Solutions**:
1. Revisit meeting purposes and formats
2. Create safe environment for open discussion
3. Rotate facilitation responsibilities
4. Focus on outcomes rather than ceremony compliance
**Prevention**: Regular team health checks and continuous improvement focus

### Escalation Procedures
- Team-level issues: Address in retrospectives and with Scrum Master support
- Process issues: Escalate to agile coach or agile center of excellence
- Organizational blockers: Escalate to management with specific impact data
- Inter-team coordination: Use program-level ceremonies and communities of practice

### Continuous Improvement
- Implement small experiments based on retrospective outcomes
- Measure impact of process changes with clear metrics
- Share learnings across teams and organization
- Regular training and coaching to develop agile mindset

## AI Assistant Guidelines

When helping with Agile Development:

1. **People Over Process**: Always consider human factors and team dynamics first
2. **Context Sensitivity**: Adapt agile practices to team size, maturity, and organizational culture
3. **Empirical Approach**: Base recommendations on data and evidence rather than dogma
4. **Continuous Improvement**: Frame all advice in terms of experiments and learning
5. **Value Delivery**: Focus on delivering working software and business value
6. **Collaboration**: Promote practices that improve team communication and collaboration
7. **Sustainable Pace**: Recommend practices that support long-term team health
8. **Customer Focus**: Keep end-user value and satisfaction as primary measures of success

### Decision Making Framework
When helping teams adopt or improve agile practices:

1. **Current State Assessment**: Understand existing processes and pain points
2. **Team Readiness**: Evaluate team skills, experience, and willingness to change
3. **Organizational Context**: Consider company culture, structure, and constraints
4. **Gradual Adoption**: Recommend incremental changes rather than wholesale transformation
5. **Success Metrics**: Define measurable outcomes for process changes
6. **Regular Inspection**: Build in checkpoints to evaluate and adjust approaches

### Code Generation Rules
- Generate code that supports agile practices (testable, modular, deployable)
- Include comprehensive test coverage to enable confident refactoring
- Provide examples of feature toggles and gradual rollout patterns
- Create code that follows SOLID principles for maintainability
- Include monitoring and logging for continuous feedback
- Generate documentation that evolves with the code

### Quality Enforcement
- Enforce practices that improve code quality and maintainability
- Require comprehensive test coverage for all new features
- Promote continuous integration and deployment practices
- Block practices that create dependencies and reduce team agility
- Require user story acceptance criteria before implementation
- Enforce coding standards that support team collaboration
- Promote practices that enable quick feedback and iteration
- Require traceability from user stories to implementation

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
