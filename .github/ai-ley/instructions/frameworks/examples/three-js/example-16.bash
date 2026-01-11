# Build for production
npm run build

# Deploy to static hosting
npm install -g serve
serve -s dist

# Deploy to Netlify
npm install -g netlify-cli
netlify deploy --prod --dir=dist

# Deploy to Vercel
npm install -g vercel
vercel --prod

# Optimize for production
# Use webpack-bundle-analyzer to analyze bundle size
npm install -D webpack-bundle-analyzer
npx webpack-bundle-analyzer dist/assets/*.js

# Enable compression
# Configure server to serve compressed assets
# Use CDN for Three.js and large assets