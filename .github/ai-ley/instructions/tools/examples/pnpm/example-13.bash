# Automatic peer dependency installation
pnpm config set auto-install-peers true
pnpm install

# Manual peer dependency management
pnpm install react@18 react-dom@18  # Install peers manually
pnpm why react                       # Check peer dependency usage

# Configuration for peer dependencies
{
  "pnpm": {
    "peerDependencyRules": {
      "ignoreMissing": ["@babel/core", "webpack"],
      "allowedVersions": {
        "react": "18",
        "typescript": "5"
      }
    }
  }
}