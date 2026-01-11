# Comprehensive initial audit
python3 crawl_site.py https://newclient.com --max-pages 200 --max-depth 4
python3 analyze_pages.py ./cache/newclient --format both --output ./audits/newclient-initial-audit.csv

# Review CRITICAL and HIGH priority pages first
# Create action plan sorted by priority and impact