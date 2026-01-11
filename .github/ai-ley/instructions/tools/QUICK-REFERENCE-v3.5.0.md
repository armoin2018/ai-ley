---
name: 'QUICK-REFERENCE-v3.5.0'
description: 'See [example-1](./examples/QUICK-REFERENCE-v3.5.0/example-1.'
keywords: [audit, categories, after, before, (analyzer), analyzer, analysis:, analyze, analysis, cases]
---



# SEO Report v3.5.0 - Quick Reference Card

## 🚀 What's New in v3.5.0

### Website Crawler

**Problem Solved**: Need to analyze entire websites, not just single pages  
**Solution**: Polite website crawler with robots.txt compliance and caching

See [example-1](./examples/QUICK-REFERENCE-v3.5.0/example-1.bash)

### Per-Page Analyzer

**Feature**: Detailed SEO scoring for every crawled page  
**Scoring**: 7 categories with weighted overall score (0-100)

See [example-2](./examples/QUICK-REFERENCE-v3.5.0/example-2.bash)

**Priority Levels**:

- 🔴 **CRITICAL** (Score < 50): Immediate action required
- 🟡 **HIGH** (Score 50-69): Address within 1-2 weeks
- 🔵 **MEDIUM** (Score 70-84): Optimize within 30 days
- 🟢 **LOW** (Score 85-100): Minor optimizations

---

## 📁 Enhanced File Structure

See [example-3](./examples/QUICK-REFERENCE-v3.5.0/example-3.txt)

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

    
2. **Meta Description** (15% weight)

    
3. **Headings** (15% weight)

    
4. **Content** (25% weight - highest!)

     
5. **Links** (15% weight)

    
6. **Images** (5% weight)

    
7. **Schema** (5% weight)
    
### Overall Score Formula

See [example-4](./examples/QUICK-REFERENCE-v3.5.0/example-4.txt)

---

## 🔄 Complete Workflow

### Step 1: Crawl Website

See [example-5](./examples/QUICK-REFERENCE-v3.5.0/example-5.bash)

**Output**: `.project/seo/example.com/2025.10.03/cache/`

**What Happens**:

1. Loads robots.txt
2. Starts from homepage
3. Extracts content + metadata
4. Follows internal links up to depth 3
5. Saves JSON files to cache
6. Displays progress with color-coded output

### Step 2: Analyze Pages

See [example-6](./examples/QUICK-REFERENCE-v3.5.0/example-6.bash)

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

See [example-7](./examples/QUICK-REFERENCE-v3.5.0/example-7.csv)

**Key Columns**:

- **Overall Score**: 0-100 combined score
- **Priority**: CRITICAL/HIGH/MEDIUM/LOW
- **Individual Scores**: Each category 0-100
- **Metadata**: Word count, link counts, image stats
- **All Issues**: Pipe-separated list of specific problems

---

## 🎯 Use Cases

### Use Case 1: New Client Audit

See [example-8](./examples/QUICK-REFERENCE-v3.5.0/example-8.bash)

### Use Case 2: Monthly Monitoring

See [example-9](./examples/QUICK-REFERENCE-v3.5.0/example-9.bash)

### Use Case 3: Pre-Launch QA

See [example-10](./examples/QUICK-REFERENCE-v3.5.0/example-10.bash)

### Use Case 4: Competitive Analysis

See [example-11](./examples/QUICK-REFERENCE-v3.5.0/example-11.bash)

---

## 🐛 Troubleshooting

### Crawler Issues

**"No specialized SEO tools detected"**

See [example-12](./examples/QUICK-REFERENCE-v3.5.0/example-12.bash)

**"robots.txt blocking crawl"**

- Check https://example.com/robots.txt
- Verify User-Agent not disallowed
- Request permission from site owner

**"Timeout errors"**

See [example-13](./examples/QUICK-REFERENCE-v3.5.0/example-13.bash)

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

See [example-14](./examples/QUICK-REFERENCE-v3.5.0/example-14.txt)

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

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
