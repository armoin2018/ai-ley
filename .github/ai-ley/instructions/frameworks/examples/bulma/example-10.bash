# Watch Sass compilation
sass --watch src/scss:dist/css

# Build for production
sass src/scss/main.scss dist/css/main.css --style=compressed

# Using with build tools
npm run build