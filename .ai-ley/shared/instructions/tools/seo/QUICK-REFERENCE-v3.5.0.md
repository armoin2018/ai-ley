# SEO Report v3.5.0 - Quick Reference Card

## 🚀 What's New in v3.5.0

### Website Crawler

**Problem Solved**: Need to analyze entire websites, not just single pages  
**Solution**: Polite website crawler with robots.txt compliance and caching

```bash
# Basic Crawl (100 pages, depth 3)
python3 crawl_site.py https://example.com

# Custom Configuration
python3 crawl_site.py https://example.com --max-pages 50 --max-depth 2 --delay 1.0

# Output Location
.project/seo/{domain}/{YYYY.MM.DD}/cache/
```

### Per-Page Analyzer

**Feature**: Detailed SEO scoring for every crawled page  
**Scoring**: 7 categories with weighted overall score (0-100)

```bash
# Analyze Cached Pages (CSV output)
python3 analyze_pages.py ./cache/example

# JSON Output
python3 analyze_pages.py ./cache/example --format json

# Both Formats
python3 analyze_pages.py ./cache/example --format both
```

**Priority Levels**:

- 🔴 **CRITICAL** (Score < 50): Immediate action required
- 🟡 **HIGH** (Score 50-69): Address within 1-2 weeks
- 🔵 **MEDIUM** (Score 70-84): Optimize within 30 days
- 🟢 **LOW** (Score 85-100): Minor optimizations

---

## 📁 Enhanced File Structure

```
.project/seo/{domain}/{YYYY.MM.DD}/
├── seo-audit-report.html          # Interactive dashboard
├── technical-analysis.json         # Structured data
├── seo-audit-summary.md           # Executive summary
├── seo-analysis.md                # Detailed analysis
├── recommendations.csv            # Action plan
├── serve_report.py                # Development server
├── README.md                      # Usage instructions
├── page-analysis.csv              # Per-page SEO scores (NEW)
├── page-analysis.json             # Per-page data (NEW)
└── cache/                         # Crawled page data (NEW)
    ├── pages/                     # Individual page JSON files
    │   ├── a1b2c3d4e5f6.json
    │   └── ...
    ├── metadata/                  # Response metadata
    │   ├── a1b2c3d4e5f6.json
    │   └── ...
    └── crawl_summary.json         # Crawl statistics
```

---

## 🕷️ Crawler Features

### Configuration Options

| Parameter      | Default | Description                      |
| -------------- | ------- | -------------------------------- |
| `--max-pages`  | 100     | Maximum pages to crawl           |
| `--max-depth`  | 3       | Maximum link depth               |
| `--delay`      | 1.0     | Delay between requests (seconds) |
| `--output-dir` | Auto    | Custom cache directory           |

### What Gets Extracted

- ✅ Title tag + length
- ✅ Meta description + length
- ✅ All heading levels (H1-H6)
- ✅ Full text content + word count
- ✅ Internal links (URL, anchor text, title)
- ✅ External links
- ✅ Images (src, alt, title, dimensions)
- ✅ Open Graph metadata
- ✅ Twitter Card tags
- ✅ Schema.org structured data
- ✅ Response time + status code

### Ethical Crawling

- ✅ Respects robots.txt automatically
- ✅ Rate limiting (1s default between requests)
- ✅ Proper User-Agent identification
- ✅ Same-domain restriction (no external crawling)
- ✅ Graceful handling of failures

---

## 📊 Per-Page Analysis Scoring

### Seven Analysis Categories

1. **Title Tag** (20% weight)

   - Length: 30-60 characters optimal
   - Keyword positioning
   - Uniqueness
   - Scores: 0-100

2. **Meta Description** (15% weight)

   - Length: 120-158 characters optimal
   - Call-to-action presence
   - Compelling copy
   - Scores: 0-100

3. **Headings** (15% weight)

   - Single H1 required
   - Proper hierarchy (no skipping levels)
   - Descriptive text
   - Scores: 0-100

4. **Content** (25% weight - highest!)

   - Minimum: 300 words
   - Ideal: 1000+ words
   - Readability
   - Uniqueness
   - Scores: 0-100

5. **Links** (15% weight)

   - Internal links: 3-100 optimal
   - Anchor text quality
   - External link presence
   - Scores: 0-100

6. **Images** (5% weight)

   - Alt tag presence (critical)
   - Image count appropriateness
   - Optimization flags
   - Scores: 0-100

7. **Schema** (5% weight)
   - Schema.org markup
   - Open Graph tags
   - Twitter Card tags
   - Scores: 0-100

### Overall Score Formula

```
Overall = (Title×0.20) + (Meta×0.15) + (Headings×0.15) +
          (Content×0.25) + (Links×0.15) + (Images×0.05) + (Schema×0.05)
```

---

## 🔄 Complete Workflow

### Step 1: Crawl Website

```bash
cd /Users/blainemcdonnell/git/ai-ley/.ai-ley/shared/instructions/tools/seo
python3 crawl_site.py https://example.com --max-pages 100 --max-depth 3
```

**Output**: `.project/seo/example.com/2025.10.03/cache/`

**What Happens**:

1. Loads robots.txt
2. Starts from homepage
3. Extracts content + metadata
4. Follows internal links up to depth 3
5. Saves JSON files to cache
6. Displays progress with color-coded output

### Step 2: Analyze Pages

```bash
python3 analyze_pages.py .project/seo/example.com/2025.10.03/cache --format both
```

**Output**:

- `page-analysis.csv` - Spreadsheet format
- `page-analysis.json` - Automation format

**What Happens**:

1. Reads all cached JSON files
2. Scores each page across 7 categories
3. Identifies specific issues
4. Assigns priority (CRITICAL/HIGH/MEDIUM/LOW)
5. Generates site-wide statistics
6. Exports to CSV and/or JSON

### Step 3: Review Results

**In Excel/Google Sheets**:

1. Open `page-analysis.csv`
2. Sort by "Priority" column (CRITICAL first)
3. Filter by specific scores (e.g., Title Score < 70)
4. Create action plan from "All Issues" column

**Programmatically**:

1. Load `page-analysis.json`
2. Parse with Python/Node.js/etc.
3. Integrate with existing dashboards
4. Automate reporting workflows

---

## 📈 CSV Output Format

```csv
URL,Overall Score,Priority,Title Score,Meta Desc Score,Headings Score,Content Score,Links Score,Images Score,Schema Score,Title Length,Meta Desc Length,Word Count,Internal Links,External Links,Images,Missing Alt Tags,H1 Count,Response Time (s),All Issues

https://example.com/,72,MEDIUM,85,65,90,60,80,75,40,42,135,1250,45,8,15,2,1,0.85,[META_DESCRIPTION] No CTA | [SCHEMA] No schema

https://example.com/about,45,CRITICAL,30,50,40,55,70,60,30,18,98,450,12,3,8,0,2,1.2,[TITLE] Too short | [HEADINGS] Multiple H1s | [CONTENT] Thin content
```

**Key Columns**:

- **Overall Score**: 0-100 combined score
- **Priority**: CRITICAL/HIGH/MEDIUM/LOW
- **Individual Scores**: Each category 0-100
- **Metadata**: Word count, link counts, image stats
- **All Issues**: Pipe-separated list of specific problems

---

## 🎯 Use Cases

### Use Case 1: New Client Audit

```bash
# Initial comprehensive audit
python3 crawl_site.py https://newclient.com --max-pages 200 --max-depth 4
python3 analyze_pages.py ./cache/newclient --format both

# Focus: Fix all CRITICAL issues first
# Deliverable: CSV sorted by priority
```

### Use Case 2: Monthly Monitoring

```bash
# Track progress over time
python3 crawl_site.py https://example.com --output-dir ./cache/example-2025-10
python3 analyze_pages.py ./cache/example-2025-10 --format json

# Compare: example-2025-09.json vs example-2025-10.json
# Metric: Average score improvement month-over-month
```

### Use Case 3: Pre-Launch QA

```bash
# Validate staging site before going live
python3 crawl_site.py https://staging.example.com --max-pages 500
python3 analyze_pages.py ./cache/staging --format csv

# Goal: Zero CRITICAL issues
# Target: Average score > 80
```

### Use Case 4: Competitive Analysis

```bash
# Benchmark against competitor (ethically)
python3 crawl_site.py https://competitor.com --delay 2.0 --max-pages 50
python3 analyze_pages.py ./cache/competitor --format json

# Compare: Content length, internal linking patterns, schema usage
# Identify: Content gaps and opportunities
```

---

## 🐛 Troubleshooting

### Crawler Issues

**"No specialized SEO tools detected"**

```bash
# Install dependencies
pip install requests beautifulsoup4 lxml
```

**"robots.txt blocking crawl"**

- Check https://example.com/robots.txt
- Verify User-Agent not disallowed
- Request permission from site owner

**"Timeout errors"**

```bash
# Increase delay between requests
python3 crawl_site.py https://example.com --delay 2.0
```

### Analyzer Issues

**"Cache directory not found"**

- Verify crawl completed successfully
- Check path to cache directory
- Review crawl_summary.json for errors

**"Missing page data"**

- Re-run crawler for failed URLs
- Check pages_failed array in summary
- Verify pages returned HTML (not PDF, images)

---

## 📝 Sample Analysis Output

### Console Output (Analyzer)

```
============================================================
Per-Page SEO Analysis
============================================================

Analyzing:
  • Cache Directory: ./cache/example
  • Total Pages: 87

[1/87] Score: 72/100 Priority: MEDIUM - https://example.com/
[2/87] Score: 45/100 Priority: CRITICAL - https://example.com/about
[3/87] Score: 88/100 Priority: LOW - https://example.com/contact
...

============================================================
Analysis Complete!
============================================================

Overall Statistics:
  • Average Score: 67.3/100
  • Highest Score: 92
  • Lowest Score: 31

Priority Distribution:
  • CRITICAL: 12 pages
  • HIGH: 23 pages
  • MEDIUM: 38 pages
  • LOW: 14 pages

Top 5 Common Issues:
  • (42 pages) No schema.org structured data found
  • (31 pages) Meta description too short
  • (28 pages) Content below ideal length
  • (19 pages) Few internal links
  • (15 pages) Images missing alt text
```

---

## ✅ Quick Checklist

### Before Crawling:

- [ ] Install dependencies: `pip install requests beautifulsoup4 lxml`
- [ ] Verify site is accessible
- [ ] Check robots.txt allows crawling
- [ ] Determine appropriate max-pages and max-depth
- [ ] Set ethical delay (1.0s minimum for production sites)

### During Crawling:

- [ ] Monitor console output for errors
- [ ] Verify pages being discovered
- [ ] Watch for failed URLs
- [ ] Ensure rate limiting is working

### After Crawling:

- [ ] Review crawl_summary.json statistics
- [ ] Check pages_crawled count
- [ ] Inspect failed_urls if any
- [ ] Verify cache directory structure

### Before Analysis:

- [ ] Confirm cache directory exists
- [ ] Check pages/ subfolder has JSON files
- [ ] Review one sample JSON file for completeness

### After Analysis:

- [ ] Open CSV in spreadsheet software
- [ ] Sort by Priority column
- [ ] Review CRITICAL pages first
- [ ] Check "All Issues" column for specific problems
- [ ] Create prioritized fix list

---

## 📚 Documentation References

**Full Instructions**: `seo-report.instructions.md` Section 4  
**Change Log**: `CHANGES.md` Phase 6  
**Update Summary**: `seo-report-instructions-v3.5.0-update-summary.md` (pending)

**Script Locations**:

- Crawler: `.ai-ley/shared/instructions/tools/seo/crawl_site.py`
- Analyzer: `.ai-ley/shared/instructions/tools/seo/analyze_pages.py`

---

## 📊 Version Comparison

| Feature                | v3.4.0 | v3.5.0 |
| ---------------------- | ------ | ------ |
| Python Server          | ✅     | ✅     |
| Markdown Viewer        | ✅     | ✅     |
| Website Crawler        | ❌     | ✅ NEW |
| Per-Page Analysis      | ❌     | ✅ NEW |
| Multi-Category Scoring | ❌     | ✅ NEW |
| Priority Assignment    | ❌     | ✅ NEW |
| CSV Export             | ❌     | ✅ NEW |
| JSON Export            | ❌     | ✅ NEW |
| Cache Management       | ❌     | ✅ NEW |
| robots.txt Compliance  | ❌     | ✅ NEW |

---

## 📈 Version History

| Version | Date       | Changes                         | Lines |
| ------- | ---------- | ------------------------------- | ----- |
| 3.1.0   | 2025-10-03 | SEO Savant persona integration  | 2,516 |
| 3.2.0   | 2025-10-03 | HTML report requirement         | 2,762 |
| 3.3.0   | 2025-01-08 | Tool detection + ranking scores | 3,450 |
| 3.4.0   | 2025-10-03 | Python server + MD viewer       | 4,207 |
| 3.5.0   | 2025-10-03 | **Crawler + per-page analysis** | 4,890 |

**Growth**: 4,207 → 4,890 lines (+683 / +16%)  
**MD5 Checksum**: `015eba67c6dc5f00f558ed80a8e6cbd2`

---

## 🎓 Best Practices

### Crawling Ethics

1. **Respect robots.txt** - Always honor site rules
2. **Rate limit appropriately** - 1-2 seconds minimum for production
3. **Identify yourself** - Proper User-Agent string
4. **Limit scope** - Don't crawl more than necessary
5. **Get permission** - For sites you don't own/control

### Analysis Workflow

1. **Fix CRITICAL first** - Biggest SEO impact
2. **Batch similar issues** - Efficient bulk updates
3. **Track progress** - Re-analyze after fixes
4. **Focus on high-traffic** - Prioritize important pages
5. **Monitor trends** - Monthly crawls for progress tracking

### Performance Tips

1. **Cache wisely** - No need to re-crawl for re-analysis
2. **Filter intelligently** - Focus on pages that matter
3. **Export formats** - CSV for humans, JSON for automation
4. **Archive crawls** - Keep historical data for comparison
5. **Optimize settings** - Adjust max-pages and depth based on site size

---

**Version**: 3.5.0  
**Date**: October 3, 2025  
**Author**: AI-LEY  
**License**: Proprietary  
**MD5**: 015eba67c6dc5f00f558ed80a8e6cbd2
