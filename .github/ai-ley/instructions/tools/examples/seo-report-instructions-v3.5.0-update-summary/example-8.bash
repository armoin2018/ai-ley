# Step 1: Install dependencies (one-time setup)
pip install requests beautifulsoup4 lxml

# Step 2: Crawl website
cd .ai-ley/shared/instructions/tools/seo
python3 crawl_site.py https://example.com --max-pages 100 --max-depth 3

# Output location:
# .project/seo/example.com/2025.10.03/cache/

# Step 3: Analyze cached pages
python3 analyze_pages.py .project/seo/example.com/2025.10.03/cache --format both

# Outputs:
# - .project/seo/example.com/2025.10.03/page-analysis.csv
# - .project/seo/example.com/2025.10.03/page-analysis.json

# Step 4: Review results
# Option A: Open CSV in Excel/Google Sheets
# Option B: Parse JSON programmatically