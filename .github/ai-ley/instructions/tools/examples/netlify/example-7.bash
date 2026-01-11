# Initialize Netlify in existing project
cd your-project
netlify init

# Link existing site
netlify link

# Create new site
netlify sites:create --name your-site-name

# Deploy from command line
netlify deploy
netlify deploy --prod  # Production deployment

# Start local development server
netlify dev