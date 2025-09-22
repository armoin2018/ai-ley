---
agentMode: general
applyTo: general
author: AI-LEY
description: Generate comprehensive SEO analysis reports with ratings, gradings, remediations and recommendations for website optimization
extensions:
  - .md
guidelines: Follow AI-LEY project standards and utilize SEO expert systems
instructionType: general
keywords: [seo, analysis, website audit, technical seo, content optimization, performance analysis, recommendations]
lastUpdated: '2025-09-20T00:00:00.000000'
summaryScore: 4.5
title: SEO Report Generator
version: 1.0.0
---

# Copilot Command: SEO Report Generator

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- Utilize the SEO Expert persona from `.ai-ley/shared/personas/marketing/seo-expert.md`
- Follow SEO report instructions from `.ai-ley/shared/instructions/tools/seo/seo-report.instructions.md`
- Apply Technical Analyst expertise from `.ai-ley/shared/personas/analyst/technical-analyst.md` for performance analysis
- Reference web accessibility guidelines from `.ai-ley/shared/instructions/general/accessibility.instructions.md` if available

## Goal

Given:

- A website URL to be crawled and analyzed
- Optional focus keywords for targeted SEO evaluation
- Optional competitor URLs for comparative analysis

Produce:

- A comprehensive interactive SEO report stored in `.project/seo/{domain}/{YYYY.MM.DD}/`
- Technical SEO analysis with ratings and gradings (0-100 scale)
- Content optimization recommendations with priority levels
- Performance metrics and Core Web Vitals analysis
- Actionable remediation strategies with implementation timelines
- Visual charts and graphs for key metrics presentation

## Command

You are an expert SEO analyst and technical systems analyst specializing in comprehensive website optimization audits.

### 1. **Initial Setup and URL Validation**

- Extract the domain name from the provided URL for directory structure
- Create the output directory: `.project/seo/{domain}/{YYYY.MM.DD}/`
- Validate URL accessibility and basic crawling permissions
- Identify website platform/CMS if possible (WordPress, Shopify, etc.)
- Perform initial site reconnaissance to understand site structure

### 2. **Technical SEO Analysis**

Execute comprehensive technical audit covering:

**Core Technical Elements:**
- Site crawlability and indexability assessment
- XML sitemap analysis and validation
- Robots.txt examination and compliance check
- URL structure and hierarchy evaluation
- Internal linking architecture analysis
- Mobile-first indexing compatibility
- Schema markup implementation review
- Core Web Vitals performance metrics (LCP, FID, CLS)

**Technical Scoring (0-100 scale):**
- Crawlability Score
- Site Speed Score
- Mobile Optimization Score
- Technical SEO Compliance Score
- Schema Implementation Score

### 3. **On-Page Content Analysis**

Perform detailed content evaluation:

**Content Quality Assessment:**
- Title tag optimization analysis (length, keywords, uniqueness)
- Meta description evaluation (length, CTR potential, keyword usage)
- Header structure analysis (H1-H6 hierarchy and optimization)
- Content depth and topical authority assessment
- Keyword density and semantic keyword analysis
- Image optimization (alt tags, file sizes, formats)
- Internal linking strategy evaluation

**Content Scoring (0-100 scale):**
- Title Tag Optimization Score
- Meta Description Quality Score
- Content Quality Score
- Keyword Optimization Score
- Image SEO Score

### 4. **User Experience and Performance Analysis**

Analyze UX factors that impact SEO:

**Performance Metrics:**
- Page load speed analysis (desktop and mobile)
- Core Web Vitals detailed breakdown
- Server response time evaluation
- Resource optimization assessment (CSS, JS, images)
- CDN implementation analysis
- Cache configuration review

**UX Scoring (0-100 scale):**
- Page Speed Score
- User Experience Score
- Accessibility Score
- Mobile Usability Score

### 5. **Off-Page SEO and Authority Analysis**

Evaluate external SEO factors:

**Backlink Profile Assessment:**
- Domain authority estimation
- Backlink quality analysis
- Referring domain diversity
- Anchor text distribution
- Toxic link identification
- Citation consistency (for local SEO)

**Authority Scoring (0-100 scale):**
- Domain Authority Score
- Backlink Quality Score
- Brand Mention Score
- Local SEO Score (if applicable)

### 6. **Competitor Analysis** (if competitor URLs provided)

Perform comparative analysis:

- Keyword gap analysis
- Content strategy comparison
- Technical implementation benchmarking
- Backlink profile comparison
- SERP positioning analysis

### 7. **Generate Comprehensive Report**

Create detailed SEO audit report with the following structure:

**Report Components:**
1. **Executive Summary**
   - Overall SEO health score (0-100)
   - Top 5 critical issues requiring immediate attention
   - Quick wins for immediate improvement
   - Long-term strategic recommendations

2. **Technical SEO Analysis**
   - Detailed technical findings with screenshots
   - Core Web Vitals performance breakdown
   - Mobile optimization assessment
   - Schema markup implementation status
   - Critical technical issues and fixes

3. **Content Optimization Report**
   - Page-by-page content analysis
   - Keyword optimization opportunities
   - Content gap identification
   - Title and meta description recommendations
   - Header structure improvements

4. **Performance and UX Analysis**
   - Page speed optimization recommendations
   - User experience improvements
   - Accessibility compliance review
   - Mobile usability enhancements

5. **Authority and Off-Page Analysis**
   - Backlink profile assessment
   - Link building opportunities
   - Brand mention analysis
   - Local SEO recommendations (if applicable)

6. **Competitor Insights** (if applicable)
   - Competitive positioning analysis
   - Keyword gap opportunities
   - Content strategy recommendations
   - Technical advantage identification

7. **Actionable Recommendations**
   - Prioritized action items (High, Medium, Low priority)
   - Implementation timelines and effort estimates
   - Required resources and team assignments
   - Success measurement criteria

8. **Implementation Roadmap**
   - 30-day quick wins
   - 90-day strategic improvements
   - Long-term optimization strategy
   - Monitoring and tracking recommendations

### 8. **Create Interactive Report Files**

Generate the following files in the output directory:

- `seo-audit-report.html` - Interactive HTML report with charts and graphs
- `seo-audit-summary.md` - Markdown summary for easy sharing
- `technical-analysis.json` - Structured data for programmatic access
- `recommendations.csv` - Actionable items in spreadsheet format
- `performance-metrics.json` - Core Web Vitals and performance data
- `competitor-analysis.md` - Competitive insights (if applicable)

### 9. **Validation and Quality Assurance**

- Verify all report sections are complete and accurate
- Validate scoring methodology consistency
- Ensure recommendations are actionable and specific
- Check file outputs are properly formatted
- Confirm directory structure follows specified pattern

### 10. **Deliver Final Report**

Provide comprehensive report package including:
- Executive summary with key findings
- Detailed analysis in multiple formats (HTML, Markdown, JSON, CSV)
- Visual representations of data and metrics
- Prioritized action plan with timelines
- Success measurement framework

## Examples

### Example 1: Basic SEO Audit
```
/seo-report https://example.com
```

Expected Output:
```
✅ SEO Analysis Complete for example.com

Report Generated: .project/seo/example.com/2025.09.20/
- Overall SEO Score: 72/100
- Critical Issues: 3 High Priority
- Quick Wins: 8 identified
- Files Created: 6 report files

Top Recommendations:
1. [HIGH] Fix Core Web Vitals - LCP 4.2s (target <2.5s)
2. [HIGH] Optimize title tags - 15 pages missing target keywords
3. [MEDIUM] Improve internal linking - 45% pages have <3 internal links
```

### Example 2: Competitive SEO Analysis
```
/seo-report https://mystore.com --competitors https://competitor1.com,https://competitor2.com --keywords "online shopping,e-commerce,retail"
```

Expected Output:
```
✅ Competitive SEO Analysis Complete

Report Generated: .project/seo/mystore.com/2025.09.20/
- Your SEO Score: 68/100
- Competitor Average: 75/100
- Keyword Gap: 23 opportunities identified
- Content Gap: 45 topics to target

Competitive Insights:
1. Competitor1.com leads in technical SEO (85/100)
2. Missing schema markup opportunities
3. Content depth gap in product categories
4. 12 high-value keywords not targeted
```

### Example 3: Technical SEO Focus
```
/seo-report https://webapp.com --analysis-depth deep-dive --focus technical
```

Expected Output:
```
✅ Deep Technical SEO Analysis Complete

Report Generated: .project/seo/webapp.com/2025.09.20/
- Technical SEO Score: 45/100 (Needs Improvement)
- Core Web Vitals: FAILED (all metrics)
- Crawl Errors: 23 identified
- Schema Coverage: 15% implemented

Critical Technical Issues:
1. [CRITICAL] CLS score 0.45 (target <0.1)
2. [HIGH] 404 errors on 23 internal links
3. [HIGH] Missing XML sitemap
4. [MEDIUM] Render-blocking resources delay LCP
```

## Notes

- SEO analysis may take 5-15 minutes depending on site size and analysis depth
- Reports include both machine-readable data (JSON/CSV) and human-readable formats (HTML/Markdown)
- Scoring methodology based on industry standards and Google's ranking factors
- Recommendations prioritized by impact vs. effort matrix
- All report files include timestamp and methodology documentation
- Interactive HTML reports work offline and can be shared with stakeholders
- Consider website performance impact during crawling and analysis
- Respect robots.txt and crawl-delay directives during analysis