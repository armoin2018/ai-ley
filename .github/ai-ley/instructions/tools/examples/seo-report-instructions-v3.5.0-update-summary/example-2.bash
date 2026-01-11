# Basic crawl with defaults
python3 crawl_site.py https://example.com

# Custom configuration for large site
python3 crawl_site.py https://example.com --max-pages 200 --max-depth 4

# Faster crawling (use responsibly)
python3 crawl_site.py https://example.com --delay 0.5

# Specific output location
python3 crawl_site.py https://example.com --output-dir ./audits/example/cache