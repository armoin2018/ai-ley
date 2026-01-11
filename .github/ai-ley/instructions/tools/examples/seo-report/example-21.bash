# Monthly crawl for progress tracking
python3 crawl_site.py https://example.com --output-dir ./cache/example-$(date +%Y-%m)
python3 analyze_pages.py ./cache/example-$(date +%Y-%m) --format json

# Compare JSON files month-over-month to track improvements
# Identify new issues or regressions