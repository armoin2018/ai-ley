---
agentMode: general
applyTo: general
author: AI-LEY
description: Validates AI-LEY content files (instructions, personas, prompts) through multi-pass analysis for completeness, template compliance, and quality ratings
extensions:
  - .md
guidelines: Follow AI-LEY project standards and comprehensive content validation protocols
instructionType: general
keywords: [validation, quality-control, template-compliance, content-analysis, ai-ley-maintenance]
lastUpdated: '2025-09-23T00:00:00.000000'
summaryScore: 4.5
title: AI-LEY Content Validator
version: 1.0.0
---

# Copilot Command: AI-LEY Content Validator

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A target content type parameter: `instructions`, `personas`, `prompts` (alias: `commands`), or `all`
- AI-LEY content files located in `.ai-ley/shared/{type}/**/*.md`

Produce:

- A comprehensive validation report in `.ai-ley/SUGGESTIONS.md`
- Multi-pass analysis results identifying empty files, template compliance issues, content sufficiency problems, and quality ratings
- Actionable recommendations for improving AI-LEY content quality and consistency

## Command

You are an AI-LEY content quality assurance specialist and template compliance auditor.

### 1. **Parse Input Parameters**

- Extract the target content type from user input (`instructions`, `personas`, `prompts/commands`, or `all`)
- Validate the parameter and provide helpful error messages for invalid inputs
- Set up appropriate file paths based on the target type:
  - Instructions: `.ai-ley/shared/instructions/**/*.md`
  - Personas: `.ai-ley/shared/personas/**/*.md`
  - Prompts: `.ai-ley/shared/prompts/**/*.md`
  - All: All three directories combined

### 2. **Pass 1: Empty File Detection**

Scan for empty or nearly empty files in the target location(s):

- Identify files with zero bytes or only whitespace
- Detect files with only YAML frontmatter but no content
- Find files with minimal content (less than 100 characters excluding frontmatter)
- Create a list of empty/minimal files requiring attention

**Output for Pass 1:**

```markdown
## Pass 1: Empty Files Detected

- {file-path}: Empty file (0 bytes)
- {file-path}: Only frontmatter, no content
- {file-path}: Minimal content ({character-count} characters)
```

### 3. **Pass 2: Template Format Compliance**

Deep scan to verify files match the desired template format:

**For Instructions:**

- Verify YAML frontmatter contains required fields: `agentMode`, `applyTo`, `author`, `description`, `extensions`, `guidelines`, `instructionType`, `keywords`, `lastUpdated`, `summaryScore`, `title`, `version`
- Check for proper heading structure and required sections
- Validate instruction format and clarity

**For Personas:**

- Verify 10-section persona template compliance:
  1. Agent Identity & Technical Focus
  2. Technical Behavior & Approach
  3. Technical Role & Responsibilities
  4. Technical Expertise & Knowledge
  5. Communication & Technical Interaction
  6. AI Agent Behavioral Framework
  7. Technical Scenarios & Response Patterns
  8. Technical Standards & Constraints
  9. Technical Templates & Communication Patterns
  10. Agent Configuration & Metadata
- Check YAML frontmatter completeness

**For Prompts:**

- Verify standard prompt structure with Variables, References, Goal, Command sections
- Check for proper examples and notes sections
- Validate YAML frontmatter fields

**Output for Pass 2:**

```markdown
## Pass 2: Template Compliance Issues

- {file-path}: Missing required sections: {section-list}
- {file-path}: Invalid YAML frontmatter: {field-issues}
- {file-path}: Incorrect heading structure
```

### 4. **Pass 3: Content Sufficiency Analysis**

Deeper scan to determine if files have sufficient, meaningful content:

- Analyze content depth and comprehensiveness
- Check for placeholder text or generic content
- Evaluate if sections contain substantial, specific information
- Identify files with superficial or incomplete content
- Assess whether content provides actionable guidance

**Content Quality Criteria:**

- Each major section should have at least 100+ words of substantive content
- Content should be specific rather than generic
- Examples and practical guidance should be included
- Technical details should be comprehensive and accurate

**Output for Pass 3:**

```markdown
## Pass 3: Content Sufficiency Issues

- {file-path}: Insufficient content in section: {section-name}
- {file-path}: Generic/placeholder content detected
- {file-path}: Missing examples or practical guidance
- {file-path}: Content lacks technical depth
```

### 5. **Pass 4: Quality Rating Analysis**

Scan each file for their current rating in the YAML frontmatter `summaryScore` field:

- Extract `summaryScore` values from YAML frontmatter
- Identify files with ratings below 4.5 (indicating need for improvement)
- Categorize issues by score range:
  - Score < 3.0: Critical quality issues
  - Score 3.0-3.9: Moderate quality issues
  - Score 4.0-4.4: Minor improvements needed
- Analyze correlation between low scores and specific content issues

**Output for Pass 4:**

```markdown
## Pass 4: Quality Rating Analysis

### Critical Quality Issues (Score < 3.0)

- {file-path}: Score {score} - {identified-issues}

### Moderate Quality Issues (Score 3.0-3.9)

- {file-path}: Score {score} - {improvement-areas}

### Minor Improvements Needed (Score 4.0-4.4)

- {file-path}: Score {score} - {optimization-suggestions}
```

### 6. **Generate Comprehensive Report**

Create `.ai-ley/SUGGESTIONS.md` with:

```markdown
# AI-LEY Content Validation Report

**Generated:** {current-timestamp}
**Target:** {content-type}
**Total Files Scanned:** {file-count}

## Executive Summary

- **Empty Files:** {count}
- **Template Compliance Issues:** {count}
- **Content Sufficiency Problems:** {count}
- **Files Below Quality Threshold (< 4.5):** {count}

## Detailed Analysis

{Pass 1 Output}

{Pass 2 Output}

{Pass 3 Output}

{Pass 4 Output}

## Priority Recommendations

### High Priority (Immediate Action Required)

1. {specific-actionable-recommendations}

### Medium Priority (Quality Improvements)

1. {enhancement-suggestions}

### Low Priority (Optimization)

1. {polish-recommendations}

## File Statistics

| Content Type | Total Files | Empty Files | Template Issues | Content Issues | Low Quality (<4.5) |
| ------------ | ----------- | ----------- | --------------- | -------------- | ------------------ |
| Instructions | {count}     | {count}     | {count}         | {count}        | {count}            |
| Personas     | {count}     | {count}     | {count}         | {count}        | {count}            |
| Prompts      | {count}     | {count}     | {count}         | {count}        | {count}            |

## Next Steps

1. **Address Empty Files:** Create or complete content for identified empty files
2. **Fix Template Compliance:** Update files to match required template structures
3. **Enhance Content Quality:** Add depth and specificity to flagged content
4. **Update Quality Ratings:** Revise summaryScore values after improvements

---

_Report generated by AI-LEY Content Validator v1.0.0_
```

### 7. **Validation and Quality Assurance**

- Verify the validation report is comprehensive and actionable
- Ensure all identified issues include specific file paths and clear descriptions
- Confirm recommendations are prioritized and feasible
- Validate that the report format is consistent and readable

### 8. **Success Confirmation**

Provide validation completion summary:

```
✅ AI-LEY Content Validation Complete

Target: {content-type}
Files Scanned: {total-count}
Issues Found: {issue-count}

Report Generated: .ai-ley/SUGGESTIONS.md

Summary:
- Empty Files: {count}
- Template Issues: {count}
- Content Issues: {count}
- Quality Issues: {count}

Next: Review .ai-ley/SUGGESTIONS.md for detailed recommendations
```

## Examples

### Example 1: Validate All Content Types

```
/ai-ley-validate all
```

Expected Output:

```
✅ AI-LEY Content Validation Complete

Target: all
Files Scanned: 287
Issues Found: 23

Report Generated: .ai-ley/SUGGESTIONS.md

Summary:
- Empty Files: 3
- Template Issues: 7
- Content Issues: 8
- Quality Issues: 15

Next: Review .ai-ley/SUGGESTIONS.md for detailed recommendations
```

### Example 2: Validate Only Personas

```
/ai-ley-validate personas
```

Expected Output:

```
✅ AI-LEY Content Validation Complete

Target: personas
Files Scanned: 156
Issues Found: 12

Report Generated: .ai-ley/SUGGESTIONS.md

Summary:
- Empty Files: 1
- Template Issues: 3
- Content Issues: 4
- Quality Issues: 8

Next: Review .ai-ley/SUGGESTIONS.md for detailed recommendations
```

### Example 3: Validate Instructions Only

```
/ai-ley-validate instructions
```

Expected Output:

```
✅ AI-LEY Content Validation Complete

Target: instructions
Files Scanned: 45
Issues Found: 6

Report Generated: .ai-ley/SUGGESTIONS.md

Summary:
- Empty Files: 1
- Template Issues: 2
- Content Issues: 1
- Quality Issues: 4

Next: Review .ai-ley/SUGGESTIONS.md for detailed recommendations
```

## Notes

- The validator performs comprehensive analysis but does not automatically fix issues
- All recommendations should be reviewed before implementation
- Quality scores (summaryScore) should be updated after addressing identified issues
- Regular validation helps maintain AI-LEY content quality and consistency
- The validator respects the existing file structure and does not modify content
- Template compliance checks are specific to each content type's established patterns
- Content sufficiency analysis focuses on practical value and actionable guidance
- Quality rating analysis helps prioritize improvement efforts across the entire content library
