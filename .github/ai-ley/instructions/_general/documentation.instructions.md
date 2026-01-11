---
name: 'Documentation.Instructions'
description: 'Development guidelines and best practices for Documentation.Instructions'
keywords: [audit, api, basic, common, checklists, architecture, assistant, avoid, cli, benefits]
---



# Documentation Instructions

## Core Principles

### Fundamental Concepts
1. **User-Centered**: Documentation should serve the needs of its intended audience first
2. **Living Documentation**: Documentation evolves with the codebase and stays current
3. **Discoverability**: Information should be easy to find and navigate
4. **Accessibility**: Documentation should be accessible to users with diverse abilities and technical backgrounds

### Key Benefits
- Reduced onboarding time for new team members
- Improved code maintainability and knowledge sharing
- Better user adoption and customer satisfaction
- Reduced support burden and repeated questions
- Enhanced team productivity and collaboration

### Common Misconceptions
- **Myth**: Documentation is a one-time activity done at the end of development
  **Reality**: Best documentation is created incrementally throughout development
- **Myth**: More documentation is always better
  **Reality**: Concise, relevant documentation is more valuable than comprehensive but unused docs
- **Myth**: Only technical writers can create good documentation
  **Reality**: Developers and domain experts often write the most valuable documentation

## Implementation Framework

### Getting Started
#### Prerequisites
- Clear understanding of target audiences and their needs
- Established writing style guide and documentation standards
- Documentation tools and platforms selected
- Integration with development workflow

#### Initial Setup
1. **Audience Analysis**: Identify different user personas and their information needs
2. **Information Architecture**: Design logical structure and navigation
3. **Tool Selection**: Choose documentation platform, authoring tools, and workflow
4. **Style Guide**: Establish consistent writing style, formatting, and terminology

### Core Methodologies
#### Docs-as-Code Approach
- **Purpose**: Treat documentation with the same rigor as source code
- **When to Use**: Technical documentation, API docs, internal developer guides
- **Implementation Steps**:
  1. Store documentation in version control alongside code
  2. Use markup languages (Markdown, reStructuredText, AsciiDoc)
  3. Implement review processes for documentation changes
  4. Automate documentation builds and deployments
- **Success Metrics**: Documentation freshness, contributor participation, user engagement

#### API-First Documentation
- **Purpose**: Generate documentation directly from code and specifications
- **When to Use**: REST APIs, GraphQL APIs, SDK documentation
- **Implementation Steps**:
  1. Use OpenAPI/Swagger specifications for REST APIs
  2. Generate interactive documentation from specifications
  3. Include code examples in multiple programming languages
  4. Implement automated testing of documentation examples
- **Success Metrics**: API adoption rates, reduced support tickets, developer satisfaction

### Process Integration
#### Development Workflow Integration
See [example-1](./examples/documentation/example-1.bash)

#### Continuous Integration Integration
See [example-2](./examples/documentation/example-2.yaml)

#### Documentation Requirements
- README files for all repositories and major components
- API documentation for all public interfaces
- Architecture decision records (ADRs) for significant decisions
- User guides and tutorials for end-user features
- Troubleshooting guides and FAQ sections

## Best Practices

### Writing and Structure
#### README Structure
See [example-3](./examples/documentation/example-3.markdown)bash
# Installation
npm install project-name

# Basic usage
project-name --help
See [example-4](./examples/documentation/example-4.txt)bash
npm install -g project-name
See [example-5](./examples/documentation/example-5.txt)bash
git clone https://github.com/org/project-name
cd project-name
npm install
npm run build
See [example-6](./examples/documentation/example-6.txt)javascript
const project = require('project-name');

const result = project.doSomething({
  option1: 'value1',
  option2: true
});

console.log(result);
See [example-7](./examples/documentation/example-7.txt)javascript
// More complex example with explanation
const config = {
  environment: 'production',
  features: {
    featureA: true,
    featureB: false
  }
};
See [example-8](./examples/documentation/example-8.txt)

#### API Documentation Structure
See [example-9](./examples/documentation/example-9.yaml)

### Code Documentation
#### Inline Documentation Standards
See [example-10](./examples/documentation/example-10.javascript)

### Architecture Documentation
#### Architecture Decision Records (ADRs)
See [example-11](./examples/documentation/example-11.markdown)

## Common Patterns and Examples

### Pattern 1: Progressive Documentation
**Scenario**: Building comprehensive documentation incrementally without overwhelming users
**Implementation**:
See [example-12](./examples/documentation/example-12.markdown)bash
npm install my-package
See [example-13](./examples/documentation/example-13.txt)javascript
const pkg = require('my-package');
pkg.doBasicThing();
See [example-14](./examples/documentation/example-14.txt)
**Expected Outcomes**: Users can find information at their appropriate level without being overwhelmed

### Pattern 2: Living API Documentation
**Scenario**: Keeping API documentation synchronized with code changes
**Implementation**:
See [example-15](./examples/documentation/example-15.typescript)
**Expected Outcomes**: API documentation stays accurate and current with automated validation

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Documentation Debt
- **Description**: Postponing documentation updates until they become overwhelming
- **Why It's Problematic**: Leads to inaccurate, outdated documentation that users can't trust
- **Better Approach**: Include documentation updates in definition of done for all features

#### Anti-Pattern 2: Over-Documentation
- **Description**: Documenting every trivial detail without considering user needs
- **Why It's Problematic**: Creates noise that obscures important information
- **Better Approach**: Focus on user scenarios and frequently asked questions

## Tools and Resources

### Essential Tools
#### Documentation Platforms
- **GitBook**: User-friendly documentation platform with great collaboration features
- **Notion**: Flexible workspace for internal documentation and knowledge management
- **MkDocs**: Static site generator for technical documentation from Markdown
- **Docusaurus**: Modern documentation website generator with React

#### API Documentation Tools
- **Swagger/OpenAPI**: Industry standard for REST API documentation
- **Redoc**: Beautiful API documentation from OpenAPI specifications
- **Postman**: API development and documentation platform
- **Insomnia**: REST client with documentation generation capabilities

#### Diagramming and Visual Tools
See [example-16](./examples/documentation/example-16.mermaid)

### Templates and Checklists
#### Documentation Review Checklist
- [ ] **Accuracy**: Information is correct and up-to-date
- [ ] **Completeness**: All necessary information is included
- [ ] **Clarity**: Language is clear and jargon-free
- [ ] **Structure**: Information is well-organized and easy to navigate
- [ ] **Examples**: Practical examples and code samples are provided
- [ ] **Accessibility**: Content is accessible to target audience
- [ ] **Maintainability**: Documentation can be easily updated
- [ ] **Discoverability**: Users can easily find the information
- [ ] **Testing**: Code examples work as documented
- [ ] **Visual Design**: Formatting and visual elements enhance readability

### Learning Resources
- **Write the Docs**: Community and resources for technical writers
- **Google Developer Documentation Style Guide**: Comprehensive style guide
- **Microsoft Writing Style Guide**: Modern approach to technical writing
- **Divio Documentation System**: Framework for organizing technical documentation

## Quality and Compliance

### Quality Standards
- Documentation accuracy verified through automated testing
- Regular review cycles for content freshness (quarterly for critical docs)
- User feedback integration with satisfaction scores >4/5
- Accessibility compliance (WCAG 2.1 AA) for all public documentation

### Compliance Requirements
#### Internal Documentation Standards
- **Requirements**: Consistent formatting, style, and information architecture
- **Implementation**: Style guide enforcement through linting and review processes
- **Verification**: Regular audits and user feedback collection

#### External Documentation Requirements
- **Requirements**: Legal disclaimers, privacy policies, accessibility statements
- **Implementation**: Template-based approach with legal review
- **Verification**: Legal team approval for public-facing documentation

### Audit and Review Processes
- Monthly review of most-accessed documentation pages
- Quarterly comprehensive review of API documentation
- Annual documentation strategy and tooling evaluation
- Continuous user feedback collection and analysis

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Documentation Becomes Outdated Quickly
**Symptoms**: Users report inaccurate information, support tickets about outdated processes
**Root Causes**: No process for updating docs, documentation not integrated with development workflow
**Solutions**:
1. Include documentation updates in definition of done
2. Implement automated checks for documentation freshness
3. Set up notifications for related code changes
4. Regular review cycles with content owners
**Prevention**: Docs-as-code approach with CI/CD integration

#### Issue 2: Users Can't Find Information
**Symptoms**: Repeated questions in support, low documentation page views
**Root Causes**: Poor information architecture, missing search functionality, unclear navigation
**Solutions**:
1. Conduct user research and card sorting exercises
2. Implement site search with analytics
3. Create clear navigation hierarchies
4. Add cross-references and related links
**Prevention**: Regular user testing and navigation analysis

### Escalation Procedures
- Content accuracy issues: Escalate to subject matter expert
- Technical issues with documentation platform: IT/DevOps team
- Legal or compliance concerns: Legal team review
- User experience problems: UX team consultation

### Continuous Improvement
- Regular user surveys and feedback collection
- Analytics tracking for popular content and search terms
- A/B testing for different documentation approaches
- Documentation metrics dashboard with key performance indicators

## AI Assistant Guidelines

When helping with Documentation:

1. **User-Focused**: Always consider the target audience and their specific needs
2. **Clarity First**: Prioritize clear, simple language over comprehensive coverage
3. **Examples Heavy**: Include practical, working examples for all concepts
4. **Structure Matters**: Organize information logically with clear headings and navigation
5. **Maintainability**: Design documentation that can be easily updated and maintained
6. **Accessibility**: Ensure documentation is accessible to users with diverse abilities
7. **Integration**: Connect documentation with development workflows and tools
8. **Feedback Loops**: Include mechanisms for user feedback and continuous improvement

### Decision Making Framework
When helping teams improve documentation:

1. **Audience Analysis**: Understand who will use the documentation and how
2. **Content Audit**: Assess current documentation quality and gaps
3. **Tool Evaluation**: Choose appropriate tools for authoring and publishing
4. **Workflow Integration**: Integrate documentation into development processes
5. **Success Metrics**: Define measurable goals for documentation effectiveness
6. **Continuous Iteration**: Plan for regular updates and improvements

### Code Generation Rules
- Generate clear, well-commented code examples
- Include error handling and edge cases in examples
- Provide examples in multiple relevant programming languages when appropriate
- Ensure all code examples are tested and working
- Include setup instructions and prerequisites
- Add explanatory comments for complex logic

### Quality Enforcement
-  Enforce clear, concise writing style
-  Require practical examples for all documented features
-  Block documentation that lacks proper structure and navigation
-  Promote docs-as-code practices with version control
-  Require documentation updates for all feature changes
-  Enforce accessibility standards for all documentation
-  Block outdated information through automated checks
-  Promote user-centered design in all documentation

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
