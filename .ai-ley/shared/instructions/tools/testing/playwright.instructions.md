# Playwright End-to-End Testing Framework Instructions

## Tool Overview
- **Tool Name**: Playwright
- **Version**: 1.40+ (stable), 1.41+ (latest with enhanced features)
- **Category**: Testing Tools
- **Purpose**: Modern end-to-end testing framework for web applications
- **Prerequisites**: Node.js 18+ (16+ minimum), npm/yarn/pnpm

## Installation & Setup
### Installation Methods
```bash
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
```

### Project Initialization
```bash
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
```

## Configuration

### Basic Configuration (playwright.config.ts)
```typescript
import { defineConfig, devices } from '@playwright/test'

export default defineConfig({
  // Test directory
  testDir: './tests',

  // Run tests in files in parallel
  fullyParallel: true,

  // Fail the build on CI if you accidentally left test.only in the source code
  forbidOnly: !!process.env.CI,

  // Retry on CI only
  retries: process.env.CI ? 2 : 0,

  // Opt out of parallel tests on CI
  workers: process.env.CI ? 1 : undefined,

  // Reporter to use
  reporter: 'html',

  // Shared settings for all the projects below
  use: {
    // Base URL to use in actions like `await page.goto('/')`
    baseURL: 'http://127.0.0.1:3000',

    // Collect trace when retrying the failed test
    trace: 'on-first-retry',

    // Take screenshot on failure
    screenshot: 'only-on-failure',

    // Record video on failure
    video: 'retain-on-failure'
  },

  // Configure projects for major browsers
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] }
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] }
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] }
    }
  ],

  // Run your local dev server before starting the tests
  webServer: {
    command: 'npm run start',
    url: 'http://127.0.0.1:3000',
    reuseExistingServer: !process.env.CI
  }
})
```

### Advanced Configuration
```typescript
import { defineConfig, devices } from '@playwright/test'

export default defineConfig({
  testDir: './tests',

  // Global setup and teardown
  globalSetup: require.resolve('./global-setup'),
  globalTeardown: require.resolve('./global-teardown'),

  // Test timeout
  timeout: 30 * 1000,
  expect: {
    timeout: 5000
  },

  // Test execution
  fullyParallel: true,
  workers: process.env.CI ? 1 : '50%',
  retries: process.env.CI ? 2 : 0,

  // Reporting
  reporter: [
    ['html'],
    ['json', { outputFile: 'test-results/results.json' }],
    ['junit', { outputFile: 'test-results/results.xml' }],
    process.env.CI ? ['github'] : ['list']
  ],

  // Output directories
  outputDir: './test-results',

  // Global test settings
  use: {
    // Browser settings
    headless: !!process.env.CI,
    viewport: { width: 1280, height: 720 },
    ignoreHTTPSErrors: true,

    // Base URL
    baseURL: process.env.BASE_URL || 'http://localhost:3000',

    // Authentication
    storageState: 'storage-state.json',

    // Network
    extraHTTPHeaders: {
      'Accept-Language': 'en-US,en;q=0.9'
    },

    // Debugging
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',

    // Locale and timezone
    locale: 'en-US',
    timezoneId: 'America/New_York'
  },

  // Projects for different browsers and devices
  projects: [
    // Desktop browsers
    {
      name: 'chromium',
      use: {
        ...devices['Desktop Chrome'],
        // Custom Chrome flags
        launchOptions: {
          args: ['--disable-web-security']
        }
      }
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] }
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] }
    },

    // Mobile browsers
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] }
    },
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12'] }
    },

    // Branded browsers
    {
      name: 'Microsoft Edge',
      use: {
        ...devices['Desktop Edge'],
        channel: 'msedge'
      }
    },
    {
      name: 'Google Chrome',
      use: {
        ...devices['Desktop Chrome'],
        channel: 'chrome'
      }
    }
  ],

  // Web server for local development
  webServer: [
    {
      command: 'npm run start:backend',
      url: 'http://127.0.0.1:8000',
      reuseExistingServer: !process.env.CI,
      timeout: 120 * 1000
    },
    {
      command: 'npm run start:frontend',
      url: 'http://127.0.0.1:3000',
      reuseExistingServer: !process.env.CI
    }
  ]
})
```

### Environment-Specific Configuration
```typescript
// playwright.config.dev.ts
import { defineConfig } from '@playwright/test'
import baseConfig from './playwright.config'

export default defineConfig({
  ...baseConfig,
  use: {
    ...baseConfig.use,
    headless: false,
    video: 'on',
    trace: 'on'
  },
  workers: 1,
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000'
  }
})

// playwright.config.prod.ts
import { defineConfig } from '@playwright/test'
import baseConfig from './playwright.config'

export default defineConfig({
  ...baseConfig,
  use: {
    ...baseConfig.use,
    baseURL: 'https://production-app.com'
  },
  retries: 3,
  workers: '50%'
})
```

## Core Features

### Page Object Model
- **Purpose**: Organize test code with reusable page objects
- **Usage**: Create maintainable test suites with clear separation of concerns
- **Example**:
```typescript
// pages/login-page.ts
import { Page, Locator } from '@playwright/test'

export class LoginPage {
  readonly page: Page
  readonly usernameInput: Locator
  readonly passwordInput: Locator
  readonly loginButton: Locator
  readonly errorMessage: Locator

  constructor(page: Page) {
    this.page = page
    this.usernameInput = page.locator('[data-testid="username"]')
    this.passwordInput = page.locator('[data-testid="password"]')
    this.loginButton = page.locator('[data-testid="login-button"]')
    this.errorMessage = page.locator('.error-message')
  }

  async goto() {
    await this.page.goto('/login')
  }

  async login(username: string, password: string) {
    await this.usernameInput.fill(username)
    await this.passwordInput.fill(password)
    await this.loginButton.click()
  }

  async getErrorMessage() {
    return await this.errorMessage.textContent()
  }
}

// tests/login.spec.ts
import { test, expect } from '@playwright/test'
import { LoginPage } from '../pages/login-page'

test.describe('Login functionality', () => {
  test('successful login', async ({ page }) => {
    const loginPage = new LoginPage(page)
    await loginPage.goto()
    await loginPage.login('user@example.com', 'password123')

    await expect(page).toHaveURL('/dashboard')
  })

  test('failed login', async ({ page }) => {
    const loginPage = new LoginPage(page)
    await loginPage.goto()
    await loginPage.login('invalid@example.com', 'wrongpassword')

    const errorMessage = await loginPage.getErrorMessage()
    expect(errorMessage).toContain('Invalid credentials')
  })
})
```

### Browser Automation
- **Purpose**: Control browsers programmatically for testing web applications
- **Usage**: Navigate, interact with elements, and verify application behavior
- **Example**:
```typescript
import { test, expect } from '@playwright/test'

test.describe('Browser automation examples', () => {
  test('navigation and interaction', async ({ page }) => {
    // Navigate to page
    await page.goto('https://example.com')

    // Fill form fields
    await page.fill('#search-input', 'playwright testing')
    await page.selectOption('#category', 'documentation')
    await page.check('#include-archived')

    // Click buttons and links
    await page.click('button[type="submit"]')
    await page.click('text=Advanced Search')

    // Handle dialogs
    page.on('dialog', dialog => dialog.accept())
    await page.click('#delete-button')

    // Wait for navigation
    await page.waitForURL('**/search-results')

    // Verify page content
    await expect(page).toHaveTitle(/Search Results/)
    await expect(page.locator('.result-item')).toHaveCount(10)
  })

  test('advanced interactions', async ({ page }) => {
    await page.goto('/interactive-demo')

    // Hover effects
    await page.hover('.tooltip-trigger')
    await expect(page.locator('.tooltip')).toBeVisible()

    // Drag and drop
    await page.dragAndDrop('#source-element', '#target-element')

    // File uploads
    await page.setInputFiles('#file-upload', 'test-files/sample.pdf')

    // Keyboard interactions
    await page.press('#text-editor', 'Control+A')
    await page.keyboard.type('New content')

    // Mouse interactions
    await page.mouse.move(100, 100)
    await page.mouse.down()
    await page.mouse.move(200, 200)
    await page.mouse.up()
  })
})
```

### Mobile Testing
- **Purpose**: Test web applications on mobile devices and different screen sizes
- **Usage**: Ensure responsive design and mobile-specific functionality works correctly
- **Example**:
```typescript
import { test, expect, devices } from '@playwright/test'

// Mobile device testing
test.describe('Mobile testing', () => {
  test('iPhone responsive design', async ({ browser }) => {
    const context = await browser.newContext({
      ...devices['iPhone 12']
    })
    const page = await context.newPage()

    await page.goto('/')

    // Test mobile navigation
    await page.click('.mobile-menu-toggle')
    await expect(page.locator('.mobile-menu')).toBeVisible()

    // Test touch interactions
    await page.touchscreen.tap('.touch-button', { x: 10, y: 10 })

    // Test viewport-specific elements
    await expect(page.locator('.desktop-only')).toBeHidden()
    await expect(page.locator('.mobile-only')).toBeVisible()
  })

  test('tablet landscape mode', async ({ browser }) => {
    const context = await browser.newContext({
      ...devices['iPad Pro landscape']
    })
    const page = await context.newPage()

    await page.goto('/')

    // Test tablet-specific layout
    await expect(page.locator('.tablet-grid')).toHaveCSS('grid-template-columns', 'repeat(3, 1fr)')
  })

  test('custom viewport', async ({ page }) => {
    // Set custom viewport
    await page.setViewportSize({ width: 375, height: 812 })
    await page.goto('/')

    // Test responsive breakpoints
    await expect(page.locator('.responsive-element')).toHaveCSS('width', '100%')
  })
})
```

## Common Commands
```bash
# Test execution
npx playwright test                     # Run all tests
npx playwright test login.spec.ts      # Run specific test file
npx playwright test --project=chromium # Run tests in specific browser
npx playwright test --headed           # Run in headed mode (visible browser)
npx playwright test --debug            # Run in debug mode

# Test filtering
npx playwright test --grep="login"     # Run tests matching pattern
npx playwright test --grep-invert="slow" # Skip tests matching pattern
npx playwright test tests/auth/        # Run tests in specific directory

# Browser and device testing
npx playwright test --project="Mobile Chrome"  # Run on mobile
npx playwright test --project="webkit"         # Run on Safari
npx playwright test --browser=all              # Run on all browsers

# Reporting and debugging
npx playwright show-report             # Show HTML report
npx playwright test --reporter=list    # Use list reporter
npx playwright test --trace=on         # Enable tracing
npx playwright test --video=on         # Record videos

# Code generation and inspection
npx playwright codegen https://example.com  # Generate test code
npx playwright inspector               # Open Playwright Inspector
npx playwright trace viewer            # View traces

# Browser management
npx playwright install                 # Install browsers
npx playwright install chromium        # Install specific browser
npx playwright install --with-deps     # Install with system dependencies

# Configuration and setup
npx playwright install-deps            # Install system dependencies
npx playwright check                   # Check installation
npx playwright --version              # Show version
```

## Advanced Features

### Custom Fixtures
```typescript
// fixtures/auth-fixture.ts
import { test as base, expect } from '@playwright/test'
import { LoginPage } from '../pages/login-page'

type AuthFixture = {
  loginPage: LoginPage
  authenticatedPage: Page
}

export const test = base.extend<AuthFixture>({
  loginPage: async ({ page }, use) => {
    const loginPage = new LoginPage(page)
    await use(loginPage)
  },

  authenticatedPage: async ({ page }, use) => {
    // Auto-login before each test
    const loginPage = new LoginPage(page)
    await loginPage.goto()
    await loginPage.login('test@example.com', 'password123')
    await use(page)
  }
})

export { expect } from '@playwright/test'

// Usage in tests
import { test, expect } from '../fixtures/auth-fixture'

test('user dashboard', async ({ authenticatedPage }) => {
  await expect(authenticatedPage.locator('#user-welcome')).toBeVisible()
})
```

### Network Interception
```typescript
import { test, expect } from '@playwright/test'

test.describe('Network testing', () => {
  test('API mocking', async ({ page }) => {
    // Mock API responses
    await page.route('**/api/users', route => {
      route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify([
          { id: 1, name: 'John Doe', email: 'john@example.com' }
        ])
      })
    })

    await page.goto('/users')
    await expect(page.locator('.user-item')).toHaveCount(1)
  })

  test('network monitoring', async ({ page }) => {
    const responses: any[] = []

    // Monitor network requests
    page.on('response', response => {
      responses.push({
        url: response.url(),
        status: response.status(),
        headers: response.headers()
      })
    })

    await page.goto('/')

    // Wait for all network requests to complete
    await page.waitForLoadState('networkidle')

    // Verify API calls were made
    const apiCalls = responses.filter(r => r.url.includes('/api/'))
    expect(apiCalls).toHaveLength(3)
  })

  test('request modification', async ({ page }) => {
    // Modify requests
    await page.route('**/api/**', route => {
      const headers = {
        ...route.request().headers(),
        'Authorization': 'Bearer fake-token',
        'X-Test-Mode': 'true'
      }

      route.continue({ headers })
    })

    await page.goto('/dashboard')
  })
})
```

### Visual Testing
```typescript
import { test, expect } from '@playwright/test'

test.describe('Visual testing', () => {
  test('screenshot comparison', async ({ page }) => {
    await page.goto('/landing-page')

    // Full page screenshot
    await expect(page).toHaveScreenshot('landing-page.png')

    // Element screenshot
    await expect(page.locator('.hero-section')).toHaveScreenshot('hero.png')

    // Mobile screenshot
    await page.setViewportSize({ width: 375, height: 812 })
    await expect(page).toHaveScreenshot('landing-page-mobile.png')
  })

  test('visual regression with custom threshold', async ({ page }) => {
    await page.goto('/chart-dashboard')

    // Wait for charts to load
    await page.waitForSelector('.chart-container[data-loaded="true"]')

    // Screenshot with custom threshold
    await expect(page.locator('.chart-container')).toHaveScreenshot('chart.png', {
      threshold: 0.3, // Allow 30% difference
      maxDiffPixels: 1000
    })
  })

  test('mask dynamic content', async ({ page }) => {
    await page.goto('/profile')

    // Mask elements that change between runs
    await expect(page).toHaveScreenshot('profile.png', {
      mask: [
        page.locator('.timestamp'),
        page.locator('.random-id')
      ]
    })
  })
})
```

### Performance Testing
```typescript
import { test, expect } from '@playwright/test'

test.describe('Performance testing', () => {
  test('page load performance', async ({ page }) => {
    const startTime = Date.now()

    await page.goto('/')
    await page.waitForLoadState('networkidle')

    const loadTime = Date.now() - startTime
    expect(loadTime).toBeLessThan(3000) // Less than 3 seconds

    // Check performance metrics
    const performanceEntries = await page.evaluate(() => {
      return JSON.stringify(performance.getEntriesByType('navigation'))
    })

    const navigation = JSON.parse(performanceEntries)[0]
    expect(navigation.loadEventEnd - navigation.fetchStart).toBeLessThan(3000)
  })

  test('Core Web Vitals', async ({ page }) => {
    await page.goto('/')

    // Measure Core Web Vitals
    const vitals = await page.evaluate(() => {
      return new Promise(resolve => {
        let vitalsData: any = {}

        // Largest Contentful Paint
        new PerformanceObserver(list => {
          const entries = list.getEntries()
          const lastEntry = entries[entries.length - 1]
          vitalsData.lcp = lastEntry.startTime
        }).observe({ entryTypes: ['largest-contentful-paint'] })

        // First Input Delay
        new PerformanceObserver(list => {
          const entries = list.getEntries()
          entries.forEach(entry => {
            vitalsData.fid = entry.processingStart - entry.startTime
          })
        }).observe({ entryTypes: ['first-input'] })

        // Cumulative Layout Shift
        new PerformanceObserver(list => {
          let cls = 0
          for (const entry of list.getEntries()) {
            if (!entry.hadRecentInput) {
              cls += entry.value
            }
          }
          vitalsData.cls = cls
          resolve(vitalsData)
        }).observe({ entryTypes: ['layout-shift'] })

        // Fallback timeout
        setTimeout(() => resolve(vitalsData), 5000)
      })
    })

    expect(vitals.lcp).toBeLessThan(2500) // LCP < 2.5s
    expect(vitals.fid).toBeLessThan(100)  // FID < 100ms
    expect(vitals.cls).toBeLessThan(0.1)  // CLS < 0.1
  })
})
```

## Testing Patterns

### Authentication Testing
```typescript
// tests/auth/login.spec.ts
import { test, expect } from '@playwright/test'

test.describe('Authentication', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/login')
  })

  test('successful login redirects to dashboard', async ({ page }) => {
    await page.fill('[data-testid="email"]', 'user@example.com')
    await page.fill('[data-testid="password"]', 'password123')
    await page.click('[data-testid="login-button"]')

    await expect(page).toHaveURL('/dashboard')
    await expect(page.locator('[data-testid="user-menu"]')).toBeVisible()
  })

  test('invalid credentials show error', async ({ page }) => {
    await page.fill('[data-testid="email"]', 'invalid@example.com')
    await page.fill('[data-testid="password"]', 'wrongpassword')
    await page.click('[data-testid="login-button"]')

    await expect(page.locator('[data-testid="error-message"]')).toContainText('Invalid credentials')
    await expect(page).toHaveURL('/login')
  })

  test('remember me functionality', async ({ page, context }) => {
    await page.check('[data-testid="remember-me"]')
    await page.fill('[data-testid="email"]', 'user@example.com')
    await page.fill('[data-testid="password"]', 'password123')
    await page.click('[data-testid="login-button"]')

    // Verify persistent storage
    const cookies = await context.cookies()
    expect(cookies.find(c => c.name === 'remember_token')).toBeTruthy()
  })
})

// Global authentication setup
// global-setup.ts
import { chromium, FullConfig } from '@playwright/test'

async function globalSetup(config: FullConfig) {
  const browser = await chromium.launch()
  const page = await browser.newPage()

  // Authenticate once globally
  await page.goto('http://localhost:3000/login')
  await page.fill('[data-testid="email"]', 'test@example.com')
  await page.fill('[data-testid="password"]', 'password123')
  await page.click('[data-testid="login-button"]')

  // Save authentication state
  await page.context().storageState({ path: 'storage-state.json' })
  await browser.close()
}

export default globalSetup
```

### Form Testing
```typescript
import { test, expect } from '@playwright/test'

test.describe('Contact form', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/contact')
  })

  test('valid form submission', async ({ page }) => {
    // Fill form fields
    await page.fill('#name', 'John Doe')
    await page.fill('#email', 'john@example.com')
    await page.selectOption('#subject', 'general')
    await page.fill('#message', 'This is a test message.')
    await page.check('#terms')

    // Submit form
    await page.click('button[type="submit"]')

    // Verify success
    await expect(page.locator('.success-message')).toBeVisible()
    await expect(page.locator('.success-message')).toContainText('Thank you')
  })

  test('form validation errors', async ({ page }) => {
    // Try to submit empty form
    await page.click('button[type="submit"]')

    // Check validation errors
    await expect(page.locator('#name-error')).toContainText('Name is required')
    await expect(page.locator('#email-error')).toContainText('Email is required')
    await expect(page.locator('#message-error')).toContainText('Message is required')
  })

  test('email format validation', async ({ page }) => {
    await page.fill('#email', 'invalid-email')
    await page.blur('#email')

    await expect(page.locator('#email-error')).toContainText('Please enter a valid email')
  })

  test('file upload', async ({ page }) => {
    // Upload file
    await page.setInputFiles('#attachment', 'test-files/sample.pdf')

    // Verify file selected
    await expect(page.locator('.file-info')).toContainText('sample.pdf')

    // Submit form
    await page.fill('#name', 'John Doe')
    await page.fill('#email', 'john@example.com')
    await page.fill('#message', 'Message with attachment')
    await page.click('button[type="submit"]')

    await expect(page.locator('.success-message')).toBeVisible()
  })
})
```

### E-commerce Testing
```typescript
import { test, expect } from '@playwright/test'

test.describe('E-commerce flow', () => {
  test('complete purchase journey', async ({ page }) => {
    // Browse products
    await page.goto('/products')
    await page.click('.product-card:first-child')

    // Add to cart
    await page.selectOption('#size', 'M')
    await page.selectOption('#color', 'blue')
    await page.click('#add-to-cart')

    // Verify cart update
    await expect(page.locator('.cart-count')).toContainText('1')

    // Go to cart
    await page.click('.cart-icon')
    await expect(page.locator('.cart-item')).toHaveCount(1)

    // Proceed to checkout
    await page.click('#checkout-button')

    // Fill shipping information
    await page.fill('#firstName', 'John')
    await page.fill('#lastName', 'Doe')
    await page.fill('#address', '123 Main St')
    await page.fill('#city', 'New York')
    await page.selectOption('#state', 'NY')
    await page.fill('#zipCode', '10001')

    // Fill payment information
    await page.fill('#cardNumber', '4111111111111111')
    await page.fill('#expiryDate', '12/25')
    await page.fill('#cvv', '123')

    // Complete purchase
    await page.click('#place-order')

    // Verify order confirmation
    await expect(page.locator('.order-confirmation')).toBeVisible()
    await expect(page.locator('.order-number')).toBeVisible()
  })

  test('cart management', async ({ page }) => {
    // Add multiple items
    await page.goto('/products')

    const products = page.locator('.product-card')
    const count = await products.count()

    for (let i = 0; i < Math.min(3, count); i++) {
      await products.nth(i).click()
      await page.click('#add-to-cart')
      await page.goBack()
    }

    // Go to cart
    await page.click('.cart-icon')

    // Update quantities
    await page.fill('.quantity-input:first-child', '2')
    await page.click('#update-cart')

    // Remove item
    await page.click('.remove-item:first-child')
    await expect(page.locator('.cart-item')).toHaveCount(2)

    // Apply discount code
    await page.fill('#discount-code', 'SAVE10')
    await page.click('#apply-discount')
    await expect(page.locator('.discount-amount')).toBeVisible()
  })
})
```

## Environment-Specific Configuration

### CI/CD Integration
```yaml
# .github/workflows/playwright.yml
name: Playwright Tests
on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]

jobs:
  test:
    timeout-minutes: 60
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - uses: actions/setup-node@v4
      with:
        node-version: 18
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Install Playwright Browsers
      run: npx playwright install --with-deps

    - name: Run Playwright tests
      run: npx playwright test

    - uses: actions/upload-artifact@v3
      if: always()
      with:
        name: playwright-report
        path: playwright-report/
        retention-days: 30
```

### Docker Integration
```dockerfile
# Dockerfile for Playwright
FROM mcr.microsoft.com/playwright:v1.41.0-focal

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Run tests
CMD ["npx", "playwright", "test"]
```

```yaml
# docker-compose.yml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development

  tests:
    build: .
    command: npx playwright test
    depends_on:
      - app
    environment:
      - BASE_URL=http://app:3000
    volumes:
      - ./test-results:/app/test-results
      - ./playwright-report:/app/playwright-report
```

## Common Issues & Solutions

### Flaky Tests
**Problem**: Tests fail intermittently due to timing issues
**Solution**: Use proper waiting strategies and assertions
```typescript
// ❌ Bad: Using fixed timeouts
await page.waitForTimeout(1000)

// ✅ Good: Wait for specific conditions
await page.waitForSelector('.loading-spinner', { state: 'hidden' })
await page.waitForLoadState('networkidle')

// ❌ Bad: Immediate assertions
await page.click('#submit')
expect(page.locator('.success')).toBeVisible()

// ✅ Good: Wait for assertions
await page.click('#submit')
await expect(page.locator('.success')).toBeVisible()
```

### Element Selection Issues
**Problem**: Elements not found or ambiguous selectors
**Solution**: Use robust locator strategies
```typescript
// ❌ Bad: Brittle selectors
page.locator('div > span:nth-child(3)')
page.locator('.btn.btn-primary.large')

// ✅ Good: Semantic selectors
page.locator('[data-testid="submit-button"]')
page.getByRole('button', { name: 'Submit' })
page.getByText('Submit Order')
page.getByLabel('Email address')
```

### Network and API Issues
**Problem**: Tests fail due to external dependencies
**Solution**: Mock external services and APIs
```typescript
// Mock external APIs
await page.route('**/api/external/**', route => {
  route.fulfill({
    status: 200,
    contentType: 'application/json',
    body: JSON.stringify({ status: 'success' })
  })
})

// Block unnecessary resources
await page.route('**/*.{png,jpg,jpeg,gif,svg}', route => route.abort())
```

## Useful Resources
- **Official Documentation**: https://playwright.dev/
- **API Reference**: https://playwright.dev/docs/api/class-playwright
- **Best Practices**: https://playwright.dev/docs/best-practices
- **Examples Repository**: https://github.com/microsoft/playwright
- **Discord Community**: https://discord.gg/playwright

## Tool-Specific Guidelines

### Best Practices
- Use data-testid attributes for reliable element selection
- Implement Page Object Model for maintainable tests
- Mock external dependencies to avoid flaky tests
- Use appropriate waiting strategies instead of fixed timeouts
- Test user journeys rather than individual components

### Performance Tips
- Run tests in parallel to reduce execution time
- Use headless mode in CI for faster execution
- Implement proper test isolation and cleanup
- Cache browser installations in CI
- Use test.slow() for inherently slow tests

### Security Considerations
- Never commit real credentials or sensitive data
- Use environment variables for test configuration
- Implement proper authentication testing
- Test permission boundaries and access controls
- Validate input sanitization and XSS protection

## Version Compatibility
- **Node.js**: 18+ (16+ minimum)
- **TypeScript**: 4.7+ (with @playwright/test)
- **Browsers**: Chromium, Firefox, WebKit (auto-updated)
- **Operating Systems**: Windows, macOS, Linux

## Troubleshooting

### Debug Mode
```bash
# Debug specific test
npx playwright test --debug login.spec.ts

# Debug with headed browser
npx playwright test --headed --debug

# Use Playwright Inspector
PWDEBUG=1 npx playwright test

# Enable verbose logging
DEBUG=pw:api npx playwright test
```

### Common Error Messages
- **Error**: `Error: page.goto: net::ERR_CONNECTION_REFUSED`
  **Cause**: Application server not running
  **Solution**: Start application server or configure webServer in config

- **Error**: `TimeoutError: Timeout 30000ms exceeded`
  **Cause**: Element not found or condition not met
  **Solution**: Increase timeout or fix locator/condition

- **Error**: `Error: Browser executable not found`
  **Cause**: Playwright browsers not installed
  **Solution**: Run `npx playwright install`
1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions

```

```
