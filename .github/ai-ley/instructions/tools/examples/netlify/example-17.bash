# Essential daily commands
netlify status                         # Check login and site status
netlify deploy                         # Deploy to draft URL
netlify deploy --prod                  # Deploy to production
netlify dev                           # Start local development server

# Site management
netlify sites:list                     # List all sites
netlify sites:create --name my-site    # Create new site
netlify sites:delete                   # Delete site
netlify link                          # Link local project to site

# Function development
netlify functions:list                 # List all functions
netlify functions:create               # Create new function
netlify functions:invoke hello         # Test function locally
netlify functions:build               # Build functions

# Build and deployment
netlify build                         # Run build locally
netlify build --dry                   # Dry run build
netlify deploy --build               # Build and deploy
netlify deploy --alias preview       # Deploy with custom alias

# Environment management
netlify env:list                      # List environment variables
netlify env:set VAR_NAME value        # Set environment variable
netlify env:unset VAR_NAME           # Remove environment variable
netlify env:import .env              # Import from .env file

# Domain and DNS
netlify domains:list                  # List domains
netlify domains:create example.com    # Add custom domain
netlify dns:create example.com A     # Create DNS record

# Analytics and logs
netlify logs                         # View function logs
netlify analytics                    # View site analytics
netlify addons:list                  # List available add-ons