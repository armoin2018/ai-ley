---
name: 'Planning.Instructions'
description: 'Development guidelines and best practices for Planning.Instructions'
keywords: [audit, api, capacity, breakdown, architecture, assistant, backend, avoid, azure, benefits]
---



# Software Project Planning Instructions

## Overview
- **Domain**: Software Project Planning and Management
- **Purpose**: Guide systematic planning, estimation, and execution of software development projects
- **Applicable To**: All software development projects from small features to large systems
- **Integration Level**: Core project management methodology affecting all development phases

## Core Principles

### Fundamental Concepts
1. **Iterative Planning**: Plans evolve with understanding and changing requirements
2. **Evidence-Based Estimation**: Use historical data and multiple estimation techniques
3. **Risk-Driven Planning**: Identify and mitigate risks early in the planning process
4. **Stakeholder Alignment**: Ensure all stakeholders understand scope, timeline, and constraints

### Key Benefits
- Improved project predictability and delivery success rates
- Better resource allocation and team coordination
- Early identification and mitigation of project risks
- Clear communication of expectations and progress
- Enhanced ability to adapt to changing requirements

### Common Misconceptions
- **Myth**: Detailed upfront planning eliminates all uncertainty
  **Reality**: Planning reduces uncertainty but must accommodate change
- **Myth**: Agile projects don't need formal planning
  **Reality**: Agile requires different planning approaches, not less planning
- **Myth**: Plans are commitments that cannot change
  **Reality**: Plans are tools for coordination that should evolve with new information

## Implementation Framework

### Getting Started
#### Prerequisites
- Clear understanding of project objectives and success criteria
- Stakeholder identification and availability for planning sessions
- Access to historical project data for estimation
- Understanding of organizational constraints and processes

#### Initial Setup
1. **Project Charter**: Define purpose, scope, objectives, and high-level constraints
2. **Stakeholder Mapping**: Identify all stakeholders and their roles/responsibilities
3. **Planning Tools**: Select appropriate planning and tracking tools
4. **Team Formation**: Assemble planning team with appropriate skills and authority

### Core Methodologies
#### Work Breakdown Structure (WBS)
- **Purpose**: Decompose project scope into manageable, estimable components
- **When to Use**: All projects requiring detailed planning and resource allocation
- **Implementation Steps**:
  1. Start with high-level deliverables and major components
  2. Decompose each component into smaller, manageable work packages
  3. Continue until work packages are 8-80 hours of effort
  4. Validate completeness and eliminate overlaps
- **Success Metrics**: All work packages are estimable, assignable, and measurable

#### Three-Point Estimation
- **Purpose**: Provide realistic estimates that account for uncertainty
- **When to Use**: When uncertainty exists in scope, complexity, or dependencies
- **Implementation Steps**:
  1. Estimate optimistic (best case) duration/effort
  2. Estimate pessimistic (worst case) duration/effort
  3. Estimate most likely (realistic) duration/effort
  4. Calculate expected value: (Optimistic + 4×Most Likely + Pessimistic) ÷ 6
- **Success Metrics**: Estimates fall within confidence intervals on completed work

### Process Integration
#### Development Workflow Integration
See [example-1](./examples/planning/example-1.bash)

#### Continuous Integration Integration
See [example-2](./examples/planning/example-2.yaml)

#### Documentation Requirements
- Project charter with clear objectives and constraints
- Work breakdown structure with effort estimates
- Risk register with mitigation strategies
- Resource allocation and timeline planning
- Definition of done and acceptance criteria

## Best Practices

### Project Scope and Requirements
#### Requirements Gathering Template
See [example-3](./examples/planning/example-3.markdown)

#### Scope Management
See [example-4](./examples/planning/example-4.markdown)

### Estimation and Timeline Planning
#### Story Point Estimation Framework
See [example-5](./examples/planning/example-5.javascript)

#### Project Timeline Planning
See [example-6](./examples/planning/example-6.markdown)mermaid
gantt
    title Project Timeline with Dependencies
    dateFormat  YYYY-MM-DD
    section Planning
    Requirements Gathering    :req, 2024-01-01, 2024-01-14
    Architecture Design      :arch, after req, 14d
    section Development
    Backend API              :api, after arch, 28d
    Frontend Development     :ui, after arch, 35d
    Integration             :int, after api, 14d
    section Testing
    Unit Testing            :unit, after api, 21d
    Integration Testing     :test, after int, 14d
    User Acceptance Testing :uat, after test, 7d
    section Deployment
    Production Deployment   :prod, after uat, 3d
See [example-7](./examples/planning/example-7.txt)

### Risk Management
#### Risk Assessment Framework
See [example-8](./examples/planning/example-8.markdown)

## Common Patterns and Examples

### Pattern 1: Epic Breakdown Planning
**Scenario**: Breaking down large features into manageable development increments
**Implementation**:
See [example-9](./examples/planning/example-9.markdown)
**Expected Outcomes**: Clear development roadmap with estimable work packages

### Pattern 2: Capacity Planning
**Scenario**: Planning team capacity and resource allocation across multiple projects
**Implementation**:
See [example-10](./examples/planning/example-10.javascript)
**Expected Outcomes**: Realistic sprint planning based on actual team availability

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Over-Planning
- **Description**: Creating overly detailed plans that become outdated quickly
- **Why It's Problematic**: Wastes time and creates false confidence in predictability
- **Better Approach**: Plan in detail for near-term work, outline for longer-term items

#### Anti-Pattern 2: Planning in Isolation
- **Description**: Creating plans without input from implementation team
- **Why It's Problematic**: Estimates are unrealistic and team has no ownership
- **Better Approach**: Collaborative planning with implementation team involved

## Tools and Resources

### Essential Tools
#### Planning and Estimation Tools
- **Jira**: Comprehensive project management with agile planning features
- **Azure DevOps**: Integrated planning with development tools
- **Linear**: Modern issue tracking with excellent planning features
- **Notion**: Flexible workspace for planning documentation

#### Estimation and Forecasting
- **Monte Carlo Simulation**: Statistical forecasting based on historical data
- **Planning Poker Apps**: Digital tools for collaborative estimation
- **Spreadsheet Templates**: Custom planning and tracking templates

### Templates and Checklists
#### Project Kickoff Checklist
- [ ] **Project Charter**: Objectives, scope, constraints, success criteria defined
- [ ] **Stakeholder Map**: All stakeholders identified with roles and communication preferences
- [ ] **Team Formation**: Core team members identified and committed
- [ ] **Requirements Baseline**: Initial requirements documented and prioritized
- [ ] **Risk Assessment**: Major risks identified with initial mitigation strategies
- [ ] **Planning Tools**: Project management tools configured and team trained
- [ ] **Communication Plan**: Meeting cadence and communication channels established
- [ ] **Definition of Done**: Quality criteria and acceptance standards agreed upon

### Learning Resources
- **Project Management Institute (PMI)**: Professional project management standards
- **Scrum Alliance**: Agile planning methodologies and certification
- **PRINCE2**: Structured project management methodology
- **Agile Estimating and Planning** by Mike Cohn: Comprehensive guide to agile planning

## Quality and Compliance

### Quality Standards
- All estimates based on historical data and team input
- Risk assessment completed and updated regularly
- Stakeholder sign-off on major planning decisions
- Planning documents maintained and accessible to team

### Compliance Requirements
#### Audit Documentation
- **Requirements**: Maintain planning artifacts for compliance audits
- **Implementation**: Version-controlled planning documents with approval trails
- **Verification**: Regular review of planning artifacts for completeness

#### Resource Tracking
- **Requirements**: Track actual vs. planned effort for future estimation improvement
- **Implementation**: Time tracking integration with project management tools
- **Verification**: Monthly variance analysis and estimation accuracy review

### Audit and Review Processes
- Weekly planning review and adjustment sessions
- Monthly planning retrospectives to improve process
- Quarterly planning methodology evaluation
- Annual planning tool and process assessment

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Estimates Consistently Too Low
**Symptoms**: Teams regularly exceed time estimates, sprint goals not met
**Root Causes**: Optimistic bias, missing work identification, insufficient breaking down
**Solutions**:
1. Use three-point estimation to account for uncertainty
2. Include time for code review, testing, and documentation
3. Add buffer time for unexpected issues (20-30%)
4. Review historical estimation accuracy and adjust accordingly
**Prevention**: Regular estimation calibration and retrospective analysis

#### Issue 2: Scope Creep and Changing Requirements
**Symptoms**: Project timeline extends, budget overruns, team frustration
**Root Causes**: Unclear initial requirements, stakeholder pressure, poor change control
**Solutions**:
1. Implement formal change request process with impact assessment
2. Regular stakeholder communication and expectation management
3. Time-box requirement exploration and defer non-critical changes
4. Maintain clear documentation of what's in and out of scope
**Prevention**: Detailed requirements gathering and stakeholder alignment upfront

### Escalation Procedures
- Planning issues: Escalate to project sponsor or steering committee
- Resource conflicts: Escalate to resource managers and department heads
- Technical risks: Escalate to architecture team or technical advisory board
- Timeline concerns: Escalate to portfolio management or executive team

### Continuous Improvement
- Regular planning retrospectives to identify process improvements
- Tracking of estimation accuracy and planning effectiveness metrics
- Experimentation with new planning techniques and tools
- Knowledge sharing across teams and projects

## AI Assistant Guidelines

When helping with Software Project Planning:

1. **Data-Driven Approach**: Base recommendations on historical data and proven methodologies
2. **Stakeholder Focus**: Consider all stakeholders and their needs in planning decisions
3. **Risk Awareness**: Always identify and plan for potential risks and uncertainties
4. **Iterative Planning**: Recommend adaptive planning approaches that can evolve
5. **Team Collaboration**: Emphasize collaborative planning with implementation teams
6. **Realistic Expectations**: Provide realistic estimates and timelines based on team capacity
7. **Documentation**: Ensure all planning decisions are documented and accessible
8. **Continuous Improvement**: Build learning and improvement into planning processes

### Decision Making Framework
When helping teams with project planning:

1. **Context Analysis**: Understand project size, complexity, team experience, and constraints
2. **Methodology Selection**: Choose appropriate planning methodologies for the situation
3. **Tool Evaluation**: Recommend tools that fit team size, complexity, and integration needs
4. **Risk Assessment**: Help identify and prioritize potential project risks
5. **Capacity Planning**: Ensure realistic planning based on actual team availability
6. **Success Metrics**: Define measurable criteria for project success and progress

### Code Generation Rules
- Generate planning templates that are practical and actionable
- Include realistic examples based on common project scenarios
- Provide checklists and frameworks for systematic planning
- Create planning artifacts that integrate with development workflows
- Include monitoring and tracking mechanisms in planning templates
- Generate risk assessment and mitigation planning tools

### Quality Enforcement
-  Enforce evidence-based estimation and planning approaches
-  Require stakeholder involvement in planning decisions
-  Block planning that ignores team capacity and constraints
-  Promote iterative and adaptive planning methodologies
-  Require risk assessment and mitigation planning
-  Enforce documentation of planning decisions and rationale
-  Promote learning and improvement from planning outcomes
-  Require regular planning review and adjustment processes

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
