# Use npm ci for faster, reproducible builds
npm ci                             # Clean install from package-lock.json

# Parallel installation
npm install --prefer-offline       # Use cache when possible
npm install --no-audit            # Skip audit for speed
npm install --no-fund             # Skip funding messages

# Alternative fast package managers
npx pnpm install                   # pnpm (faster alternative)
npx yarn install                   # Yarn (alternative manager)