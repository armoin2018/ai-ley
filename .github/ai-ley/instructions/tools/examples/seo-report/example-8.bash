# Crawl 50 pages with max depth of 2
python3 crawl_site.py https://example.com --max-pages 50 --max-depth 2

# Faster crawling with 0.5s delay (use responsibly)
python3 crawl_site.py https://example.com --delay 0.5

# Custom output directory
python3 crawl_site.py https://example.com --output-dir ./seo-audits/example/cache