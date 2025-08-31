# General Guidelines Instructions Template

## Overview

- **Domain**: Cross-Domain Development Guidelines
- **Purpose**: Provide universal principles and patterns applicable across technologies and frameworks
- **Applicable To**: All development projects requiring systematic approach and quality standards
- **Complexity Level**: Foundational (applies to all experience levels)

## Core Concepts

### Essential Concepts

- **Universal Principles**: Consistency, maintainability, security, and performance considerations
- **Quality Framework**: Measurable standards for code quality, documentation, and operational excellence
- **Integration Patterns**: Standard approaches for tool integration and workflow automation

### Key Benefits

- Consistent development standards across diverse technology stacks and teams
- Reduced onboarding time through standardized patterns and documented processes
- Improved code quality and maintainability through systematic guidelines application

## Implementation Guidelines

### Getting Started

- **Standards Assessment**: Evaluate existing practices against universal quality principles
- **Gap Analysis**: Identify areas requiring standardization or improvement
- **Incremental Adoption**: Implement guidelines systematically with team feedback integration

### Core Patterns

```markdown
## Universal Quality Pattern

1. **Define Standards**: Establish clear, measurable quality criteria
2. **Automate Validation**: Integrate quality checks into development workflow
3. **Monitor Compliance**: Track adherence and effectiveness metrics
4. **Continuous Improvement**: Regular review and optimization of standards
```

### Framework Integration

```yaml
# Universal CI/CD Quality Gates
quality_checks:
  - name: code_standards
    tools: [linter, formatter]
    failure_threshold: 'zero_violations'

  - name: security_scan
    tools: [vulnerability_scanner, dependency_check]
    failure_threshold: 'zero_high_severity'

  - name: test_coverage
    tools: [coverage_tool]
    failure_threshold: 'minimum_80_percent'
```

## Common Use Cases

### Use Case 1: Multi-Technology Project Standards

**When**: Projects using multiple programming languages or frameworks
**Implementation**: Technology-agnostic quality standards with tool-specific implementations
**Expected Result**: Consistent quality and maintainability across all project components

### Use Case 2: Team Onboarding and Training

**When**: New team members or teams adopting standardized practices
**Implementation**: Comprehensive guidelines with examples and automated enforcement
**Expected Result**: Faster onboarding with consistent practice adoption

### Use Case 3: Legacy System Modernization

**When**: Upgrading or refactoring existing systems with inconsistent standards
**Implementation**: Gradual guidelines adoption with automated migration tools
**Expected Result**: Improved system maintainability and reduced technical debt

## Anti-Patterns to Avoid

- **Over-Standardization**: Creating rigid rules that prevent appropriate technology-specific optimizations
- **Tool Proliferation**: Using too many tools without considering integration and maintenance overhead
- **Documentation Debt**: Creating guidelines without maintaining them as technologies evolve
- **Process Over Value**: Focusing on compliance rather than actual quality and productivity outcomes

## Integration & Tools

### Essential Tool Categories

- **Code Quality**: Language-agnostic linters, formatters, and static analysis tools
- **Security**: SAST/DAST scanners, dependency vulnerability checkers, secret detection
- **Documentation**: API documentation generators, architecture diagramming, knowledge bases
- **Automation**: CI/CD platforms, infrastructure as code, deployment automation

### Integration Patterns

```bash
#!/bin/bash
# Universal project setup script
# Detects project type and applies appropriate standards

detect_project_type() {
  if [[ -f "package.json" ]]; then
    echo "nodejs"
  elif [[ -f "requirements.txt" ]] || [[ -f "pyproject.toml" ]]; then
    echo "python"
  elif [[ -f "pom.xml" ]] || [[ -f "build.gradle" ]]; then
    echo "java"
  else
    echo "generic"
  fi
}

apply_standards() {
  local project_type=$1

  # Apply universal standards
  setup_gitignore
  setup_readme_template
  setup_security_scanning

  # Apply type-specific standards
  case $project_type in
    "nodejs") setup_nodejs_standards ;;
    "python") setup_python_standards ;;
    "java") setup_java_standards ;;
    *) setup_generic_standards ;;
  esac
}
```

## AI Assistant Guidelines

When helping with General Guidelines implementation:

1. **Technology Neutrality**: Provide guidance that applies across different technology stacks
2. **Scalability Focus**: Consider how guidelines work for both small and large teams
3. **Automation Emphasis**: Prioritize automated enforcement over manual processes
4. **Measurable Outcomes**: Include specific metrics and success criteria
5. **Flexibility Balance**: Provide structure while allowing for context-specific adaptations
6. **Integration Priority**: Focus on how guidelines integrate with existing workflows
7. **Documentation Standards**: Ensure all guidelines are clearly documented and maintained
8. **Continuous Evolution**: Build in mechanisms for guideline updates and improvements

### Decision Making Framework

When helping teams implement general guidelines:

1. **Context Assessment**: Understand team size, technology stack, and current practices
2. **Priority Identification**: Focus on high-impact guidelines that address specific pain points
3. **Tool Evaluation**: Select tools that integrate well and provide clear value
4. **Implementation Planning**: Develop phased rollout with success metrics
5. **Change Management**: Include training, communication, and feedback mechanisms
6. **Monitoring Setup**: Establish metrics and monitoring for guideline effectiveness

### Code Generation Rules

- Generate technology-agnostic examples that can be adapted to specific contexts
- Include comprehensive configuration templates for common tool integrations
- Provide clear documentation and comments explaining guideline rationale
- Create modular, reusable components that can be combined as needed
- Include validation and testing mechanisms for generated configurations
- Focus on maintainable, scalable implementations

### Quality Enforcement

- ✅ Enforce universal quality standards (security, performance, maintainability)
- ✅ Require comprehensive documentation for all guidelines and processes
- ✅ Promote automation over manual processes wherever possible
- 🚫 Block guidelines that create unnecessary complexity or overhead
- 🚫 Avoid rigid standards that prevent appropriate context-specific adaptations
- 🚫 Reject processes that prioritize compliance over actual value delivery

## Resources

- **Quality Standards**: ISO/IEC 25010 (Software Quality), OWASP Top 10, NIST Cybersecurity Framework
- **Process Frameworks**: DevOps Research and Assessment (DORA), SPACE Productivity Framework
- **Industry References**: Google Engineering Practices, Microsoft Engineering Guidelines, Netflix Tech Blog
