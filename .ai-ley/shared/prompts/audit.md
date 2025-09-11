---
agentMode: general
applyTo: general
author: AI-LEY
description: Audit the existing project to verify it aligns with the standards defined in instructions, with optional automated fixes
extensions:
  - .md
guidelines: Follow AI-LEY project standards and best practices for code auditing and compliance
instructionType: general
keywords: [audit, compliance, standards, instructions, validation, fix, report]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 3.0
title: Project Audit
version: 1.0.0
---

# Copilot Command: Project Audit

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A project codebase and structure to audit
- Standards and guidelines defined in `{{files.instructions}}`
- An optional fix parameter to enable automated corrections
- Quality and compliance requirements

Produce:

- A comprehensive audit report stored in `{{files.audit-report}}`
- Detailed compliance analysis against defined standards
- List of violations, warnings, and recommendations
- Automated fixes applied (if fix parameter is true)
- Action items and improvement recommendations

## Command

You are a code quality specialist and compliance auditor with expertise in project standards validation and automated remediation.

### 1. **Parse Audit Parameters and Load Standards**

**Parameter Processing**:

- Extract the `<fix>` parameter from user input (true|false, default: false)
- Validate parameter values and set appropriate flags
- Configure audit scope and remediation settings
- Initialize audit tracking and reporting structures

**Standards Loading**:

```markdown
**Load Project Standards**:

- Load all instruction files from `{{files.instructions}}`
- Parse coding standards, style guidelines, and best practices
- Extract quality requirements and compliance criteria
- Load project-specific rules and configurations
- Create comprehensive standards checklist for validation

**Context Analysis**:

- Analyze project structure and technology stack
- Identify applicable standards and guidelines
- Map standards to specific file types and components
- Create audit scope and priority matrix
- Establish compliance thresholds and success criteria
```

### 2. **Project Structure and Organization Audit**

**File Structure Compliance**:

```markdown
**Step 2.1: Directory Structure Validation**

**Project Organization Analysis**:

1. **Standard Directory Structure**

   - Verify presence of required directories (src/, docs/, tests/, etc.)
   - Check directory naming conventions and organization
   - Validate separation of concerns and logical grouping
   - Ensure consistent hierarchy and navigation patterns

2. **File Naming and Organization**

   - Audit file naming conventions across all directories
   - Check for consistent extension usage and patterns
   - Validate configuration file placement and naming
   - Ensure proper separation of source, test, and documentation files

3. **Configuration and Metadata Files**
   - Verify presence and validity of package.json, requirements.txt, etc.
   - Check project metadata completeness and accuracy
   - Validate configuration file formats and required fields
   - Ensure environment-specific configurations are properly organized

**Step 2.2: Documentation Structure Audit**

**Documentation Compliance**:

1. **Required Documentation Files**

   - Verify presence of README.md with comprehensive project information
   - Check for CONTRIBUTING.md, CODE_OF_CONDUCT.md, LICENSE files
   - Validate changelog and release documentation
   - Ensure API documentation completeness and currency

2. **Documentation Quality Assessment**
   - Analyze documentation structure and navigability
   - Check for outdated or missing information
   - Validate code examples and tutorial accuracy
   - Ensure consistent formatting and style across documents
```

### 3. **Code Quality and Standards Audit**

**Source Code Analysis**:

```markdown
**Step 3.1: Coding Standards Compliance**

**Style and Formatting Analysis**:

1. **Code Style Consistency**

   - Check indentation, spacing, and formatting standards
   - Validate naming conventions for variables, functions, and classes
   - Ensure consistent code organization and structure
   - Verify adherence to language-specific style guides

2. **Code Quality Metrics**

   - Analyze code complexity and maintainability scores
   - Check for code duplication and redundancy
   - Validate function and class size guidelines
   - Ensure proper error handling and logging practices

3. **Security and Best Practices**
   - Scan for security vulnerabilities and anti-patterns
   - Check for hardcoded secrets and sensitive information
   - Validate input sanitization and validation practices
   - Ensure proper dependency management and updates

**Step 3.2: Architecture and Design Compliance**

**Architectural Standards Validation**:

1. **Design Pattern Adherence**

   - Verify implementation of required design patterns
   - Check separation of concerns and modularity
   - Validate abstraction layers and interfaces
   - Ensure consistent architectural decisions across components

2. **Dependency Management**

   - Audit dependency versions and compatibility
   - Check for unused or outdated dependencies
   - Validate dependency security and licensing compliance
   - Ensure proper dependency injection and inversion patterns

3. **Performance and Scalability**
   - Analyze performance-critical code sections
   - Check for scalability bottlenecks and issues
   - Validate caching strategies and optimization techniques
   - Ensure resource management and cleanup practices
```

### 4. **Testing and Quality Assurance Audit**

**Test Coverage and Quality Analysis**:

```markdown
**Step 4.1: Testing Standards Compliance**

**Test Structure and Organization**:

1. **Test Coverage Analysis**

   - Calculate code coverage percentages by module
   - Identify untested or under-tested code sections
   - Validate test case completeness and edge case coverage
   - Ensure critical path and error condition testing

2. **Test Quality Assessment**

   - Review test case design and maintainability
   - Check for test isolation and independence
   - Validate test data management and cleanup
   - Ensure proper mocking and stubbing practices

3. **Testing Framework Compliance**
   - Verify adherence to testing framework standards
   - Check test naming conventions and organization
   - Validate integration and end-to-end test coverage
   - Ensure continuous integration test pipeline compliance

**Step 4.2: Quality Gates and CI/CD Audit**

**Pipeline and Process Validation**:

1. **Build and Deployment Standards**

   - Audit build scripts and configuration
   - Check deployment automation and rollback procedures
   - Validate environment promotion and release processes
   - Ensure proper version control and branching strategies

2. **Quality Gate Implementation**
   - Verify automated quality checks and thresholds
   - Check code review processes and requirements
   - Validate security scanning and vulnerability management
   - Ensure compliance with release and approval workflows
```

### 5. **Automated Fix Implementation (if fix=true)**

**Remediation and Correction Process**:

```markdown
**Step 5.1: Safe Automated Fixes**

**Low-Risk Corrections** (Applied when fix=true):

1. **Formatting and Style Fixes**

   - Apply consistent code formatting and indentation
   - Correct naming convention violations
   - Fix import organization and unused import removal
   - Update file headers and documentation templates

2. **Configuration Updates**

   - Update outdated configuration values
   - Add missing required configuration fields
   - Normalize configuration file formats
   - Apply security hardening configurations

3. **Documentation Corrections**
   - Update outdated version references
   - Fix broken internal links and references
   - Standardize documentation formatting
   - Add missing required documentation sections

**Step 5.2: High-Risk Issue Identification**

**Manual Review Required** (Always flagged, never auto-fixed):

1. **Architectural Changes**

   - Design pattern violations requiring refactoring
   - Security vulnerabilities requiring code changes
   - Performance issues requiring optimization
   - Breaking changes requiring careful consideration

2. **Business Logic Issues**
   - Incorrect algorithm implementations
   - Data validation and processing errors
   - Integration and API contract violations
   - Complex refactoring requirements

**Fix Application Process**:

- Create backup of original files before applying fixes
- Apply fixes incrementally with validation at each step
- Run tests after each category of fixes
- Document all changes made during automated remediation
- Provide rollback instructions for all applied fixes
```

### 6. **Audit Report Generation**

**Comprehensive Report Creation**:

````markdown
**Step 6.1: Audit Report Structure**

**Create Detailed Audit Report** in `{{files.audit-report}}`:

```markdown
# Project Audit Report

**Generated**: {current-timestamp}
**Audit Scope**: Full project compliance audit
**Fix Mode**: {true/false}
**Standards Reference**: {{files.instructions}}

## Executive Summary

- **Overall Compliance Score**: {score}/100
- **Critical Issues**: {count}
- **Warning Issues**: {count}
- **Recommendations**: {count}
- **Fixes Applied**: {count} (if fix=true)

## Compliance Analysis

### Project Structure Compliance

| Category                | Score      | Status   | Issues Found |
| ----------------------- | ---------- | -------- | ------------ |
| Directory Organization  | {score}/10 | {status} | {count}      |
| File Naming             | {score}/10 | {status} | {count}      |
| Configuration Files     | {score}/10 | {status} | {count}      |
| Documentation Structure | {score}/10 | {status} | {count}      |

### Code Quality Compliance

| Category                | Score      | Status   | Issues Found |
| ----------------------- | ---------- | -------- | ------------ |
| Coding Standards        | {score}/10 | {status} | {count}      |
| Architecture Compliance | {score}/10 | {status} | {count}      |
| Security Standards      | {score}/10 | {status} | {count}      |
| Performance Guidelines  | {score}/10 | {status} | {count}      |

### Testing and Quality Assurance

| Category         | Score      | Status   | Issues Found |
| ---------------- | ---------- | -------- | ------------ |
| Test Coverage    | {score}/10 | {status} | {count}      |
| Test Quality     | {score}/10 | {status} | {count}      |
| CI/CD Compliance | {score}/10 | {status} | {count}      |
| Quality Gates    | {score}/10 | {status} | {count}      |

## Detailed Findings

### Critical Issues (Require Immediate Attention)

1. **Issue Type**: {category}
   - **Location**: {file-path:line-number}
   - **Description**: {detailed-description}
   - **Standard Violated**: {instruction-reference}
   - **Impact**: High
   - **Recommendation**: {action-required}
   - **Auto-Fix Available**: {yes/no}

### Warning Issues (Should Be Addressed)

1. **Issue Type**: {category}
   - **Location**: {file-path:line-number}
   - **Description**: {detailed-description}
   - **Standard Violated**: {instruction-reference}
   - **Impact**: Medium
   - **Recommendation**: {action-suggested}
   - **Auto-Fix Available**: {yes/no}

### Recommendations (Best Practice Improvements)

1. **Improvement Area**: {category}
   - **Current State**: {description}
   - **Recommended State**: {description}
   - **Benefit**: {improvement-benefit}
   - **Effort Required**: {low/medium/high}
   - **Priority**: {1-5}

## Applied Fixes (if fix=true)

### Automated Corrections Applied

1. **Fix Category**: {type}
   - **Files Modified**: {count}
   - **Changes Made**: {description}
   - **Validation**: {passed/failed}
   - **Rollback Available**: {yes/no}

### Manual Actions Required

1. **Issue**: {description}
   - **Why Not Auto-Fixed**: {reason}
   - **Recommended Action**: {manual-steps}
   - **Priority**: {high/medium/low}
   - **Estimated Effort**: {time-estimate}

## Compliance Trends and Metrics

- **Previous Audit Comparison**: {improvement/degradation}
- **Code Quality Score**: {current} (Previous: {previous})
- **Test Coverage**: {current}% (Previous: {previous}%)
- **Security Score**: {current}/10 (Previous: {previous}/10)

## Next Steps and Action Plan

1. **Immediate Actions** (Next 1-2 weeks)
   - {action-item-1}
   - {action-item-2}
2. **Short-term Improvements** (Next 1-2 months)
   - {improvement-item-1}
   - {improvement-item-2}
3. **Long-term Initiatives** (Next 3-6 months)
   - {initiative-1}
   - {initiative-2}

## Appendix

### Standards Reference

- {standard-1}: {description}
- {standard-2}: {description}

### Tool Configuration

- Audit Tools Used: {list}
- Configuration Files: {list}
- Exclusions Applied: {list}

---

_Report generated by AI-LEY Project Audit System_
_For questions or clarifications, refer to {{files.instructions}}_
```
````

**Step 6.2: Report Validation and Storage**

**Report Quality Assurance**:

- Verify all findings are properly categorized and documented
- Ensure recommendations are actionable and prioritized
- Validate that applied fixes are properly tracked
- Check that report formatting is consistent and readable
- Confirm report is stored in specified location `{{files.audit-report}}`

````

### 7. **Post-Audit Validation and Follow-up**

**Audit Completion and Verification**:
```markdown
**Step 7.1: Fix Validation (if fixes were applied)**

**Automated Fix Verification**:
- Run project build and test suite after fixes
- Verify no regressions were introduced by automated changes
- Validate that applied fixes actually resolve identified issues
- Check that project functionality remains intact
- Ensure all quality gates still pass after modifications

**Step 7.2: Audit Trail and Documentation**

**Compliance Documentation**:
- Document audit methodology and tools used
- Create changelog entries for any applied fixes
- Update project documentation if structural changes were made
- Generate summary metrics for compliance tracking
- Schedule follow-up audit recommendations

**Continuous Improvement Integration**:
- Suggest updates to project standards based on findings
- Recommend tooling improvements for automated compliance
- Identify patterns for proactive compliance monitoring
- Create templates for regular audit scheduling
- Document lessons learned and process improvements
````

## Examples

### Example 1: Basic Audit (No Fixes)

**Input**:

```
audit false
```

**Expected Output**:

```markdown
🔍 Starting comprehensive project audit...

📋 Audit Configuration:

- Fix Mode: Disabled (report only)
- Standards Source: {{files.instructions}}
- Report Output: {{files.audit-report}}

🏗️ Analyzing Project Structure...
✅ Directory organization: 8/10
⚠️ File naming: 6/10 (3 violations found)
✅ Configuration files: 9/10
❌ Documentation: 4/10 (README outdated, missing CONTRIBUTING.md)

💻 Analyzing Code Quality...
✅ Coding standards: 7/10
⚠️ Architecture: 6/10 (2 design pattern violations)
❌ Security: 5/10 (3 vulnerabilities found)
✅ Performance: 8/10

🧪 Analyzing Testing & QA...
⚠️ Test coverage: 65% (target: 80%)
✅ Test quality: 8/10
❌ CI/CD: 4/10 (missing quality gates)

📊 Audit Complete!

- Overall Compliance: 68/100
- Critical Issues: 5
- Warnings: 8
- Recommendations: 12

📄 Detailed report saved to: {{files.audit-report}}
```

### Example 2: Audit with Automated Fixes

**Input**:

```
audit true
```

**Expected Output**:

```markdown
🔍 Starting comprehensive project audit with automated fixes...

📋 Audit Configuration:

- Fix Mode: Enabled (apply safe corrections)
- Standards Source: {{files.instructions}}
- Report Output: {{files.audit-report}}

🏗️ Analyzing & Fixing Project Structure...
✅ Directory organization: 8/10
🔧 Fixing file naming violations...
├── Renamed 3 files to follow naming conventions
└── ✅ File naming: 10/10 (fixed)
✅ Configuration files: 9/10
🔧 Updating documentation structure...
├── Updated README.md with current project info
├── Created CONTRIBUTING.md from template
└── ✅ Documentation: 8/10 (improved)

💻 Analyzing & Fixing Code Quality...
🔧 Applying code formatting fixes...
├── Fixed indentation in 15 files
├── Organized imports in 8 files
├── Updated file headers in 12 files
└── ✅ Coding standards: 9/10 (improved)
⚠️ Architecture: 6/10 (manual review required)
❌ Security: 5/10 (manual fixes required)
✅ Performance: 8/10

🧪 Testing & QA Analysis...
⚠️ Test coverage: 65% (requires new test development)
✅ Test quality: 8/10
🔧 Fixed CI/CD configuration...
├── Added missing quality gate checks
├── Updated pipeline configuration
└── ✅ CI/CD: 8/10 (improved)

📊 Audit & Fix Complete!

- Overall Compliance: 78/100 (improved from 68)
- Fixes Applied: 23 automated corrections
- Remaining Critical Issues: 2 (manual fixes required)
- Warnings: 3 (reduced from 8)

📄 Detailed report with fix log saved to: {{files.audit-report}}

⚠️ Manual Actions Required:

1. Address 3 security vulnerabilities in authentication module
2. Refactor user service to follow repository pattern
3. Add integration tests for payment processing

🎯 Next Steps: Review manual action items and schedule follow-up audit
```

### Example 3: Audit with No Standards Found

**Input**:

```
audit
```

**Expected Output**:

```markdown
❌ Project Audit Failed to Start

🔍 Standards Loading Error:

- Could not locate standards file: {{files.instructions}}
- No compliance criteria available for audit

📋 Required Setup:

1. Create or update {{files.instructions}} with project standards
2. Ensure instruction files contain:
   - Coding standards and style guidelines
   - Architecture and design requirements
   - Testing and quality assurance criteria
   - Documentation standards

💡 Suggestion: Use the 'requirements' command to generate initial standards
Example: requirements "Create comprehensive coding standards for this project"

⏸️ Audit halted - please resolve standards configuration and retry
```

## Notes

- **Fix parameter** enables safe automated corrections (formatting, configuration, documentation)
- **Manual review required** for architectural changes, security fixes, and business logic
- **Audit report** provides comprehensive compliance analysis with actionable recommendations
- **Standards source** loaded from `{{files.instructions}}` ensures consistent compliance criteria
- **Backup creation** before applying fixes allows for safe rollback if needed
- **Incremental validation** after fixes ensures no regressions are introduced
- **Continuous improvement** feedback loop helps refine standards and audit processes
- **Compliance scoring** provides measurable progress tracking over time
