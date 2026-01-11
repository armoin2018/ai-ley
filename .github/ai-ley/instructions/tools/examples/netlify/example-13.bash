# Connect repository via Netlify dashboard or CLI
netlify sites:create --name my-awesome-app

# Configure build settings
netlify build --dry  # Test build locally

# Deploy specific branch
git checkout feature/new-ui
git push origin feature/new-ui
# Netlify automatically creates deploy preview

# Production deployment
git checkout main
git push origin main
# Automatically deploys to production