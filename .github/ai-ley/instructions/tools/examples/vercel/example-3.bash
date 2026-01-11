# Deploy existing project
cd your-project
vercel

# Initialize new project with framework
npx create-next-app@latest my-app
cd my-app
vercel

# Link existing project to Vercel
vercel link

# Set up development environment
vercel dev
vercel dev --listen 4000  # Custom port

# Deploy specific environment
vercel --prod              # Production deployment
vercel --target production # Alias for production