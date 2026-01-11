# Debug specific test
npx playwright test --debug login.spec.ts

# Debug with headed browser
npx playwright test --headed --debug

# Use Playwright Inspector
PWDEBUG=1 npx playwright test

# Enable verbose logging
DEBUG=pw:api npx playwright test