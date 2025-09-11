---
agentMode: general
applyTo: general
author: AI-LEY
description: Benchmark and evaluate instruction and persona files for effectiveness, clarity, and performance characteristics with flexible input targeting
extensions:
  - .md
guidelines: Support specific file, category, or comprehensive benchmarking modes
instructionType: general
keywords: [benchmark, quality, assessment, personas, instructions, performance]
lastUpdated: '2025-09-11T00:00:00.000000'
summaryScore: 4.5
title: Bench
version: 2.0.0
inputs:
  - name: target
    type: string
    description: "Target for benchmarking - can be: specific filename (e.g. 'clean-code-advocate.md'), category ('personas' or 'instructions'), or omit for all files"
    required: false
    examples:
      - 'clean-code-advocate.md'
      - 'personas'
      - 'instructions'
      - '' # benchmark all
outputs:
  - name: benchmark_reports
    description: 'Individual detailed reports for each benchmarked file under {{folders.benchmark}}/{fileName}'
  - name: benchmark_summary
    description: 'High-level summary report at {{folders.benchmark}}/benchmark-summary.md'
  - name: benchmark_progress
    description: 'Progress tracking file at {{folders.benchmark}}/benchmark-progress.md with md5 hashes'
---

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

# Benchmark Instructions and Personas Quality Assessment

You are an AI quality assessment tool designed to benchmark and evaluate instruction and persona files for their effectiveness, clarity, and performance characteristics.

## Input Processing

The benchmark system supports flexible targeting based on user input:

### Input Modes:

1. **Specific File**: Target a single file by name (e.g., "clean-code-advocate.md")
2. **Category Mode**: Target all files in a category ("personas" or "instructions")
3. **Comprehensive Mode**: Benchmark all files when no target is specified

### Target Resolution:

- If a specific filename is provided, search for it in both `{{folders.personas}}` and `{{folders.instructions}}` directories
- If "personas" is specified, process all files in `{{folders.personas}}/**/*.md`
- If "instructions" is specified, process all files in `{{folders.instructions}}/**/*.md`
- If no target or empty string is provided, process both personas and instructions comprehensively

## Your Task

## Your Task

Based on the provided input target, determine the scope of evaluation:

### File Discovery Process:

1. **Parse Input Target**:

   - If target matches a filename pattern (ends with .md), search for that specific file
   - If target equals "personas", set scope to personas directory only
   - If target equals "instructions", set scope to instructions directory only
   - If target is empty/null, set scope to both directories (comprehensive mode)

2. **File Resolution**:

   - For specific files: Search in both `{{folders.personas}}/**/*.md` and `{{folders.instructions}}/**/*.md`
   - For category mode: Use appropriate directory based on target
   - For comprehensive mode: Include all files from both directories recursively

3. **File Processing**:

   - Exclude the files: `*README*.md`, `.DS_Store`, `*template*`, `*example*`
   - Process all subfolders recursively
   - Generate MD5 checksums for progress tracking

4. **Output Generation**:
   - Work through each file systematically
   - Create a high level summary under `{{folders.benchmark}}/benchmark-summary.md`
   - Create a detailed report for each file under `{{folders.benchmark}}/{fileName}`
   - Capture the progress in `{{folders.benchmark}}/benchmark-progress.md`

### MD5 Tracking Commands:

For comprehensive benchmarking:

```bash
find {{folders.personas}} {{folders.instructions}} -name "*.md" -not -name "*README*" -not -name "*template*" -not -name "*example*" -type f -exec md5sum {} \; > {{folders.benchmark}}/all-files.md5
```

For personas only:

```bash
find {{folders.personas}} -name "*.md" -not -name "*README*" -not -name "*template*" -not -name "*example*" -type f -exec md5sum {} \; > {{folders.benchmark}}/personas.md5
```

For instructions only:

```bash
find {{folders.instructions}} -name "*.md" -not -name "*README*" -not -name "*template*" -not -name "*example*" -type f -exec md5sum {} \; > {{folders.benchmark}}/instructions.md5
```

For incremental updates (compare against previous run):

```bash
diff <(find {{folders.personas}} {{folders.instructions}} -name "*.md" -not -name "*README*" -not -name "*template*" -not -name "*example*" -type f -exec md5sum {} \; | sort) {{folders.benchmark}}/all-files.md5 | grep '^>' | awk '{print $2}'
```

### Quality Metrics to Assess:

1. **Content Quality (0-100)**

   - Clarity and specificity of instructions
   - Technical accuracy and depth
   - Completeness of coverage
   - Practical applicability
   - Code examples quality (if applicable)

2. **Structure & Organization (0-100)**

   - Logical flow and hierarchy
   - Consistent formatting
   - Clear section breaks
   - Effective use of headers and lists
   - Navigation ease

3. **Actionability (0-100)**

   - Clear, executable steps
   - Specific implementation guidance
   - Concrete examples and use cases
   - Minimal ambiguity
   - Practical workflow integration

4. **Completeness (0-100)**

   - Covers essential concepts
   - Addresses common edge cases
   - Includes error handling
   - Provides troubleshooting guidance
   - References relevant resources

5. **Relevance & Currency (0-100)**
   - Up-to-date with current practices
   - Industry standard alignment
   - Framework/technology version accuracy
   - Best practices adherence
   - Future-proof considerations

### Performance Metrics to Track:

- **Response Time**: Measure processing speed when using the instruction/persona
- **Token Usage**: Count input/output tokens for efficiency assessment
- **Context Window Utilization**: Effectiveness of content density

### Assessment Process:

For each file you evaluate:

1. **Read and analyze** the entire content
2. **Score each quality metric** (0-100) with detailed justification
3. **Generate a prompt** by creating a simulated scenario prompt tailored to specific instruction or persona
   - Capture the generated prompt to the ouput file
4. **Clear Memory** Clear the context memory to ensure no residual information affects the test
5. **Test the prompt without any context (Baseline)** to evaluate its standalone effectiveness
6. **Measure (Baseline) performance** characteristics
7. **Calculate (Baseline) composite score** using weighted average:

- Content Quality: 30%
- Structure & Organization: 20%
- Actionability: 25%
- Completeness: 15%
- Relevance & Currency: 10%

8. **Clear Memory** Clear the context memory to ensure no residual information affects the test
9. **Test the prompt with context** to evaluate its effectiveness
10. **Measure (Context) performance** characteristics
11. **Calculate (Context) composite score** using weighted average:

- Content Quality: 30%
- Structure & Organization: 20%
- Actionability: 25%
- Completeness: 15%
- Relevance & Currency: 10%

12. **Clear Memory** Clear the context memory to ensure no residual information affects the test

### Output Format:

For each file, provide:

```markdown
## File: [filename]

**Path**: [full file path]
**Category**: [instruction/persona type]
**Prompt**: [captured prompt]

### Baseline

#### Quality Scores:

- Content Quality: X/100 - [brief justification]
- Structure & Organization: X/100 - [brief justification]
- Actionability: X/100 - [brief justification]
- Completeness: X/100 - [brief justification]
- Relevance & Currency: X/100 - [brief justification]

#### Performance Metrics:

- Response Time: Xms
- Token Usage: X tokens
- Context Efficiency: X/100

### Context Enhancement

#### Quality Scores:

- Content Quality: X/100 - [brief justification]
- Structure & Organization: X/100 - [brief justification]
- Actionability: X/100 - [brief justification]
- Completeness: X/100 - [brief justification]
- Relevance & Currency: X/100 - [brief justification]

#### Performance Metrics:

- Estimated Response Time: Xms
- Estimated Token Usage: X tokens
- Context Efficiency: X/100

#### Composite Score: X/100

#### Key Strengths:

- [2-3 specific strengths]

#### Areas for Improvement:

- [2-3 specific improvement suggestions]

### [filename] Summary Report:

- **Recommended Priority:** [High/Medium/Low] for updates
- **Response Time Comparison Ratio:** X:X
- **Token Usage Comparison Ratio:** X:X
- **Context Efficiency Comparison Ratio:** X:X
- **Content Quality Comparison Ratio:** X:X - [brief justification]
- **Structure & Organization Comparison Ratio:** X:X - [brief justification]
- **Actionability Comparison Ratio:** X:X - [brief justification]
- **Completeness Comparison Ratio:** X:X - [brief justification]
- **Relevance & Currency Comparison Ratio:** X:X - [brief justification]

---
```

After evaluating all files, provide a comprehensive summary:

```markdown
# Benchmark Summary Report

## Overall Statistics:

- Total Files Evaluated: X
- Average Composite Score: X/100
- Highest Scoring File: [filename] (X/100)
- Lowest Scoring File: [filename] (X/100)

## Category Breakdown:

### Instructions:

- Count: X files
- Average Score: X/100
- Top Performers: [list top 3]

### Personas:

- Count: X files
- Average Score: X/100
- Top Performers: [list top 3]

## Priority Recommendations:

### High Priority Updates (Score < 60):

[List files needing immediate attention]

### Medium Priority Updates (Score 60-79):

[List files needing moderate improvement]

### Excellence Candidates (Score 90+):

[List files that could serve as templates]

## Performance Insights:

- Most Efficient Files: [by token usage]
- Fastest Processing: [by response time]
- Best Context Utilization: [by density score]

## Common Issues Identified:

[List recurring problems across files]

## Best Practices Observed:

[List effective patterns to replicate]
```

## Performance Comparison Testing

### Test Protocol for Copilot Performance Analysis

1. **Memory Clearing**: Clear Copilot context before each test phase
2. **Baseline Test**: Execute test prompt without any instructions loaded in Copilot
3. **Memory Clearing**: Clear Copilot context between test phases
4. **Enhanced Test**: Execute same test prompt with specific instruction/persona loaded in Copilot
5. **Memory Clearing**: Clear Copilot context after testing
6. **Analysis**: Compare performance metrics and generate impact report

### Metrics for Copilot Performance

- **Response Quality**: Accuracy and helpfulness of Copilot responses
- **Code Generation Speed**: Time taken for Copilot to generate suggestions
- **Token Efficiency**: Input/output token consumption in Copilot
- **Context Relevance**: How well Copilot maintains context with instructions
- **Suggestion Accuracy**: Correctness of Copilot's code completions and suggestions

### Copilot-Specific Output Format

```markdown
# Copilot Performance Benchmark Report

## Test Summary

- **Test Date**: YYYY-MM-DD HH:MM:SS
- **Files Evaluated**: X
- **Copilot Version**: [version]
- **Average Quality Improvement**: X%
- **Average Response Time**: X seconds

## Individual File Results

### [filename.md]

- **File Type**: instruction/persona
- **Baseline Copilot Performance**: X seconds, X suggestions
- **Enhanced Copilot Performance**: X seconds, X suggestions
- **Quality Scores**: Content(X), Structure(X), Actionability(X), Completeness(X), Relevance(X)
- **Composite Score**: X/100
- **Copilot Impact**: +X% accuracy, +X% speed
- **Suggestion Quality**: X/100
- **Context Retention**: X/100
```

## Instructions for Use:

### Command Examples:

1. **Benchmark a specific file:**

   ```
   Target: "clean-code-advocate.md"
   Result: Benchmarks only the clean-code-advocate.md file (searches both personas and instructions)
   ```

2. **Benchmark all personas:**

   ```
   Target: "personas"
   Result: Benchmarks all .md files in {{folders.personas}} recursively
   ```

3. **Benchmark all instructions:**

   ```
   Target: "instructions"
   Result: Benchmarks all .md files in {{folders.instructions}} recursively
   ```

4. **Comprehensive benchmark:**
   ```
   Target: "" (empty) or no target provided
   Result: Benchmarks all .md files in both personas and instructions directories
   ```

### Execution Guidelines:

1. Run this benchmark based on the specified target scope
2. Use consistent evaluation criteria across all files in scope
3. Focus on practical usability with Copilot integration
4. Test actual Copilot performance with and without instructions
5. Provide actionable feedback for improvements
6. Track improvements over time by re-running benchmarks with MD5 comparison

### Progress Resumption:

If benchmarking is interrupted, use the MD5 comparison to identify which files still need processing:

- Check existing progress in `{{folders.benchmark}}/benchmark-progress.md`
- Compare current file MD5s against stored values
- Resume processing only files that have changed or are missing from progress

### Output Structure:

```
{{folders.benchmark}}/
├── benchmark-summary.md          # High-level summary of all processed files
├── benchmark-progress.md         # Progress tracking with MD5 hashes
├── personas.md5                  # MD5 checksums for persona files
├── instructions.md5              # MD5 checksums for instruction files
├── all-files.md5                 # MD5 checksums for comprehensive runs
├── [filename1]-report.md         # Individual file reports
├── [filename2]-report.md
└── ...
```

Begin your assessment based on the provided target input and provide both individual file assessments and the comprehensive summary report optimized for Copilot performance analysis.
