---
name: 'SEO Report Analysis Instructions'
description: 'Comprehensive SEO analysis and audit instruction set for AI agents to'
keywords: [audit, assessment, availability, (`crawl, access, (`analyze, analyzer, architecture, analysis, cli]
---


# SEO Analysis & Audit Instructions

## 1. Overview & Purpose

Comprehensive instruction set for AI agents to perform detailed SEO analysis and generate actionable audit reports. This system evaluates technical SEO, content optimization, user experience, and authority signals to provide prioritized recommendations for improved search engine visibility and organic traffic growth.

### Persona Reference

This instruction set should be used in conjunction with the **SEO Expert persona** (`.ai-ley/shared/personas/marketing/seo-expert.md`) to ensure analysis follows industry best practices, Google Webmaster Guidelines, and current search engine ranking factors. The SEO Expert persona provides:

- Deep technical SEO expertise including Core Web Vitals and site architecture
- E-A-T (Expertise, Authoritativeness, Trustworthiness) optimization knowledge
- Comprehensive toolset familiarity (SEMrush, Ahrefs, Screaming Frog, etc.)
- White-hat SEO strategies and ethical link building approaches
- User experience prioritization balanced with search optimization
- Current algorithm update awareness and adaptation strategies

**Integration Approach**: AI agents should adopt the SEO Expert persona's behavioral directives when generating reports, ensuring recommendations are data-driven, prioritized by impact vs. effort, and compliant with search engine guidelines.

### Strategic SEO Enhancement with SEO Savant Persona

For advanced strategic analysis and ecosystem-level optimization recommendations, this instruction set can also leverage the **SEO Savant persona** (`.ai-ley/shared/personas/marketing/seo-savant.md`)—an elite strategist specializing in systemic SEO thinking and sustained organic dominance. The SEO Savant persona provides:

- **Intent-Driven Optimization**: Focus on satisfying underlying user intent rather than keyword targeting
- **Topic Cluster Architecture**: Encyclopedia-like content ecosystems with pillar-cluster relationships
- **Internal Linking Mastery**: Strategic authority redistribution through internal link architecture
- **Content Refreshing Systems**: Prioritized content updates over constant new publishing
- **SERP Feature Domination**: Multi-element ownership (snippets, PAA, knowledge panels)
- **Behavioral Signal Engineering**: Engagement optimization (dwell time, pogo-sticking reduction)
- **Search Console Mining**: Hidden opportunity identification from query data
- **Brand Signal Amplification**: Trust and authority building through brand search demand
- **Trust Acceleration**: Strategies to bypass "sandbox" limitations for new sites

**Strategic Integration**: Use the SEO Savant persona for reports requiring systemic strategic recommendations, topic cluster planning, internal linking architecture design, content velocity planning, trust acceleration strategies, and hard-won insights that produce compounding returns rather than tactical quick fixes. This persona is ideal for growth-stage companies seeking 10x organic improvements and teams frustrated with conventional SEO approaches.

**Complementary Usage**: The SEO Expert persona handles tactical execution and technical implementation details, while the SEO Savant persona provides strategic direction and ecosystem-level architecture. Together, they deliver comprehensive analysis from both tactical and strategic perspectives.

### Core Objectives

- Conduct thorough technical SEO assessments
- Analyze on-page content optimization opportunities
- Evaluate Core Web Vitals and performance metrics
- Assess authority signals and off-page SEO factors
- Generate actionable recommendations with implementation timelines
- Provide competitive benchmarking when applicable
- Deliver executive-ready reports with prioritized action plans

## 2. Input Parameters & Configuration

### Required Inputs

| Parameter           | Type    | Required | Description                                        | Validation             |
| ------------------- | ------- | -------- | -------------------------------------------------- | ---------------------- |
| website_url         | string  | ✅       | Target website URL for analysis                    | Valid HTTP/HTTPS URL   |
| focus_keywords      | array   | ❌       | Primary keywords for optimization analysis         | 1-20 keywords max      |
| competitor_urls     | array   | ❌       | Competitor websites for comparative analysis       | Max 5 URLs             |
| analysis_depth      | enum    | ❌       | `standard` \| `comprehensive` \| `technical-focus` | Default: comprehensive |
| output_format       | enum    | ❌       | `html` \| `markdown` \| `json` \| `csv` \| `all`   | Default: html          |
| include_screenshots | boolean | ❌       | Include visual evidence in reports                 | Default: false         |

### Optional Configuration

See [example-1](./examples/seo-report/example-1.json)

## 3. SEO Tool Detection & Web Access Methods

### Tool Detection & Availability Assessment

**CRITICAL**: Before initiating SEO analysis, AI agents MUST detect available SEO tools and web access methods to optimize data collection strategies and ensure comprehensive analysis.

#### Available SEO Tools Detection

See [example-2](./examples/seo-report/example-2.python)

### Web Access Strategy

**Priority Order for Web Access:**

1. **Direct Web Fetch (If Agent Has Web Access)**

   
2. **Command-Line Tools (curl/wget)**

   
3. **External SEO Tools**
   
#### Web Access via CLI Tools

See [example-3](./examples/seo-report/example-3.bash)

See [example-4](./examples/seo-report/example-4.bash)

#### Tool Execution Framework

See [example-5](./examples/seo-report/example-5.python)

### Tool Detection Best Practices

1. **Always Detect Before Execution**

   
2. **Graceful Degradation**

   
3. **Tool Capability Mapping**

   
4. **Error Handling**
   
---

## 4. Website Crawling & Per-Page Analysis

**Phase 6 Enhancement (v3.5.0)**: Complete website crawling and per-page SEO analysis framework for comprehensive site-wide audits.

#
### 4.1 Website Crawler (`crawl_site.py`)

#### Purpose

Politely crawl target websites to extract comprehensive page data including content, metadata, links, images, and schema markup. All data is cached locally for subsequent analysis.

#### Key Features

- **Robots.txt Compliance**: Automatically loads and respects robots.txt directives
- **Configurable Depth & Limits**: Control max pages and crawl depth
- **Rate Limiting**: Built-in delays between requests for ethical crawling
- **Content Extraction**: Comprehensive HTML parsing for all SEO-relevant elements
- **Link Discovery**: Follows internal links while respecting domain boundaries
- **Metadata Collection**: Response times, status codes, content types
- **Cache Management**: Organized JSON storage for efficient retrieval

#### Installation & Requirements

See [example-6](./examples/seo-report/example-6.bash)

#### Usage Examples

**Basic Crawl (Default Settings)**

See [example-7](./examples/seo-report/example-7.bash)

**Custom Configuration**

See [example-8](./examples/seo-report/example-8.bash)

#### Crawl Configuration Options

| Parameter      | Type    | Default  | Description                      |
| -------------- | ------- | -------- | -------------------------------- |
| `url`          | string  | Required | Target website URL to crawl      |
| `--max-pages`  | integer | 100      | Maximum number of pages to crawl |
| `--max-depth`  | integer | 3        | Maximum link depth from homepage |
| `--delay`      | float   | 1.0      | Delay between requests (seconds) |
| `--output-dir` | string  | Auto     | Output directory for cached data |

#### Output Structure

See [example-9](./examples/seo-report/example-9.txt)

#### Page Data Schema

Each cached page file contains:

See [example-10](./examples/seo-report/example-10.json)

#### Crawl Summary Schema

See [example-11](./examples/seo-report/example-11.json)

### 4.2 Per-Page Analyzer (`analyze_pages.py`)

#### Purpose

Analyze cached page data to generate detailed per-page SEO assessments with specific, actionable recommendations. Scores each page across 7 categories and prioritizes fixes.

#### Key Features

- **Multi-Category Scoring**: Title, meta description, headings, content, links, images, schema
- **Issue Detection**: Identifies specific problems on each page
- **Priority Assignment**: CRITICAL, HIGH, MEDIUM, LOW based on overall score
- **Detailed Recommendations**: Actionable fixes for every identified issue
- **Export Formats**: CSV for spreadsheets, JSON for automation
- **Site-Wide Insights**: Common issues and patterns across all pages

#### Usage Examples

**Basic Analysis (CSV Output)**

See [example-12](./examples/seo-report/example-12.bash)

**JSON Output**

See [example-13](./examples/seo-report/example-13.bash)

**Both Formats**

See [example-14](./examples/seo-report/example-14.bash)

**Custom Output Path**

See [example-15](./examples/seo-report/example-15.bash)

#### Analysis Options

| Parameter   | Type   | Default  | Description                       |
| ----------- | ------ | -------- | --------------------------------- |
| `cache_dir` | string | Required | Directory with cached page data   |
| `--format`  | enum   | csv      | Output format: csv, json, or both |
| `--output`  | string | Auto     | Custom output file path           |

#### Scoring System

**Seven Analysis Categories (0-100 scale each):**

1. **Title Tag Score** (Weight: 20%)

    
2. **Meta Description Score** (Weight: 15%)

    
3. **Headings Score** (Weight: 15%)

    
4. **Content Score** (Weight: 25%)

    
5. **Links Score** (Weight: 15%)

    
6. **Images Score** (Weight: 5%)

   
7. **Schema Score** (Weight: 5%)
   
**Overall Score Calculation:**

See [example-16](./examples/seo-report/example-16.txt)

**Priority Assignment:**

*Content optimized for conciseness. See external references for additional details.*

---
version: 3.5.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.5.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
