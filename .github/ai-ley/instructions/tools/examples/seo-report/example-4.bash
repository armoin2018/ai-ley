# Wget-based Web Access Framework

# 1. Mirror Website (Limited Pages)
wget --mirror --page-requisites --convert-links --adjust-extension \
     --no-parent --level=2 --limit-rate=200k --wait=1 \
     --directory-prefix=./site_mirror "https://example.com"

# 2. Fetch Specific Pages
wget --input-file=urls.txt --directory-prefix=./pages

# 3. Recursive Download with Limits
wget -r -l 2 -nd -P ./downloads "https://example.com"

# 4. Check for Broken Links
wget --spider --recursive --level=2 --no-directories "https://example.com" 2>&1 | grep "broken link"

# 5. Download Sitemap and Extract URLs
wget "https://example.com/sitemap.xml" -O - | grep -oP '(?<=<loc>)[^<]+'