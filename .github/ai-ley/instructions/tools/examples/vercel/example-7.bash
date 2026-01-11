# .env.local (Next.js)
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
NEXTAUTH_SECRET=your-secret-key
NEXTAUTH_URL=http://localhost:3000

# APIs
API_BASE_URL=https://api.yourservice.com
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...

# Analytics
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
NEXT_PUBLIC_ANALYTICS_ID=your-analytics-id

# Feature flags
NEXT_PUBLIC_FEATURE_NEW_UI=true
NEXT_PUBLIC_DEBUG_MODE=false

# Vercel-specific
VERCEL_URL=your-deployment-url.vercel.app
VERCEL_ENV=development