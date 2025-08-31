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
```bash
# Example Agile development workflow
git checkout -b feature/user-story-123
# Develop feature with TDD approach
npm run test:watch
# Commit frequently with descriptive messages
git commit -m "feat: add user authentication endpoint

- Implements OAuth 2.0 integration
- Adds input validation and error handling
- Includes unit tests with 95% coverage

Closes #123"
```

#### Continuous Integration Integration
```yaml
# CI/CD pipeline supporting Agile delivery
name: Agile Delivery Pipeline
on:
  pull_request:
    branches: [main, develop]
  push:
    branches: [main]

jobs:
  quality_gate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run tests
        run: npm test
      - name: Check coverage
        run: npm run coverage:check
      - name: Static analysis
        run: npm run lint
      - name: Security scan
        run: npm audit

  deployment:
    needs: quality_gate
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to staging
        run: ./deploy-staging.sh
      - name: Run acceptance tests
        run: npm run test:e2e
      - name: Deploy to production
        run: ./deploy-production.sh
```

#### Documentation Requirements
- User stories with acceptance criteria
- Sprint goals and retrospective notes
- Architecture decision records (ADRs)
- Definition of Done and team working agreements

## Best Practices

### Sprint Planning and Management
#### User Story Writing
```gherkin
#  Good: Well-structured user story
Feature: User Authentication
  As a registered user
  I want to log into my account
  So that I can access my personal dashboard

  Background:
    Given I am on the login page

  Scenario: Successful login
    Given I have a valid account
    When I enter my correct email and password
    And I click the "Sign In" button
    Then I should be redirected to my dashboard
    And I should see a welcome message

  Scenario: Invalid credentials
    When I enter an incorrect email or password
    And I click the "Sign In" button
    Then I should see an error message
    And I should remain on the login page
```

#### Sprint Goal Definition
```markdown
#  Good: Clear sprint goal
## Sprint 15 Goal
Enable new users to complete account registration and email verification 
so that they can access basic platform features.

### Success Criteria
- [ ] User registration form accepts and validates input
- [ ] Email verification system sends and processes confirmation
- [ ] New users can log in after verification
- [ ] Welcome tutorial guides users through first use

### Definition of Done
- [ ] Code reviewed and approved by 2+ team members
- [ ] Unit tests with >90% coverage
- [ ] Integration tests pass
- [ ] Accessibility requirements met (WCAG 2.1 AA)
- [ ] Performance tests show <2s page load times
- [ ] Security review completed
- [ ] Product owner accepts user stories
```

### Daily Standups and Communication
#### Effective Daily Standup Format
```markdown
# Daily Standup Template

## What I completed yesterday:
- [Specific accomplishments with ticket numbers]

## What I plan to work on today:
- [Specific tasks with priorities]

## Blockers and impediments:
- [Any obstacles needing team help]

## Help needed:
- [Specific assistance requests]

## Dependencies:
- [Work waiting on others or affecting others]
```

### Backlog Management
#### Story Prioritization Framework
```javascript
// Product Backlog Item scoring example
class BacklogItem {
  constructor(title, businessValue, effort, risk, knowledge) {
    this.title = title;
    this.businessValue = businessValue; // 1-10
    this.effort = effort; // 1-13 (Fibonacci)
    this.risk = risk; // 1-5
    this.knowledge = knowledge; // 1-5
  }

  calculatePriority() {
    // Weighted Shortest Job First (WSJF) approach
    const costOfDelay = this.businessValue + this.risk;
    const jobSize = this.effort;
    return costOfDelay / jobSize;
  }

  getComplexityRating() {
    if (this.effort <= 3) return 'Simple';
    if (this.effort <= 8) return 'Medium';
    return 'Complex';
  }
}
```

## Common Patterns and Examples

### Pattern 1: Feature Toggle Implementation
**Scenario**: Deploying incomplete features without impacting users
**Implementation**:
```javascript
// Feature toggle for gradual rollout
class FeatureToggle {
  constructor(configService) {
    this.config = configService;
  }

  isEnabled(featureName, userId = null) {
    const feature = this.config.getFeature(featureName);
    
    if (!feature || !feature.enabled) return false;
    
    // Percentage rollout
    if (feature.percentage && userId) {
      const hash = this.hashUserId(userId);
      return hash < feature.percentage;
    }
    
    // User whitelist
    if (feature.whitelist && userId) {
      return feature.whitelist.includes(userId);
    }
    
    return feature.enabled;
  }
}

// Usage in component
function NewFeatureComponent({ userId }) {
  const isNewFeatureEnabled = useFeatureToggle('new-dashboard', userId);
  
  return isNewFeatureEnabled ? 
    <NewDashboard /> : 
    <LegacyDashboard />;
}
```
**Expected Outcomes**: Continuous delivery without user-facing regressions

### Pattern 2: Definition of Ready Checklist
**Scenario**: Ensuring user stories are prepared before sprint planning
**Implementation**:
```markdown
# Definition of Ready Checklist

## Story Requirements 
- [ ] User story follows INVEST criteria (Independent, Negotiable, Valuable, Estimatable, Small, Testable)
- [ ] Acceptance criteria are clear and testable
- [ ] Business value and user impact defined
- [ ] Dependencies identified and resolved
- [ ] Wireframes or mockups provided (if UI changes)

## Technical Requirements 
- [ ] Technical approach discussed and documented
- [ ] Architecture impacts assessed
- [ ] Performance requirements defined
- [ ] Security considerations reviewed
- [ ] API contracts defined (if applicable)

## Team Readiness 
- [ ] Story sized and estimated by team
- [ ] Required skills available within sprint
- [ ] External dependencies confirmed
- [ ] Testable in current environment
```
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
```javascript
// Agile metrics tracking example
class AgileMetrics {
  calculateVelocity(sprints) {
    const completedStoryPoints = sprints.map(sprint => 
      sprint.completedStories.reduce((sum, story) => sum + story.points, 0)
    );
    return completedStoryPoints.reduce((sum, points) => sum + points) / sprints.length;
  }

  calculateBurndownData(sprint) {
    return sprint.days.map(day => ({
      date: day.date,
      remaining: day.remainingStoryPoints,
      ideal: this.calculateIdealBurndown(sprint, day)
    }));
  }

  calculateCycleTime(workItems) {
    return workItems.map(item => ({
      id: item.id,
      cycleTime: item.completedDate - item.startedDate,
      leadTime: item.completedDate - item.createdDate
    }));
  }
}
```

### Templates and Checklists
#### Sprint Retrospective Template
```markdown
# Sprint Retrospective Template

## What went well? =

- [Things to continue doing]

## What didn't go well? =
- [Issues and frustrations]

## What should we try next? =¡
- [Experiments and improvements]

## Action Items <¯
- [ ] Action 1 - Owner: [Name] - Due: [Date]
- [ ] Action 2 - Owner: [Name] - Due: [Date]

## Metrics Review =Ê
- Velocity: [X] story points (vs [Y] planned)
- Sprint Goal: [Achieved/Partially Achieved/Not Achieved]
- Cycle Time: [Average] days
- Team Satisfaction: [Rating]/10
```

### Learning Resources
- **Scrum Guide**: https://scrumguides.org/
- **Agile Alliance**: https://www.agilealliance.org/
- **Scaled Agile Framework (SAFe)**: https://www.scaledagileframework.com/
- **Atlassian Agile Coach**: https://www.atlassian.com/agile

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
-  Enforce practices that improve code quality and maintainability
-  Require comprehensive test coverage for all new features
-  Promote continuous integration and deployment practices
-  Block practices that create dependencies and reduce team agility
-  Require user story acceptance criteria before implementation
-  Enforce coding standards that support team collaboration
-  Promote practices that enable quick feedback and iteration
-  Require traceability from user stories to implementation