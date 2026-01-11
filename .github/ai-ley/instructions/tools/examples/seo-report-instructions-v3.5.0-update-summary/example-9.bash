# October crawl
python3 crawl_site.py https://example.com --output-dir ./cache/example-2025-10
python3 analyze_pages.py ./cache/example-2025-10 --format json --output october.json

# November crawl
python3 crawl_site.py https://example.com --output-dir ./cache/example-2025-11
python3 analyze_pages.py ./cache/example-2025-11 --format json --output november.json

# Compare month-over-month
# Parse both JSON files, compare average scores, identify improvements