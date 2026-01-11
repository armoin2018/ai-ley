# Initialize Playwright in existing project
npm init playwright@latest

# This creates:
# - playwright.config.ts/js
# - tests/ directory with example tests
# - tests-examples/ directory with sample tests
# - .github/workflows/playwright.yml (CI configuration)

# Basic project structure
my-project/
├── playwright.config.ts
├── tests/
│   ├── example.spec.ts
│   └── fixtures/
├── test-results/
└── playwright-report/