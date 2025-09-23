# AI-LEY Content Assessor

Rescans and rates AI-LEY content files (instructions, personas, prompts) from 0-5 based on quality and template alignment, updating scores and listing files below 4.5 for improvement.

## Usage

```
/ai-ley-assess [content-type]
```

### Parameters

- `content-type`: Target content type to assess
  - `instructions` - Assess instruction files only
  - `personas` - Assess persona files only
  - `prompts` or `commands` - Assess prompt files only
  - `all` - Assess all content types (default)

## Examples

```bash
# Assess all content types
/ai-ley-assess all

# Assess only personas
/ai-ley-assess personas

# Assess only instructions
/ai-ley-assess instructions

# Assess only prompts/commands
/ai-ley-assess prompts
```

## What This Command Does

1. **Content Assessment**: Evaluates AI-LEY files against quality standards and template compliance
2. **Score Updates**: Updates `summaryScore` values (0-5 scale) in YAML frontmatter based on assessment
3. **Improvement Reporting**: Generates `.ai-ley/SUGGESTIONS.md` with files scoring below 4.5
4. **Quality Metrics**: Provides comprehensive statistics and score distribution

## Assessment Criteria

- **Template Compliance (25%)**: How well content matches required template structure
- **Content Quality (25%)**: Depth, accuracy, and comprehensiveness of information
- **Clarity & Usability (25%)**: How clear and actionable the content is
- **Professional Standards (25%)**: Writing quality, organization, and presentation

## Output

- Updates `summaryScore` in file frontmatter
- Creates/updates `.ai-ley/SUGGESTIONS.md` with improvement recommendations
- Provides assessment statistics and score distribution
- Lists files requiring improvement (score < 4.5)

## Quality Standards

- **Instructions**: Evaluated against `.ai-ley/shared/prompts/update-instructions.md` standards
- **Personas**: Evaluated against `.ai-ley/shared/prompts/update-personas.md` standards
- **Prompts**: Evaluated against general prompt quality standards

## Implementation

This command uses the comprehensive assessment workflow defined in:
`.ai-ley/shared/prompts/ai-ley-assess.md`
