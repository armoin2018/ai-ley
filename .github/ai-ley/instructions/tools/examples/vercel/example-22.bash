# Debug build locally
vercel build
vercel dev

# Check build settings in vercel.json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm ci"
}

# Check Node.js version
{
  "build": {
    "env": {
      "NODE_VERSION": "18.x"
    }
  }
}

# Clear build cache
vercel --force  # Force rebuild without cache