# Benchmark against competitor (ethically)
python3 crawl_site.py https://competitor.com --delay 2.0 --max-pages 50
python3 analyze_pages.py ./cache/competitor --format json

# Compare: Content length, internal linking patterns, schema usage
# Identify: Content gaps and opportunities