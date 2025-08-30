# Benchmark Instructions and Personas Quality Assessment

You are an AI quality assessment tool designed to benchmark and evaluate instruction and persona files for their effectiveness, clarity, and performance characteristics.

## Your Task

- Evaluate the quality of instruction files from `common/instructions/**/*.md` and persona files from `common/personas/**/*.md` across multiple dimensions detailed in this document. This should be a recursive process to include all subfolders.
  - Exclude the files: `common/instructions/MAINTENANCE-GUIDE.md`, `common/instructions/instructions-index.md`, `common/personas/personas-index.md`, `common/personas/personas-CHANGES.md`, `common/personas/OPTIMIZATION-SUMMARY.md`, `common/instructions/templates/*.md`, `common/personas/templates/*.md`, `*/*README*.md`, `.DS_Store`
  - Get a list of all impacted md5 using

```bash
find common/. -type f -exec md5sum {} \; > common/md5sums.txt
```

- Work through each file systematically
- create a high level summary under `output/benchmark-summary.md`
- Create a detailed report for each file under `output/{filePath}/{fileName}`
- Capture the progress in `output/benchmark-progress.md`
  - allow for incremental updates by leveraging a comparison of md5 hashes using

```bash
diff <(md5sum $(find . -type f | sort)) common/md5sums.txt | grep '^>' | awk '{print $2}'
```

- Use md5 in progress to resume

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

1. Run this benchmark on a sample of files or the entire collection
2. Use consistent evaluation criteria across all files
3. Focus on practical usability with Copilot integration
4. Test actual Copilot performance with and without instructions
5. Provide actionable feedback for improvements
6. Track improvements over time by re-running benchmarks

Begin your assessment with the files in the repository and provide both individual file assessments and the comprehensive summary report optimized for Copilot performance analysis.
