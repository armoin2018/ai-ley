---
name: 'Powershell.Instructions'
description: 'Development guidelines and best practices for Powershell.Instructions'
keywords: [cloud, advanced, common, assistant, architecture, analysis, avoid, azure, benefits, aws]
---



`
---
applyTo: "**/*.ps1, **/*.psm1, **/*.psd1, powershell"
---

# PowerShell Programming Instructions

## Overview
- **Domain**: System Administration, Automation, and Cross-Platform Scripting
- **Purpose**: Build efficient, maintainable automation scripts and administrative tools using PowerShell
- **Applicable To**: Windows/Linux/macOS automation, cloud administration, DevOps pipelines, and enterprise management
- **Integration Level**: System administration, CI/CD pipelines, and infrastructure automation

## Core Principles

### Fundamental Concepts
1. **Object-Oriented Pipelines**: PowerShell works with .NET objects, not just text
2. **Verb-Noun Syntax**: Consistent command structure following approved verb-noun pairs
3. **Pipeline-Centric**: Design scripts to work efficiently with PowerShell pipelines
4. **Cross-Platform Compatibility**: Modern PowerShell Core runs on Windows, Linux, and macOS

### Key Benefits
- Rich object model with .NET integration
- Extensive cmdlet library for system administration
- Strong support for remote management and automation
- Excellent help system and discoverability
- Integration with cloud platforms (Azure, AWS)

### Common Misconceptions
- **Myth**: PowerShell is only for Windows administration
  **Reality**: PowerShell Core is cross-platform and excellent for cloud/DevOps automation
- **Myth**: PowerShell is slow compared to other scripting languages
  **Reality**: PowerShell's object model provides efficiency gains for many administrative tasks

## Implementation Framework

### Getting Started
#### Prerequisites
- PowerShell 7+ (PowerShell Core recommended for cross-platform compatibility)
- Basic understanding of .NET objects and concepts
- Administrative privileges for system-level scripts

#### Initial Setup
See [example-1](./examples/powershell/example-1.powershell)

### Core Methodologies
#### Function-Based Development
- **Purpose**: Create reusable, modular code with proper error handling
- **When to Use**: All PowerShell scripts beyond simple one-liners
- **Implementation Steps**:
  1. Design functions with single responsibilities
  2. Use approved verbs and proper parameter design
  3. Implement comprehensive error handling
  4. Add help documentation and examples
- **Success Metrics**: Reusable functions with clear interfaces and documentation

#### Pipeline Optimization
- **Purpose**: Leverage PowerShell's object pipeline for efficient data processing
- **When to Use**: Data processing, filtering, and transformation tasks
- **Implementation Steps**:
  1. Design functions to accept pipeline input
  2. Use Where-Object and ForEach-Object efficiently
  3. Implement proper pipeline terminating vs non-terminating errors
  4. Optimize memory usage with streaming operations
- **Success Metrics**: Efficient pipeline processing with minimal memory footprint

### Process Integration
#### Module Development
See [example-2](./examples/powershell/example-2.powershell)

#### CI/CD Integration
See [example-3](./examples/powershell/example-3.yaml)

## Best Practices

### Modern PowerShell Function Design
See [example-4](./examples/powershell/example-4.powershell)

### Advanced Pipeline and Error Handling
See [example-5](./examples/powershell/example-5.powershell)

## Common Patterns and Examples

### Pattern 1: Configuration Management
**Scenario**: Manage system configurations across multiple servers
**Implementation**:
See [example-6](./examples/powershell/example-6.powershell)
**Expected Outcomes**: Consistent server configurations with automated compliance checking

### Pattern 2: Azure Resource Management
**Scenario**: Manage Azure resources with PowerShell automation
**Implementation**:
See [example-7](./examples/powershell/example-7.powershell)
**Expected Outcomes**: Automated Azure infrastructure provisioning with proper configuration

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Using Write-Host for Output
- **Description**: Using Write-Host instead of Write-Output or Write-Information
- **Why It's Problematic**: Breaks pipeline functionality and cannot be captured
- **Better Approach**: Use Write-Output for data, Write-Information for user messages

#### Anti-Pattern 2: Ignoring Error Handling
- **Description**: Not implementing proper error handling and terminating vs non-terminating errors
- **Why It's Problematic**: Scripts fail unpredictably and provide poor user experience
- **Better Approach**: Use try-catch blocks and proper ErrorAction parameters

## Tools and Resources

### Essential Modules and Tools
See [example-8](./examples/powershell/example-8.powershell)

### Code Analysis and Testing
See [example-9](./examples/powershell/example-9.powershell)

### Learning Resources
- **PowerShell Documentation**: https://docs.microsoft.com/en-us/powershell/
- **PowerShell Gallery**: https://www.powershellgallery.com/
- **PowerShell Best Practices**: https://github.com/PoshCode/PowerShellPracticeAndStyle
- **Pester Testing**: https://pester.dev/

## Quality and Compliance

### Quality Standards
- All functions include comprehensive help documentation
- Scripts pass PSScriptAnalyzer analysis with no errors or warnings
- Proper error handling implemented throughout
- Pipeline support for functions that process multiple objects
- Consistent verb-noun naming following PowerShell conventions

### Security Standards
- Credential handling through secure methods (never plaintext)
- Input validation for all parameters
- Execution policy considerations documented
- Script signing for production environments
- Principle of least privilege for administrative scripts

### Performance Standards
- Efficient use of PowerShell pipelines
- Memory-conscious processing for large datasets
- Proper use of PowerShell remoting for scale
- Background jobs for long-running operations

## AI Assistant Guidelines

When helping with PowerShell Development:

1. **Function Design First**: Always design proper functions with parameters, help, and pipeline support
2. **Error Handling Priority**: Implement comprehensive error handling with proper exception types
3. **Modern PowerShell**: Use PowerShell 7+ features and cross-platform compatibility
4. **Pipeline Focus**: Design scripts to work efficiently with PowerShell object pipelines
5. **Documentation Strategy**: Include comprehensive help documentation with examples
6. **Testing Approach**: Include Pester tests for all functions
7. **Security Considerations**: Handle credentials and sensitive data properly
8. **Performance Optimization**: Use efficient PowerShell patterns and avoid common pitfalls

### Decision Making Framework
When helping teams choose PowerShell approaches:

1. **Requirements Analysis**: Understand automation needs and target platforms
2. **Architecture Design**: Plan for modularity, reusability, and maintenance
3. **Security Assessment**: Implement appropriate security measures and access controls
4. **Performance Planning**: Design for efficiency and scalability
5. **Integration Strategy**: Plan for CI/CD and enterprise integration

### Code Generation Rules
- Generate functions following PowerShell best practices and conventions
- Include comprehensive parameter validation and help documentation
- Use proper error handling with try-catch blocks and error records
- Implement pipeline support where appropriate
- Generate corresponding Pester tests for all functions
- Follow approved verb-noun naming conventions
- Include verbose and debug output for troubleshooting
- Provide clear examples and usage documentation

### Quality Enforcement
- ✅ Enforce approved verb-noun function naming conventions
- ✅ Require comprehensive help documentation for all functions
- ✅ Block Write-Host usage in favor of proper output streams
- ✅ Enforce proper error handling and exception management
- ✅ Require parameter validation and type constraints
- ✅ Enforce pipeline support for multi-object functions
- ✅ Require PSScriptAnalyzer compliance
- ✅ Promote secure credential handling practices

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
