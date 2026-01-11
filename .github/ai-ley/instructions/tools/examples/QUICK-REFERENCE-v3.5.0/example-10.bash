# Validate staging site before going live
python3 crawl_site.py https://staging.example.com --max-pages 500
python3 analyze_pages.py ./cache/staging --format csv

# Goal: Zero CRITICAL issues
# Target: Average score > 80