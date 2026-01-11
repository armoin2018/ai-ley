# Enable debug logging
DEBUG=vite:* npm run dev

# Verbose build output
npm run build -- --reporter verbose

# Force dependency re-optimization
npm run dev -- --force

# Check dependency issues
npx vite optimize