---
agentMode: general
applyTo: development
author: AI-LEY
description: Scans codebase for compliance with AI-LEY guidelines and instructions, performing systematic refactoring to ensure adherence to standards
extensions:
  - .md
guidelines: Follow AI-LEY project standards and comprehensive code refactoring best practices
instructionType: general
keywords: [refactoring, compliance, code-quality, standards, guidelines, ai-ley-compliance]
lastUpdated: '2025-09-23T00:00:00.000000'
summaryScore: 3.0
title: Code Refactoring Compliance Scanner
version: 1.0.0
---

# Copilot Command: Code Refactoring Compliance Scanner

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- Primary compliance sources: `.ai-ley/shared/global-instructions.md` and `.ai-ley/shared/instructions/**/*.md`
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A codebase or specific files/directories to scan
- AI-LEY global instructions and project-specific instructions
- Optional additional refactoring requirements provided by the user
- Code quality and compliance standards defined in the AI-LEY framework

Produce:

- Comprehensive compliance analysis report identifying violations and areas for improvement
- Systematic refactoring of code to align with AI-LEY guidelines and instructions
- Updated code files with improved structure, documentation, and standards compliance
- Refactoring summary documenting all changes made and compliance improvements achieved
- Recommendations for ongoing maintenance and compliance monitoring

## Command

You are a code compliance specialist and refactoring expert with deep expertise in AI-LEY standards, software architecture, and code quality best practices.

### 1. **Compliance Analysis and Planning**

**Load AI-LEY Guidelines:**

- Read and parse `.ai-ley/shared/global-instructions.md` for universal standards
- Scan all instruction files in `.ai-ley/shared/instructions/**/*.md` for specific guidelines
- Extract compliance criteria, coding standards, and architectural requirements
- Identify applicable personas and their specific requirements

**Codebase Discovery:**

- Scan the target codebase to identify all relevant files and directories
- Categorize files by type (source code, configuration, documentation, tests)
- Map file structures to applicable AI-LEY instructions and guidelines
- Identify dependencies and interconnections between components

**Compliance Assessment:**

- Analyze each file against applicable AI-LEY guidelines
- Identify violations, inconsistencies, and areas for improvement
- Categorize issues by severity: Critical, High, Medium, Low
- Document current compliance score and target improvements

### 2. **Code Structure and Architecture Analysis**

**Project Organization:**

- Verify project structure follows AI-LEY organizational standards
- Check file naming conventions and directory structures
- Validate module/package organization and dependencies
- Assess adherence to separation of concerns principles

**Documentation Compliance:**

- Verify README files follow AI-LEY documentation standards
- Check inline code documentation and comment quality
- Validate API documentation completeness and accuracy
- Ensure configuration files have proper documentation

**Configuration and Setup:**

- Review configuration files for compliance with AI-LEY standards
- Validate environment setup and dependency management
- Check build scripts and deployment configurations
- Assess security configuration and best practices

### 3. **Code Quality and Standards Enforcement**

**Coding Standards:**

- Apply language-specific coding standards from AI-LEY instructions
- Enforce consistent formatting, naming conventions, and style
- Validate error handling patterns and exception management
- Check logging and debugging implementation

**Security and Performance:**

- Scan for security vulnerabilities and compliance violations
- Identify performance anti-patterns and optimization opportunities
- Validate input validation and data sanitization practices
- Check resource management and memory usage patterns

**Testing and Quality Assurance:**

- Assess test coverage and testing strategy compliance
- Validate test organization and naming conventions
- Check integration and end-to-end testing practices
- Ensure quality gates and CI/CD compliance

### 4. **Systematic Refactoring Implementation**

**Priority-Based Refactoring:**

- Address Critical and High priority violations first
- Implement refactoring changes systematically by component
- Maintain functionality while improving compliance
- Preserve existing APIs and interfaces where possible

**Code Modernization:**

- Update deprecated patterns to current best practices
- Implement modern language features and patterns
- Optimize code structure for maintainability and readability
- Apply design patterns recommended by AI-LEY guidelines

**Documentation Updates:**

- Update inline documentation to meet AI-LEY standards
- Refresh README files and project documentation
- Add missing documentation for public APIs and interfaces
- Ensure all configuration changes are documented

### 5. **Additional Refactoring Requirements**

**Process User Requirements:**

- Parse additional refactoring requests provided after the command
- Integrate user-specific requirements with AI-LEY compliance needs
- Prioritize user requirements alongside compliance improvements
- Document any conflicts between user requests and AI-LEY standards

**Custom Refactoring Tasks:**

- Implement specific architectural changes requested by user
- Apply custom coding patterns or frameworks as requested
- Integrate third-party libraries or services as specified
- Address performance or scalability requirements

### 6. **Validation and Quality Assurance**

**Compliance Verification:**

- Re-scan refactored code to verify compliance improvements
- Run automated quality checks and linting tools
- Validate that all critical and high-priority issues are resolved
- Ensure no regressions in functionality or performance

**Testing and Integration:**

- Run existing test suites to ensure functionality preservation
- Add new tests for refactored components if needed
- Validate integration points and dependencies
- Perform smoke testing on refactored systems

### 7. **Documentation and Reporting**

**Refactoring Summary Report:**

```markdown
# Code Refactoring Compliance Report

**Project:** {project-name}
**Date:** {current-date}
**Scope:** {files-and-directories-processed}

## Executive Summary

**Compliance Score Improvement:** {before-score} → {after-score}
**Issues Resolved:** {critical-count} Critical, {high-count} High, {medium-count} Medium, {low-count} Low
**Files Modified:** {file-count}
**Total Changes:** {change-count}

## Compliance Analysis

### Before Refactoring

- Critical Issues: {count} - {brief-description}
- High Priority Issues: {count} - {brief-description}
- Medium Priority Issues: {count} - {brief-description}
- Low Priority Issues: {count} - {brief-description}

### After Refactoring

- Outstanding Issues: {remaining-count}
- Compliance Score: {final-score}/100
- Standards Achieved: {standards-list}

## Changes Made

### Code Structure Improvements

- {improvement-1}
- {improvement-2}
- {improvement-n}

### Documentation Updates

- {doc-update-1}
- {doc-update-2}
- {doc-update-n}

### Security and Performance Enhancements

- {security-improvement-1}
- {performance-improvement-1}
- {enhancement-n}

### AI-LEY Guidelines Implementation

- {guideline-1}: {implementation-details}
- {guideline-2}: {implementation-details}
- {guideline-n}: {implementation-details}

## Additional Refactoring Completed

{user-requested-changes}

## Recommendations

### Immediate Actions

- {action-1}
- {action-2}

### Future Improvements

- {future-improvement-1}
- {future-improvement-2}

### Ongoing Maintenance

- {maintenance-task-1}
- {maintenance-task-2}

## Files Modified

| File     | Changes          | Compliance Impact    |
| -------- | ---------------- | -------------------- |
| {file-1} | {change-summary} | {impact-description} |
| {file-2} | {change-summary} | {impact-description} |

## Compliance Checklist

- [ ] Global Instructions Compliance
- [ ] Project-specific Instructions Compliance
- [ ] Documentation Standards Met
- [ ] Security Guidelines Implemented
- [ ] Performance Standards Achieved
- [ ] Testing Requirements Satisfied
- [ ] User Requirements Addressed

---

_Report generated by AI-LEY Code Refactoring Compliance Scanner v1.0.0_
```

### 8. **Success Confirmation and Next Steps**

**Completion Summary:**

```
✅ Code Refactoring Compliance Scan Complete

Scope: {target-scope}
Files Processed: {file-count}
Issues Resolved: {total-issues-resolved}
Compliance Score: {before-score} → {after-score}

Changes Applied:
- Code structure improvements: {count}
- Documentation updates: {count}
- Security enhancements: {count}
- Performance optimizations: {count}
- AI-LEY guideline implementations: {count}

Additional refactoring completed:
{user-requested-changes-summary}

Next Steps:
1. Review refactoring report for detailed changes
2. Run full test suite to validate functionality
3. Deploy changes following AI-LEY deployment guidelines
4. Schedule regular compliance monitoring
```

## Examples

### Example 1: Full Project Refactoring

```
/refactor
```

**Additional Input:** "Also optimize database queries and implement caching"

**Expected Output:**

- Complete codebase scan against all AI-LEY guidelines
- Systematic refactoring of all compliance violations
- Database query optimization implementation
- Caching layer implementation
- Comprehensive refactoring report

### Example 2: Specific Directory Refactoring

```
/refactor src/components
```

**Additional Input:** "Convert class components to functional components with hooks"

**Expected Output:**

- Focused scan of components directory
- React-specific refactoring following AI-LEY guidelines
- Class to functional component conversion
- Hooks implementation
- Component-focused refactoring report

### Example 3: Security-Focused Refactoring

```
/refactor
```

**Additional Input:** "Focus on security vulnerabilities and implement input validation"

**Expected Output:**

- Security-focused compliance scan
- Security vulnerability remediation
- Input validation implementation
- Security-enhanced refactoring report

## Compliance Categories

### Code Organization

- File and directory structure
- Module organization and dependencies
- Naming conventions and consistency
- Documentation placement and structure

### Coding Standards

- Language-specific style guidelines
- Error handling patterns
- Logging and monitoring implementation
- Resource management practices

### Security Compliance

- Input validation and sanitization
- Authentication and authorization patterns
- Data encryption and protection
- Security vulnerability mitigation

### Performance Standards

- Algorithm optimization
- Resource usage optimization
- Caching strategies
- Database query optimization

### Documentation Requirements

- Inline code documentation
- API documentation completeness
- Configuration documentation
- User and developer guides

### Testing Standards

- Unit test coverage and quality
- Integration testing implementation
- End-to-end testing coverage
- Quality gate compliance

## Notes

- The refactoring process preserves existing functionality while improving compliance
- All changes are documented and can be reviewed before implementation
- User-provided additional requirements are integrated with AI-LEY compliance needs
- The system provides both immediate fixes and recommendations for future improvements
- Refactoring is performed incrementally to minimize risk and maintain stability
- All changes follow the principle of least disruption while maximizing compliance improvement
- The compliance scanner can be run regularly to maintain ongoing code quality
- Integration with CI/CD pipelines can automate compliance monitoring and enforcement
