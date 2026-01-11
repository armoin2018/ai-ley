# Curl-based Web Access Framework

# 1. Basic Page Fetch
curl -L -s "https://example.com" -o page_content.html

# 2. Fetch with Headers
curl -L -s -I "https://example.com" -o headers.txt

# 3. Measure Response Time
curl -L -s -w "\nTime Total: %{time_total}s\nTime Connect: %{time_connect}s\nTime Start Transfer: %{time_starttransfer}s\n" -o /dev/null "https://example.com"

# 4. Check for Redirects
curl -L -s -w "\nFinal URL: %{url_effective}\nHTTP Code: %{http_code}\nRedirect Count: %{num_redirects}\n" -o /dev/null "https://example.com"

# 5. Fetch Multiple Pages (Sitemap URLs)
while IFS= read -r url; do
  curl -L -s "$url" -o "pages/$(echo $url | md5sum | cut -d' ' -f1).html"
done < urls.txt

# 6. Check SSL Certificate
curl -vI https://example.com 2>&1 | grep -E "SSL|certificate|expire"

# 7. Extract Meta Tags
curl -L -s "https://example.com" | grep -Eo '<meta[^>]+>' > meta_tags.txt

# 8. Check Robots.txt
curl -L -s "https://example.com/robots.txt" -o robots.txt

# 9. Fetch XML Sitemap
curl -L -s "https://example.com/sitemap.xml" -o sitemap.xml

# 10. Test Mobile User-Agent
curl -L -s -A "Mozilla/5.0 (iPhone; CPU iPhone OS 14_7 like Mac OS X)" "https://example.com" -o mobile_version.html