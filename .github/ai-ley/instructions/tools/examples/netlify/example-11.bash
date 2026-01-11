# _redirects file for client-side routing and API proxying

# API proxy
/api/*  /.netlify/functions/:splat  200

# Legacy URL redirects
/old-page  /new-page  301
/blog/old-post  /blog/new-post  301

# SPA routing (must be last)
/*  /index.html  200

# Country-based redirects
/  /us  302  Country=us
/  /ca  302  Country=ca
/  /uk  302  Country=gb

# Role-based redirects
/admin/*  /login  302  Role=!admin
/dashboard/*  /login  302  Role=!user,!admin

# Language redirects
/  /en  302  Language=en
/  /fr  302  Language=fr
/  /es  302  Language=es