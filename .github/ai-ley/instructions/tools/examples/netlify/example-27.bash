# Debug build locally
netlify build --dry
netlify dev

# Check build settings in netlify.toml
[build]
  command = "npm run build"  # Ensure this matches your build script
  publish = "dist"           # Ensure this matches your build output

# Check Node.js version
[build.environment]
  NODE_VERSION = "18"        # Specify Node.js version

# Clear build cache
netlify build --clear-cache