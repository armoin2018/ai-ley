# npm installation
npm init playwright@latest
npm install --save-dev @playwright/test

# yarn installation
yarn create playwright
yarn add --dev @playwright/test

# pnpm installation
pnpm create playwright
pnpm add -D @playwright/test

# Install system dependencies (browsers)
npx playwright install
npx playwright install chromium firefox webkit

# Install specific browser
npx playwright install chromium
npx playwright install --with-deps chromium

# Update browsers
npx playwright install --force

# Verify installation
npx playwright --version