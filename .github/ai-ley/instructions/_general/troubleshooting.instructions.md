---
name: 'Troubleshooting.Instructions'
description: 'See [example-9](./examples/troubleshooting/example-9.'
keywords: [audit, approach, common, compliance, checklists, architecture, assistant, classification, avoid, benefits]
---



# Software Troubleshooting Instructions

## Overview
- **Domain**: Software Problem Diagnosis and Resolution
- **Purpose**: Systematic approach to identifying, diagnosing, and resolving software issues
- **Applicable To**: All software systems, from development to production environments
- **Integration Level**: Critical operational skill affecting system reliability and user experience

## Core Principles

### Fundamental Concepts
1. **Systematic Approach**: Follow structured methodology to avoid missing critical steps
2. **Reproduce First**: Consistently reproduce issues before attempting fixes
3. **Minimal Changes**: Make one change at a time to isolate cause and effect
4. **Document Everything**: Record symptoms, steps, and resolutions for future reference

### Key Benefits
- Faster problem resolution with systematic approach
- Reduced downtime and improved system reliability
- Knowledge accumulation for preventing future issues
- Better team collaboration through shared troubleshooting practices
- Improved customer satisfaction through quick issue resolution

### Common Misconceptions
- **Myth**: Experienced developers don't need systematic troubleshooting
  **Reality**: Complex systems require structured approaches regardless of experience
- **Myth**: Quick fixes are better than thorough investigation
  **Reality**: Understanding root causes prevents recurring issues
- **Myth**: Troubleshooting is only for production issues
  **Reality**: Development and testing environments benefit from systematic debugging

## Implementation Framework

### Getting Started
#### Prerequisites
- Access to relevant logs, monitoring tools, and system documentation
- Understanding of system architecture and component interactions
- Basic knowledge of debugging tools and techniques
- Permission to access and modify relevant systems and configurations

#### Initial Setup
1. **Tool Preparation**: Set up logging, monitoring, and debugging tools
2. **Documentation Access**: Ensure access to system documentation and runbooks
3. **Communication Channels**: Establish incident communication procedures
4. **Escalation Paths**: Define when and how to escalate issues

### Core Methodologies
#### Root Cause Analysis (RCA)
- **Purpose**: Identify underlying causes rather than treating symptoms
- **When to Use**: For recurring issues, critical system failures, or post-incident analysis
- **Implementation Steps**:
  1. Define the problem clearly with specific symptoms
  2. Collect evidence and data about the issue
  3. Map the sequence of events leading to the problem
  4. Identify potential causes using techniques like "5 Whys"
  5. Test hypotheses and validate root causes
  6. Implement corrective and preventive actions
- **Success Metrics**: Issues don't recur, preventive measures are implemented

#### Binary Search Debugging
- **Purpose**: Efficiently narrow down the source of issues in large codebases
- **When to Use**: When dealing with large systems or recent changes causing issues
- **Implementation Steps**:
  1. Identify the working and non-working states
  2. Find a midpoint between the two states
  3. Test the midpoint to determine which half contains the issue
  4. Repeat the process on the problematic half
  5. Continue until the exact cause is isolated
- **Success Metrics**: Problem source identified with minimal testing

### Process Integration
#### Development Workflow Integration
See [example-1](./examples/troubleshooting/example-1.bash)

#### Monitoring Integration
See [example-2](./examples/troubleshooting/example-2.yaml)

#### Documentation Requirements
- Incident response runbooks with step-by-step procedures
- System architecture diagrams showing component relationships
- Log analysis guides with common patterns and solutions
- Escalation procedures and contact information
- Post-incident reports with lessons learned

## Best Practices

### Issue Classification and Prioritization
#### Severity Classification Framework
See [example-3](./examples/troubleshooting/example-3.javascript)

#### Triage Process
See [example-4](./examples/troubleshooting/example-4.markdown)

### Systematic Debugging Approach
#### The TRACE Method
See [example-5](./examples/troubleshooting/example-5.markdown)

#### Log Analysis Framework
See [example-6](./examples/troubleshooting/example-6.bash)

### Performance Troubleshooting
#### Application Performance Analysis
See [example-7](./examples/troubleshooting/example-7.javascript)

## Common Patterns and Examples

### Pattern 1: Database Performance Issues
**Scenario**: Application experiencing slow response times with database-related errors
**Implementation**:
See [example-8](./examples/troubleshooting/example-8.sql)

See [example-9](./examples/troubleshooting/example-9.bash)
**Expected Outcomes**: Identification of slow queries, index issues, or resource constraints

### Pattern 2: Memory Leak Investigation
**Scenario**: Application memory usage continuously increasing over time
**Implementation**:
See [example-10](./examples/troubleshooting/example-10.javascript)
**Expected Outcomes**: Detection of memory growth patterns and identification of potential leak sources

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Guess and Check Debugging
- **Description**: Making random changes without systematic investigation
- **Why It's Problematic**: Can introduce new bugs and wastes time
- **Better Approach**: Follow systematic debugging methodology and test hypotheses

#### Anti-Pattern 2: Fixing Symptoms Instead of Root Causes
- **Description**: Addressing immediate symptoms without investigating underlying causes
- **Why It's Problematic**: Issues will likely recur and may manifest in other ways
- **Better Approach**: Use root cause analysis to identify and fix underlying issues

## Tools and Resources

### Essential Tools
#### Logging and Monitoring
- **ELK Stack**: Elasticsearch, Logstash, Kibana for log aggregation and analysis
- **Prometheus + Grafana**: Metrics collection and visualization
- **Datadog**: Comprehensive monitoring and alerting platform
- **New Relic**: Application performance monitoring

#### Debugging Tools
- **Chrome DevTools**: Frontend debugging and performance analysis
- **Node.js Inspector**: Server-side JavaScript debugging
- **GDB**: System-level debugging for compiled languages
- **Wireshark**: Network protocol analysis

#### System Monitoring
See [example-11](./examples/troubleshooting/example-11.bash)

### Templates and Checklists
#### Incident Response Checklist
- [ ] **Immediate Response**: Acknowledge incident and assess severity
- [ ] **Team Assembly**: Gather relevant team members based on severity
- [ ] **Communication**: Set up incident communication channel
- [ ] **Investigation**: Begin systematic troubleshooting using TRACE method
- [ ] **Mitigation**: Implement immediate fixes or workarounds
- [ ] **Monitoring**: Verify fix effectiveness and monitor for recurrence
- [ ] **Documentation**: Record incident details, actions taken, and lessons learned
- [ ] **Follow-up**: Schedule post-incident review and implement preventive measures

### Learning Resources
- **Google SRE Book**: Site Reliability Engineering practices and incident response
- **The Art of Debugging**: Systematic debugging techniques and methodologies
- **Systems Performance** by Brendan Gregg: Comprehensive performance analysis
- **Effective Debugging** by Diomidis Spinellis: Practical debugging strategies

## Quality and Compliance

### Quality Standards
- All incidents documented with root cause analysis
- Response times meet SLA requirements based on severity
- Preventive measures implemented for recurring issues
- Knowledge base updated with new troubleshooting procedures

### Compliance Requirements
#### Incident Documentation
- **Requirements**: Maintain detailed records of all incidents and resolutions
- **Implementation**: Structured incident tracking with timeline and actions
- **Verification**: Regular audit of incident response procedures

#### Security Incident Handling
- **Requirements**: Special procedures for security-related incidents
- **Implementation**: Isolated investigation, evidence preservation, compliance notification
- **Verification**: Security team review and external audit compliance

### Audit and Review Processes
- Weekly review of critical incidents and response effectiveness
- Monthly analysis of incident trends and prevention opportunities
- Quarterly training updates based on lessons learned
- Annual incident response procedure review and improvement

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Intermittent Application Failures
**Symptoms**: Application works sometimes but fails unpredictably
**Root Causes**: Race conditions, resource contention, external service instability
**Solutions**:
1. Add comprehensive logging around failure points
2. Implement retry mechanisms with exponential backoff
3. Analyze timing patterns and correlate with system metrics
4. Review concurrent access patterns and add synchronization
**Prevention**: Load testing, chaos engineering, comprehensive monitoring

#### Issue 2: Performance Degradation Over Time
**Symptoms**: Application starts fast but slows down over time
**Root Causes**: Memory leaks, cache pollution, resource exhaustion, database bloat
**Solutions**:
1. Monitor memory usage trends and analyze heap dumps
2. Review and optimize database queries and indexes
3. Implement proper cache expiration policies
4. Add resource monitoring and alerting
**Prevention**: Regular performance testing, proactive monitoring, capacity planning

### Escalation Procedures
- Technical issues: Senior engineer  Team lead  Engineering manager
- Critical incidents: Immediate manager notification + On-call escalation
- Security incidents: Security team + Legal + Compliance teams
- Customer-impacting issues: Customer success team notification

### Continuous Improvement
- Incident retrospectives to identify process improvements
- Regular review of troubleshooting tools and techniques
- Knowledge sharing sessions on complex issue resolutions
- Training on new debugging tools and methodologies

## AI Assistant Guidelines

When helping with Software Troubleshooting:

1. **Systematic Approach**: Always recommend structured debugging methodologies
2. **Evidence First**: Require evidence gathering before proposing solutions
3. **Root Cause Focus**: Guide toward identifying underlying causes, not just symptoms
4. **Documentation**: Emphasize documenting findings and solutions for future reference
5. **Safety First**: Prioritize system stability and data safety in all recommendations
6. **One Change at a Time**: Recommend testing one hypothesis at a time
7. **Monitoring**: Include monitoring and validation in all troubleshooting steps
8. **Knowledge Sharing**: Promote sharing lessons learned with the team

### Decision Making Framework
When helping teams troubleshoot issues:

1. **Issue Classification**: Help classify severity and impact appropriately
2. **Information Gathering**: Guide systematic evidence collection
3. **Hypothesis Formation**: Help form testable theories about root causes
4. **Test Planning**: Recommend safe, controlled testing approaches
5. **Solution Validation**: Ensure fixes are properly tested and monitored
6. **Prevention Planning**: Include measures to prevent recurrence

### Code Generation Rules
- Generate debugging code that is safe and non-destructive
- Include comprehensive logging and error handling
- Provide monitoring and alerting configurations
- Create troubleshooting scripts that are well-documented
- Include rollback procedures for any changes made
- Generate diagnostic tools that provide actionable insights

### Quality Enforcement
-  Enforce systematic debugging approaches over random changes
-  Require evidence gathering before proposing solutions
-  Block changes that could compromise system stability
-  Promote comprehensive testing of fixes before deployment
-  Require documentation of troubleshooting steps and outcomes
-  Enforce proper incident communication and escalation procedures
-  Promote learning and prevention over quick fixes
-  Require root cause analysis for recurring or critical issues

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
