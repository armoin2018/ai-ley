---
agentMode: general
applyTo: seo-analysis
author: AI-LEY
description: Comprehensive SEO analysis and audit instruction set for AI agents to perform detailed website optimization assessments with technical, content, and performance analysis including executive summaries, performance metrics, keyword analysis, technical health, backlink profiles, competitive landscape, local SEO, automated tool detection, CLI web access fallbacks, Google ranking scores, content rewording recommendations, lightweight Python development server for proper AJAX loading, markdown document viewer with syntax highlighting, and prioritized action plans
extensions:
  - .md
guidelines: Follow Google SEO best practices and current ranking factors
instructionType: tool-specific
keywords:
  [
    seo,
    audit,
    analysis,
    technical-seo,
    content-optimization,
    performance,
    meta-tags,
    schema-markup,
    link-building,
    executive-summary,
    kpi-metrics,
    action-plan,
    competitive-analysis,
    local-seo,
    tool-detection,
    cli-fallbacks,
    ranking-scores,
    content-rewording,
    python-server,
    markdown-viewer,
    ajax-loading,
  ]
lastUpdated: '2025-10-03T16:30:00.000000'
technicalQualityScore: 5.0
AIUsabilityScore: 5.0
title: SEO Report Analysis Instructions
version: 3.4.0
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

```json
{
  "crawl_limits": {
    "max_pages": 100,
    "max_depth": 3,
    "timeout_seconds": 30
  },
  "analysis_options": {
    "check_mobile_usability": true,
    "analyze_page_speed": true,
    "audit_accessibility": true,
    "check_schema_markup": true,
    "analyze_internal_linking": true
  },
  "reporting_preferences": {
    "include_technical_details": true,
    "priority_scoring": true,
    "implementation_timelines": true,
    "resource_requirements": true
  }
}
```

## 3. SEO Tool Detection & Web Access Methods

### Tool Detection & Availability Assessment

**CRITICAL**: Before initiating SEO analysis, AI agents MUST detect available SEO tools and web access methods to optimize data collection strategies and ensure comprehensive analysis.

#### Available SEO Tools Detection

```python
# SEO Tool Detection Framework
class SEOToolDetector:
    def __init__(self):
        self.available_tools = {}
        self.tool_registry = {
            'screaming_frog': {
                'command': 'screamingfrogseospider',
                'check_method': 'which',
                'capabilities': ['crawling', 'technical_audit', 'sitemap_generation']
            },
            'lighthouse': {
                'command': 'lighthouse',
                'check_method': 'npm list -g',
                'capabilities': ['performance', 'accessibility', 'seo_audit', 'core_web_vitals']
            },
            'pa11y': {
                'command': 'pa11y',
                'check_method': 'npm list -g',
                'capabilities': ['accessibility', 'wcag_compliance']
            },
            'semrush_api': {
                'command': 'semrush-api-key',
                'check_method': 'env',
                'capabilities': ['keyword_research', 'competitor_analysis', 'backlink_profile']
            },
            'ahrefs_api': {
                'command': 'ahrefs-api-key',
                'check_method': 'env',
                'capabilities': ['backlink_analysis', 'keyword_difficulty', 'domain_rating']
            },
            'curl': {
                'command': 'curl',
                'check_method': 'which',
                'capabilities': ['web_fetch', 'header_analysis', 'response_time']
            },
            'wget': {
                'command': 'wget',
                'check_method': 'which',
                'capabilities': ['web_fetch', 'recursive_download', 'mirror']
            },
            'google_pagespeed': {
                'command': 'pagespeed-api-key',
                'check_method': 'env',
                'capabilities': ['performance_metrics', 'core_web_vitals', 'optimization_suggestions']
            }
        }

    def detect_available_tools(self):
        """Detect all available SEO tools on the system"""
        for tool_name, tool_config in self.tool_registry.items():
            if self.is_tool_available(tool_name, tool_config):
                self.available_tools[tool_name] = tool_config
                print(f"✓ {tool_name} detected - Capabilities: {', '.join(tool_config['capabilities'])}")
            else:
                print(f"✗ {tool_name} not available")

        return self.available_tools

    def is_tool_available(self, tool_name, config):
        """Check if a specific tool is available"""
        check_method = config['check_method']
        command = config['command']

        if check_method == 'which':
            result = subprocess.run(['which', command], capture_output=True)
            return result.returncode == 0
        elif check_method == 'npm list -g':
            result = subprocess.run(['npm', 'list', '-g', command], capture_output=True)
            return command in result.stdout.decode()
        elif check_method == 'env':
            return os.getenv(command.upper().replace('-', '_')) is not None

        return False

    def get_optimal_tool_for_task(self, task_type):
        """Recommend optimal tool for specific SEO task"""
        tool_priorities = {
            'crawling': ['screaming_frog', 'curl', 'wget'],
            'performance': ['lighthouse', 'google_pagespeed'],
            'keyword_research': ['semrush_api', 'ahrefs_api'],
            'backlink_analysis': ['ahrefs_api', 'semrush_api'],
            'accessibility': ['pa11y', 'lighthouse'],
            'web_fetch': ['curl', 'wget']
        }

        for tool in tool_priorities.get(task_type, []):
            if tool in self.available_tools:
                return tool

        return None
```

### Web Access Strategy

**Priority Order for Web Access:**

1. **Direct Web Fetch (If Agent Has Web Access)**

   - Use built-in web fetch capabilities
   - Fastest and most reliable method
   - Supports JavaScript rendering if available

2. **Command-Line Tools (curl/wget)**

   - Fallback when direct access unavailable
   - Reliable for static HTML content
   - Can retrieve headers, status codes, response times

3. **External SEO Tools**
   - Lighthouse for performance/SEO audits
   - Screaming Frog for comprehensive crawling
   - API-based tools for keyword/backlink data

#### Web Access via CLI Tools

```bash
# Curl-based Web Access Framework

# 1. Basic Page Fetch
curl -L -s "https://example.com" -o page_content.html

# 2. Fetch with Headers
curl -L -s -I "https://example.com" -o headers.txt

# 3. Measure Response Time
curl -L -s -w "\nTime Total: %{time_total}s\nTime Connect: %{time_connect}s\nTime Start Transfer: %{time_starttransfer}s\n" -o /dev/null "https://example.com"

# 4. Check for Redirects
curl -L -s -w "\nFinal URL: %{url_effective}\nHTTP Code: %{http_code}\nRedirect Count: %{num_redirects}\n" -o /dev/null "https://example.com"

# 5. Fetch Multiple Pages (Sitemap URLs)
while IFS= read -r url; do
  curl -L -s "$url" -o "pages/$(echo $url | md5sum | cut -d' ' -f1).html"
done < urls.txt

# 6. Check SSL Certificate
curl -vI https://example.com 2>&1 | grep -E "SSL|certificate|expire"

# 7. Extract Meta Tags
curl -L -s "https://example.com" | grep -Eo '<meta[^>]+>' > meta_tags.txt

# 8. Check Robots.txt
curl -L -s "https://example.com/robots.txt" -o robots.txt

# 9. Fetch XML Sitemap
curl -L -s "https://example.com/sitemap.xml" -o sitemap.xml

# 10. Test Mobile User-Agent
curl -L -s -A "Mozilla/5.0 (iPhone; CPU iPhone OS 14_7 like Mac OS X)" "https://example.com" -o mobile_version.html
```

```bash
# Wget-based Web Access Framework

# 1. Mirror Website (Limited Pages)
wget --mirror --page-requisites --convert-links --adjust-extension \
     --no-parent --level=2 --limit-rate=200k --wait=1 \
     --directory-prefix=./site_mirror "https://example.com"

# 2. Fetch Specific Pages
wget --input-file=urls.txt --directory-prefix=./pages

# 3. Recursive Download with Limits
wget -r -l 2 -nd -P ./downloads "https://example.com"

# 4. Check for Broken Links
wget --spider --recursive --level=2 --no-directories "https://example.com" 2>&1 | grep "broken link"

# 5. Download Sitemap and Extract URLs
wget "https://example.com/sitemap.xml" -O - | grep -oP '(?<=<loc>)[^<]+'
```

#### Tool Execution Framework

```python
# Automated Tool Execution Based on Availability
class SEOAnalysisExecutor:
    def __init__(self, url, tool_detector):
        self.url = url
        self.detector = tool_detector
        self.results = {}

    def execute_seo_analysis(self):
        """Execute SEO analysis using available tools"""

        # 1. Detect available tools
        print("🔍 Detecting available SEO tools...")
        available_tools = self.detector.detect_available_tools()

        if not available_tools:
            print("⚠️ No specialized SEO tools detected. Using CLI fallbacks.")

        # 2. Performance Analysis
        perf_tool = self.detector.get_optimal_tool_for_task('performance')
        if perf_tool == 'lighthouse':
            self.results['performance'] = self.run_lighthouse()
        elif perf_tool == 'google_pagespeed':
            self.results['performance'] = self.fetch_pagespeed_insights()
        else:
            print("⚠️ No performance tools available. Manual assessment required.")

        # 3. Crawling/Content Fetch
        crawl_tool = self.detector.get_optimal_tool_for_task('web_fetch')
        if crawl_tool == 'curl':
            self.results['content'] = self.fetch_with_curl()
        elif crawl_tool == 'wget':
            self.results['content'] = self.fetch_with_wget()
        else:
            print("⚠️ No web fetch tools available. Cannot retrieve page content.")

        # 4. Backlink Analysis
        backlink_tool = self.detector.get_optimal_tool_for_task('backlink_analysis')
        if backlink_tool:
            self.results['backlinks'] = self.analyze_backlinks(backlink_tool)
        else:
            print("ℹ️ No backlink analysis tools available. Skipping backlink audit.")

        # 5. Keyword Research
        keyword_tool = self.detector.get_optimal_tool_for_task('keyword_research')
        if keyword_tool:
            self.results['keywords'] = self.research_keywords(keyword_tool)
        else:
            print("ℹ️ No keyword research tools available. Manual keyword analysis required.")

        return self.results

    def run_lighthouse(self):
        """Execute Lighthouse audit"""
        cmd = f"lighthouse {self.url} --output json --output-path ./lighthouse_report.json --chrome-flags='--headless'"
        subprocess.run(cmd, shell=True)
        with open('lighthouse_report.json', 'r') as f:
            return json.load(f)

    def fetch_with_curl(self):
        """Fetch page content using curl"""
        cmd = f"curl -L -s '{self.url}'"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        return result.stdout

    def fetch_with_wget(self):
        """Fetch page content using wget"""
        cmd = f"wget -qO- '{self.url}'"
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        return result.stdout
```

### Tool Detection Best Practices

1. **Always Detect Before Execution**

   - Run tool detection at the start of every SEO analysis
   - Log detected tools for transparency
   - Adapt analysis strategy based on available tools

2. **Graceful Degradation**

   - If premium tools (SEMrush, Ahrefs) unavailable, use free alternatives
   - If no tools available, provide manual analysis guidelines
   - Always attempt CLI fallbacks (curl/wget) before failing

3. **Tool Capability Mapping**

   - Match analysis requirements to tool capabilities
   - Use most appropriate tool for each task
   - Combine multiple tools for comprehensive analysis

4. **Error Handling**
   - Catch tool execution failures
   - Provide alternative methods
   - Log which tools succeeded/failed for user awareness

## 5. Meta Tags & Content Element Size Guidelines

### Title Tag Optimization

**Recommended Length: 50-60 characters (512px width)**

- **Optimal Range:** 50-60 characters
- **Maximum Before Truncation:** 70 characters (varies by device)
- **Mobile Consideration:** 55 characters for mobile display

```html
<!-- Optimal Title Examples -->
<title>Primary Keyword - Secondary Keyword | Brand Name</title>
<title>Best Educational Card Games for Kids | Base6 Games</title>

<!-- Length Validation -->
function validateTitleLength(title) { const length = title.length; if (length < 30) return
"too_short"; if (length <= 60) return "optimal"; if (length <= 70) return "acceptable"; return
"too_long"; }
```

### Meta Description Guidelines

**Recommended Length: 150-160 characters (920px width)**

- **Optimal Range:** 150-160 characters
- **Mobile Limit:** 130 characters for mobile SERPs
- **Maximum Display:** 320 characters (rare cases)

```html
<!-- Optimal Meta Description Examples -->
<meta
  name="description"
  content="Discover Base6, the innovative hexagonal card game that sparks creativity and strategic thinking. Perfect for ages 7+, families, and classrooms. Shop now!"
/>

<!-- Length Validation -->
function validateMetaDescription(description) { const length = description.length; if (length < 120)
return "too_short"; if (length <= 160) return "optimal"; if (length <= 180) return "acceptable";
return "too_long"; }
```

### Header Tag Structure & Sizing

**H1 Tag Guidelines:**

- **Length:** 20-70 characters optimal
- **Frequency:** One H1 per page
- **Keywords:** Include primary keyword naturally

**H2-H6 Guidelines:**

- **H2 Length:** 30-65 characters
- **H3-H6 Length:** 20-50 characters
- **Structure:** Logical hierarchy (H1 > H2 > H3...)

```html
<!-- Optimal Header Structure -->
<h1>Primary Keyword - Main Topic (45 chars)</h1>
<h2>Secondary Topic with Supporting Keyword (55 chars)</h2>
<h3>Specific Subtopic (25 chars)</h3>
```

### Image Alt Text Specifications

**Recommended Length: 80-125 characters**

- **Screen Reader Optimal:** 80-100 characters
- **SEO Value:** Include relevant keywords naturally
- **Accessibility:** Descriptive, not keyword-stuffed

```html
<!-- Optimal Alt Text Examples -->
<img
  src="base6-cards.jpg"
  alt="Base6 hexagonal cards showing colorful numbers and icons for creative educational gameplay"
/>
<img
  src="family-playing.jpg"
  alt="Children and parents playing Base6 card game around kitchen table during family game night"
/>
```

### Schema Markup Sizing Guidelines

**Organization Schema:**

- **Name:** 10-60 characters
- **Description:** 100-250 characters
- **Address:** Complete, properly formatted

**Product Schema:**

- **Name:** 10-80 characters
- **Description:** 150-300 characters
- **SKU/GTIN:** As required by standard

## 6. Technical SEO Analysis Framework

### Website Crawling & Data Extraction

```python
# Technical SEO Crawling Framework
class SEOCrawler:
    def __init__(self, url, max_pages=100):
        self.base_url = url
        self.max_pages = max_pages
        self.crawled_pages = []
        self.technical_issues = []

    def analyze_page_elements(self, page_url):
        """Extract and analyze key page elements"""
        elements = {
            'title': self.extract_title(page_url),
            'meta_description': self.extract_meta_description(page_url),
            'headers': self.extract_headers(page_url),
            'images': self.analyze_images(page_url),
            'links': self.analyze_links(page_url),
            'schema': self.detect_schema_markup(page_url)
        }

        # Validate element sizes
        issues = self.validate_element_sizes(elements)
        return elements, issues

    def validate_element_sizes(self, elements):
        """Validate meta elements against size guidelines"""
        issues = []

        # Title validation
        title_length = len(elements['title'])
        if title_length > 60:
            issues.append({
                'type': 'title_too_long',
                'current_length': title_length,
                'recommended_max': 60,
                'priority': 'high'
            })
        elif title_length < 30:
            issues.append({
                'type': 'title_too_short',
                'current_length': title_length,
                'recommended_min': 30,
                'priority': 'medium'
            })

        # Meta description validation
        if elements['meta_description']:
            desc_length = len(elements['meta_description'])
            if desc_length > 160:
                issues.append({
                    'type': 'meta_description_too_long',
                    'current_length': desc_length,
                    'recommended_max': 160,
                    'priority': 'high'
                })
        else:
            issues.append({
                'type': 'missing_meta_description',
                'priority': 'high',
                'impact': 'Reduced SERP click-through rates'
            })

        return issues
```

### Core Web Vitals Assessment

```python
# Performance Analysis Framework
class CoreWebVitalsAnalyzer:
    def __init__(self):
        self.thresholds = {
            'lcp': {'good': 2.5, 'needs_improvement': 4.0},
            'fid': {'good': 100, 'needs_improvement': 300},
            'cls': {'good': 0.1, 'needs_improvement': 0.25}
        }

    def analyze_performance(self, url):
        """Analyze Core Web Vitals and performance metrics"""
        metrics = {
            'largest_contentful_paint': self.measure_lcp(url),
            'first_input_delay': self.measure_fid(url),
            'cumulative_layout_shift': self.measure_cls(url),
            'first_contentful_paint': self.measure_fcp(url),
            'time_to_interactive': self.measure_tti(url)
        }

        # Score each metric
        scored_metrics = {}
        for metric, value in metrics.items():
            if metric in self.thresholds:
                scored_metrics[metric] = self.score_metric(metric, value)

        return scored_metrics

    def score_metric(self, metric, value):
        """Score individual Core Web Vital metrics"""
        thresholds = self.thresholds[metric]

        if value <= thresholds['good']:
            return {'score': 'good', 'value': value, 'rating': 90}
        elif value <= thresholds['needs_improvement']:
            return {'score': 'needs_improvement', 'value': value, 'rating': 50}
        else:
            return {'score': 'poor', 'value': value, 'rating': 10}
```

## 7. Content Analysis & Optimization

### On-Page Content Evaluation

```python
# Content Analysis Framework
class ContentAnalyzer:
    def __init__(self, focus_keywords=None):
        self.focus_keywords = focus_keywords or []
        self.content_metrics = {}

    def analyze_page_content(self, url, content):
        """Comprehensive content analysis"""
        analysis = {
            'word_count': self.count_words(content),
            'readability_score': self.calculate_readability(content),
            'keyword_density': self.analyze_keyword_density(content),
            'header_structure': self.analyze_headers(content),
            'internal_links': self.analyze_internal_links(content),
            'content_quality': self.assess_content_quality(content)
        }

        # Generate content recommendations
        recommendations = self.generate_content_recommendations(analysis)
        return analysis, recommendations

    def analyze_keyword_density(self, content):
        """Analyze keyword usage and density"""
        keyword_analysis = {}

        for keyword in self.focus_keywords:
            occurrences = content.lower().count(keyword.lower())
            total_words = len(content.split())
            density = (occurrences / total_words) * 100 if total_words > 0 else 0

            keyword_analysis[keyword] = {
                'occurrences': occurrences,
                'density_percentage': round(density, 2),
                'recommendation': self.get_keyword_recommendation(density),
                'optimal_range': '1-3%'
            }

        return keyword_analysis

    def get_keyword_recommendation(self, density):
        """Provide keyword density recommendations"""
        if density < 0.5:
            return 'increase_usage'
        elif density <= 3.0:
            return 'optimal'
        elif density <= 5.0:
            return 'reduce_slightly'
        else:
            return 'keyword_stuffing_risk'

    def generate_content_rewording_recommendations(self, content, keywords, page_url):
        """Generate AI-powered content rewording recommendations for SEO optimization"""
        recommendations = {
            'page_url': page_url,
            'seo_improvements': [],
            'readability_improvements': [],
            'keyword_integration': [],
            'semantic_enhancements': [],
            'overall_priority': 'medium'
        }

        # Analyze title tag and meta description
        title = self.extract_title(content)
        meta_desc = self.extract_meta_description(content)
        h1 = self.extract_h1(content)

        # 1. Title Tag Rewording
        if title:
            title_analysis = self.analyze_title_seo_value(title, keywords)
            if title_analysis['needs_improvement']:
                recommendations['seo_improvements'].append({
                    'element': 'title_tag',
                    'current': title,
                    'issue': title_analysis['issue'],
                    'suggested_rewrite': self.suggest_title_rewrite(title, keywords),
                    'priority': 'high',
                    'expected_impact': 'Improved CTR in search results (5-15% increase)',
                    'seo_value': 'High - Title is primary ranking signal'
                })

        # 2. Meta Description Rewording
        if meta_desc:
            meta_analysis = self.analyze_meta_description_seo_value(meta_desc, keywords)
            if meta_analysis['needs_improvement']:
                recommendations['seo_improvements'].append({
                    'element': 'meta_description',
                    'current': meta_desc,
                    'issue': meta_analysis['issue'],
                    'suggested_rewrite': self.suggest_meta_description_rewrite(meta_desc, keywords),
                    'priority': 'high',
                    'expected_impact': 'Improved SERP CTR (10-20% increase)',
                    'seo_value': 'High - Directly affects click-through rate'
                })

        # 3. H1 Heading Rewording
        if h1:
            h1_analysis = self.analyze_h1_seo_value(h1, keywords)
            if h1_analysis['needs_improvement']:
                recommendations['seo_improvements'].append({
                    'element': 'h1_heading',
                    'current': h1,
                    'issue': h1_analysis['issue'],
                    'suggested_rewrite': self.suggest_h1_rewrite(h1, keywords),
                    'priority': 'medium',
                    'expected_impact': 'Improved topical relevance signal',
                    'seo_value': 'Medium - Secondary ranking factor'
                })

        # 4. Body Content Semantic Improvements
        content_text = self.extract_body_text(content)
        semantic_issues = self.analyze_semantic_seo_gaps(content_text, keywords)

        for issue in semantic_issues:
            recommendations['semantic_enhancements'].append({
                'section': issue['section'],
                'current_text': issue['excerpt'],
                'issue': issue['problem'],
                'suggested_rewrite': issue['improved_version'],
                'semantic_keywords_added': issue['keywords_integrated'],
                'priority': issue['priority'],
                'expected_impact': issue['impact'],
                'seo_value': 'Medium - Improves semantic relevance and entity recognition'
            })

        # 5. Readability Enhancements (affects dwell time/engagement signals)
        readability_score = self.calculate_readability(content_text)
        if readability_score < 60:  # Flesch Reading Ease score
            complex_sentences = self.identify_complex_sentences(content_text)
            for sentence in complex_sentences[:5]:  # Top 5 most complex
                recommendations['readability_improvements'].append({
                    'current_sentence': sentence['text'],
                    'issue': 'High complexity - difficult to read',
                    'suggested_rewrite': self.simplify_sentence(sentence['text']),
                    'readability_improvement': f"{sentence['score']} → {self.calculate_sentence_readability(self.simplify_sentence(sentence['text']))}",
                    'priority': 'low',
                    'expected_impact': 'Improved user engagement and dwell time',
                    'seo_value': 'Low-Medium - Indirect ranking benefit through user signals'
                })

        # 6. Keyword Integration Opportunities
        keyword_gaps = self.identify_keyword_integration_opportunities(content_text, keywords)
        for gap in keyword_gaps:
            recommendations['keyword_integration'].append({
                'keyword': gap['keyword'],
                'current_paragraph': gap['paragraph_excerpt'],
                'issue': f"Keyword '{gap['keyword']}' missing from relevant section",
                'suggested_rewrite': gap['paragraph_with_keyword'],
                'integration_method': gap['method'],  # 'natural_insertion', 'sentence_restructure', 'new_sentence'
                'priority': 'medium',
                'expected_impact': 'Improved keyword relevance scoring',
                'seo_value': 'Medium - Strengthens topical relevance'
            })

        # Calculate overall priority based on issues found
        high_priority_count = sum(1 for cat in ['seo_improvements', 'keyword_integration']
                                   for item in recommendations[cat] if item['priority'] == 'high')

        if high_priority_count >= 3:
            recommendations['overall_priority'] = 'critical'
        elif high_priority_count >= 1:
            recommendations['overall_priority'] = 'high'

        # Add summary statistics
        recommendations['summary'] = {
            'total_improvements': sum(len(recommendations[cat]) for cat in
                                     ['seo_improvements', 'readability_improvements',
                                      'keyword_integration', 'semantic_enhancements']),
            'high_priority_items': high_priority_count,
            'estimated_seo_impact': self.estimate_overall_seo_impact(recommendations),
            'implementation_effort': self.estimate_implementation_effort(recommendations)
        }

        return recommendations

    def suggest_title_rewrite(self, current_title, keywords):
        """Generate improved title with primary keyword and compelling copy"""
        primary_keyword = keywords[0] if keywords else ''

        # Example rewrites (AI agent should customize based on content)
        rewrites = []

        # Pattern 1: Keyword + Benefit + Brand
        if primary_keyword:
            rewrites.append(f"{primary_keyword} - Complete Guide | [Brand Name]")
            rewrites.append(f"Best {primary_keyword}: Expert Tips & Strategies")
            rewrites.append(f"How to Master {primary_keyword} in [Year]")

        # Return most relevant rewrite
        return rewrites[0] if rewrites else current_title

    def suggest_meta_description_rewrite(self, current_desc, keywords):
        """Generate improved meta description with keywords and CTA"""
        primary_keyword = keywords[0] if keywords else ''

        # Example rewrite with keyword, value prop, and CTA
        return f"Discover expert {primary_keyword} strategies that drive results. Learn proven techniques, avoid common mistakes, and boost your success. Get started today!"

    def analyze_semantic_seo_gaps(self, content, keywords):
        """Identify content sections lacking semantic keyword coverage"""
        gaps = []

        # Split content into paragraphs
        paragraphs = content.split('\n\n')

        for idx, paragraph in enumerate(paragraphs):
            # Check if paragraph lacks any primary/secondary keywords
            has_keywords = any(kw.lower() in paragraph.lower() for kw in keywords)

            if not has_keywords and len(paragraph.split()) > 30:  # Significant paragraph
                gaps.append({
                    'section': f'Paragraph {idx + 1}',
                    'excerpt': paragraph[:200] + '...' if len(paragraph) > 200 else paragraph,
                    'problem': 'No target keywords present in significant content section',
                    'improved_version': self.inject_keywords_naturally(paragraph, keywords[0]),
                    'keywords_integrated': [keywords[0]],
                    'priority': 'medium',
                    'impact': 'Improved semantic relevance for target keywords'
                })

        return gaps[:10]  # Limit to top 10 opportunities

    def inject_keywords_naturally(self, paragraph, keyword):
        """Inject keyword into paragraph while maintaining natural flow"""
        sentences = paragraph.split('. ')

        # Find best insertion point (usually second or third sentence)
        insertion_point = min(1, len(sentences) - 1)

        # Example natural injection
        sentences[insertion_point] = f"When considering {keyword}, {sentences[insertion_point][0].lower()}{sentences[insertion_point][1:]}"

        return '. '.join(sentences)
```

### Content Rewording Best Practices

**Critical Guidelines for AI Agents:**

1. **Maintain User Intent**

   - Never sacrifice user value for keyword stuffing
   - Rewrites must improve both SEO and readability
   - Preserve brand voice and tone

2. **Natural Language Processing**

   - Use LSI (Latent Semantic Indexing) keywords
   - Integrate synonyms and related terms
   - Maintain conversational flow

3. **Priority Framework**

   - **Critical**: Title tags, H1 headers, meta descriptions
   - **High**: First paragraph, subheadings
   - **Medium**: Body content, conclusion
   - **Low**: Supplementary content, sidebar text

4. **Measurement & Validation**

   - Track ranking changes after rewording
   - Monitor user engagement metrics (time on page, bounce rate)
   - A/B test major content changes
   - Validate readability scores (Flesch-Kincaid)

5. **Implementation Guidelines**
   - Implement high-priority changes first
   - Test one change at a time for attribution
   - Document all rewrites for rollback if needed
   - Monitor Google Search Console for impact

### Internal Linking Analysis

```python
# Internal Linking Framework
class InternalLinkAnalyzer:
    def __init__(self, base_domain):
        self.base_domain = base_domain
        self.link_graph = {}
        self.authority_distribution = {}

    def analyze_internal_linking(self, crawled_pages):
        """Analyze internal linking structure and authority flow"""
        for page in crawled_pages:
            internal_links = self.extract_internal_links(page)
            self.link_graph[page['url']] = internal_links

        # Calculate page authority distribution
        self.calculate_authority_flow()

        # Identify linking opportunities
        opportunities = self.identify_linking_opportunities()

        return {
            'link_graph': self.link_graph,
            'authority_distribution': self.authority_distribution,
            'opportunities': opportunities,
            'orphaned_pages': self.find_orphaned_pages(),
            'over_linked_pages': self.find_over_linked_pages()
        }

    def identify_linking_opportunities(self):
        """Identify strategic internal linking opportunities"""
        opportunities = []

        # Find pages with high authority but few outbound links
        # Find pages with low authority that could benefit from more links
        # Identify topical clustering opportunities

        return opportunities
```

## 8. Schema Markup Assessment

### Structured Data Analysis

```python
# Schema Markup Analysis Framework
class SchemaAnalyzer:
    def __init__(self):
        self.schema_types = {
            'Organization': self.analyze_organization_schema,
            'Product': self.analyze_product_schema,
            'LocalBusiness': self.analyze_local_business_schema,
            'Article': self.analyze_article_schema,
            'Review': self.analyze_review_schema,
            'BreadcrumbList': self.analyze_breadcrumb_schema
        }

    def analyze_page_schema(self, url, page_content):
        """Detect and analyze schema markup implementation"""
        detected_schemas = self.detect_schema_types(page_content)
        schema_analysis = {}

        for schema_type in detected_schemas:
            if schema_type in self.schema_types:
                analysis = self.schema_types[schema_type](page_content)
                schema_analysis[schema_type] = analysis

        # Identify missing schema opportunities
        missing_schemas = self.identify_missing_schemas(url, page_content)

        return {
            'detected_schemas': schema_analysis,
            'missing_opportunities': missing_schemas,
            'implementation_score': self.calculate_schema_score(schema_analysis),
            'recommendations': self.generate_schema_recommendations(schema_analysis, missing_schemas)
        }

    def analyze_product_schema(self, content):
        """Analyze Product schema implementation"""
        product_schema = self.extract_product_schema(content)

        analysis = {
            'required_properties': {
                'name': self.validate_property(product_schema, 'name', 10, 80),
                'description': self.validate_property(product_schema, 'description', 150, 300),
                'price': self.validate_property(product_schema, 'price'),
                'availability': self.validate_property(product_schema, 'availability')
            },
            'recommended_properties': {
                'brand': self.validate_property(product_schema, 'brand'),
                'sku': self.validate_property(product_schema, 'sku'),
                'aggregateRating': self.validate_property(product_schema, 'aggregateRating'),
                'review': self.validate_property(product_schema, 'review')
            },
            'implementation_quality': self.assess_schema_quality(product_schema)
        }

        return analysis

    def validate_property(self, schema_data, property_name, min_length=None, max_length=None):
        """Validate individual schema property"""
        if property_name not in schema_data:
            return {'status': 'missing', 'recommendation': 'Add required property'}

        value = schema_data[property_name]
        validation = {'status': 'present', 'value': value}

        if min_length and len(str(value)) < min_length:
            validation['warning'] = f'Value too short (min: {min_length} chars)'
        elif max_length and len(str(value)) > max_length:
            validation['warning'] = f'Value too long (max: {max_length} chars)'
        else:
            validation['status'] = 'optimal'

        return validation
```

## 9. Authority & Off-Page Analysis

### Backlink Profile Assessment

```python
# Authority Analysis Framework
class AuthorityAnalyzer:
    def __init__(self):
        self.authority_metrics = {}
        self.backlink_sources = []

    def analyze_domain_authority(self, domain):
        """Analyze domain authority signals"""
        authority_analysis = {
            'estimated_domain_authority': self.estimate_domain_authority(domain),
            'backlink_profile': self.analyze_backlink_profile(domain),
            'brand_mentions': self.analyze_brand_mentions(domain),
            'social_signals': self.analyze_social_signals(domain),
            'trust_signals': self.analyze_trust_signals(domain)
        }

        return authority_analysis

    def analyze_backlink_profile(self, domain):
        """Analyze backlink quality and diversity"""
        # Note: This would integrate with backlink analysis APIs
        backlink_analysis = {
            'total_backlinks': 0,  # From API
            'referring_domains': 0,  # From API
            'domain_diversity': self.calculate_domain_diversity(),
            'anchor_text_distribution': self.analyze_anchor_text(),
            'link_quality_score': self.assess_link_quality(),
            'toxic_links': self.identify_toxic_links()
        }

        recommendations = self.generate_link_building_recommendations(backlink_analysis)

        return {
            'analysis': backlink_analysis,
            'recommendations': recommendations
        }
```

## 10. Competitive Analysis Framework

### Competitor Benchmarking

```python
# Competitive Analysis Framework
class CompetitorAnalyzer:
    def __init__(self, target_domain, competitor_domains):
        self.target_domain = target_domain
        self.competitors = competitor_domains
        self.comparison_metrics = {}

    def perform_competitive_analysis(self):
        """Comprehensive competitive SEO analysis"""
        analysis = {}

        for competitor in self.competitors:
            competitor_analysis = {
                'technical_seo': self.analyze_competitor_technical(competitor),
                'content_strategy': self.analyze_competitor_content(competitor),
                'keyword_overlap': self.analyze_keyword_overlap(competitor),
                'backlink_comparison': self.compare_backlink_profiles(competitor),
                'performance_metrics': self.compare_performance(competitor)
            }

            analysis[competitor] = competitor_analysis

        # Generate competitive insights
        insights = self.generate_competitive_insights(analysis)
        opportunities = self.identify_opportunities(analysis)

        return {
            'competitor_analysis': analysis,
            'competitive_insights': insights,
            'opportunities': opportunities,
            'benchmark_metrics': self.create_benchmark_metrics(analysis)
        }
```

## 11. Report Generation & Output

### Comprehensive Report Structure

```python
# Report Generation Framework
class SEOReportGenerator:
    def __init__(self, analysis_data):
        self.analysis_data = analysis_data
        self.report_sections = [
            'executive_summary',
            'technical_analysis',
            'content_optimization',
            'performance_metrics',
            'authority_assessment',
            'competitive_analysis',
            'recommendations',
            'implementation_roadmap'
        ]

    def generate_comprehensive_report(self, output_format='html'):
        """Generate complete SEO audit report"""
        report_data = {
            'metadata': self.generate_metadata(),
            'executive_summary': self.create_executive_summary(),
            'overall_scores': self.calculate_overall_scores(),
            'technical_findings': self.compile_technical_findings(),
            'content_analysis': self.compile_content_analysis(),
            'performance_assessment': self.compile_performance_data(),
            'authority_analysis': self.compile_authority_data(),
            'recommendations': self.prioritize_recommendations(),
            'implementation_plan': self.create_implementation_plan()
        }

        if output_format == 'html':
            return self.generate_html_report(report_data)
        elif output_format == 'json':
            return self.generate_json_report(report_data)
        elif output_format == 'csv':
            return self.generate_csv_report(report_data)
        else:
            return self.generate_markdown_report(report_data)

    def calculate_overall_scores(self):
        """Calculate weighted overall SEO scores"""
        scores = {
            'technical_seo': self.calculate_technical_score(),
            'content_quality': self.calculate_content_score(),
            'user_experience': self.calculate_ux_score(),
            'authority_signals': self.calculate_authority_score(),
            'mobile_optimization': self.calculate_mobile_score(),
            'page_speed': self.calculate_speed_score()
        }

        # Calculate weighted overall score
        weights = {
            'technical_seo': 0.25,
            'content_quality': 0.25,
            'user_experience': 0.20,
            'authority_signals': 0.15,
            'mobile_optimization': 0.10,
            'page_speed': 0.05
        }

        overall_score = sum(scores[metric] * weights[metric] for metric in scores)

        return {
            'individual_scores': scores,
            'overall_score': round(overall_score, 1),
            'scoring_methodology': weights
        }
```

### HTML Report Template

```html
<!-- Interactive HTML Report Template -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SEO Audit Report - {{domain}}</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
      /* Comprehensive CSS styling for interactive report */
      .seo-report {
        font-family: 'Segoe UI', sans-serif;
      }
      .score-card {
        background: white;
        border-radius: 10px;
        padding: 25px;
      }
      .score-excellent {
        color: #28a745;
      }
      .score-good {
        color: #ffc107;
      }
      .score-fair {
        color: #fd7e14;
      }
      .score-poor {
        color: #dc3545;
      }
    </style>
  </head>
  <body>
    <div class="seo-report">
      <!-- Executive Summary Section -->
      <section class="executive-summary">
        <h1>SEO Audit Report: {{domain}}</h1>
        <div class="overall-score">{{overall_score}}/100</div>
        <div class="critical-issues">{{critical_issues_count}} Critical Issues</div>
      </section>

      <!-- Interactive Charts and Data Visualization -->
      <section class="performance-charts">
        <canvas id="seoRadarChart"></canvas>
        <canvas id="performanceChart"></canvas>
      </section>

      <!-- Detailed Analysis Sections -->
      <!-- Content populated by report generator -->
    </div>
  </body>
</html>
```

### Interactive HTML Report Generation (REQUIRED)

**CRITICAL**: All SEO report generation MUST include creation of an interactive HTML dashboard file (`seo-audit-report.html`) as the primary deliverable for stakeholder presentations and visual analysis.

#### HTML Report Requirements

**File Structure:**

- **Filename**: `seo-audit-report.html`
- **Location**: `.project/seo/{domain}/{YYYY.MM.DD}/seo-audit-report.html`
- **Dependencies**: Must automatically load data from `technical-analysis.json` in same directory
- **Self-Contained**: No external dependencies except CDN resources (Chart.js)
- **Browser Compatibility**: Works in all modern browsers (Chrome, Firefox, Safari, Edge)

#### Essential Components

1. **Header Section**

   - Domain name and analysis date
   - Report version and personas used
   - Analysis depth indicator
   - Quick metadata display

2. **Navigation Menu**

   - Sticky navigation bar with smooth scrolling
   - Sections: Overview, Technical SEO, Content, Performance, Strategy, Authority, SERP Features, Roadmap
   - Active section highlighting
   - Mobile-responsive hamburger menu

3. **Score Dashboard**

   - Overall SEO Health score with animated progress bar
   - 6 category score cards (Technical, Content, UX, Strategy, Authority, Mobile)
   - Color-coded grades (Excellent: Green ≥80, Good: Yellow ≥70, Fair: Orange ≥50, Poor: Red <50)
   - Animated counters that count up on page load
   - Visual progress bars for each category

4. **Data Visualization**

   - **Bar Chart**: Category scores comparison (Chart.js)
   - **Radar Chart**: Current score vs target (80) for all categories
   - **Trend Charts**: For performance metrics over time (if historical data available)
   - Interactive tooltips on hover
   - Responsive sizing for mobile/tablet/desktop

5. **Content Sections**

   - **Overview**: Executive summary with critical issues and quick wins
   - **Technical SEO**: Issues list with severity badges (Critical/High/Medium/Low), positives, recommendations
   - **Content Analysis**: Title tags, meta descriptions, headers, images with optimization suggestions
   - **Performance**: Core Web Vitals breakdown with targets, mobile optimization status
   - **Content Strategy**: Topic cluster plans, content velocity roadmap, internal linking architecture
   - **Authority Building**: Domain authority, backlink profile, trust acceleration plan, link building priorities
   - **SERP Features**: Current presence, optimization targets for snippets/PAA/image packs
   - **Implementation Roadmap**: Week-by-week tasks for 90-day plan, KPI tracking tables

6. **Interactive Features**

   - Collapsible sections for detailed data
   - Sortable tables for recommendations
   - Filterable issue lists by priority/category
   - Print-friendly CSS media queries
   - Copy-to-clipboard for code snippets
   - Search functionality for large reports

7. **Visual Design**
   - Professional gradient header (primary to secondary color)
   - Card-based layout with shadows and hover effects
   - Consistent color scheme matching brand
   - Responsive grid layout (CSS Grid/Flexbox)
   - Smooth animations and transitions
   - High contrast for accessibility

#### Implementation Example

```javascript
// HTML Report must include JavaScript to dynamically load JSON data
<script>
  let seoData = null;

  // Load technical-analysis.json from same directory
  fetch('technical-analysis.json')
    .then(response => response.json())
    .then(data => {
      seoData = data.seo_audit;
      initializeDashboard();
    })
    .catch(error => {
      console.error('Error loading JSON:', error);
      alert('Error loading SEO data. Ensure technical-analysis.json exists.');
    });

  function initializeDashboard() {
    updateScoreCards();
    createCharts();
    populateAllSections();
  }

  function updateScoreCards() {
    // Animate score values from 0 to actual score
    const scores = seoData.overall_scores;
    animateScore('overall-score', scores.total_seo_health);
    animateScore('technical-score', scores.category_scores.technical_seo);
    // ... repeat for all categories
  }

  function createCharts() {
    // Create Chart.js bar chart for category scores
    const ctx = document.getElementById('categoryChart').getContext('2d');
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Technical', 'Content', 'Performance', 'Strategy', 'Authority'],
        datasets: [{
          label: 'SEO Score',
          data: [/* scores from JSON */],
          backgroundColor: [/* colors based on score ranges */]
        }]
      },
      options: {
        responsive: true,
        scales: { y: { beginAtZero: true, max: 100 } }
      }
    });

    // Create radar chart comparing current vs target scores
    // ... radar chart implementation
  }

  function populateAllSections() {
    populateCriticalIssues();
    populateTechnicalSection();
    populateContentSection();
    // ... populate all other sections from JSON data
  }
</script>
```

#### CSS Requirements

```css
/* Essential CSS for professional report appearance */
:root {
  --primary-color: #2563eb;
  --secondary-color: #0ea5e9;
  --success-color: #10b981;
  --warning-color: #f59e0b;
  --danger-color: #ef4444;
}

/* Animated score cards */
.score-card {
  background: white;
  border-radius: 1rem;
  padding: 1.5rem;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  transition: transform 0.2s, box-shadow 0.2s;
}

.score-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
}

/* Color-coded score values */
.score-excellent {
  color: var(--success-color);
}
.score-good {
  color: #10b981;
}
.score-fair {
  color: var(--warning-color);
}
.score-poor {
  color: var(--danger-color);
}

/* Responsive navigation */
.nav {
  position: sticky;
  top: 0;
  z-index: 100;
  background: white;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

/* Print-friendly styles */
@media print {
  .nav,
  .header {
    display: none;
  }
  .section {
    display: block !important;
    page-break-inside: avoid;
  }
}
```

#### File Generation Checklist

When generating SEO reports, AI agents MUST:

✅ Create `seo-audit-report.html` as the first file
✅ Include all required sections with navigation
✅ Implement animated score cards and progress bars
✅ Add Chart.js visualizations (bar chart + radar chart minimum)
✅ Auto-load data from `technical-analysis.json`
✅ Ensure responsive design (mobile/tablet/desktop)
✅ Include print-friendly CSS
✅ Test that file opens correctly in browser
✅ Verify all data populates from JSON dynamically
✅ Include error handling for missing JSON file
✅ Add professional styling with gradients and shadows
✅ Implement interactive features (collapsible sections, sortable tables)

#### Quality Standards

- **Visual Appeal**: Professional gradient design, card-based layout, smooth animations
- **Data Accuracy**: All scores and metrics match JSON data exactly
- **Usability**: Intuitive navigation, clear section labels, logical information hierarchy
- **Performance**: Fast load time (<2 seconds), smooth animations (60fps)
- **Accessibility**: Sufficient color contrast (WCAG AA), keyboard navigation support
- **Browser Support**: Works in Chrome, Firefox, Safari, Edge (latest versions)
- **File Size**: Optimized to <500KB (excluding external CDN resources)

### Python Development Server for Local Viewing (REQUIRED)

**CRITICAL**: Due to CORS restrictions, the HTML report cannot load JSON files via AJAX when opened directly from the filesystem (file:// protocol). A lightweight Python HTTP server MUST be created to serve the report files properly.

#### Server Requirements

**File Structure:**

- **Filename**: `serve_report.py`
- **Location**: `.project/seo/{domain}/{YYYY.MM.DD}/serve_report.py`
- **Purpose**: Serve HTML, JSON, CSS, JS files with proper MIME types and CORS headers
- **Dependencies**: Python 3.6+ standard library only (no external packages required)

#### Python Server Implementation

```python
#!/usr/bin/env python3
"""
Lightweight HTTP server for SEO audit report viewing.
Serves static files with proper MIME types and CORS headers to enable AJAX JSON loading.
"""

import http.server
import socketserver
import os
import sys
from pathlib import Path

# Configuration
PORT = 8080
HOST = 'localhost'

class SEOReportHandler(http.server.SimpleHTTPRequestHandler):
    """Custom handler with proper MIME types and CORS headers"""

    def end_headers(self):
        """Add CORS headers to allow AJAX requests"""
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET')
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        return super().end_headers()

    def log_message(self, format, *args):
        """Custom logging with timestamp and color coding"""
        timestamp = self.log_date_time_string()
        status_code = args[1] if len(args) > 1 else '000'

        # Color code based on status
        if status_code.startswith('2'):
            color = '\033[92m'  # Green
        elif status_code.startswith('3'):
            color = '\033[93m'  # Yellow
        elif status_code.startswith('4') or status_code.startswith('5'):
            color = '\033[91m'  # Red
        else:
            color = '\033[0m'   # Default

        print(f"[{timestamp}] {color}{format % args}\033[0m")

    def guess_type(self, path):
        """Override MIME type detection for common SEO report files"""
        mime_types = {
            '.html': 'text/html',
            '.json': 'application/json',
            '.js': 'application/javascript',
            '.css': 'text/css',
            '.md': 'text/markdown',
            '.csv': 'text/csv',
            '.svg': 'image/svg+xml',
            '.png': 'image/png',
            '.jpg': 'image/jpeg',
            '.jpeg': 'image/jpeg',
            '.gif': 'image/gif',
            '.ico': 'image/x-icon'
        }

        ext = Path(path).suffix.lower()
        return mime_types.get(ext, 'application/octet-stream')

def start_server():
    """Initialize and start the HTTP server"""

    # Change to report directory
    report_dir = Path(__file__).parent.resolve()
    os.chdir(report_dir)

    print("\n" + "="*70)
    print("  SEO AUDIT REPORT SERVER")
    print("="*70)
    print(f"\n📂 Serving directory: {report_dir}")
    print(f"🌐 Server URL: http://{HOST}:{PORT}")
    print(f"\n📊 Available files:")

    # List available report files
    files = {
        'seo-audit-report.html': 'Interactive HTML Dashboard',
        'technical-analysis.json': 'Structured Data (JSON)',
        'seo-audit-summary.md': 'Executive Summary (Markdown)',
        'seo-analysis.md': 'Detailed Analysis (Markdown)',
        'recommendations.csv': 'Action Plan (CSV)'
    }

    for filename, description in files.items():
        if Path(filename).exists():
            size = Path(filename).stat().st_size
            size_str = f"{size:,} bytes" if size < 1024 else f"{size/1024:.1f} KB"
            print(f"  ✓ {filename:<30} {description:<35} ({size_str})")
        else:
            print(f"  ✗ {filename:<30} {description:<35} (NOT FOUND)")

    print("\n" + "-"*70)
    print(f"\n🚀 Starting server on http://{HOST}:{PORT}/")
    print(f"📱 Open in browser: http://{HOST}:{PORT}/seo-audit-report.html")
    print(f"\n⚠️  Press Ctrl+C to stop the server\n")
    print("="*70 + "\n")

    # Create and start server
    with socketserver.TCPServer((HOST, PORT), SEOReportHandler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n\n" + "="*70)
            print("  SERVER STOPPED")
            print("="*70)
            print("\n👋 Server shut down successfully.\n")
            sys.exit(0)

if __name__ == '__main__':
    start_server()
```

#### Server Usage Instructions

**Starting the Server:**

```bash
# Navigate to report directory
cd .project/seo/{domain}/{YYYY.MM.DD}/

# Make server executable (first time only)
chmod +x serve_report.py

# Start the server
python3 serve_report.py

# Alternative: Direct python invocation
python3 serve_report.py
```

**Accessing the Report:**

1. **Browser**: Open http://localhost:8080/seo-audit-report.html
2. **Automatic Loading**: The HTML report will automatically fetch data from technical-analysis.json via AJAX
3. **Markdown Files**: Can view markdown files with the markdown rendering tab (see below)

**Stopping the Server:**

- Press `Ctrl+C` in the terminal where the server is running
- Server will display graceful shutdown message

#### Enhanced HTML Report with Markdown Viewer Tab

The HTML report must be enhanced with a markdown viewer tab to display the markdown summary and analysis files inline.

**Additional HTML Tab Navigation:**

```html
<!-- Add to navigation menu -->
<nav class="nav">
  <ul>
    <li><a href="#overview">Overview</a></li>
    <li><a href="#technical">Technical SEO</a></li>
    <li><a href="#content">Content</a></li>
    <li><a href="#performance">Performance</a></li>
    <li><a href="#strategy">Strategy</a></li>
    <li><a href="#authority">Authority</a></li>
    <li><a href="#serp">SERP Features</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#markdown" class="markdown-tab">📄 Documents</a></li>
  </ul>
</nav>

<!-- Add markdown viewer section -->
<section id="markdown" class="section markdown-section">
  <h2>📄 Report Documents</h2>

  <div class="markdown-controls">
    <label for="md-file-select">Select Document:</label>
    <select id="md-file-select" onchange="loadMarkdownFile(this.value)">
      <option value="">-- Choose a file --</option>
      <option value="seo-audit-summary.md">Executive Summary</option>
      <option value="seo-analysis.md">Detailed Analysis</option>
      <option value="README.md">Project README</option>
    </select>

    <button onclick="downloadMarkdown()" class="btn-download">⬇️ Download Current</button>
  </div>

  <div id="markdown-content" class="markdown-rendered">
    <p class="placeholder">Select a document to view...</p>
  </div>
</section>
```

**JavaScript for Markdown Rendering:**

```javascript
// Add marked.js library via CDN in HTML <head>
// <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

let currentMarkdownFile = '';
let currentMarkdownContent = '';

/**
 * Load and render markdown file
 */
async function loadMarkdownFile(filename) {
  if (!filename) {
    document.getElementById('markdown-content').innerHTML =
      '<p class="placeholder">Select a document to view...</p>';
    return;
  }

  try {
    const response = await fetch(filename);
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`);
    }

    const markdownText = await response.text();
    currentMarkdownFile = filename;
    currentMarkdownContent = markdownText;

    // Render markdown to HTML using marked.js
    const htmlContent = marked.parse(markdownText);

    // Display rendered content
    document.getElementById('markdown-content').innerHTML = htmlContent;

    // Enhance rendered content
    enhanceMarkdownRendering();

    console.log(`✓ Loaded: ${filename} (${markdownText.length} bytes)`);
  } catch (error) {
    console.error('Error loading markdown:', error);
    document.getElementById('markdown-content').innerHTML = `
      <div class="error-message">
        <h3>⚠️ Error Loading Document</h3>
        <p><strong>File:</strong> ${filename}</p>
        <p><strong>Error:</strong> ${error.message}</p>
        <p>Make sure the Python server is running and the file exists.</p>
      </div>
    `;
  }
}

/**
 * Enhance rendered markdown with syntax highlighting and interactive features
 */
function enhanceMarkdownRendering() {
  const content = document.getElementById('markdown-content');

  // Add anchor links to headings
  const headings = content.querySelectorAll('h1, h2, h3, h4, h5, h6');
  headings.forEach((heading) => {
    const id = heading.textContent
      .toLowerCase()
      .replace(/[^\w\s-]/g, '')
      .replace(/\s+/g, '-');
    heading.id = id;

    // Add copy link button
    const linkBtn = document.createElement('a');
    linkBtn.href = `#${id}`;
    linkBtn.className = 'heading-anchor';
    linkBtn.innerHTML = '🔗';
    linkBtn.title = 'Copy link to this section';
    heading.appendChild(linkBtn);
  });

  // Make tables responsive
  const tables = content.querySelectorAll('table');
  tables.forEach((table) => {
    const wrapper = document.createElement('div');
    wrapper.className = 'table-wrapper';
    table.parentNode.insertBefore(wrapper, table);
    wrapper.appendChild(table);
  });

  // Add copy buttons to code blocks
  const codeBlocks = content.querySelectorAll('pre code');
  codeBlocks.forEach((block) => {
    const pre = block.parentElement;
    const copyBtn = document.createElement('button');
    copyBtn.className = 'copy-code-btn';
    copyBtn.innerHTML = '📋 Copy';
    copyBtn.onclick = () => copyCodeToClipboard(block.textContent, copyBtn);
    pre.appendChild(copyBtn);
  });
}

/**
 * Copy code block content to clipboard
 */
function copyCodeToClipboard(text, button) {
  navigator.clipboard
    .writeText(text)
    .then(() => {
      const originalText = button.innerHTML;
      button.innerHTML = '✓ Copied!';
      button.classList.add('copied');

      setTimeout(() => {
        button.innerHTML = originalText;
        button.classList.remove('copied');
      }, 2000);
    })
    .catch((err) => {
      console.error('Failed to copy:', err);
      alert('Failed to copy to clipboard');
    });
}

/**
 * Download current markdown file
 */
function downloadMarkdown() {
  if (!currentMarkdownFile || !currentMarkdownContent) {
    alert('No document loaded to download');
    return;
  }

  const blob = new Blob([currentMarkdownContent], { type: 'text/markdown' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = currentMarkdownFile;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);

  console.log(`✓ Downloaded: ${currentMarkdownFile}`);
}

// Configure marked.js options for better rendering
marked.setOptions({
  headerIds: true,
  mangle: false,
  breaks: true,
  gfm: true, // GitHub Flavored Markdown
  tables: true,
  smartLists: true,
  smartypants: true,
});
```

**CSS for Markdown Viewer:**

```css
/* Markdown section styling */
.markdown-section {
  background: #f8fafc;
  min-height: 80vh;
}

.markdown-controls {
  background: white;
  padding: 1.5rem;
  border-radius: 0.5rem;
  margin-bottom: 1.5rem;
  display: flex;
  align-items: center;
  gap: 1rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.markdown-controls label {
  font-weight: 600;
  color: #334155;
}

#md-file-select {
  flex: 1;
  max-width: 400px;
  padding: 0.5rem 1rem;
  border: 2px solid #e2e8f0;
  border-radius: 0.375rem;
  font-size: 1rem;
  cursor: pointer;
  transition: border-color 0.2s;
}

#md-file-select:hover {
  border-color: #cbd5e1;
}

#md-file-select:focus {
  outline: none;
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

.btn-download {
  padding: 0.5rem 1.25rem;
  background: var(--primary-color);
  color: white;
  border: none;
  border-radius: 0.375rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-download:hover {
  background: #1d4ed8;
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(37, 99, 235, 0.2);
}

/* Rendered markdown content */
.markdown-rendered {
  background: white;
  padding: 2rem;
  border-radius: 0.5rem;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  max-width: 1200px;
  margin: 0 auto;
  line-height: 1.7;
  color: #1e293b;
}

.markdown-rendered .placeholder {
  text-align: center;
  color: #94a3b8;
  font-size: 1.125rem;
  padding: 4rem 0;
}

/* Markdown typography */
.markdown-rendered h1 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-top: 2rem;
  margin-bottom: 1rem;
  color: #0f172a;
  border-bottom: 3px solid var(--primary-color);
  padding-bottom: 0.5rem;
  position: relative;
}

.markdown-rendered h2 {
  font-size: 2rem;
  font-weight: 600;
  margin-top: 2.5rem;
  margin-bottom: 1rem;
  color: #1e293b;
  border-bottom: 2px solid #e2e8f0;
  padding-bottom: 0.5rem;
}

.markdown-rendered h3 {
  font-size: 1.5rem;
  font-weight: 600;
  margin-top: 2rem;
  margin-bottom: 0.75rem;
  color: #334155;
}

.markdown-rendered h4 {
  font-size: 1.25rem;
  font-weight: 600;
  margin-top: 1.5rem;
  margin-bottom: 0.5rem;
  color: #475569;
}

.markdown-rendered p {
  margin-bottom: 1rem;
}

.markdown-rendered a {
  color: var(--primary-color);
  text-decoration: none;
  border-bottom: 1px solid transparent;
  transition: border-color 0.2s;
}

.markdown-rendered a:hover {
  border-bottom-color: var(--primary-color);
}

/* Heading anchors */
.heading-anchor {
  opacity: 0;
  margin-left: 0.5rem;
  font-size: 0.8em;
  text-decoration: none;
  transition: opacity 0.2s;
}

.markdown-rendered h1:hover .heading-anchor,
.markdown-rendered h2:hover .heading-anchor,
.markdown-rendered h3:hover .heading-anchor,
.markdown-rendered h4:hover .heading-anchor {
  opacity: 0.6;
}

.heading-anchor:hover {
  opacity: 1 !important;
}

/* Code blocks */
.markdown-rendered pre {
  background: #1e293b;
  color: #e2e8f0;
  padding: 1.5rem;
  border-radius: 0.5rem;
  overflow-x: auto;
  position: relative;
  margin: 1.5rem 0;
}

.markdown-rendered code {
  font-family: 'Fira Code', 'Consolas', 'Monaco', monospace;
  font-size: 0.9em;
}

.markdown-rendered pre code {
  background: none;
  padding: 0;
  color: inherit;
}

.markdown-rendered p code,
.markdown-rendered li code {
  background: #f1f5f9;
  color: #e11d48;
  padding: 0.2rem 0.4rem;
  border-radius: 0.25rem;
  font-size: 0.875em;
}

.copy-code-btn {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  padding: 0.375rem 0.75rem;
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 0.25rem;
  font-size: 0.875rem;
  cursor: pointer;
  transition: all 0.2s;
}

.copy-code-btn:hover {
  background: rgba(255, 255, 255, 0.2);
}

.copy-code-btn.copied {
  background: var(--success-color);
  border-color: var(--success-color);
}

/* Lists */
.markdown-rendered ul,
.markdown-rendered ol {
  margin: 1rem 0;
  padding-left: 2rem;
}

.markdown-rendered li {
  margin-bottom: 0.5rem;
}

/* Tables */
.table-wrapper {
  overflow-x: auto;
  margin: 1.5rem 0;
  border-radius: 0.5rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.markdown-rendered table {
  width: 100%;
  border-collapse: collapse;
  background: white;
}

.markdown-rendered th {
  background: #f8fafc;
  color: #0f172a;
  font-weight: 600;
  text-align: left;
  padding: 0.75rem 1rem;
  border-bottom: 2px solid #e2e8f0;
}

.markdown-rendered td {
  padding: 0.75rem 1rem;
  border-bottom: 1px solid #f1f5f9;
}

.markdown-rendered tr:hover td {
  background: #f8fafc;
}

/* Blockquotes */
.markdown-rendered blockquote {
  border-left: 4px solid var(--primary-color);
  padding-left: 1.5rem;
  margin: 1.5rem 0;
  color: #64748b;
  font-style: italic;
}

/* Horizontal rules */
.markdown-rendered hr {
  border: none;
  border-top: 2px solid #e2e8f0;
  margin: 2rem 0;
}

/* Error message */
.error-message {
  background: #fee;
  border: 2px solid #fcc;
  border-radius: 0.5rem;
  padding: 2rem;
  text-align: center;
}

.error-message h3 {
  color: var(--danger-color);
  margin-top: 0;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .markdown-controls {
    flex-direction: column;
    align-items: stretch;
  }

  #md-file-select {
    max-width: none;
  }

  .markdown-rendered {
    padding: 1.5rem;
  }

  .markdown-rendered h1 {
    font-size: 2rem;
  }

  .markdown-rendered h2 {
    font-size: 1.5rem;
  }

  .markdown-rendered pre {
    padding: 1rem;
  }
}
```

#### Server and Markdown Viewer Checklist

When generating SEO reports with server and markdown capabilities, AI agents MUST:

✅ Create `serve_report.py` in report directory
✅ Make server executable with proper shebang (`#!/usr/bin/env python3`)
✅ Include proper MIME types for all file formats (HTML, JSON, CSS, JS, MD, CSV)
✅ Add CORS headers to allow AJAX requests
✅ Implement graceful shutdown with Ctrl+C handler
✅ Display file listing with sizes on server start
✅ Add marked.js library via CDN in HTML head
✅ Create markdown viewer tab in navigation
✅ Implement file selector dropdown with all markdown files
✅ Add markdown rendering with proper typography
✅ Include copy-to-clipboard for code blocks
✅ Add heading anchor links for easy navigation
✅ Implement download functionality for markdown files
✅ Style markdown content professionally with responsive design
✅ Test markdown rendering with all report markdown files
✅ Verify AJAX loading works properly with server running

#### Usage Documentation

Create a `README.md` in the report directory with these instructions:

````markdown
# SEO Audit Report - Viewing Instructions

## Quick Start

1. **Start the local server:**
   ```bash
   python3 serve_report.py
   ```
````

2. **Open in browser:**

   - URL: http://localhost:8080/seo-audit-report.html
   - The report will automatically load all data

3. **View markdown documents:**

   - Click the "📄 Documents" tab
   - Select a document from the dropdown
   - View rendered markdown with syntax highlighting

4. **Stop the server:**
   - Press Ctrl+C in the terminal

## Available Files

- **seo-audit-report.html** - Interactive dashboard with charts and visualizations
- **technical-analysis.json** - Structured data (auto-loaded by HTML)
- **seo-audit-summary.md** - Executive summary (viewable in Documents tab)
- **seo-analysis.md** - Detailed analysis (viewable in Documents tab)
- **recommendations.csv** - Action plan spreadsheet
- **serve_report.py** - Development server for local viewing

## Troubleshooting

**Problem: "Failed to load JSON data"**

- **Solution**: Make sure you're using the Python server, not opening the HTML file directly

**Problem: "Port 8080 already in use"**

- **Solution**: Change PORT variable in serve_report.py to another port (e.g., 8081)

**Problem: "Markdown not rendering"**

- **Solution**: Check browser console for errors, ensure marked.js CDN is accessible

## Technical Notes

- Server uses Python standard library only (no pip install required)
- CORS headers enabled for local AJAX requests
- All files served with appropriate MIME types
- Markdown rendered with marked.js library

````

## 12. Implementation Guidelines & Best Practices

### Meta Element Size Validation

```python
# Meta Element Size Validator
class MetaElementValidator:
    def __init__(self):
        self.size_guidelines = {
            'title': {'min': 30, 'optimal_max': 60, 'absolute_max': 70},
            'meta_description': {'min': 120, 'optimal_max': 160, 'absolute_max': 180},
            'h1': {'min': 20, 'optimal_max': 70, 'absolute_max': 100},
            'h2': {'min': 15, 'optimal_max': 65, 'absolute_max': 80},
            'alt_text': {'min': 10, 'optimal_max': 125, 'absolute_max': 150},
            'schema_name': {'min': 10, 'optimal_max': 80, 'absolute_max': 100},
            'schema_description': {'min': 100, 'optimal_max': 250, 'absolute_max': 300}
        }

    def validate_element_sizes(self, elements):
        """Validate all meta elements against size guidelines"""
        validation_results = {}

        for element_type, content in elements.items():
            if element_type in self.size_guidelines:
                validation = self.validate_single_element(element_type, content)
                validation_results[element_type] = validation

        return validation_results

    def validate_single_element(self, element_type, content):
        """Validate individual element against size guidelines"""
        if not content:
            return {
                'status': 'missing',
                'length': 0,
                'recommendation': f'Add {element_type} content',
                'priority': 'high' if element_type in ['title', 'meta_description'] else 'medium'
            }

        length = len(content)
        guidelines = self.size_guidelines[element_type]

        if length < guidelines['min']:
            status = 'too_short'
            priority = 'medium'
            recommendation = f'Expand {element_type} to at least {guidelines["min"]} characters'
        elif length <= guidelines['optimal_max']:
            status = 'optimal'
            priority = 'none'
            recommendation = f'{element_type} length is optimal'
        elif length <= guidelines['absolute_max']:
            status = 'acceptable'
            priority = 'low'
            recommendation = f'Consider shortening {element_type} for better display'
        else:
            status = 'too_long'
            priority = 'high'
            recommendation = f'Shorten {element_type} to under {guidelines["optimal_max"]} characters'

        return {
            'status': status,
            'length': length,
            'recommendation': recommendation,
            'priority': priority,
            'optimal_range': f'{guidelines["min"]}-{guidelines["optimal_max"]} characters',
            'current_length': length
        }
````

### Quality Assurance Checklist

- [ ] All meta elements validated against size guidelines
- [ ] Technical SEO issues prioritized by impact and effort
- [ ] Content recommendations include specific keyword targets
- [ ] Performance metrics include Core Web Vitals assessment
- [ ] Authority analysis covers backlink quality and diversity
- [ ] Competitive analysis provides actionable insights
- [ ] Implementation timeline includes resource requirements
- [ ] Report includes visual charts and interactive elements

### Error Handling & Edge Cases

```python
# Error Handling Framework
class SEOAnalysisErrorHandler:
    def __init__(self):
        self.error_types = {
            'connection_timeout': self.handle_connection_error,
            'invalid_url': self.handle_url_error,
            'content_parsing_error': self.handle_parsing_error,
            'api_rate_limit': self.handle_rate_limit,
            'insufficient_data': self.handle_data_limitation
        }

    def handle_analysis_errors(self, error_type, context):
        """Handle various analysis errors gracefully"""
        if error_type in self.error_types:
            return self.error_types[error_type](context)
        else:
            return self.handle_unknown_error(error_type, context)

    def handle_connection_error(self, context):
        """Handle connection timeouts and network issues"""
        return {
            'status': 'partial_analysis',
            'message': 'Some pages could not be analyzed due to connection issues',
            'recommendations': [
                'Retry analysis during off-peak hours',
                'Check website availability and response times',
                'Consider analyzing individual pages separately'
            ],
            'impact': 'Limited technical SEO assessment'
        }
```

This comprehensive SEO analysis instruction set provides AI agents with detailed guidance for performing thorough website audits, including specific meta element size guidelines, technical assessment frameworks, and actionable report generation capabilities.

---

## 13. Executive Summary Report Section

### Purpose & Audience

The Executive Summary provides a concise, non-technical overview designed for busy stakeholders, decision-makers, and C-suite executives who need to understand the SEO state in under two minutes.

### Core Components

```python
# Executive Summary Generator
class ExecutiveSummaryGenerator:
    def __init__(self, analysis_data, previous_report_data=None):
        self.analysis_data = analysis_data
        self.previous_data = previous_report_data
        self.summary_sections = {}

    def generate_executive_summary(self):
        """Generate comprehensive executive summary"""
        summary = {
            'report_metadata': self.create_metadata(),
            'overall_health_score': self.calculate_overall_health(),
            'major_wins': self.identify_major_wins(),
            'critical_losses': self.identify_critical_losses(),
            'trend_analysis': self.analyze_trends(),
            'algorithm_impacts': self.assess_algorithm_impacts(),
            'competitor_movements': self.analyze_competitor_changes(),
            'high_priority_actions': self.identify_priority_actions(),
            'projected_outcomes': self.project_expected_outcomes(),
            'executive_recommendations': self.generate_executive_recommendations()
        }

        return self.format_executive_summary(summary)

    def calculate_overall_health(self):
        """Calculate overall SEO health score with visual indicators"""
        health_metrics = {
            'technical_health': self.analysis_data.get('technical_score', 0),
            'content_quality': self.analysis_data.get('content_score', 0),
            'user_experience': self.analysis_data.get('ux_score', 0),
            'authority_signals': self.analysis_data.get('authority_score', 0),
            'mobile_optimization': self.analysis_data.get('mobile_score', 0)
        }

        overall_score = sum(health_metrics.values()) / len(health_metrics)

        # Determine health status
        if overall_score >= 80:
            status = 'Excellent'
            trend_indicator = '🟢'
            summary = 'SEO performance is strong across all key metrics'
        elif overall_score >= 60:
            status = 'Good'
            trend_indicator = '🟡'
            summary = 'SEO performance is solid with opportunities for improvement'
        elif overall_score >= 40:
            status = 'Fair'
            trend_indicator = '🟠'
            summary = 'SEO performance needs attention in several key areas'
        else:
            status = 'Poor'
            trend_indicator = '🔴'
            summary = 'Immediate action required to improve SEO performance'

        return {
            'overall_score': round(overall_score, 1),
            'status': status,
            'trend_indicator': trend_indicator,
            'summary': summary,
            'component_scores': health_metrics,
            'change_from_previous': self.calculate_score_change()
        }

    def identify_major_wins(self):
        """Identify and summarize major SEO achievements"""
        wins = []

        # Traffic increases
        if self.previous_data:
            traffic_change = self.calculate_traffic_change()
            if traffic_change > 10:
                wins.append({
                    'type': 'traffic_growth',
                    'title': f'Organic Traffic Increased {traffic_change}%',
                    'description': f'Website experienced {traffic_change}% growth in organic sessions',
                    'impact': 'high',
                    'metric_value': traffic_change
                })

        # Ranking improvements
        ranking_wins = self.analyze_ranking_improvements()
        if ranking_wins:
            wins.extend(ranking_wins)

        # Technical improvements
        technical_wins = self.analyze_technical_improvements()
        if technical_wins:
            wins.extend(technical_wins)

        return sorted(wins, key=lambda x: x.get('impact_score', 0), reverse=True)[:5]

    def identify_critical_losses(self):
        """Identify critical SEO issues and losses"""
        losses = []

        # Traffic decreases
        if self.previous_data:
            traffic_change = self.calculate_traffic_change()
            if traffic_change < -10:
                losses.append({
                    'type': 'traffic_decline',
                    'title': f'Organic Traffic Decreased {abs(traffic_change)}%',
                    'severity': 'critical',
                    'description': f'Website experienced {abs(traffic_change)}% decline in organic sessions',
                    'potential_causes': self.identify_traffic_decline_causes(),
                    'recommended_action': 'Immediate investigation required'
                })

        # Ranking losses
        ranking_losses = self.analyze_ranking_declines()
        if ranking_losses:
            losses.extend(ranking_losses)

        # Technical issues
        critical_technical = self.identify_critical_technical_issues()
        if critical_technical:
            losses.extend(critical_technical)

        return sorted(losses, key=lambda x: x.get('severity_score', 0), reverse=True)[:5]

    def analyze_trends(self):
        """Analyze SEO performance trends over time"""
        if not self.previous_data:
            return {
                'status': 'insufficient_data',
                'message': 'Trend analysis requires historical data from previous reports'
            }

        trends = {
            'organic_traffic_trend': self.calculate_traffic_trend(),
            'keyword_visibility_trend': self.calculate_visibility_trend(),
            'technical_health_trend': self.calculate_technical_health_trend(),
            'content_performance_trend': self.calculate_content_trend(),
            'authority_trend': self.calculate_authority_trend()
        }

        # Identify overall trajectory
        positive_trends = sum(1 for t in trends.values() if t.get('direction') == 'upward')
        negative_trends = sum(1 for t in trends.values() if t.get('direction') == 'downward')

        if positive_trends > negative_trends:
            overall_trajectory = 'improving'
            trajectory_summary = 'SEO metrics show positive momentum'
        elif negative_trends > positive_trends:
            overall_trajectory = 'declining'
            trajectory_summary = 'SEO metrics indicate areas of concern'
        else:
            overall_trajectory = 'stable'
            trajectory_summary = 'SEO performance remains consistent'

        return {
            'trends': trends,
            'overall_trajectory': overall_trajectory,
            'trajectory_summary': trajectory_summary,
            'trend_confidence': self.calculate_trend_confidence()
        }

    def assess_algorithm_impacts(self):
        """Assess impact of known algorithm updates"""
        algorithm_impacts = []

        # Check for recent Google algorithm updates
        recent_updates = self.get_recent_algorithm_updates()

        for update in recent_updates:
            impact = self.analyze_update_impact(update)
            if impact.get('detected_impact'):
                algorithm_impacts.append({
                    'update_name': update['name'],
                    'update_date': update['date'],
                    'impact_severity': impact['severity'],
                    'affected_metrics': impact['affected_metrics'],
                    'description': impact['description'],
                    'recommended_response': impact['recommendations']
                })

        return algorithm_impacts

    def analyze_competitor_changes(self):
        """Analyze notable competitor movements and strategies"""
        if not self.analysis_data.get('competitor_data'):
            return {
                'status': 'no_competitor_data',
                'message': 'Enable competitive analysis for competitor insights'
            }

        competitor_movements = []

        for competitor in self.analysis_data['competitor_data']:
            changes = self.detect_competitor_changes(competitor)
            if changes.get('notable_changes'):
                competitor_movements.append({
                    'competitor': competitor['domain'],
                    'changes': changes['notable_changes'],
                    'impact_on_position': changes['impact'],
                    'strategic_implications': changes['implications']
                })

        return competitor_movements

    def identify_priority_actions(self):
        """Identify and prioritize high-impact next actions"""
        priority_actions = []

        # Critical technical fixes
        critical_technical = self.get_critical_technical_actions()
        priority_actions.extend(critical_technical)

        # High-impact content opportunities
        content_opportunities = self.get_high_impact_content_actions()
        priority_actions.extend(content_opportunities)

        # Quick wins
        quick_wins = self.identify_quick_wins()
        priority_actions.extend(quick_wins)

        # Sort by impact score and effort
        sorted_actions = sorted(
            priority_actions,
            key=lambda x: (x['impact_score'] / x['effort_score']),
            reverse=True
        )

        return sorted_actions[:10]

    def project_expected_outcomes(self):
        """Project expected outcomes from recommended actions"""
        projections = []

        for action in self.identify_priority_actions()[:5]:
            projection = {
                'action': action['title'],
                'timeline': action['estimated_timeline'],
                'expected_traffic_impact': self.estimate_traffic_impact(action),
                'expected_ranking_impact': self.estimate_ranking_impact(action),
                'confidence_level': action.get('confidence', 'medium'),
                'success_metrics': action.get('success_metrics', [])
            }
            projections.append(projection)

        return {
            'individual_projections': projections,
            'cumulative_impact': self.calculate_cumulative_impact(projections),
            'timeline_summary': self.create_timeline_summary(projections)
        }
```

### Executive Summary Template

```markdown
# Executive Summary: SEO Performance Report

**Report Date:** {report_date}
**Analysis Period:** {date_range}
**Website:** {domain}

---

## Overall SEO Health: {health_score}/100 {status_indicator}

**Status:** {health_status}
**Trend:** {trend_direction} {trend_percentage} from previous period

{health_summary_description}

---

## Key Highlights

### 🎯 Major Wins

1. **{win_1_title}**

   - Impact: {win_1_impact}
   - Metric Change: {win_1_metric}

2. **{win_2_title}**

   - Impact: {win_2_impact}
   - Metric Change: {win_2_metric}

3. **{win_3_title}**
   - Impact: {win_3_impact}
   - Metric Change: {win_3_metric}

### ⚠️ Areas of Concern

1. **{loss_1_title}** (Priority: {loss_1_priority})

   - Issue: {loss_1_description}
   - Action Required: {loss_1_action}

2. **{loss_2_title}** (Priority: {loss_2_priority})
   - Issue: {loss_2_description}
   - Action Required: {loss_2_action}

---

## Market & Competitive Intelligence

### Algorithm Updates

{algorithm_impact_summary}

### Competitor Movements

{competitor_changes_summary}

---

## High-Priority Next Actions

### Immediate (This Week)

1. **{priority_action_1}** - Expected Impact: {impact_1}
2. **{priority_action_2}** - Expected Impact: {impact_2}

### Short-Term (This Month)

1. **{priority_action_3}** - Expected Impact: {impact_3}
2. **{priority_action_4}** - Expected Impact: {impact_4}

---

## Projected Outcomes

**Timeline:** {projection_timeline}
**Expected Traffic Increase:** {projected_traffic_increase}
**Expected Ranking Improvements:** {projected_ranking_improvements}
**Confidence Level:** {projection_confidence}

---

## Executive Recommendation

{executive_recommendation_summary}

**Budget Required:** {estimated_budget}
**Resource Allocation:** {resource_requirements}
**Expected ROI:** {expected_roi}
```

---

## 14. Performance Metrics (KPIs) Section

### Purpose & Metrics Framework

Provide clear, benchmarked metrics against goals and previous periods with visual trend representation and contextual annotations for major changes.

### Core KPI Implementation

```python
# Performance Metrics Framework
class PerformanceMetricsAnalyzer:
    def __init__(self, current_data, historical_data, goals=None):
        self.current_data = current_data
        self.historical_data = historical_data
        self.goals = goals or {}
        self.metrics = {}

    def generate_comprehensive_kpis(self):
        """Generate all performance metrics with context"""
        kpis = {
            'organic_traffic': self.analyze_organic_traffic(),
            'keyword_rankings': self.analyze_keyword_rankings(),
            'click_through_rates': self.analyze_ctr_performance(),
            'conversions_revenue': self.analyze_conversions(),
            'engagement_metrics': self.analyze_engagement(),
            'visibility_metrics': self.analyze_visibility(),
            'technical_performance': self.analyze_technical_kpis()
        }

        # Add visualizations and annotations
        for metric_category, data in kpis.items():
            data['visualizations'] = self.create_visualization_config(metric_category, data)
            data['annotations'] = self.add_metric_annotations(metric_category, data)
            data['goal_progress'] = self.calculate_goal_progress(metric_category, data)

        return kpis

    def analyze_organic_traffic(self):
        """Analyze organic traffic metrics"""
        current_traffic = self.current_data.get('organic_traffic', {})
        historical_traffic = self.historical_data.get('organic_traffic', {})

        analysis = {
            'sessions': {
                'current': current_traffic.get('sessions', 0),
                'previous': historical_traffic.get('sessions', 0),
                'change_absolute': 0,
                'change_percentage': 0,
                'trend': []
            },
            'users': {
                'current': current_traffic.get('users', 0),
                'previous': historical_traffic.get('users', 0),
                'change_absolute': 0,
                'change_percentage': 0,
                'trend': []
            },
            'new_users': {
                'current': current_traffic.get('new_users', 0),
                'previous': historical_traffic.get('new_users', 0),
                'change_absolute': 0,
                'change_percentage': 0,
                'trend': []
            },
            'pageviews': {
                'current': current_traffic.get('pageviews', 0),
                'previous': historical_traffic.get('pageviews', 0),
                'change_absolute': 0,
                'change_percentage': 0,
                'trend': []
            }
        }

        # Calculate changes and trends
        for metric, data in analysis.items():
            if data['previous'] > 0:
                data['change_absolute'] = data['current'] - data['previous']
                data['change_percentage'] = ((data['current'] - data['previous']) / data['previous']) * 100
                data['trend'] = self.calculate_trend_direction(data['change_percentage'])

        # Add growth trends over time
        analysis['growth_trends'] = self.calculate_traffic_growth_trends()
        analysis['traffic_sources'] = self.analyze_traffic_sources()
        analysis['device_breakdown'] = self.analyze_device_traffic()

        return analysis

    def analyze_keyword_rankings(self):
        """Analyze keyword ranking performance"""
        rankings = {
            'total_keywords_tracked': 0,
            'keywords_ranking': 0,
            'top_3_positions': 0,
            'top_10_positions': 0,
            'top_20_positions': 0,
            'average_position': 0,
            'visibility_score': 0,
            'position_changes': {
                'improved': [],
                'declined': [],
                'new_rankings': [],
                'lost_rankings': []
            },
            'keyword_distribution': {},
            'intent_performance': {}
        }

        # Analyze current vs previous rankings
        current_keywords = self.current_data.get('keyword_rankings', [])
        previous_keywords = self.historical_data.get('keyword_rankings', [])

        for keyword in current_keywords:
            current_position = keyword.get('position', 100)
            previous_position = self.get_previous_position(keyword['keyword'], previous_keywords)

            # Track position distribution
            if current_position <= 3:
                rankings['top_3_positions'] += 1
            if current_position <= 10:
                rankings['top_10_positions'] += 1
            if current_position <= 20:
                rankings['top_20_positions'] += 1

            # Track changes
            if previous_position:
                position_change = previous_position - current_position
                if position_change > 0:  # Improved
                    rankings['position_changes']['improved'].append({
                        'keyword': keyword['keyword'],
                        'previous_position': previous_position,
                        'current_position': current_position,
                        'improvement': position_change,
                        'search_volume': keyword.get('search_volume', 0)
                    })
                elif position_change < 0:  # Declined
                    rankings['position_changes']['declined'].append({
                        'keyword': keyword['keyword'],
                        'previous_position': previous_position,
                        'current_position': current_position,
                        'decline': abs(position_change),
                        'search_volume': keyword.get('search_volume', 0)
                    })
            else:
                rankings['position_changes']['new_rankings'].append({
                    'keyword': keyword['keyword'],
                    'position': current_position,
                    'search_volume': keyword.get('search_volume', 0)
                })

        # Calculate average position
        total_positions = sum(k.get('position', 100) for k in current_keywords)
        rankings['average_position'] = total_positions / len(current_keywords) if current_keywords else 0
        rankings['total_keywords_tracked'] = len(current_keywords)
        rankings['keywords_ranking'] = sum(1 for k in current_keywords if k.get('position', 100) <= 100)

        # Calculate visibility score (weighted by search volume and position)
        rankings['visibility_score'] = self.calculate_visibility_score(current_keywords)

        return rankings

    def analyze_ctr_performance(self):
        """Analyze click-through rate performance from SERPs"""
        ctr_analysis = {
            'overall_ctr': 0,
            'average_ctr': 0,
            'ctr_by_position': {},
            'ctr_trends': [],
            'underperforming_pages': [],
            'overperforming_pages': [],
            'opportunity_pages': []
        }

        search_console_data = self.current_data.get('search_console', {})

        if search_console_data:
            total_clicks = search_console_data.get('total_clicks', 0)
            total_impressions = search_console_data.get('total_impressions', 0)

            ctr_analysis['overall_ctr'] = (total_clicks / total_impressions * 100) if total_impressions > 0 else 0

            # Analyze CTR by position
            for position in range(1, 21):
                position_data = self.get_position_data(position)
                expected_ctr = self.get_expected_ctr_for_position(position)
                actual_ctr = position_data.get('ctr', 0)

                ctr_analysis['ctr_by_position'][position] = {
                    'actual_ctr': actual_ctr,
                    'expected_ctr': expected_ctr,
                    'variance': actual_ctr - expected_ctr,
                    'clicks': position_data.get('clicks', 0),
                    'impressions': position_data.get('impressions', 0)
                }

            # Identify underperforming pages (high impressions, low CTR)
            pages_data = search_console_data.get('pages', [])
            for page in pages_data:
                if page.get('impressions', 0) > 1000:
                    expected_ctr = self.get_expected_ctr_for_position(page.get('average_position', 10))
                    if page.get('ctr', 0) < expected_ctr * 0.7:  # 30% below expected
                        ctr_analysis['underperforming_pages'].append({
                            'url': page['url'],
                            'impressions': page['impressions'],
                            'clicks': page['clicks'],
                            'ctr': page['ctr'],
                            'expected_ctr': expected_ctr,
                            'opportunity': (expected_ctr - page['ctr']) * page['impressions']
                        })

        return ctr_analysis

    def analyze_conversions(self):
        """Analyze conversions and revenue from organic traffic"""
        conversion_analysis = {
            'total_conversions': 0,
            'organic_conversions': 0,
            'conversion_rate': 0,
            'revenue_total': 0,
            'revenue_organic': 0,
            'revenue_per_session': 0,
            'goal_completions': {},
            'conversion_paths': [],
            'top_converting_keywords': [],
            'top_converting_pages': []
        }

        conversion_data = self.current_data.get('conversions', {})

        if conversion_data:
            organic_sessions = self.current_data.get('organic_traffic', {}).get('sessions', 0)
            conversion_analysis['organic_conversions'] = conversion_data.get('organic_conversions', 0)
            conversion_analysis['conversion_rate'] = (
                (conversion_analysis['organic_conversions'] / organic_sessions * 100)
                if organic_sessions > 0 else 0
            )

            # Revenue analysis
            conversion_analysis['revenue_organic'] = conversion_data.get('organic_revenue', 0)
            conversion_analysis['revenue_per_session'] = (
                conversion_analysis['revenue_organic'] / organic_sessions
                if organic_sessions > 0 else 0
            )

            # Goal completions
            for goal_name, goal_data in conversion_data.get('goals', {}).items():
                conversion_analysis['goal_completions'][goal_name] = {
                    'completions': goal_data.get('completions', 0),
                    'value': goal_data.get('value', 0),
                    'conversion_rate': goal_data.get('conversion_rate', 0)
                }

            # Top converting keywords and pages
            conversion_analysis['top_converting_keywords'] = self.get_top_converting_keywords()
            conversion_analysis['top_converting_pages'] = self.get_top_converting_pages()

        # Calculate change from previous period
        previous_conversions = self.historical_data.get('conversions', {})
        if previous_conversions:
            conversion_analysis['change_from_previous'] = self.calculate_conversion_changes(
                conversion_analysis,
                previous_conversions
            )

        return conversion_analysis

    def analyze_engagement(self):
        """Analyze engagement metrics"""
        engagement = {
            'bounce_rate': 0,
            'average_session_duration': 0,
            'pages_per_session': 0,
            'time_on_page': {},
            'scroll_depth': {},
            'engagement_rate': 0,
            'return_visitor_rate': 0
        }

        engagement_data = self.current_data.get('engagement', {})

        if engagement_data:
            engagement['bounce_rate'] = engagement_data.get('bounce_rate', 0)
            engagement['average_session_duration'] = engagement_data.get('avg_session_duration', 0)
            engagement['pages_per_session'] = engagement_data.get('pages_per_session', 0)

            # Analyze by page type
            engagement['engagement_by_page_type'] = self.analyze_engagement_by_page_type()

            # Analyze by device
            engagement['engagement_by_device'] = self.analyze_engagement_by_device()

            # Calculate engagement score
            engagement['engagement_score'] = self.calculate_engagement_score(engagement)

        return engagement

    def create_visualization_config(self, metric_category, data):
        """Create visualization configuration for charts"""
        visualizations = []

        if metric_category == 'organic_traffic':
            visualizations.append({
                'type': 'line_chart',
                'title': 'Organic Traffic Trend',
                'data_points': data.get('growth_trends', []),
                'x_axis': 'Date',
                'y_axis': 'Sessions',
                'annotations': self.get_traffic_annotations()
            })

            visualizations.append({
                'type': 'bar_chart',
                'title': 'Traffic by Device',
                'data_points': data.get('device_breakdown', {}),
                'x_axis': 'Device Type',
                'y_axis': 'Sessions'
            })

        elif metric_category == 'keyword_rankings':
            visualizations.append({
                'type': 'distribution_chart',
                'title': 'Keyword Position Distribution',
                'data': {
                    'Top 3': data.get('top_3_positions', 0),
                    'Top 10': data.get('top_10_positions', 0),
                    'Top 20': data.get('top_20_positions', 0)
                }
            })

        return visualizations

    def add_metric_annotations(self, metric_category, data):
        """Add contextual annotations for metric changes"""
        annotations = []

        # Check for significant events
        if metric_category == 'organic_traffic':
            traffic_change = data.get('sessions', {}).get('change_percentage', 0)
            if abs(traffic_change) > 20:
                annotations.append({
                    'type': 'significant_change',
                    'message': f'Significant {"increase" if traffic_change > 0 else "decrease"} in organic traffic',
                    'severity': 'high',
                    'action_required': traffic_change < -20
                })

        return annotations
```

### KPI Report Template

```markdown
## Performance Metrics (KPIs)

### Organic Traffic Performance

**Reporting Period:** {date_range}
**Comparison Period:** {comparison_period}

| Metric    | Current   | Previous   | Change   | % Change | Trend   |
| --------- | --------- | ---------- | -------- | -------- | ------- |
| Sessions  | {current} | {previous} | {change} | {pct}%   | {📈/📉} |
| Users     | {current} | {previous} | {change} | {pct}%   | {📈/📉} |
| New Users | {current} | {previous} | {change} | {pct}%   | {📈/📉} |
| Pageviews | {current} | {previous} | {change} | {pct}%   | {📈/📉} |

**Major Traffic Events:**

- {event_date}: {event_description} - Impact: {impact}

[Traffic Trend Chart - 12 Months]

---

### Keyword Rankings & Visibility

**Total Keywords Tracked:** {total_keywords}
**Keywords Ranking (Top 100):** {ranking_keywords}
**Average Position:** {avg_position}
**Visibility Score:** {visibility_score}/100

| Position Range | Count   | Change   | % of Total |
| -------------- | ------- | -------- | ---------- |
| Top 3          | {top3}  | {change} | {pct}%     |
| Top 10         | {top10} | {change} | {pct}%     |
| Top 20         | {top20} | {change} | {pct}%     |

**Ranking Improvements (Top 10):**

1. {keyword} - Position {prev} → {current} (↑{improvement})
2. {keyword} - Position {prev} → {current} (↑{improvement})

**Ranking Declines (Attention Required):**

1. {keyword} - Position {prev} → {current} (↓{decline})

[Position Distribution Chart]

---

### Click-Through Rates (CTR)

**Overall CTR:** {overall_ctr}%
**Previous Period:** {previous_ctr}%
**Change:** {change}% ({direction})

| Position | Actual CTR | Expected CTR | Variance | Opportunity |
| -------- | ---------- | ------------ | -------- | ----------- |
| 1-3      | {actual}%  | {expected}%  | {var}%   | {clicks}    |
| 4-10     | {actual}%  | {expected}%  | {var}%   | {clicks}    |
| 11-20    | {actual}%  | {expected}%  | {var}%   | {clicks}    |

**Underperforming Pages (High Impressions, Low CTR):**

1. {url} - {impressions} impressions, {ctr}% CTR (Expected: {expected}%)
   - Opportunity: ~{opportunity} additional clicks/month

[CTR Performance Chart by Position]

---

### Conversions & Revenue

**Organic Conversions:** {conversions}
**Conversion Rate:** {conversion_rate}%
**Organic Revenue:** ${revenue}
**Revenue Per Session:** ${rps}

| Goal Type | Completions | Value  | Conv Rate | Change |
| --------- | ----------- | ------ | --------- | ------ |
| {goal_1}  | {count}     | ${val} | {rate}%   | {chg}% |
| {goal_2}  | {count}     | ${val} | {rate}%   | {chg}% |

**Top Converting Keywords:**

1. {keyword} - {conversions} conversions, ${revenue}
2. {keyword} - {conversions} conversions, ${revenue}

**Top Converting Pages:**

1. {url} - {conversions} conversions, {conversion_rate}%

[Conversion Funnel Visualization]

---

### Engagement Metrics

| Metric               | Current | Previous | Change | Benchmark |
| -------------------- | ------- | -------- | ------ | --------- |
| Bounce Rate          | {rate}% | {prev}%  | {chg}% | {bench}%  |
| Avg Session Duration | {time}  | {prev}   | {chg}  | {bench}   |
| Pages Per Session    | {pages} | {prev}   | {chg}  | {bench}   |
| Engagement Rate      | {rate}% | {prev}%  | {chg}% | {bench}%  |

**Engagement by Device:**

- Desktop: {rate}% bounce rate, {duration} avg session
- Mobile: {rate}% bounce rate, {duration} avg session
- Tablet: {rate}% bounce rate, {duration} avg session

[Engagement Metrics Comparison Chart]
```

---

## 15. Keyword & Content Analysis Section

### Purpose & Deep Insights

Provide comprehensive analysis of content and keyword performance, including traffic drivers, intent mapping, content gaps, and competitive keyword opportunities.

### Implementation Framework

```python
# Keyword & Content Analysis Framework
class KeywordContentAnalyzer:
    def __init__(self, keyword_data, content_data, competitor_data=None):
        self.keyword_data = keyword_data
        self.content_data = content_data
        self.competitor_data = competitor_data
        self.analysis_results = {}

    def generate_comprehensive_analysis(self):
        """Generate complete keyword and content analysis"""
        analysis = {
            'top_performing_keywords': self.analyze_top_performers(),
            'keyword_opportunities': self.identify_opportunities(),
            'content_performance': self.analyze_content_performance(),
            'content_gaps': self.identify_content_gaps(),
            'intent_analysis': self.analyze_search_intent(),
            'semantic_clusters': self.identify_semantic_clusters(),
            'cannibalization_issues': self.detect_keyword_cannibalization()
        }

        return analysis

    def analyze_top_performers(self):
        """Analyze top-performing keywords"""
        top_keywords = []

        for keyword in self.keyword_data:
            if keyword.get('position', 100) <= 20:  # Focus on ranking keywords
                performance_score = self.calculate_keyword_performance_score(keyword)

                keyword_analysis = {
                    'keyword': keyword['keyword'],
                    'position': keyword.get('position', 100),
                    'search_volume': keyword.get('search_volume', 0),
                    'clicks': keyword.get('clicks', 0),
                    'impressions': keyword.get('impressions', 0),
                    'ctr': keyword.get('ctr', 0),
                    'traffic_value': self.calculate_traffic_value(keyword),
                    'intent': self.classify_search_intent(keyword['keyword']),
                    'ranking_url': keyword.get('url', ''),
                    'performance_score': performance_score,
                    'trend': keyword.get('trend', 'stable'),
                    'opportunity_score': self.calculate_opportunity_score(keyword)
                }

                # Add competitive analysis if available
                if self.competitor_data:
                    keyword_analysis['competitor_positions'] = self.get_competitor_positions(
                        keyword['keyword']
                    )
                    keyword_analysis['serp_features'] = self.analyze_serp_features(keyword['keyword'])

                top_keywords.append(keyword_analysis)

        # Sort by traffic value and performance score
        return sorted(
            top_keywords,
            key=lambda x: (x['traffic_value'] * x['performance_score']),
            reverse=True
        )[:50]

    def identify_opportunities(self):
        """Identify keyword opportunities"""
        opportunities = {
            'page_2_keywords': [],
            'near_top_10': [],
            'high_volume_low_position': [],
            'low_competition_high_value': [],
            'quick_wins': []
        }

        for keyword in self.keyword_data:
            position = keyword.get('position', 100)
            search_volume = keyword.get('search_volume', 0)

            # Keywords on page 2 (positions 11-20)
            if 11 <= position <= 20 and search_volume > 100:
                opportunities['page_2_keywords'].append({
                    'keyword': keyword['keyword'],
                    'current_position': position,
                    'search_volume': search_volume,
                    'potential_traffic': self.estimate_potential_traffic(keyword, target_position=10),
                    'difficulty_score': keyword.get('difficulty', 50),
                    'optimization_effort': self.estimate_optimization_effort(keyword)
                })

            # Near top 10 (positions 11-15)
            if 11 <= position <= 15:
                opportunities['near_top_10'].append({
                    'keyword': keyword['keyword'],
                    'current_position': position,
                    'positions_to_top_10': position - 10,
                    'estimated_effort': 'low',
                    'potential_impact': 'high'
                })

            # High volume but lower position
            if search_volume > 1000 and position > 20:
                opportunities['high_volume_low_position'].append({
                    'keyword': keyword['keyword'],
                    'search_volume': search_volume,
                    'current_position': position,
                    'ranking_url': keyword.get('url', ''),
                    'content_quality_score': self.assess_content_quality(keyword.get('url')),
                    'recommendation': self.generate_keyword_recommendation(keyword)
                })

            # Quick wins (positions 4-10 with potential for top 3)
            if 4 <= position <= 10 and search_volume > 500:
                opportunities['quick_wins'].append({
                    'keyword': keyword['keyword'],
                    'current_position': position,
                    'target_position': 3,
                    'ctr_opportunity': self.calculate_ctr_opportunity(keyword, target_position=3),
                    'optimization_actions': self.suggest_optimization_actions(keyword)
                })

        # Sort each category by opportunity score
        for category in opportunities:
            if opportunities[category]:
                opportunities[category] = sorted(
                    opportunities[category],
                    key=lambda x: self.calculate_opportunity_value(x),
                    reverse=True
                )[:20]

        return opportunities

    def calculate_google_ranking_score(self, keyword, url):
        """Calculate Google ranking score for specific keyword"""
        # This method determines actual Google ranking position
        # Uses multiple data sources for accuracy

        ranking_data = {
            'keyword': keyword,
            'url': url,
            'position': None,
            'page': None,
            'search_engine': 'google',
            'location': 'US',  # Can be parameterized
            'device': 'desktop',
            'ranking_score': 0,
            'visibility_score': 0,
            'serp_features': [],
            'competitors_above': []
        }

        # Method 1: Use available SEO tool API
        if self.has_semrush_api():
            position = self.fetch_semrush_position(keyword, url)
        elif self.has_ahrefs_api():
            position = self.fetch_ahrefs_position(keyword, url)
        elif self.has_google_search_console():
            position = self.fetch_gsc_position(keyword, url)
        else:
            # Method 2: Use curl/wget with Google Search scraping (careful with rate limits)
            position = self.scrape_google_position(keyword, url)

        ranking_data['position'] = position
        ranking_data['page'] = (position // 10) + 1 if position else None

        # Calculate ranking score (0-100 scale)
        if position:
            if position == 1:
                ranking_data['ranking_score'] = 100
            elif position <= 3:
                ranking_data['ranking_score'] = 90 - (position - 1) * 5
            elif position <= 10:
                ranking_data['ranking_score'] = 70 - (position - 3) * 5
            elif position <= 20:
                ranking_data['ranking_score'] = 40 - (position - 10) * 3
            elif position <= 50:
                ranking_data['ranking_score'] = 20 - (position - 20) * 0.5
            else:
                ranking_data['ranking_score'] = max(0, 10 - (position - 50) * 0.1)

        # Calculate visibility score (considers CTR by position)
        ranking_data['visibility_score'] = self.calculate_visibility_score(position)

        return ranking_data

    def scrape_google_position(self, keyword, target_url):
        """Scrape Google search results to find position (fallback method)"""
        import subprocess
        import re
        from urllib.parse import quote

        # URL-encode the keyword
        encoded_keyword = quote(keyword)
        search_url = f"https://www.google.com/search?q={encoded_keyword}&num=100"

        # Use curl with appropriate headers to avoid blocks
        curl_command = [
            'curl', '-s', '-L',
            '-H', 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            '-H', 'Accept-Language: en-US,en;q=0.9',
            search_url
        ]

        try:
            result = subprocess.run(curl_command, capture_output=True, text=True, timeout=30)
            html_content = result.stdout

            # Extract organic result URLs
            # Pattern matches Google search result links
            url_pattern = r'<a href="/url\?q=(https?://[^&]+)&'
            matches = re.findall(url_pattern, html_content)

            # Find position of target URL
            domain = self.extract_domain(target_url)
            for idx, url in enumerate(matches, start=1):
                if domain in url or target_url in url:
                    return idx

            return None  # Not found in top 100

        except subprocess.TimeoutExpired:
            print(f"⚠️ Timeout while checking ranking for '{keyword}'")
            return None
        except Exception as e:
            print(f"⚠️ Error scraping Google position: {e}")
            return None

    def fetch_semrush_position(self, keyword, url):
        """Fetch position from SEMrush API"""
        # Implementation depends on SEMrush API access
        # Returns position or None
        pass

    def fetch_ahrefs_position(self, keyword, url):
        """Fetch position from Ahrefs API"""
        # Implementation depends on Ahrefs API access
        pass

    def fetch_gsc_position(self, keyword, url):
        """Fetch average position from Google Search Console"""
        # Implementation using GSC API
        pass

    def calculate_visibility_score(self, position):
        """Calculate visibility score based on CTR by position"""
        # CTR estimates by position (industry averages)
        ctr_by_position = {
            1: 31.7, 2: 24.7, 3: 18.7, 4: 13.6, 5: 9.5,
            6: 6.3, 7: 4.5, 8: 3.7, 9: 3.1, 10: 2.5,
            11: 2.0, 12: 1.7, 13: 1.5, 14: 1.3, 15: 1.1,
            16: 1.0, 17: 0.9, 18: 0.8, 19: 0.8, 20: 0.7
        }

        if not position or position > 20:
            return 0

        return ctr_by_position.get(position, 0.5)

    def generate_ranking_report_for_keywords(self, keywords):
        """Generate comprehensive ranking report for all target keywords"""
        ranking_report = {
            'summary': {
                'total_keywords': len(keywords),
                'keywords_ranking': 0,
                'keywords_top_3': 0,
                'keywords_top_10': 0,
                'keywords_top_20': 0,
                'keywords_not_ranking': 0,
                'average_position': 0,
                'average_ranking_score': 0,
                'visibility_index': 0
            },
            'keyword_rankings': [],
            'ranking_distribution': {},
            'recommendations': []
        }

        total_position = 0
        total_score = 0
        total_visibility = 0

        for keyword in keywords:
            ranking_data = self.calculate_google_ranking_score(keyword, self.target_url)
            ranking_report['keyword_rankings'].append(ranking_data)

            position = ranking_data['position']
            if position:
                ranking_report['summary']['keywords_ranking'] += 1
                total_position += position
                total_score += ranking_data['ranking_score']
                total_visibility += ranking_data['visibility_score']

                if position <= 3:
                    ranking_report['summary']['keywords_top_3'] += 1
                if position <= 10:
                    ranking_report['summary']['keywords_top_10'] += 1
                if position <= 20:
                    ranking_report['summary']['keywords_top_20'] += 1

                # Track distribution
                page = (position // 10) + 1
                page_key = f"page_{page}"
                ranking_report['ranking_distribution'][page_key] = \
                    ranking_report['ranking_distribution'].get(page_key, 0) + 1
            else:
                ranking_report['summary']['keywords_not_ranking'] += 1

        # Calculate averages
        if ranking_report['summary']['keywords_ranking'] > 0:
            ranking_report['summary']['average_position'] = \
                total_position / ranking_report['summary']['keywords_ranking']
            ranking_report['summary']['average_ranking_score'] = \
                total_score / ranking_report['summary']['keywords_ranking']
            ranking_report['summary']['visibility_index'] = total_visibility

        # Generate recommendations
        ranking_report['recommendations'] = self.generate_ranking_recommendations(
            ranking_report['keyword_rankings']
        )

        return ranking_report

    def analyze_content_performance(self):
        """Analyze content performance across the site"""
        content_analysis = {
            'best_performing': [],
            'worst_performing': [],
            'content_by_type': {},
            'content_by_topic': {},
            'performance_metrics': {}
        }

        for page in self.content_data:
            page_metrics = {
                'url': page['url'],
                'title': page.get('title', ''),
                'word_count': page.get('word_count', 0),
                'organic_traffic': page.get('sessions', 0),
                'conversions': page.get('conversions', 0),
                'bounce_rate': page.get('bounce_rate', 0),
                'avg_time_on_page': page.get('avg_time_on_page', 0),
                'keywords_ranking': len(page.get('ranking_keywords', [])),
                'backlinks': page.get('backlinks', 0),
                'performance_score': self.calculate_page_performance_score(page),
                'content_type': self.classify_content_type(page),
                'topic_category': self.classify_topic_category(page)
            }

            # Categorize content
            content_type = page_metrics['content_type']
            if content_type not in content_analysis['content_by_type']:
                content_analysis['content_by_type'][content_type] = []
            content_analysis['content_by_type'][content_type].append(page_metrics)

            # Best and worst performing
            if page_metrics['performance_score'] > 70:
                content_analysis['best_performing'].append(page_metrics)
            elif page_metrics['performance_score'] < 30 and page_metrics['organic_traffic'] < 10:
                content_analysis['worst_performing'].append(page_metrics)

        # Sort best and worst
        content_analysis['best_performing'] = sorted(
            content_analysis['best_performing'],
            key=lambda x: x['performance_score'],
            reverse=True
        )[:20]

        content_analysis['worst_performing'] = sorted(
            content_analysis['worst_performing'],
            key=lambda x: x['performance_score']
        )[:20]

        return content_analysis

    def identify_content_gaps(self):
        """Identify content gaps and opportunities"""
        content_gaps = {
            'competitor_content': [],
            'keyword_gaps': [],
            'topic_gaps': [],
            'format_gaps': [],
            'intent_gaps': []
        }

        if self.competitor_data:
            # Analyze competitor content
            for competitor in self.competitor_data:
                competitor_keywords = competitor.get('keywords', [])

                for keyword in competitor_keywords:
                    if not self.is_keyword_covered(keyword['keyword']):
                        content_gaps['competitor_content'].append({
                            'keyword': keyword['keyword'],
                            'search_volume': keyword.get('search_volume', 0),
                            'competitor_url': keyword.get('url', ''),
                            'competitor_position': keyword.get('position', 100),
                            'content_angle': self.analyze_content_angle(keyword.get('url')),
                            'priority': self.calculate_gap_priority(keyword)
                        })

            # Identify keyword gaps
            your_keywords = set(k['keyword'] for k in self.keyword_data)
            for competitor in self.competitor_data:
                competitor_keywords = set(k['keyword'] for k in competitor.get('keywords', []))
                keyword_gaps = competitor_keywords - your_keywords

                for keyword in keyword_gaps:
                    keyword_data = self.get_keyword_data(keyword, competitor)
                    if keyword_data.get('search_volume', 0) > 100:
                        content_gaps['keyword_gaps'].append({
                            'keyword': keyword,
                            'search_volume': keyword_data.get('search_volume', 0),
                            'difficulty': keyword_data.get('difficulty', 50),
                            'competitors_ranking': self.count_competitors_ranking(keyword),
                            'recommended_action': 'Create new content targeting this keyword'
                        })

        # Identify topic clusters needing expansion
        content_gaps['topic_gaps'] = self.identify_topic_cluster_gaps()

        # Identify content format opportunities
        content_gaps['format_gaps'] = self.identify_format_opportunities()

        return content_gaps

    def analyze_search_intent(self):
        """Analyze keywords by search intent"""
        intent_analysis = {
            'informational': {'keywords': [], 'traffic': 0, 'conversions': 0},
            'navigational': {'keywords': [], 'traffic': 0, 'conversions': 0},
            'commercial': {'keywords': [], 'traffic': 0, 'conversions': 0},
            'transactional': {'keywords': [], 'traffic': 0, 'conversions': 0}
        }

        for keyword in self.keyword_data:
            intent = self.classify_search_intent(keyword['keyword'])
            intent_category = intent_analysis.get(intent, intent_analysis['informational'])

            intent_category['keywords'].append({
                'keyword': keyword['keyword'],
                'position': keyword.get('position', 100),
                'traffic': keyword.get('clicks', 0),
                'conversions': keyword.get('conversions', 0)
            })

            intent_category['traffic'] += keyword.get('clicks', 0)
            intent_category['conversions'] += keyword.get('conversions', 0)

        # Calculate conversion rates by intent
        for intent, data in intent_analysis.items():
            if data['traffic'] > 0:
                data['conversion_rate'] = (data['conversions'] / data['traffic']) * 100
            else:
                data['conversion_rate'] = 0

        return intent_analysis

    def identify_semantic_clusters(self):
        """Identify semantic keyword clusters and topic relationships"""
        clusters = []

        # Group keywords by semantic similarity
        keyword_groups = self.group_keywords_semantically()

        for cluster_name, keywords in keyword_groups.items():
            cluster_analysis = {
                'cluster_name': cluster_name,
                'keyword_count': len(keywords),
                'total_search_volume': sum(k.get('search_volume', 0) for k in keywords),
                'total_traffic': sum(k.get('clicks', 0) for k in keywords),
                'average_position': sum(k.get('position', 100) for k in keywords) / len(keywords),
                'primary_keywords': self.identify_primary_keywords(keywords),
                'supporting_keywords': self.identify_supporting_keywords(keywords),
                'content_coverage': self.assess_cluster_coverage(keywords),
                'opportunities': self.identify_cluster_opportunities(keywords),
                'pillar_page_url': self.identify_pillar_page(keywords),
                'cluster_health': self.assess_cluster_health(keywords)
            }

            clusters.append(cluster_analysis)

        return sorted(clusters, key=lambda x: x['total_traffic'], reverse=True)

    def detect_keyword_cannibalization(self):
        """Detect keyword cannibalization issues"""
        cannibalization_issues = []

        # Group keywords by exact match
        keyword_urls = {}
        for keyword in self.keyword_data:
            kw = keyword['keyword']
            url = keyword.get('url', '')
            position = keyword.get('position', 100)

            if kw not in keyword_urls:
                keyword_urls[kw] = []
            keyword_urls[kw].append({'url': url, 'position': position})

        # Identify keywords ranking for multiple URLs
        for keyword, urls in keyword_urls.items():
            if len(urls) > 1:
                cannibalization_issues.append({
                    'keyword': keyword,
                    'affected_urls': urls,
                    'severity': self.calculate_cannibalization_severity(urls),
                    'recommended_action': self.suggest_cannibalization_fix(keyword, urls),
                    'primary_url_recommendation': self.recommend_primary_url(urls)
                })

        return sorted(cannibalization_issues, key=lambda x: x['severity'], reverse=True)
```

### Keyword & Content Analysis Report Template

```markdown
## Keyword & Content Analysis

### Top-Performing Keywords

**Traffic Drivers (Top 20 by Value)**

| Keyword   | Position | Volume | Clicks   | Traffic Value | Intent   | Trend   | URL   |
| --------- | -------- | ------ | -------- | ------------- | -------- | ------- | ----- |
| {keyword} | {pos}    | {vol}  | {clicks} | ${value}      | {intent} | {📈/📉} | {url} |

**Key Insights:**

- {insight_1}
- {insight_2}
- {insight_3}

---

### Keyword Opportunities

#### Page 2 Keywords (Positions 11-20)

**High-Priority Keywords Near First Page**

| Keyword   | Position | Volume | Potential Traffic | Effort   | Action   |
| --------- | -------- | ------ | ----------------- | -------- | -------- |
| {keyword} | {pos}    | {vol}  | +{traffic}        | {effort} | {action} |

**Recommended Actions:**

1. {keyword}: {specific_action}
2. {keyword}: {specific_action}

#### Quick Wins (Positions 4-10)

**Keywords Ready for Top 3**

| Keyword   | Current | Target | CTR Opportunity | Actions  |
| --------- | ------- | ------ | --------------- | -------- |
| {keyword} | {pos}   | 3      | +{clicks}/mo    | {action} |

---

### Content Performance Analysis

#### Best-Performing Content

| Page  | Traffic   | Keywords | Conversions | Perf Score  |
| ----- | --------- | -------- | ----------- | ----------- |
| {url} | {traffic} | {kws}    | {convs}     | {score}/100 |

**Success Factors:**

- {factor_1}
- {factor_2}

#### Worst-Performing Content

| Page  | Traffic   | Age   | Issues   | Recommendation |
| ----- | --------- | ----- | -------- | -------------- |
| {url} | {traffic} | {age} | {issues} | {action}       |

**Action Plan:**

- {url}: {action} (Priority: {priority})

---

### Content Gap Analysis

#### Keywords Competitors Rank For (But You Don't)

| Keyword   | Volume | Difficulty | Competitors | Priority   | Recommended Content |
| --------- | ------ | ---------- | ----------- | ---------- | ------------------- |
| {keyword} | {vol}  | {diff}/100 | {count}     | {priority} | {content_type}      |

**Content Creation Opportunities:**

1. **{topic}** - Target keywords: {keywords}
   - Format: {format}
   - Estimated traffic: {traffic}
   - Priority: {priority}

#### Topic Cluster Gaps

**Cluster: {cluster_name}**

- Coverage: {coverage}%
- Missing topics: {topics}
- Recommended pillar page: {suggestion}

---

### Search Intent Analysis

| Intent Type   | Keywords | Traffic   | Conversions | Conv Rate |
| ------------- | -------- | --------- | ----------- | --------- |
| Informational | {count}  | {traffic} | {convs}     | {rate}%   |
| Commercial    | {count}  | {traffic} | {convs}     | {rate}%   |
| Transactional | {count}  | {traffic} | {convs}     | {rate}%   |
| Navigational  | {count}  | {traffic} | {convs}     | {rate}%   |

**Intent Optimization Recommendations:**

- {recommendation_1}
- {recommendation_2}

---

### Semantic Clusters

#### Cluster: {cluster_name}

- **Total Keywords:** {count}
- **Combined Volume:** {volume}
- **Total Traffic:** {traffic}
- **Average Position:** {position}
- **Cluster Health:** {health_score}/100

**Primary Keywords:**

- {keyword_1} (Position {pos})
- {keyword_2} (Position {pos})

**Pillar Page:** {url}
**Supporting Content:** {count} pages

**Opportunities:**

- {opportunity_1}
- {opportunity_2}

---

### Keyword Cannibalization Issues

| Keyword   | Affected URLs | Severity   | Recommended Primary URL |
| --------- | ------------- | ---------- | ----------------------- |
| {keyword} | {count} URLs  | {severity} | {recommended_url}       |

**Resolution Actions:**

1. **{keyword}** - Consolidate to {url}, 301 redirect from {other_urls}
2. **{keyword}** - Differentiate content angle on {url_1} vs {url_2}
```

---

## 16. Technical SEO Health & Prioritized Action Plan

### Purpose & Visual Scorecard

Provide a comprehensive snapshot of site crawlability, performance, and technical health with visual scorecards for non-technical readers and a priority-ordered action table.

### Implementation Framework

```python
# Technical SEO Health Assessment
class TechnicalSEOHealthCheck:
    def __init__(self, site_data):
        self.site_data = site_data
        self.health_scores = {}
        self.priority_actions = []

    def generate_health_assessment(self):
        """Generate complete technical SEO health assessment"""
        assessment = {
            'overall_health_score': 0,
            'indexing_status': self.assess_indexing_health(),
            'core_web_vitals': self.assess_core_web_vitals(),
            'mobile_usability': self.assess_mobile_usability(),
            'crawl_health': self.assess_crawl_health(),
            'structured_data': self.assess_structured_data(),
            'security_https': self.assess_security(),
            'site_architecture': self.assess_site_architecture(),
            'priority_action_table': self.generate_priority_action_table()
        }

        # Calculate overall health score
        assessment['overall_health_score'] = self.calculate_overall_health_score(assessment)

        return assessment

    def assess_indexing_health(self):
        """Assess indexing status and health"""
        indexing_data = self.site_data.get('indexing', {})

        analysis = {
            'pages_indexed': indexing_data.get('indexed_pages', 0),
            'pages_submitted': indexing_data.get('submitted_pages', 0),
            'indexation_rate': 0,
            'blocked_pages': indexing_data.get('blocked_pages', []),
            'noindex_pages': indexing_data.get('noindex_pages', []),
            'excluded_pages': indexing_data.get('excluded_pages', {}),
            'coverage_issues': [],
            'score': 0
        }

        # Calculate indexation rate
        if analysis['pages_submitted'] > 0:
            analysis['indexation_rate'] = (
                analysis['pages_indexed'] / analysis['pages_submitted'] * 100
            )

        # Analyze coverage issues
        excluded_pages = indexing_data.get('excluded_pages', {})
        for reason, count in excluded_pages.items():
            if count > 0:
                analysis['coverage_issues'].append({
                    'issue': reason,
                    'affected_pages': count,
                    'severity': self.assess_coverage_issue_severity(reason, count),
                    'recommendation': self.get_coverage_issue_fix(reason)
                })

        # Calculate indexing health score
        analysis['score'] = self.calculate_indexing_score(analysis)

        return analysis

    def assess_core_web_vitals(self):
        """Assess Core Web Vitals performance"""
        cwv_data = self.site_data.get('core_web_vitals', {})

        vitals = {
            'lcp': {
                'value': cwv_data.get('lcp', 0),
                'status': self.evaluate_lcp(cwv_data.get('lcp', 0)),
                'score': self.score_cwv_metric('lcp', cwv_data.get('lcp', 0)),
                'threshold_good': 2.5,
                'threshold_poor': 4.0,
                'unit': 'seconds'
            },
            'fid': {
                'value': cwv_data.get('fid', 0),
                'status': self.evaluate_fid(cwv_data.get('fid', 0)),
                'score': self.score_cwv_metric('fid', cwv_data.get('fid', 0)),
                'threshold_good': 100,
                'threshold_poor': 300,
                'unit': 'milliseconds'
            },
            'cls': {
                'value': cwv_data.get('cls', 0),
                'status': self.evaluate_cls(cwv_data.get('cls', 0)),
                'score': self.score_cwv_metric('cls', cwv_data.get('cls', 0)),
                'threshold_good': 0.1,
                'threshold_poor': 0.25,
                'unit': 'score'
            },
            'fcp': {
                'value': cwv_data.get('fcp', 0),
                'status': self.evaluate_fcp(cwv_data.get('fcp', 0)),
                'score': self.score_cwv_metric('fcp', cwv_data.get('fcp', 0)),
                'threshold_good': 1.8,
                'threshold_poor': 3.0,
                'unit': 'seconds'
            },
            'inp': {
                'value': cwv_data.get('inp', 0),
                'status': self.evaluate_inp(cwv_data.get('inp', 0)),
                'score': self.score_cwv_metric('inp', cwv_data.get('inp', 0)),
                'threshold_good': 200,
                'threshold_poor': 500,
                'unit': 'milliseconds'
            }
        }

        # Calculate overall Core Web Vitals score
        total_score = sum(v['score'] for v in vitals.values())
        avg_score = total_score / len(vitals)

        # Identify pages with poor performance
        poor_performing_pages = self.identify_poor_cwv_pages(cwv_data)

        return {
            'vitals': vitals,
            'overall_score': round(avg_score, 1),
            'poor_performing_pages': poor_performing_pages,
            'optimization_opportunities': self.identify_cwv_opportunities(vitals)
        }

    def assess_mobile_usability(self):
        """Assess mobile usability and issues"""
        mobile_data = self.site_data.get('mobile', {})

        assessment = {
            'mobile_friendly_pages': mobile_data.get('friendly_pages', 0),
            'total_pages': mobile_data.get('total_pages', 0),
            'mobile_friendly_rate': 0,
            'usability_issues': [],
            'viewport_issues': [],
            'tap_target_issues': [],
            'font_size_issues': [],
            'score': 0
        }

        # Calculate mobile-friendly rate
        if assessment['total_pages'] > 0:
            assessment['mobile_friendly_rate'] = (
                assessment['mobile_friendly_pages'] / assessment['total_pages'] * 100
            )

        # Analyze specific issues
        issues = mobile_data.get('issues', [])
        for issue in issues:
            issue_data = {
                'type': issue.get('type', ''),
                'affected_pages': issue.get('count', 0),
                'severity': issue.get('severity', 'medium'),
                'example_urls': issue.get('examples', [])[:5],
                'fix_guidance': self.get_mobile_issue_fix(issue.get('type'))
            }

            if 'viewport' in issue.get('type', '').lower():
                assessment['viewport_issues'].append(issue_data)
            elif 'tap' in issue.get('type', '').lower():
                assessment['tap_target_issues'].append(issue_data)
            elif 'font' in issue.get('type', '').lower():
                assessment['font_size_issues'].append(issue_data)
            else:
                assessment['usability_issues'].append(issue_data)

        # Calculate mobile usability score
        assessment['score'] = self.calculate_mobile_score(assessment)

        return assessment

    def generate_priority_action_table(self):
        """Generate comprehensive priority action table"""
        actions = []

        # Gather all issues from different assessments
        actions.extend(self.extract_indexing_actions())
        actions.extend(self.extract_cwv_actions())
        actions.extend(self.extract_mobile_actions())
        actions.extend(self.extract_crawl_actions())
        actions.extend(self.extract_structured_data_actions())
        actions.extend(self.extract_content_actions())
        actions.extend(self.extract_technical_actions())

        # Calculate priority score for each action
        for action in actions:
            action['priority_score'] = self.calculate_priority_score(
                impact=action['impact_score'],
                effort=action['effort_score'],
                urgency=action['urgency_score']
            )

        # Sort by priority score (highest first)
        sorted_actions = sorted(
            actions,
            key=lambda x: x['priority_score'],
            reverse=True
        )

        # Add priority ranking
        for idx, action in enumerate(sorted_actions, 1):
            action['priority_rank'] = idx
            action['priority_level'] = self.determine_priority_level(action['priority_score'])

        return sorted_actions

    def calculate_priority_score(self, impact, effort, urgency):
        """Calculate priority score using weighted formula"""
        # Priority Score = (Impact * 0.5) + ((10 - Effort) * 0.3) + (Urgency * 0.2)
        # Higher score = higher priority
        return (impact * 0.5) + ((10 - effort) * 0.3) + (urgency * 0.2)

    def determine_priority_level(self, score):
        """Determine priority level from score"""
        if score >= 8.0:
            return 'Critical'
        elif score >= 6.0:
            return 'High'
        elif score >= 4.0:
            return 'Medium'
        else:
            return 'Low'

    def create_action_item(self, category, location, issue, action, impact_score,
                           effort_score, urgency_score, expected_impact):
        """Create standardized action item"""
        return {
            'category': category,
            'location': location,
            'issue_description': issue,
            'recommended_action': action,
            'impact_score': impact_score,  # 1-10 scale
            'effort_score': effort_score,  # 1-10 scale (1=easy, 10=hard)
            'urgency_score': urgency_score,  # 1-10 scale
            'expected_impact': expected_impact,
            'completed': False,
            'priority_score': 0,  # Calculated later
            'priority_rank': 0,  # Assigned later
            'priority_level': ''  # Assigned later
        }
```

### Priority Action Table Template

```markdown
## Technical SEO Health Report

### Overall Health Score: {score}/100 {status_indicator}

**Status:** {status_description}

| Category         | Score       | Status     |
| ---------------- | ----------- | ---------- |
| Indexing         | {score}/100 | {🟢/🟡/🔴} |
| Core Web Vitals  | {score}/100 | {🟢/🟡/🔴} |
| Mobile Usability | {score}/100 | {🟢/🟡/🔴} |
| Crawl Health     | {score}/100 | {🟢/🟡/🔴} |
| Structured Data  | {score}/100 | {🟢/🟡/🔴} |
| HTTPS/Security   | {score}/100 | {🟢/🟡/🔴} |

---

### Indexing Status

**Pages Indexed:** {indexed}/{submitted} ({indexation_rate}%)

| Status   | Count   | Percentage |
| -------- | ------- | ---------- |
| Indexed  | {count} | {pct}%     |
| Excluded | {count} | {pct}%     |
| Error    | {count} | {pct}%     |

**Coverage Issues:**

- {issue_type}: {count} pages - {severity}
  - Recommendation: {fix}

---

### Core Web Vitals

| Metric                          | Value     | Status     | Threshold | Score       |
| ------------------------------- | --------- | ---------- | --------- | ----------- |
| LCP (Largest Contentful Paint)  | {value}s  | {🟢/🟡/🔴} | < 2.5s    | {score}/100 |
| INP (Interaction to Next Paint) | {value}ms | {🟢/🟡/🔴} | < 200ms   | {score}/100 |
| CLS (Cumulative Layout Shift)   | {value}   | {🟢/🟡/🔴} | < 0.1     | {score}/100 |

**Pages with Poor Performance:**

- {url} - LCP: {value}s, INP: {value}ms
  - Issues: {issues}
  - Fix: {recommendations}

---

### Mobile Usability

**Mobile-Friendly:** {friendly_pages}/{total_pages} ({rate}%)

**Issues Found:**

- Viewport not configured: {count} pages
- Text too small: {count} pages
- Tap targets too close: {count} pages

---

### Crawl Errors & Broken Links

**Total Crawl Errors:** {count}

| Error Type       | Count   | Priority |
| ---------------- | ------- | -------- |
| 404 Not Found    | {count} | High     |
| 500 Server Error | {count} | Critical |
| Redirect Chains  | {count} | Medium   |

---

### Structured Data

**Implementation Score:** {score}/100

| Schema Type  | Pages   | Valid   | Errors   | Warnings   |
| ------------ | ------- | ------- | -------- | ---------- |
| Product      | {count} | {valid} | {errors} | {warnings} |
| Article      | {count} | {valid} | {errors} | {warnings} |
| Organization | {count} | {valid} | {errors} | {warnings} |

---

## PRIORITY ACTION TABLE

**Total Actions:** {total_count}
**Critical:** {critical_count} | **High:** {high_count} | **Medium:** {medium_count} | **Low:** {low_count}

| Priority     | Location                | Issue Description                                            | Recommended Action                                                                     | Impact (1-10) | Effort (1-10) | Expected Impact                                                     | Status |
| ------------ | ----------------------- | ------------------------------------------------------------ | -------------------------------------------------------------------------------------- | ------------- | ------------- | ------------------------------------------------------------------- | ------ |
| **Critical** | {location}              | {issue_description}                                          | {recommended_action}                                                                   | {impact}      | {effort}      | {expected_impact}                                                   | ☐      |
| **Critical** | Core Web Vitals - LCP   | Homepage LCP is 4.2s (Poor - threshold 2.5s)                 | Optimize largest image, implement lazy loading, reduce server response time            | 9             | 6             | Potential 30% bounce rate improvement, better Core Web Vitals score | ☐      |
| **Critical** | Mobile Usability        | 45 pages missing viewport meta tag                           | Add `<meta name="viewport" content="width=device-width, initial-scale=1">` to template | 9             | 2             | Full mobile-friendly status, improved mobile rankings               | ☐      |
| **High**     | Indexing - Coverage     | 127 pages excluded due to "Crawled - currently not indexed"  | Improve page quality, add internal links, enhance content depth                        | 8             | 7             | Additional ~15% indexed pages, increased organic visibility         | ☐      |
| **High**     | Structured Data         | Product schema missing 'aggregateRating' on 23 product pages | Implement review schema with rating data                                               | 8             | 4             | Rich snippets in SERPs, potential 20% CTR increase                  | ☐      |
| **High**     | Site Architecture       | Orphaned pages: 34 pages with zero internal links            | Create hub pages, add internal linking structure                                       | 7             | 5             | Better crawl efficiency, improved page authority distribution       | ☐      |
| **High**     | Technical - Crawl       | Redirect chains detected on 18 URLs (3+ hops)                | Update redirects to point directly to final destination                                | 7             | 3             | Faster page load, reduced crawl budget waste                        | ☐      |
| **Medium**   | Core Web Vitals - CLS   | Blog template has CLS of 0.18 (Poor - threshold 0.1)         | Reserve space for ads, set image dimensions, avoid late-loading content                | 6             | 5             | Improved user experience, better Core Web Vitals score              | ☐      |
| **Medium**   | Mobile Usability        | Tap targets too close on navigation menu (12 pages)          | Increase button padding to minimum 48x48px                                             | 6             | 2             | Better mobile UX, reduced mobile bounce rate                        | ☐      |
| **Medium**   | Technical - XML Sitemap | Sitemap contains 456 URLs but only 312 are indexed           | Remove non-indexable pages from sitemap, submit updated version                        | 5             | 2             | Cleaner crawl signals, better index management                      | ☐      |
| **Medium**   | Content - Thin Content  | 28 pages with <300 words identified                          | Expand content to 800+ words, add relevant keywords, improve depth                     | 6             | 8             | Better rankings for expanded pages, improved E-E-A-T                | ☐      |
| **Low**      | Technical - robots.txt  | robots.txt blocking CSS and JS files                         | Update robots.txt to allow Googlebot access to static resources                        | 4             | 1             | Better page rendering for Google, minor ranking impact              | ☐      |
| **Low**      | Structured Data         | Breadcrumb schema has warnings (non-critical)                | Fix breadcrumb position values to sequential integers                                  | 3             | 2             | Cleaner structured data, potential breadcrumb display in SERPs      | ☐      |

---

### Action Plan Summary by Priority

#### Critical Priority (Complete Within 1 Week)

**Count:** {critical_count}
**Estimated Total Effort:** {hours} hours
**Expected Combined Impact:** {impact_description}

1. {action_1}
2. {action_2}
3. {action_3}

#### High Priority (Complete Within 1 Month)

**Count:** {high_count}
**Estimated Total Effort:** {hours} hours
**Expected Combined Impact:** {impact_description}

1. {action_1}
2. {action_2}
3. {action_3}

#### Medium Priority (Complete Within 3 Months)

**Count:** {medium_count}

#### Low Priority (Complete Within 6 Months)

**Count:** {low_count}

---

### Resource Requirements

**Total Estimated Hours:** {hours}
**Recommended Team:**

- Developer: {hours} hours
- SEO Specialist: {hours} hours
- Content Writer: {hours} hours

**Estimated Budget:** ${budget}
**Expected ROI:** {roi_percentage}% over {timeframe}
```
