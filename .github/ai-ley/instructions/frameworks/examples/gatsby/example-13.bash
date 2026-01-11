# Test production build
gatsby build && gatsby serve

# Audit build output
npx lighthouse http://localhost:9000 --view

# Test PWA functionality
npx lighthouse http://localhost:9000 --view --only-categories=pwa