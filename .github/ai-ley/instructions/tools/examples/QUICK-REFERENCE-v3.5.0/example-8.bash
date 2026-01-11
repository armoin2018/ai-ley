# Initial comprehensive audit
python3 crawl_site.py https://newclient.com --max-pages 200 --max-depth 4
python3 analyze_pages.py ./cache/newclient --format both

# Focus: Fix all CRITICAL issues first
# Deliverable: CSV sorted by priority