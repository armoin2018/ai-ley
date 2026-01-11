# Step 1: Crawl the website
python3 crawl_site.py https://example.com --max-pages 100 --max-depth 3

# Output: .project/seo/example.com/2025.10.03/cache/

# Step 2: Analyze all crawled pages
python3 analyze_pages.py .project/seo/example.com/2025.10.03/cache --format both

# Output:
#   - .project/seo/example.com/2025.10.03/page-analysis.csv
#   - .project/seo/example.com/2025.10.03/page-analysis.json

# Step 3: Review results
# - Open CSV in Excel/Google Sheets for spreadsheet view
# - Use JSON for automated processing or custom reporting
# - Filter by priority to focus on high-impact fixes first