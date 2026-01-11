# .env
VITE_API_URL=http://localhost:8080
VITE_APP_TITLE=My Vite App
VITE_BUILD_VERSION=1.0.0

# .env.local (not committed to git)
VITE_SECRET_KEY=my-secret-key

# .env.development
VITE_API_URL=http://localhost:8080
VITE_DEBUG=true

# .env.production
VITE_API_URL=https://api.production.com
VITE_DEBUG=false

# Usage in code
console.log(import.meta.env.VITE_API_URL)
console.log(import.meta.env.MODE) // 'development' or 'production'
console.log(import.meta.env.DEV)  // boolean
console.log(import.meta.env.PROD) // boolean