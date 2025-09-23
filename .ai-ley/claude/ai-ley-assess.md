# AI-LEY Content Assessor

Rescans and rates AI-LEY content files (instructions, personas, prompts) from 0-5 based on quality and template alignment, updating scores and listing files below 4.5 for improvement.

## Usage

When working with AI-LEY content assessment, use the following patterns:

```
I need to assess the quality of AI-LEY content files
```

```
Please run ai-ley-assess on all content types
```

```
Rate and score the personas based on template compliance
```

```
Assess instruction files and update their quality scores
```

## Parameters

- **Content Type**: Specify what to assess
  - `instructions` - Assess instruction files only
  - `personas` - Assess persona files only
  - `prompts` or `commands` - Assess prompt files only
  - `all` - Assess all content types

## What This Does

1. **Quality Assessment**: Evaluates AI-LEY files against established quality standards and template compliance
2. **Score Updates**: Updates `summaryScore` values (0-5 scale) in YAML frontmatter based on comprehensive assessment
3. **Improvement Reporting**: Generates `.ai-ley/SUGGESTIONS.md` with actionable recommendations for files scoring below 4.5
4. **Quality Metrics**: Provides detailed statistics and score distribution across content types

## Assessment Framework

The assessment uses a 4-dimension evaluation:

- **Template Compliance (25%)**: How well content matches required template structure
- **Content Quality (25%)**: Depth, accuracy, and comprehensiveness of information
- **Clarity & Usability (25%)**: How clear and actionable the content is
- **Professional Standards (25%)**: Writing quality, organization, and presentation

## Scoring Scale

- **5.0**: Exceptional quality, perfect template compliance
- **4.5**: High quality, strong compliance with minor gaps
- **4.0**: Good quality, adequate compliance with improvement opportunities
- **3.5**: Moderate quality, partial compliance with several gaps
- **3.0**: Basic quality, limited compliance with major gaps
- **2.5 and below**: Below standard, requires significant improvement

## Expected Outputs

- **File Updates**: Modified `summaryScore` values in YAML frontmatter
- **Assessment Report**: `.ai-ley/SUGGESTIONS.md` with improvement priorities
- **Statistics Summary**: Quality distribution and average scores
- **Action Items**: Specific recommendations for files needing improvement

## Quality Standards References

- **Instructions**: Based on `.ai-ley/shared/prompts/update-instructions.md` standards
- **Personas**: Based on `.ai-ley/shared/prompts/update-personas.md` standards
- **Prompts**: Based on general prompt quality standards and best practices

## Claude-Specific Notes

- The assessment command automatically identifies content types if not specified
- Results include both immediate feedback and persistent file updates
- Assessment criteria are consistently applied across all platforms
- The system preserves all existing metadata while updating quality scores

## Implementation Reference

This command implements the comprehensive assessment workflow defined in:
`.ai-ley/shared/prompts/ai-ley-assess.md`
