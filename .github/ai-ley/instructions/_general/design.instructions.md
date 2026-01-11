---
name: 'Design.Instructions'
description: 'Development guidelines and best practices for Design.Instructions'
keywords: [audit, api, avoid, (command, assistant, architecture, authentication, authorization, architectural, benefits]
---



# Software Design Instructions

## Overview
- **Domain**: Software Architecture and Design Methodology
- **Purpose**: Guide AI agents in creating scalable, maintainable, and robust software designs
- **Applicable To**: All software development projects requiring architectural design and system planning
- **Integration Level**: Core methodology affecting all development phases from conception to deployment

## Core Principles

### Fundamental Concepts
1. **Design for Change**: Create flexible architectures that can evolve with changing requirements
2. **Separation of Concerns**: Organize code into distinct sections handling different aspects of functionality
3. **Principle of Least Knowledge**: Components should know only what they need to accomplish their responsibilities
4. **Composition over Inheritance**: Favor object composition over class inheritance for flexibility

### Key Benefits
- Improved maintainability through clear separation of responsibilities
- Enhanced scalability with modular and loosely coupled components
- Reduced complexity through well-defined interfaces and abstractions
- Faster development cycles with reusable and testable components
- Better collaboration through shared design patterns and conventions

### Common Misconceptions
- **Myth**: Good design means complex architecture with many patterns
  **Reality**: Good design is often simple, focused, and uses patterns judiciously
- **Myth**: Design decisions are permanent and cannot be changed
  **Reality**: Good design enables evolution and refactoring as requirements change
- **Myth**: Design is only needed for large, complex systems
  **Reality**: Design principles apply to all software, from simple scripts to enterprise systems

## Implementation Framework

### Getting Started
#### Prerequisites
- Understanding of software design patterns and architectural principles
- Knowledge of relevant programming languages and frameworks
- Familiarity with the problem domain and business requirements
- Access to stakeholders for requirements clarification and validation

#### Initial Setup
1. **Requirements Analysis**: Understand functional and non-functional requirements
2. **Technology Selection**: Choose appropriate languages, frameworks, and tools
3. **Architecture Planning**: Define high-level system structure and components
4. **Design Documentation**: Create comprehensive design documentation and diagrams

### Core Methodologies
#### Domain-Driven Design (DDD)
- **Purpose**: Align software design with business domain and requirements
- **When to Use**: Complex business domains with rich business logic and rules
- **Implementation Steps**:
  1. Collaborate with domain experts to understand business requirements
  2. Identify bounded contexts and define domain models
  3. Create ubiquitous language shared between developers and domain experts
  4. Design aggregates, entities, and value objects based on business rules
- **Success Metrics**: Clear alignment between code structure and business concepts

#### SOLID Principles Application
- **Purpose**: Create maintainable and extensible object-oriented designs
- **When to Use**: Object-oriented programming projects requiring flexibility
- **Implementation Steps**:
  1. **Single Responsibility**: Ensure each class has one reason to change
  2. **Open/Closed**: Design classes open for extension, closed for modification
  3. **Liskov Substitution**: Derived classes must be substitutable for base classes
  4. **Interface Segregation**: Create focused interfaces rather than large, general ones
  5. **Dependency Inversion**: Depend on abstractions, not concrete implementations
- **Success Metrics**: Low coupling, high cohesion, and easy testability

### Process Integration
#### Design Review Workflow
See [example-1](./examples/design/example-1.markdown)

#### Documentation Requirements
- System architecture diagrams showing component relationships
- API specifications and interface contracts
- Data model documentation with relationships and constraints
- Deployment architecture and infrastructure requirements
- Security design and threat model documentation

## Best Practices

### Architectural Patterns
#### Layered Architecture Implementation
See [example-2](./examples/design/example-2.typescript)

#### Microservices Design Pattern
See [example-3](./examples/design/example-3.typescript)

### Design Patterns Implementation
#### Repository Pattern with Dependency Injection
See [example-4](./examples/design/example-4.typescript)

## Common Patterns and Examples

### Pattern 1: Event-Driven Architecture
**Scenario**: Building a scalable e-commerce system with multiple services
**Implementation**:
See [example-5](./examples/design/example-5.typescript)

### Pattern 2: CQRS (Command Query Responsibility Segregation)
**Scenario**: System with complex business logic requiring optimized read and write operations
**Implementation**:
See [example-6](./examples/design/example-6.typescript)

### Anti-Patterns to Avoid
#### Anti-Pattern 1: God Object
- **Description**: Single class or component responsible for too many functions
- **Why It's Problematic**: Difficult to maintain, test, and extend; violates single responsibility principle
- **Better Approach**: Break down into smaller, focused components with clear responsibilities

#### Anti-Pattern 2: Tight Coupling
- **Description**: Components directly dependent on concrete implementations of other components
- **Why It's Problematic**: Makes system difficult to change, test, and extend
- **Better Approach**: Use dependency injection and interface-based design for loose coupling

## Tools and Resources

### Essential Tools
#### Design and Modeling Tools
- **UML Diagrams**: Comprehensive system modeling with class, sequence, and component diagrams
- **Architecture Decision Records (ADRs)**: Document important architectural decisions
- **C4 Model**: Visual architecture documentation at different levels of abstraction
- **Domain Modeling Tools**: Visual representation of business domain and relationships

#### Code Analysis and Quality
- **Static Code Analysis**: Automated detection of design issues and code smells
- **Dependency Analysis**: Visualization of component dependencies and coupling metrics
- **Complexity Metrics**: Measurement of cyclomatic complexity and maintainability
- **Architecture Testing**: Automated validation of architectural constraints

### Templates and Checklists
#### Design Review Checklist
- [ ] **Business Requirements**: Design addresses all functional requirements
- [ ] **Non-Functional Requirements**: Performance, security, and scalability requirements met
- [ ] **Component Design**: Clear responsibilities and well-defined interfaces
- [ ] **Data Design**: Appropriate data modeling and storage strategies
- [ ] **Integration Design**: External system integration patterns and error handling
- [ ] **Security Design**: Authentication, authorization, and data protection measures
- [ ] **Testing Strategy**: Comprehensive testing approach at all levels
- [ ] **Deployment Design**: Infrastructure requirements and deployment procedures

### Learning Resources
- **Design Patterns**: Gang of Four patterns and modern architectural patterns
- **Clean Architecture**: Uncle Bob's architectural principles and practices
- **Domain-Driven Design**: Eric Evans' strategic design and tactical patterns
- **Microservices Patterns**: Chris Richardson's microservices design patterns

## Quality and Compliance

### Quality Standards
- All design decisions documented with rationale and trade-offs
- Architecture supports testability with clear component boundaries
- Performance requirements addressed with appropriate design patterns
- Security considerations integrated into architectural design

### Compliance Requirements
#### Documentation Standards
- **Requirements**: Comprehensive design documentation maintained and version-controlled
- **Implementation**: Structured documentation with diagrams, ADRs, and API specifications
- **Verification**: Regular design review and documentation currency validation

#### Design Review Process
- **Requirements**: Peer review of all significant design decisions
- **Implementation**: Formal design review process with checkpoints and approvals
- **Verification**: Design review meeting minutes and approval documentation

### Audit and Review Processes
- Weekly component design review for new features
- Monthly architecture review for significant changes
- Quarterly comprehensive architecture assessment
- Annual technology stack and design pattern evaluation

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Performance Problems Due to Poor Design
**Symptoms**: Slow response times, high resource usage, scalability limitations
**Root Causes**: Inefficient algorithms, inappropriate data structures, poor caching strategy
**Solutions**:
1. Performance profiling to identify bottlenecks
2. Algorithm optimization and data structure improvements
3. Implement appropriate caching strategies
4. Consider architectural changes for better scalability
**Prevention**: Performance requirements integration into design phase

#### Issue 2: Maintenance Difficulties
**Symptoms**: Frequent bugs, difficult to add new features, long development cycles
**Root Causes**: Tight coupling, poor separation of concerns, inadequate documentation
**Solutions**:
1. Refactor to improve separation of concerns
2. Introduce dependency injection and interface-based design
3. Improve documentation and code organization
4. Implement comprehensive testing strategy
**Prevention**: Regular code review and refactoring, adherence to SOLID principles

### Escalation Procedures
- Design issues: Escalate to senior architects and technical leads
- Performance problems: Escalate to performance engineering team
- Security concerns: Escalate to security architecture team
- Technology decisions: Escalate to architecture review board

### Continuous Improvement
- Regular architecture review and improvement sessions
- Technology evaluation and adoption planning
- Design pattern training and knowledge sharing
- Lessons learned documentation and process improvement

## AI Assistant Guidelines

When helping with Software Design:

1. **Requirements Focus**: Always understand business requirements before proposing technical solutions
2. **Simplicity First**: Start with simple designs and add complexity only when necessary
3. **Pattern Application**: Use established design patterns appropriately, not for their own sake
4. **Quality Attributes**: Consider performance, security, maintainability, and scalability in all designs
5. **Future Evolution**: Design for change and extensibility while avoiding over-engineering
6. **Testing Integration**: Ensure designs support comprehensive testing strategies
7. **Documentation Emphasis**: Create clear, comprehensive design documentation
8. **Stakeholder Communication**: Use clear language and visual aids for design communication

### Decision Making Framework
When helping teams with software design:

1. **Problem Analysis**: Thoroughly understand the problem domain and constraints
2. **Solution Evaluation**: Compare multiple design alternatives with trade-off analysis
3. **Pattern Selection**: Choose appropriate architectural and design patterns
4. **Quality Assessment**: Evaluate design against quality attributes and requirements
5. **Implementation Planning**: Break design into implementable components and phases
6. **Risk Assessment**: Identify design risks and mitigation strategies

### Code Generation Rules
- Generate well-structured code following SOLID principles
- Include comprehensive interface definitions and abstractions
- Implement appropriate error handling and validation
- Create modular, loosely coupled components
- Include comprehensive documentation and examples
- Generate appropriate test structures and patterns

### Quality Enforcement
-  Enforce single responsibility principle in all components
-  Require interface-based design for flexibility and testability
-  Block tight coupling between unrelated components
-  Promote composition over inheritance for flexibility
-  Require comprehensive error handling and validation
-  Enforce separation of concerns across architectural layers
-  Promote dependency injection and inversion of control
-  Require comprehensive documentation of design decisions

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
