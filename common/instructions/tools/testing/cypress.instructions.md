---
applyTo: 'cypress, cypress.io, e2e-testing'
agentMode: 'tool-specific'
instructionType: 'guide'
guidelines: 'Focus on Cypress for end-to-end testing and web application automation'
---

# Cypress Testing Tool Instructions for AI Agents

## When to Use Cypress

Use Cypress when you need:

- End-to-end testing for web applications
- Integration testing with real browser interactions
- Visual testing and screenshot comparisons
- API testing and network stubbing
- Component testing in isolation
- Debugging capabilities with time-travel
- Real-time browser automation
- Cross-browser testing (Chrome, Firefox, Edge, Electron)

## When to Avoid Cypress

Consider alternatives when:

- Testing mobile applications natively (use Appium, Detox)
- Testing multiple tabs or browser windows (use Playwright)
- Testing PDF content or file downloads extensively
- Need to test in Safari or IE (limited browser support)
- Performing load testing (use Artillery, k6)
- Testing desktop applications (use Electron-specific tools)
- Simple unit testing needs (use Jest, Vitest)

## Tool Overview

- **Tool**: Cypress
- **Version**: 13.0+
- **Category**: End-to-end testing framework
- **Purpose**: Web application testing and browser automation
- **Prerequisites**: Node.js 18+, modern web browser

## Installation & Setup

### ✅ Recommended: npm Installation

```bash
# Install Cypress as dev dependency
npm install --save-dev cypress

# Install additional testing utilities
npm install --save-dev @testing-library/cypress @cypress/code-coverage

# Initialize Cypress (creates cypress folder and config)
npx cypress open

# Run Cypress in headless mode
npx cypress run
```

### ✅ Project Setup and Configuration

```javascript
// cypress.config.js - Modern Cypress configuration
const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    // Base URL for your application
    baseUrl: 'http://localhost:3000',

    // Browser and viewport settings
    viewportWidth: 1280,
    viewportHeight: 720,

    // Test file patterns
    specPattern: 'cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',
    supportFile: 'cypress/support/e2e.js',

    // Screenshots and videos
    screenshotsFolder: 'cypress/screenshots',
    videosFolder: 'cypress/videos',
    video: true,
    screenshotOnRunFailure: true,

    // Test behavior
    defaultCommandTimeout: 10000,
    requestTimeout: 10000,
    responseTimeout: 10000,
    pageLoadTimeout: 30000,

    // Test execution
    testIsolation: true,
    experimentalStudio: true,

    setupNodeEvents(on, config) {
      // Code coverage plugin
      require('@cypress/code-coverage/task')(on, config);

      // Custom tasks
      on('task', {
        log(message) {
          console.log(message);
          return null;
        },

        // Database seeding task
        seedDb(fixture) {
          // Custom database seeding logic
          return null;
        },

        // API mocking task
        setupApiMocks() {
          // Setup API mocking
          return null;
        },
      });

      return config;
    },
  },

  component: {
    devServer: {
      framework: 'react', // or 'vue', 'angular'
      bundler: 'vite', // or 'webpack'
    },
    specPattern: 'src/**/*.cy.{js,jsx,ts,tsx}',
    supportFile: 'cypress/support/component.js',
  },

  // Environment variables
  env: {
    auth_username: 'testuser@example.com',
    auth_password: 'password123',
    api_server: 'http://localhost:8080',
  },

  // Retry configuration
  retries: {
    runMode: 2,
    openMode: 0,
  },
});
```

### ✅ Support Files and Custom Commands

```javascript
// cypress/support/e2e.js - Global support configuration
import './commands';
import '@cypress/code-coverage/support';

// Global before hook
beforeEach(() => {
  // Setup that runs before each test
  cy.log('Starting test execution');
});

// Global after hook
afterEach(() => {
  // Cleanup after each test
  cy.clearCookies();
  cy.clearLocalStorage();
});

// Custom error handling
Cypress.on('uncaught:exception', (err, runnable) => {
  // Prevent Cypress from failing tests on uncaught exceptions
  // that we expect in our application
  if (err.message.includes('Script error')) {
    return false;
  }
  return true;
});
```

```javascript
// cypress/support/commands.js - Custom commands
// Login command
Cypress.Commands.add('login', (username, password) => {
  cy.session([username, password], () => {
    cy.visit('/login');
    cy.get('[data-cy=username]').type(username);
    cy.get('[data-cy=password]').type(password);
    cy.get('[data-cy=login-button]').click();

    // Wait for successful login
    cy.url().should('include', '/dashboard');
    cy.get('[data-cy=user-menu]').should('be.visible');
  });
});

// Database seeding command
Cypress.Commands.add('seedDatabase', (fixture) => {
  cy.task('seedDb', fixture);
});

// API mocking command
Cypress.Commands.add('mockApi', (route, fixture) => {
  cy.intercept('GET', route, { fixture }).as('apiCall');
});

// Custom assertion commands
Cypress.Commands.add('shouldBeVisible', { prevSubject: true }, (subject) => {
  cy.wrap(subject).should('be.visible');
  return cy.wrap(subject);
});

// File upload command
Cypress.Commands.add('uploadFile', (selector, fileName, fileType = '') => {
  cy.get(selector).then((subject) => {
    const el = subject[0];
    const blob = Cypress.Blob.base64StringToBlob('test content', fileType);
    const file = new File([blob], fileName, { type: fileType });
    const dataTransfer = new DataTransfer();
    dataTransfer.items.add(file);
    el.files = dataTransfer.files;

    cy.wrap(subject).trigger('change', { force: true });
  });
});

// Accessibility testing command
Cypress.Commands.add('injectAxe', () => {
  cy.window({ log: false }).then((win) => {
    const script = win.document.createElement('script');
    script.src = 'https://unpkg.com/axe-core@4.7.0/axe.min.js';
    win.document.head.appendChild(script);
  });
});

Cypress.Commands.add('checkA11y', (context, options) => {
  cy.window({ log: false }).then((win) => {
    if (win.axe) {
      cy.wrap(null, { log: false })
        .then(() => {
          return new Cypress.Promise((resolve, reject) => {
            win.axe.run(context || win.document, options || {}, (err, results) => {
              if (err) reject(err);
              else resolve(results);
            });
          });
        })
        .then((results) => {
          cy.task('log', `Accessibility violations: ${results.violations.length}`);
          if (results.violations.length) {
            results.violations.forEach((violation) => {
              cy.task('log', `${violation.id}: ${violation.description}`);
            });
            throw new Error(`${results.violations.length} accessibility violation(s) detected`);
          }
        });
    }
  });
});
```

### AI Agent Decision Tree

- **For E2E testing**: Use Cypress for comprehensive user journey testing
- **For component testing**: Use Cypress component testing with real browser rendering
- **For API testing**: Use Cypress intercepts and network stubbing
- **For visual testing**: Use Cypress with screenshot comparison plugins
- **For cross-browser testing**: Use Cypress with multiple browser configurations
- **For CI/CD integration**: Use Cypress Cloud or custom Docker containers

## Core Concepts

### Test Structure and Organization

✅ **Best Practice**: Organize tests with clear structure and good practices

```javascript
// cypress/e2e/authentication.cy.js - E2E test example
describe('Authentication Flow', () => {
  beforeEach(() => {
    // Setup before each test
    cy.visit('/');
    cy.clearCookies();
    cy.clearLocalStorage();
  });

  context('Login', () => {
    it('should login with valid credentials', () => {
      // Test data
      const user = {
        email: 'user@example.com',
        password: 'password123',
      };

      // Navigate to login
      cy.get('[data-cy=login-link]').click();
      cy.url().should('include', '/login');

      // Fill form
      cy.get('[data-cy=email-input]').type(user.email).should('have.value', user.email);

      cy.get('[data-cy=password-input]').type(user.password).should('have.value', user.password);

      // Submit form
      cy.get('[data-cy=login-button]').click();

      // Verify success
      cy.url().should('include', '/dashboard');
      cy.get('[data-cy=welcome-message]').should('be.visible').and('contain', 'Welcome back');

      // Verify user menu is available
      cy.get('[data-cy=user-menu]').should('be.visible').click();

      cy.get('[data-cy=profile-link]').should('be.visible');
      cy.get('[data-cy=logout-link]').should('be.visible');
    });

    it('should show error with invalid credentials', () => {
      cy.get('[data-cy=login-link]').click();

      cy.get('[data-cy=email-input]').type('invalid@example.com');
      cy.get('[data-cy=password-input]').type('wrongpassword');
      cy.get('[data-cy=login-button]').click();

      // Verify error message
      cy.get('[data-cy=error-message]').should('be.visible').and('contain', 'Invalid credentials');

      // Verify still on login page
      cy.url().should('include', '/login');
    });

    it('should validate required fields', () => {
      cy.get('[data-cy=login-link]').click();
      cy.get('[data-cy=login-button]').click();

      // Check validation messages
      cy.get('[data-cy=email-error]').should('be.visible').and('contain', 'Email is required');

      cy.get('[data-cy=password-error]')
        .should('be.visible')
        .and('contain', 'Password is required');
    });
  });

  context('Registration', () => {
    it('should register new user successfully', () => {
      const newUser = {
        firstName: 'John',
        lastName: 'Doe',
        email: `test${Date.now()}@example.com`,
        password: 'SecurePassword123!',
      };

      cy.get('[data-cy=register-link]').click();
      cy.url().should('include', '/register');

      // Fill registration form
      cy.get('[data-cy=first-name-input]').type(newUser.firstName);
      cy.get('[data-cy=last-name-input]').type(newUser.lastName);
      cy.get('[data-cy=email-input]').type(newUser.email);
      cy.get('[data-cy=password-input]').type(newUser.password);
      cy.get('[data-cy=confirm-password-input]').type(newUser.password);

      // Accept terms
      cy.get('[data-cy=terms-checkbox]').check();

      // Submit registration
      cy.get('[data-cy=register-button]').click();

      // Verify success
      cy.get('[data-cy=success-message]')
        .should('be.visible')
        .and('contain', 'Registration successful');

      // Should redirect to verification page
      cy.url().should('include', '/verify-email');
    });
  });
});
```

### API Testing and Network Stubbing

✅ **Best Practice**: Test API interactions and mock network requests

```javascript
// cypress/e2e/api-testing.cy.js - API testing examples
describe('API Testing', () => {
  beforeEach(() => {
    cy.login('user@example.com', 'password123');
  });

  context('User Profile API', () => {
    it('should load user profile data', () => {
      // Intercept API call
      cy.intercept('GET', '/api/user/profile', {
        fixture: 'user-profile.json',
      }).as('getUserProfile');

      cy.visit('/profile');

      // Wait for API call and verify request
      cy.wait('@getUserProfile').then((interception) => {
        expect(interception.response.statusCode).to.equal(200);
        expect(interception.request.headers).to.have.property('authorization');
      });

      // Verify UI displays data correctly
      cy.get('[data-cy=profile-name]').should('contain', 'John Doe');
      cy.get('[data-cy=profile-email]').should('contain', 'john@example.com');
    });

    it('should handle API errors gracefully', () => {
      // Mock API error
      cy.intercept('GET', '/api/user/profile', {
        statusCode: 500,
        body: { error: 'Internal server error' },
      }).as('getUserProfileError');

      cy.visit('/profile');

      cy.wait('@getUserProfileError');

      // Verify error handling
      cy.get('[data-cy=error-message]')
        .should('be.visible')
        .and('contain', 'Failed to load profile');

      cy.get('[data-cy=retry-button]').should('be.visible');
    });

    it('should update profile successfully', () => {
      const updatedProfile = {
        firstName: 'Jane',
        lastName: 'Smith',
        bio: 'Updated bio text',
      };

      // Mock successful update
      cy.intercept('PUT', '/api/user/profile', {
        statusCode: 200,
        body: { message: 'Profile updated successfully' },
      }).as('updateProfile');

      cy.visit('/profile/edit');

      // Update form fields
      cy.get('[data-cy=first-name-input]').clear().type(updatedProfile.firstName);

      cy.get('[data-cy=last-name-input]').clear().type(updatedProfile.lastName);

      cy.get('[data-cy=bio-textarea]').clear().type(updatedProfile.bio);

      // Submit update
      cy.get('[data-cy=save-button]').click();

      // Verify API call
      cy.wait('@updateProfile').then((interception) => {
        expect(interception.request.body).to.deep.include(updatedProfile);
      });

      // Verify success feedback
      cy.get('[data-cy=success-message]').should('be.visible').and('contain', 'Profile updated');
    });
  });

  context('File Upload API', () => {
    it('should upload profile picture', () => {
      cy.intercept('POST', '/api/user/avatar', {
        statusCode: 200,
        body: { avatarUrl: '/uploads/avatar-123.jpg' },
      }).as('uploadAvatar');

      cy.visit('/profile/edit');

      // Upload file
      cy.get('[data-cy=avatar-upload]').selectFile({
        contents: Cypress.Buffer.from('fake-image-content'),
        fileName: 'avatar.jpg',
        mimeType: 'image/jpeg',
      });

      cy.wait('@uploadAvatar');

      // Verify new avatar is displayed
      cy.get('[data-cy=avatar-preview]')
        .should('be.visible')
        .and('have.attr', 'src')
        .and('include', 'avatar-123.jpg');
    });
  });
});
```

### Component Testing

✅ **Best Practice**: Test individual components in isolation

```javascript
// src/components/UserCard.cy.js - Component test example
import UserCard from './UserCard.vue';

describe('UserCard Component', () => {
  it('should render user information correctly', () => {
    const user = {
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      avatar: '/images/john.jpg',
      role: 'Admin',
      status: 'active',
    };

    cy.mount(UserCard, {
      props: { user },
    });

    // Verify rendered content
    cy.get('[data-cy=user-name]').should('contain', user.name);
    cy.get('[data-cy=user-email]').should('contain', user.email);
    cy.get('[data-cy=user-avatar]')
      .should('have.attr', 'src', user.avatar)
      .and('have.attr', 'alt', user.name);

    cy.get('[data-cy=user-role]').should('contain', user.role);
    cy.get('[data-cy=user-status]')
      .should('contain', user.status)
      .and('have.class', 'status-active');
  });

  it('should handle missing avatar gracefully', () => {
    const user = {
      id: 2,
      name: 'Jane Smith',
      email: 'jane@example.com',
      role: 'User',
      status: 'inactive',
    };

    cy.mount(UserCard, {
      props: { user },
    });

    // Should show default avatar
    cy.get('[data-cy=user-avatar]').should('have.attr', 'src').and('include', 'default-avatar');

    cy.get('[data-cy=user-status]').should('have.class', 'status-inactive');
  });

  it('should emit events on user interactions', () => {
    const user = { id: 1, name: 'John Doe', email: 'john@example.com' };

    cy.mount(UserCard, {
      props: { user },
    }).then(({ component }) => {
      // Listen for emitted events
      cy.spy(component, '$emit').as('componentEmit');
    });

    // Trigger click event
    cy.get('[data-cy=user-card]').click();
    cy.get('@componentEmit').should('have.been.calledWith', 'userSelected', user);

    // Trigger edit button
    cy.get('[data-cy=edit-button]').click();
    cy.get('@componentEmit').should('have.been.calledWith', 'editUser', user.id);

    // Trigger delete button with confirmation
    cy.get('[data-cy=delete-button]').click();
    cy.get('[data-cy=confirm-delete]').click();
    cy.get('@componentEmit').should('have.been.calledWith', 'deleteUser', user.id);
  });
});
```

## Best Practices

### ✅ Do's

- Use data-cy attributes for reliable element selection
- Implement Page Object Model for complex applications
- Use cy.session() for efficient authentication in multiple tests
- Set up proper wait strategies with cy.intercept() for API calls
- Organize tests with clear describe/context/it structure
- Use fixtures for test data management
- Implement custom commands for reusable functionality
- Configure proper timeouts and retry logic

### ❌ Don'ts

- Don't use cy.wait(milliseconds) for arbitrary delays
- Don't rely on CSS selectors that may change frequently
- Don't ignore failed tests or flaky behavior
- Don't test third-party integrations without proper mocking
- Don't write tests that depend on external services directly
- Don't skip accessibility testing considerations
- Don't forget to clean up test data between tests
- Don't use Cypress for unit testing (use Jest/Vitest instead)

### Test Data Management and Fixtures

```javascript
// cypress/fixtures/users.json - Test data fixtures
{
  "adminUser": {
    "email": "admin@example.com",
    "password": "admin123",
    "firstName": "Admin",
    "lastName": "User",
    "role": "administrator"
  },
  "regularUser": {
    "email": "user@example.com",
    "password": "user123",
    "firstName": "Regular",
    "lastName": "User",
    "role": "user"
  },
  "userProfiles": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "avatar": "/images/john.jpg",
      "bio": "Software developer",
      "joinDate": "2023-01-15"
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "email": "jane@example.com",
      "avatar": "/images/jane.jpg",
      "bio": "Product manager",
      "joinDate": "2023-02-20"
    }
  ]
}
```

```javascript
// cypress/e2e/data-driven-testing.cy.js - Using fixtures
describe('Data-Driven Testing', () => {
  beforeEach(() => {
    cy.fixture('users').as('userData');
  });

  it('should test with multiple user types', function () {
    // Access fixture data
    const { adminUser, regularUser } = this.userData;

    // Test with admin user
    cy.login(adminUser.email, adminUser.password);
    cy.visit('/admin');
    cy.get('[data-cy=admin-panel]').should('be.visible');
    cy.logout();

    // Test with regular user
    cy.login(regularUser.email, regularUser.password);
    cy.visit('/admin');
    cy.get('[data-cy=access-denied]').should('be.visible');
  });

  it('should handle user profile data', function () {
    this.userData.userProfiles.forEach((profile) => {
      cy.intercept('GET', `/api/users/${profile.id}`, profile).as('getUser');

      cy.visit(`/users/${profile.id}`);

      cy.wait('@getUser');
      cy.get('[data-cy=user-name]').should('contain', profile.name);
      cy.get('[data-cy=user-email]').should('contain', profile.email);
    });
  });
});
```

## Development Workflow

### ✅ Cypress Development Process

```bash
# Development workflow
npm run cy:open          # Open Cypress Test Runner
npm run cy:run           # Run tests headlessly
npm run cy:run:chrome    # Run in specific browser
npm run cy:run:record    # Record to Cypress Cloud

# Test specific files
npx cypress run --spec "cypress/e2e/auth/**/*"
npx cypress run --spec "cypress/e2e/auth/login.cy.js"

# Environment-specific testing
npx cypress run --env environment=staging
npx cypress run --config baseUrl=https://staging.app.com

# Component testing
npm run cy:open:component
npm run cy:run:component

# Generate test reports
npx cypress run --reporter mochawesome
```

### ✅ CI/CD Integration

```yaml
# .github/workflows/cypress.yml - GitHub Actions
name: Cypress Tests

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  cypress-run:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        browser: [chrome, firefox, edge]

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Start application
        run: npm run start:ci &

      - name: Wait for application
        run: npx wait-on http://localhost:3000

      - name: Run Cypress tests
        uses: cypress-io/github-action@v6
        with:
          browser: ${{ matrix.browser }}
          record: true
          parallel: true
          group: 'CI - ${{ matrix.browser }}'
        env:
          CYPRESS_RECORD_KEY: ${{ secrets.CYPRESS_RECORD_KEY }}
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Upload test results
        uses: actions/upload-artifact@v4
        if: failure()
        with:
          name: cypress-screenshots-${{ matrix.browser }}
          path: cypress/screenshots

      - name: Upload videos
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: cypress-videos-${{ matrix.browser }}
          path: cypress/videos
```

## AI Agent Decision Matrix

| Scenario                  | Recommended Approach                  | Avoid                                                   |
| ------------------------- | ------------------------------------- | ------------------------------------------------------- |
| E2E user journey testing  | Cypress with real browser testing     | Unit testing tools for integration tests                |
| Component testing         | Cypress component testing             | Testing components in isolation without browser context |
| API testing               | Cypress intercepts + network stubbing | Postman/Insomnia for automated testing                  |
| Cross-browser testing     | Cypress with multiple browser configs | Manual testing across browsers                          |
| CI/CD integration         | Cypress Cloud or Docker containers    | Local-only testing approaches                           |
| Visual regression testing | Cypress + visual testing plugins      | Manual visual comparisons                               |
| Accessibility testing     | Cypress + axe-core integration        | Ignoring accessibility in automated tests               |
| Performance testing       | Cypress for user-centric metrics      | Cypress for load testing (use k6/Artillery)             |

## Integration Points

### React Testing Library Integration

```javascript
// cypress/support/commands.js - Testing Library integration
import '@testing-library/cypress/add-commands';

// Example test using Testing Library queries
describe('React Component Testing', () => {
  it('should find elements using Testing Library queries', () => {
    cy.visit('/');

    // Use Testing Library queries in Cypress
    cy.findByRole('button', { name: /submit/i }).click();
    cy.findByLabelText(/email address/i).type('user@example.com');
    cy.findByText(/welcome back/i).should('be.visible');

    // Can still use regular Cypress commands
    cy.get('[data-cy=form]').within(() => {
      cy.findByRole('textbox', { name: /password/i }).type('password');
    });
  });
});
```

### TypeScript Integration

```typescript
// cypress/support/e2e.ts - TypeScript support
/// <reference types="cypress" />

declare global {
  namespace Cypress {
    interface Chainable {
      login(email: string, password: string): Chainable<void>;
      uploadFile(selector: string, fileName: string, fileType?: string): Chainable<void>;
      seedDatabase(fixture: string): Chainable<void>;
      checkA11y(context?: any, options?: any): Chainable<void>;
    }
  }
}

// Custom command with TypeScript
Cypress.Commands.add('login', (email: string, password: string): void => {
  cy.session([email, password], () => {
    cy.visit('/login');
    cy.get('[data-cy=email-input]').type(email);
    cy.get('[data-cy=password-input]').type(password);
    cy.get('[data-cy=login-button]').click();
    cy.url().should('include', '/dashboard');
  });
});
```

## Performance Optimization

- Use cy.session() for authentication to avoid repeated login flows
- Implement proper API mocking to avoid dependency on external services
- Configure appropriate timeouts based on application characteristics
- Use test isolation effectively to prevent test interdependence
- Implement parallel test execution for faster CI/CD pipelines
- Optimize viewport and browser settings for test environment
- Use selective test execution based on changed files

## Security Considerations

- Store sensitive test data in environment variables, not in code
- Use proper authentication tokens in API testing
- Implement test data cleanup to prevent data leakage
- Avoid testing with production credentials or real user data
- Use proper network stubbing to prevent external API calls during testing
- Implement proper access controls for Cypress Cloud recordings
- Regular updates to Cypress and security-related plugins

## AI Agent Quick Reference

- **Test Strategy**: Use Cypress for E2E and integration testing, complement with unit testing tools
- **Element Selection**: Prefer data-cy attributes over CSS selectors for stability
- **API Testing**: Use intercepts for mocking and network testing patterns
- **Component Testing**: Leverage Cypress component testing for isolated component verification
- **CI/CD Integration**: Use Cypress Cloud or proper Docker configurations for reliable CI execution
- **Accessibility**: Integrate axe-core for automated accessibility testing
- **Performance**: Implement efficient authentication and test isolation strategies

### CLI Configuration

```bash
# Global configuration
[tool] config set [option] [value]

# Project-specific configuration
[tool] config --local [option] [value]
```

## Core Features

### [Feature 1]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 2]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 3]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

## Common Commands

```bash
# Essential daily commands
[tool] [basic-command]              # Description
[tool] [frequent-command] [options] # Description
[tool] [status-command]             # Check status
[tool] [help-command]               # Get help

# Advanced operations
[tool] [advanced-command] [options] # Description
[tool] [config-command]             # Configuration management
[tool] [debug-command]              # Debugging and troubleshooting
```

## Workflow Integration

### Development Workflow

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
