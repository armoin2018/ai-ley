# Track progress over time
python3 crawl_site.py https://example.com --output-dir ./cache/example-2025-10
python3 analyze_pages.py ./cache/example-2025-10 --format json

# Compare: example-2025-09.json vs example-2025-10.json
# Metric: Average score improvement month-over-month