---
agentMode: general
applyTo: general
author: AI-LEY
description: Rescans and rates AI-LEY content files (instructions, personas, prompts) from 0-5 based on quality and template alignment, updating scores and listing files below 4.5 for improvement
extensions:
  - .md
guidelines: Follow AI-LEY project standards and comprehensive quality assessment protocols based on established templates
instructionType: general
keywords: [assessment, quality-rating, template-alignment, content-evaluation, ai-ley-scoring]
lastUpdated: '2025-09-23T00:00:00.000000'
summaryScore: 4.5
title: AI-LEY Content Assessor
version: 1.0.0
---

# Copilot Command: AI-LEY Content Assessor

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- Reference quality standards from `.ai-ley/shared/prompts/update-instructions.md` for instruction assessment
- Reference quality standards from `.ai-ley/shared/prompts/update-personas.md` for persona assessment
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A target content type parameter: `instructions`, `personas`, `prompts` (alias: `commands`), or `all`
- AI-LEY content files located in `.ai-ley/shared/{type}/**/*.md`
- Quality standards and templates defined in update-instructions.md and update-personas.md

Produce:

- Updated `summaryScore` values (0-5 scale) in YAML frontmatter based on quality and template alignment
- A focused improvement report in `.ai-ley/SUGGESTIONS.md` listing files scoring below 4.5
- Systematic quality assessment following established AI-LEY standards and templates

## Command

You are an AI-LEY content quality assessor and scoring specialist with expertise in template compliance and content excellence evaluation.

### 1. **Parse Input Parameters**

- Extract the target content type from user input (`instructions`, `personas`, `prompts/commands`, or `all`)
- Validate the parameter and provide helpful error messages for invalid inputs
- Set up appropriate file paths and assessment criteria based on target type:
  - Instructions: `.ai-ley/shared/instructions/**/*.md` (evaluated against update-instructions.md standards)
  - Personas: `.ai-ley/shared/personas/**/*.md` (evaluated against update-personas.md standards)
  - Prompts: `.ai-ley/shared/prompts/**/*.md` (evaluated against general prompt standards)
  - All: All three directories with type-specific criteria

### 2. **Load Assessment Standards**

**For Instructions:**

- Read and parse `.ai-ley/shared/prompts/update-instructions.md` for quality criteria
- Extract template requirements, content standards, and scoring guidelines
- Identify key elements: structure, clarity, actionability, technical accuracy

**For Personas:**

- Read and parse `.ai-ley/shared/prompts/update-personas.md` for quality criteria
- Extract 10-section template requirements and persona standards
- Identify key elements: authenticity, role clarity, character depth, AI usability

**For Prompts:**

- Apply general prompt quality standards: clear structure, actionable instructions, proper examples
- Evaluate YAML frontmatter completeness and content organization

### 3. **Systematic Content Assessment**

For each file in the target type(s), perform comprehensive quality evaluation:

**Assessment Criteria (0-5 Scale):**

**5.0 - Exceptional Quality**

- Perfect template compliance and structure
- Comprehensive, detailed, and highly actionable content
- Exceptional clarity and professional presentation
- Fully meets or exceeds all quality standards
- Ready for immediate production use

**4.5 - High Quality**

- Strong template compliance with minor gaps
- Comprehensive content with good depth and clarity
- Mostly meets quality standards with minimal improvements needed
- Professional presentation with minor polish opportunities

**4.0 - Good Quality**

- Adequate template compliance with some missing elements
- Good content depth but could be more comprehensive
- Meets most quality standards but has improvement opportunities
- Functional but could benefit from enhancement

**3.5 - Moderate Quality**

- Partial template compliance with several gaps
- Moderate content quality with some superficial areas
- Meets basic standards but requires significant improvement
- Functional but needs substantial enhancement

**3.0 - Basic Quality**

- Limited template compliance with major gaps
- Basic content that lacks depth and detail
- Does not consistently meet quality standards
- Requires major revision and improvement

**2.5 - Below Standard**

- Poor template compliance with structural issues
- Superficial content with significant gaps
- Fails to meet most quality standards
- Requires complete restructuring and content development

**2.0 - Poor Quality**

- Major template compliance failures
- Inadequate content with minimal useful information
- Fails to meet basic quality standards
- Requires extensive rework

**1.5 - Very Poor Quality**

- Severe structural and content deficiencies
- Minimal viable content
- Completely fails quality standards
- Requires complete reconstruction

**1.0 - Minimal Quality**

- Barely functional content
- Major deficiencies in all areas
- Unsuitable for use
- Complete reconstruction required

**0.5 - Critically Deficient**

- Non-functional or placeholder content
- Critical deficiencies requiring immediate attention
- Unsuitable for any use case

**0.0 - Empty/Non-functional**

- Empty file or completely non-functional content
- No usable content present

### 4. **Detailed Assessment Process**

**For Each File:**

1. **Parse Current Content**

   - Extract existing YAML frontmatter and current `summaryScore`
   - Analyze content structure and organization
   - Identify template compliance level

2. **Apply Assessment Criteria**

   - **Template Compliance (25%)**: How well does it match required template structure?
   - **Content Quality (25%)**: Depth, accuracy, and comprehensiveness of information
   - **Clarity & Usability (25%)**: How clear and actionable is the content?
   - **Professional Standards (25%)**: Writing quality, organization, and presentation

3. **Calculate Composite Score**

   - Weight each assessment dimension appropriately
   - Round to nearest 0.5 increment
   - Ensure score reflects overall quality accurately

4. **Update YAML Frontmatter**
   - Modify `summaryScore` field with new assessment
   - Preserve all other frontmatter fields
   - Update `lastUpdated` timestamp if score changes significantly (>0.5 difference)

### 5. **Score Update Implementation**

**For each file requiring score updates:**

```yaml
# Example frontmatter update
---
agentMode: specialized
applyTo: development
author: AI-LEY
description: [existing description]
extensions:
  - .md
guidelines: [existing guidelines]
instructionType: persona
keywords: [existing keywords]
lastUpdated: '2025-09-23T00:00:00.000000' # Update if significant score change
summaryScore: 4.0 # Updated score
title: [existing title]
version: 1.0.0
---
```

**Score Update Rules:**

- Only update `summaryScore` field
- Update `lastUpdated` timestamp if score changes by >0.5
- Preserve all other metadata fields exactly
- Maintain proper YAML formatting

### 6. **Generate Improvement Report**

Create or update `.ai-ley/SUGGESTIONS.md` with files scoring below 4.5:

```markdown
# AI-LEY Content Assessment Report

**Generated:** {current-timestamp}
**Assessment Type:** {content-type}
**Files Assessed:** {total-count}
**Files Requiring Improvement:** {low-score-count}

## Executive Summary

Total files scoring below 4.5: **{count}**

### Score Distribution

- 0.0-1.9 (Critical): {count}
- 2.0-2.9 (Poor): {count}
- 3.0-3.9 (Moderate): {count}
- 4.0-4.4 (Good but needs polish): {count}

## Files Requiring Improvement (Score < 4.5)

### Critical Priority (Score 0.0-2.9)

| File        | Current Score | Primary Issues     | Recommended Action      |
| ----------- | ------------- | ------------------ | ----------------------- |
| {file-path} | {score}       | {key-deficiencies} | Complete reconstruction |

### High Priority (Score 3.0-3.9)

| File        | Current Score | Primary Issues      | Recommended Action    |
| ----------- | ------------- | ------------------- | --------------------- |
| {file-path} | {score}       | {improvement-areas} | Major revision needed |

### Medium Priority (Score 4.0-4.4)

| File        | Current Score | Primary Issues         | Recommended Action |
| ----------- | ------------- | ---------------------- | ------------------ |
| {file-path} | {score}       | {polish-opportunities} | Minor enhancements |

## Improvement Recommendations

### Template Compliance Issues

- {specific-template-gaps}
- {structural-improvements-needed}

### Content Quality Issues

- {content-depth-improvements}
- {accuracy-corrections-needed}

### Clarity & Usability Issues

- {clarity-improvements}
- {actionability-enhancements}

### Professional Standards Issues

- {writing-quality-improvements}
- {presentation-enhancements}

## Next Steps

1. **Immediate Action (Critical/Poor files):** Prioritize complete reconstruction
2. **Short-term (Moderate files):** Plan major revision cycles
3. **Medium-term (Good files):** Schedule polish and enhancement
4. **Ongoing:** Regular assessment to maintain quality standards

## Assessment Criteria Applied

### Instructions Assessment

- Based on standards from: `.ai-ley/shared/prompts/update-instructions.md`
- Template compliance, technical accuracy, actionability

### Personas Assessment

- Based on standards from: `.ai-ley/shared/prompts/update-personas.md`
- 10-section template compliance, authenticity, AI usability

### Prompts Assessment

- General prompt quality standards
- Structure, clarity, examples, actionability

---

_Assessment performed by AI-LEY Content Assessor v1.0.0_
```

### 7. **Assessment Statistics and Reporting**

Track and report assessment statistics:

```markdown
## Assessment Statistics

| Content Type | Total Files | Average Score | Files < 4.5 | Improvement Rate |
| ------------ | ----------- | ------------- | ----------- | ---------------- |
| Instructions | {count}     | {avg-score}   | {count}     | {percentage}     |
| Personas     | {count}     | {avg-score}   | {count}     | {percentage}     |
| Prompts      | {count}     | {avg-score}   | {count}     | {percentage}     |
| **Total**    | {count}     | {avg-score}   | {count}     | {percentage}     |
```

### 8. **Validation and Quality Assurance**

- Verify all score updates are properly applied to YAML frontmatter
- Ensure assessment criteria are consistently applied across all files
- Confirm improvement report is comprehensive and actionable
- Validate that scoring methodology aligns with established standards

### 9. **Success Confirmation**

Provide assessment completion summary:

```
✅ AI-LEY Content Assessment Complete

Assessment Target: {content-type}
Files Assessed: {total-count}
Scores Updated: {update-count}
Files Below 4.5: {improvement-count}

Score Updates Applied: {files-with-score-changes}
Report Generated: .ai-ley/SUGGESTIONS.md

Average Quality Score: {average-score}
Quality Distribution:
- Exceptional (4.5-5.0): {count} files
- Good (4.0-4.4): {count} files
- Moderate (3.0-3.9): {count} files
- Poor (0.0-2.9): {count} files

Next: Review .ai-ley/SUGGESTIONS.md for improvement priorities
```

## Examples

### Example 1: Assess All Content Types

```
/ai-ley-assess all
```

Expected Output:

```
✅ AI-LEY Content Assessment Complete

Assessment Target: all
Files Assessed: 287
Scores Updated: 45
Files Below 4.5: 23

Score Updates Applied: 45 files modified
Report Generated: .ai-ley/SUGGESTIONS.md

Average Quality Score: 4.2
Quality Distribution:
- Exceptional (4.5-5.0): 156 files
- Good (4.0-4.4): 108 files
- Moderate (3.0-3.9): 18 files
- Poor (0.0-2.9): 5 files

Next: Review .ai-ley/SUGGESTIONS.md for improvement priorities
```

### Example 2: Assess Only Personas

```
/ai-ley-assess personas
```

Expected Output:

```
✅ AI-LEY Content Assessment Complete

Assessment Target: personas
Files Assessed: 156
Scores Updated: 28
Files Below 4.5: 12

Score Updates Applied: 28 files modified
Report Generated: .ai-ley/SUGGESTIONS.md

Average Quality Score: 4.3
Quality Distribution:
- Exceptional (4.5-5.0): 89 files
- Good (4.0-4.4): 55 files
- Moderate (3.0-3.9): 10 files
- Poor (0.0-2.9): 2 files

Next: Review .ai-ley/SUGGESTIONS.md for improvement priorities
```

### Example 3: Assess Instructions Only

```
/ai-ley-assess instructions
```

Expected Output:

```
✅ AI-LEY Content Assessment Complete

Assessment Target: instructions
Files Assessed: 45
Scores Updated: 8
Files Below 4.5: 6

Score Updates Applied: 8 files modified
Report Generated: .ai-ley/SUGGESTIONS.md

Average Quality Score: 4.4
Quality Distribution:
- Exceptional (4.5-5.0): 25 files
- Good (4.0-4.4): 14 files
- Moderate (3.0-3.9): 5 files
- Poor (0.0-2.9): 1 file

Next: Review .ai-ley/SUGGESTIONS.md for improvement priorities
```

## Notes

- The assessor updates scores in-place, modifying the actual content files
- Assessment criteria are based on established AI-LEY quality standards and templates
- Only the `summaryScore` field is updated; all other metadata is preserved
- Files scoring below 4.5 are flagged for improvement in the suggestions report
- Assessment scoring is objective and consistent, based on measurable criteria
- The system respects existing file structure and only updates quality ratings
- Regular assessment helps maintain high content quality across the AI-LEY ecosystem
- Score updates trigger timestamp updates only for significant changes (>0.5 difference)
- Assessment methodology can be refined based on emerging quality standards
