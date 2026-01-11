# Enable caching
eslint --cache src/

# Use specific file patterns
eslint "src/**/*.{js,ts}" --ext .js,.ts

# Optimize TypeScript project references
# Use project: ["./tsconfig.json"] instead of project: true