# Essential daily commands
vercel                              # Deploy current directory
vercel --prod                       # Deploy to production
vercel dev                          # Start local development server
vercel ls                           # List deployments

# Project management
vercel projects ls                  # List all projects
vercel projects add my-project      # Create new project
vercel projects rm my-project       # Remove project
vercel link                         # Link local project to Vercel

# Environment management
vercel env ls                       # List environment variables
vercel env add                      # Add environment variable
vercel env rm VAR_NAME             # Remove environment variable
vercel env pull .env.local         # Download environment variables

# Domain management
vercel domains ls                   # List domains
vercel domains add example.com      # Add custom domain
vercel domains rm example.com       # Remove domain
vercel domains verify example.com   # Verify domain ownership

# Team and collaboration
vercel teams ls                     # List teams
vercel teams switch team-name       # Switch to team
vercel teams invite user@email.com  # Invite team member

# Analytics and monitoring
vercel logs                         # View function logs
vercel inspect deployment-url       # Inspect deployment details
vercel analytics                    # View analytics data

# Deployment management
vercel alias set deployment-url custom-alias  # Set deployment alias
vercel rollback deployment-url                # Rollback deployment
vercel promote deployment-url                 # Promote preview to production