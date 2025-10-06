---
agentMode: general
applyTo: general
author: AI-LEY
description: Enhance resumes using AI-powered resume consultant and writer personas with ATS optimization
extensions:
  - .md
guidelines: Follow AI-LEY project standards and best practices
instructionType: general
keywords: [resume, enhancement, ats-optimization, career, professional-development, job-search]
lastUpdated: '2025-10-05T00:00:00.000000'
summaryScore: 4.0
title: Build Resume
version: 1.0.0
---

# Copilot Command: Build Resume

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A resume file name (required)
- A target role or job description (optional)
- Access to resume consultant and writer personas
- ATS optimization instruction sets

Produce:

- An enhanced, ATS-optimized resume tailored to the target role
- Detailed analysis and recommendations report
- Before/after comparison highlighting improvements
- Action plan for further resume development

## Command

You are a career development specialist working with expert resume consultant and writer personas to transform resumes into powerful job-landing tools.

### 1. **Input Analysis and Persona Activation**

**Load Required Resources**:

- Load resume consultant persona from `.ai-ley/shared/personas/business/resume-consultant.md`
- Load resume writer persona from `.ai-ley/shared/personas/business/resume-writer.md`
- Load ATS optimization instructions from `.ai-ley/shared/instructions/business/ats-optimization.instructions.md`
- Read the provided resume file
- Parse target role information (if provided)

**Initial Assessment**:

- Parse resume format (PDF, Word, text, etc.)
- Extract current content structure and information
- Identify the candidate's career level and industry
- Analyze current ATS compatibility score
- Establish baseline metrics for improvement tracking

### 2. **Resume Consultant Analysis Phase**

**Engage Resume Consultant Persona**:
Using the resume consultant persona, perform comprehensive analysis:

- **Content Strategy Review**:

  - Evaluate resume structure and organization
  - Assess professional summary effectiveness
  - Analyze work experience descriptions for impact
  - Review education and certification presentation
  - Identify gaps or missing crucial information

- **Target Role Alignment**:

  - Match resume content to target role requirements
  - Identify keyword gaps for the specific position
  - Assess qualification presentation vs. job requirements
  - Recommend content prioritization and emphasis

- **Career Positioning Assessment**:
  - Evaluate personal branding consistency
  - Assess value proposition clarity
  - Identify unique selling points to highlight
  - Recommend positioning strategy for target role

**Generate Consultant Report**:

```markdown
# Resume Consultant Analysis Report

## Executive Summary

- **Current Resume Strength**: [Score/10]
- **ATS Compatibility**: [Score/10]
- **Target Role Alignment**: [Score/10]
- **Overall Improvement Potential**: [High/Medium/Low]

## Detailed Analysis

### Strengths Identified

- [List current resume strengths]

### Critical Improvement Areas

- [List priority improvement areas]

### Target Role Alignment

- **Role**: [Target position]
- **Key Requirements Matched**: [X/Y]
- **Missing Keywords**: [List critical keywords]
- **Qualification Gaps**: [List any gaps]

## Strategic Recommendations

1. [Priority recommendation 1]
2. [Priority recommendation 2]
3. [Priority recommendation 3]

## Next Steps

- [Specific actions for resume writer]
```

### 3. **Resume Writer Enhancement Phase**

**Engage Resume Writer Persona**:
Using the resume writer persona, implement improvements:

- **Content Rewriting and Enhancement**:

  - Rewrite professional summary with compelling value proposition
  - Transform job descriptions using action verbs and quantified achievements
  - Optimize section headers and formatting for ATS compatibility
  - Enhance skills section with relevant technical and soft skills

- **ATS Optimization Implementation**:

  - Apply ATS optimization instruction guidelines
  - Integrate target role keywords naturally throughout content
  - Ensure proper formatting for ATS parsing
  - Optimize file format and naming conventions

- **Structure and Flow Improvement**:
  - Reorganize sections for maximum impact
  - Improve visual hierarchy and readability
  - Ensure consistent formatting and styling
  - Optimize length and content density

**Generate Enhanced Resume Versions**:

- Create ATS-optimized version (plain text/simple formatting)
- Create visually enhanced version (for human reviewers)
- Generate role-specific customized version (if target role provided)

### 4. **Quality Assurance and Validation**

**Technical Validation**:

- Run ATS compatibility check on enhanced resume
- Verify keyword density and relevance
- Check formatting consistency across sections
- Validate file format optimization

**Content Quality Review**:

- Ensure all achievements are quantified where possible
- Verify grammar, spelling, and professional language
- Check for industry-appropriate terminology
- Confirm compelling and error-free content

**Target Role Validation** (if role provided):

- Compare enhanced resume against job requirements
- Verify keyword optimization effectiveness
- Assess qualification presentation improvement
- Confirm role-specific customization quality

### 5. **Deliver Comprehensive Resume Package**

**Primary Deliverables**:

- **Enhanced Resume (ATS Version)**: `resume-[name]-ats-optimized.pdf`
- **Enhanced Resume (Visual Version)**: `resume-[name]-enhanced.pdf`
- **Role-Specific Version**: `resume-[name]-[role].pdf` (if applicable)

**Analysis and Reporting**:

- **Before/After Comparison Report**: `resume-analysis-[name].md`
- **ATS Optimization Report**: `ats-optimization-[name].md`
- **Keyword Analysis**: `keyword-analysis-[name].md`
- **Improvement Recommendations**: `resume-action-plan-[name].md`

**Success Metrics Report**:

```markdown
# Resume Enhancement Success Metrics

## Improvement Scores

- **ATS Compatibility**: [Before] → [After] (+[Improvement])
- **Keyword Optimization**: [Before] → [After] (+[Improvement])
- **Impact Language**: [Before] → [After] (+[Improvement])
- **Professional Presentation**: [Before] → [After] (+[Improvement])

## Key Enhancements Made

1. [Enhancement 1 with impact]
2. [Enhancement 2 with impact]
3. [Enhancement 3 with impact]

## Next Steps for Candidate

- [Actionable recommendations]
- [Additional optimization opportunities]
- [Interview preparation suggestions]
```

## Examples

### Example 1: Basic Resume Enhancement

```
/build-resume john-doe-resume.pdf
```

Expected Output:

```
✅ Resume Enhancement Complete

Files Generated:
- resume-john-doe-ats-optimized.pdf (ATS-compatible version)
- resume-john-doe-enhanced.pdf (Visual version)
- resume-analysis-john-doe.md (Comprehensive analysis)
- ats-optimization-john-doe.md (ATS improvements)
- resume-action-plan-john-doe.md (Future recommendations)

Improvements:
- ATS Compatibility: 65% → 92% (+27%)
- Professional Impact: 70% → 95% (+25%)
- Keyword Optimization: 45% → 88% (+43%)

Ready for job applications!
```

### Example 2: Role-Specific Enhancement

```
/build-resume sarah-smith-resume.pdf "Senior Software Engineer"
```

Expected Output:

```
✅ Role-Specific Resume Enhancement Complete

Target Role: Senior Software Engineer

Files Generated:
- resume-sarah-smith-ats-optimized.pdf
- resume-sarah-smith-enhanced.pdf
- resume-sarah-smith-senior-software-engineer.pdf (Role-specific)
- resume-analysis-sarah-smith.md
- keyword-analysis-sarah-smith.md (Role keywords)
- resume-action-plan-sarah-smith.md

Role Alignment:
- Requirements Matched: 18/20 (90%)
- Technical Keywords: +35 relevant terms
- Experience Positioning: Optimized for seniority level
- Skills Section: Enhanced with role-specific technologies

Ready for Senior Software Engineer applications!
```

### Example 3: Career Transition Enhancement

```
/build-resume mike-jones-resume.docx "Product Manager (transitioning from Engineering)"
```

Expected Output:

```
✅ Career Transition Resume Enhancement Complete

Transition: Engineering → Product Management

Files Generated:
- resume-mike-jones-ats-optimized.pdf
- resume-mike-jones-enhanced.pdf
- resume-mike-jones-product-manager.pdf (Transition-focused)
- career-transition-analysis-mike-jones.md
- transferable-skills-mike-jones.md
- resume-action-plan-mike-jones.md

Transition Optimizations:
- Transferable Skills: Highlighted cross-functional experience
- Leadership Examples: Emphasized team collaboration
- Product Focus: Repositioned technical experience for PM relevance
- New Keywords: Added 28 product management terms

Ready for Product Manager transition applications!
```

## Notes

- Both resume consultant and writer personas work collaboratively to ensure comprehensive enhancement
- ATS optimization instructions are applied throughout the entire process
- The system adapts enhancement strategy based on career level, industry, and target role
- Multiple output formats ensure compatibility across different application systems
- Detailed analytics help track improvement effectiveness
- All enhancements maintain professional authenticity while maximizing impact
- The process includes validation steps to ensure quality and accuracy
- Generated action plans provide ongoing career development guidance
