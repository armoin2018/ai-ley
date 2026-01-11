# Check _redirects file syntax and order
# More specific rules should come first
/api/*  /.netlify/functions/:splat  200
/old-page  /new-page  301
/*  /index.html  200  # SPA fallback (should be last)

# Test redirects locally
netlify dev

# Check netlify.toml redirects
[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/:splat"
  status = 200