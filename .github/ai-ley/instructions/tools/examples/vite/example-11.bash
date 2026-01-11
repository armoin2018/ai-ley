# Development commands
npm run dev                        # Start development server
npm run dev -- --port 3001        # Custom port
npm run dev -- --host 0.0.0.0     # Expose to network
npm run dev -- --open /admin      # Open specific path

# Build commands
npm run build                      # Production build
npm run build -- --mode staging   # Custom mode
npm run build -- --base /app/     # Custom base path

# Preview production build
npm run preview                    # Preview built app
npm run preview -- --port 4174    # Custom preview port

# Vite CLI commands
npx vite                          # Start dev server
npx vite build                    # Build for production
npx vite preview                  # Preview production build
npx vite optimize                 # Pre-bundle dependencies

# Advanced commands
npx vite build --watch            # Watch mode for build
npx vite build --minify false     # Build without minification
npx vite --force                  # Force re-optimize dependencies

# Plugin and dependency management
npx vite optimize --force         # Force re-optimize deps
npx vite build --reporter verbose # Detailed build output

# Configuration validation
npx vite --config vite.config.ts  # Use TypeScript config
npx vite build --mode production  # Specify build mode