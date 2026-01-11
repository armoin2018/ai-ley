# Install Turbo globally
npm install -g turbo

# Or install in monorepo root
npm install --save-dev turbo

# Initialize Turbo in existing monorepo
npx turbo init

# Verify installation
turbo --version

# Run first build to establish baseline
turbo build