# Your site
python3 crawl_site.py https://yoursite.com --max-pages 50
python3 analyze_pages.py ./cache/yoursite --output yoursite-analysis.json

# Competitor site (ethical crawling with longer delay)
python3 crawl_site.py https://competitor.com --max-pages 50 --delay 2.0
python3 analyze_pages.py ./cache/competitor --output competitor-analysis.json

# Compare: content length, internal linking, schema usage, etc.