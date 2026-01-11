# Analyze bundle size
webpack-bundle-analyzer dist/main.*.js

# Optimize Less compilation
lessc --compress --source-map src/styles.less dist/styles.css

# Use CDN for production
# Include only core components locally
# Load additional components on demand