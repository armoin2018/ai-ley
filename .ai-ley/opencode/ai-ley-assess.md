# AI-LEY Content Assessor

**Command**: `ai-ley-assess`

Rescans and rates AI-LEY content files (instructions, personas, prompts) from 0-5 based on quality and template alignment, updating scores and listing files below 4.5 for improvement.

## Command Syntax

```
@ai-ley-assess [content-type]
```

### Parameters

- `content-type` (optional): Target content type to assess
  - `instructions` - Assess instruction files only
  - `personas` - Assess persona files only
  - `prompts` - Assess prompt files only
  - `commands` - Alias for prompts
  - `all` - Assess all content types (default if not specified)

## Usage Examples

```
@ai-ley-assess all
```

_Assesses all AI-LEY content types and provides comprehensive quality report_

```
@ai-ley-assess personas
```

_Focuses assessment on persona files only, evaluating against 10-section template standards_

```
@ai-ley-assess instructions
```

_Assesses instruction files against technical accuracy and actionability standards_

```
@ai-ley-assess prompts
```

_Evaluates prompt files for structure, clarity, and effectiveness_

## Assessment Process

### 1. Content Discovery

- Scans specified content directories for .md files
- Parses existing YAML frontmatter and current scores
- Identifies files requiring assessment updates

### 2. Quality Evaluation

Four-dimensional assessment framework:

- **Template Compliance (25%)**: Adherence to required structure and format
- **Content Quality (25%)**: Information depth, accuracy, and comprehensiveness
- **Clarity & Usability (25%)**: Readability, actionability, and user experience
- **Professional Standards (25%)**: Writing quality, organization, presentation

### 3. Scoring System

0-5 scale with 0.5 increments:

- **5.0**: Exceptional - Perfect compliance, production-ready
- **4.5**: High quality - Strong compliance, minor improvements
- **4.0**: Good - Adequate compliance, some enhancements needed
- **3.5**: Moderate - Partial compliance, several gaps
- **3.0**: Basic - Limited compliance, major improvements needed
- **2.5-0.5**: Below standard - Significant reconstruction required
- **0.0**: Empty/non-functional - Complete reconstruction needed

### 4. File Updates

- Updates `summaryScore` field in YAML frontmatter
- Preserves all other metadata fields
- Updates `lastUpdated` timestamp for significant score changes (>0.5)

### 5. Improvement Reporting

Generates/updates `.ai-ley/SUGGESTIONS.md` with:

- Files scoring below 4.5
- Categorized by priority level (Critical, High, Medium)
- Specific improvement recommendations
- Assessment statistics and quality distribution

## Output Structure

### Immediate Feedback

```
✅ AI-LEY Content Assessment Complete

Assessment Target: {content-type}
Files Assessed: {total-count}
Scores Updated: {update-count}
Files Below 4.5: {improvement-count}

Average Quality Score: {average-score}
Quality Distribution:
- Exceptional (4.5-5.0): {count} files
- Good (4.0-4.4): {count} files
- Moderate (3.0-3.9): {count} files
- Poor (0.0-2.9): {count} files

Next: Review .ai-ley/SUGGESTIONS.md for improvement priorities
```

### Assessment Report

Comprehensive report in `.ai-ley/SUGGESTIONS.md` includes:

- Executive summary with score distribution
- Prioritized improvement tables
- Specific recommendations by category
- Next steps and action items

## Quality Standards

### Instructions Assessment

- Based on `.ai-ley/shared/prompts/update-instructions.md`
- Evaluates technical accuracy, actionability, structure
- Focuses on implementation clarity and completeness

### Personas Assessment

- Based on `.ai-ley/shared/prompts/update-personas.md`
- Evaluates 10-section template compliance
- Focuses on authenticity, role clarity, AI usability

### Prompts Assessment

- Based on general prompt quality standards
- Evaluates structure, clarity, examples, actionability
- Focuses on effectiveness and user experience

## OpenCode Integration

- Compatible with OpenCode's project management workflow
- Results integrate with existing quality tracking systems
- Assessment data can inform project planning and prioritization
- Supports continuous improvement processes

## Files Modified

The command modifies:

- **Content files**: Updates `summaryScore` in YAML frontmatter
- **Assessment report**: Creates/updates `.ai-ley/SUGGESTIONS.md`
- **Metadata**: Updates timestamps for significant score changes

## Best Practices

1. **Regular Assessment**: Run quarterly or after major content updates
2. **Targeted Assessment**: Use specific content types for focused improvement
3. **Follow-up Actions**: Address files below 4.5 score systematically
4. **Quality Tracking**: Monitor score trends over time
5. **Template Compliance**: Ensure all content follows established templates

## Implementation

This command implements the comprehensive assessment workflow defined in:
`.ai-ley/shared/prompts/ai-ley-assess.md`

The assessment process is consistent across all AI platforms and provides reliable, objective quality measurement for AI-LEY content management.
