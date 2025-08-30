`
---
applyTo: "cypress, **/*.cy.{js,ts}, **/cypress/**"
---

# Cypress End-to-End Testing Instructions

## Overview
- **Domain**: End-to-End Testing and Integration Testing
- **Purpose**: Build reliable, maintainable E2E tests for modern web applications
- **Applicable To**: Web applications, SPAs, PWAs, and component testing
- **Integration Level**: Development workflow and CI/CD pipeline integration

## Core Principles

### Fundamental Concepts
1. **Real Browser Testing**: Tests run in actual browsers with real user interactions
2. **Time-Travel Debugging**: Visual debugging with command snapshots and DOM inspection
3. **Automatic Waiting**: Built-in retry logic eliminates flaky tests from timing issues
4. **Developer Experience**: Modern tooling with hot reload and intuitive API

### Key Benefits
- Zero configuration setup for most modern frameworks
- Powerful debugging capabilities with time-travel and visual testing
- Comprehensive assertion library and automatic waiting
- Network stubbing and request/response interception

### Common Misconceptions
- **Myth**: Cypress is only for E2E testing
  **Reality**: Supports component testing, integration testing, and API testing
- **Myth**: Cypress tests are always slow and unreliable
  **Reality**: Modern Cypress with proper patterns is fast and reliable

## Implementation Framework

### Getting Started
#### Prerequisites
- Node.js 16+ (18+ recommended)
- Modern web application (React, Vue, Angular, or vanilla JS)
- Package manager (npm, yarn, or pnpm)

#### Initial Setup
```bash
# Install Cypress
npm install --save-dev cypress

# Open Cypress for first time setup
npx cypress open

# Run tests in headless mode
npx cypress run
```

### Core Methodologies
#### Page Object Pattern
- **Purpose**: Organize test code with reusable page components
- **When to Use**: Complex applications with multiple pages and shared elements
- **Implementation Steps**:
  1. Create page object classes for each major page/component
  2. Encapsulate element selectors and common actions
  3. Use page objects in test files for maintainable code
- **Success Metrics**: Reduced code duplication and improved test maintenance

#### Custom Commands
- **Purpose**: Create reusable commands for common test operations
- **When to Use**: Repetitive actions like authentication, form filling, or navigation
- **Implementation Steps**:
  1. Define custom commands in cypress/support/commands.js
  2. Add TypeScript declarations for better developer experience
  3. Use commands across test files for consistency
- **Success Metrics**: Improved test readability and reduced boilerplate

### Process Integration
#### CI/CD Integration
```bash
# Install Cypress GitHub Action
# .github/workflows/e2e.yml
name: E2E Tests
on: [push, pull_request]
jobs:
  cypress-run:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: cypress-io/github-action@v6
        with:
          build: npm run build
          start: npm start
          wait-on: 'http://localhost:3000'
```

#### Development Workflow
```bash
# Development workflow
npm run dev &          # Start development server
npx cypress open       # Open Cypress GUI for development
npx cypress run --spec "cypress/e2e/auth.cy.js"  # Run specific test
```

## Best Practices

### Modern Test Patterns
```javascript
// cypress/e2e/user-authentication.cy.js
describe('User Authentication', () => {
  beforeEach(() => {
    // Reset database state
    cy.task('db:reset')
    // Visit login page
    cy.visit('/login')
  })

  it('should login with valid credentials', () => {
    // Use data attributes for reliable selectors
    cy.get('[data-cy=email-input]').type('user@example.com')
    cy.get('[data-cy=password-input]').type('securepassword123')
    cy.get('[data-cy=login-button]').click()

    // Verify successful login
    cy.url().should('include', '/dashboard')
    cy.get('[data-cy=user-menu]').should('contain', 'Welcome, User')
    
    // Verify local storage token
    cy.window().its('localStorage').invoke('getItem', 'authToken').should('exist')
  })

  it('should show error for invalid credentials', () => {
    cy.get('[data-cy=email-input]').type('invalid@example.com')
    cy.get('[data-cy=password-input]').type('wrongpassword')
    cy.get('[data-cy=login-button]').click()

    // Verify error handling
    cy.get('[data-cy=error-message]')
      .should('be.visible')
      .and('contain', 'Invalid credentials')
    
    // Ensure we stay on login page
    cy.url().should('include', '/login')
  })
})
```

### API Testing and Network Interception
```javascript
// cypress/e2e/api-integration.cy.js
describe('API Integration', () => {
  beforeEach(() => {
    // Intercept API calls
    cy.intercept('GET', '/api/users', { fixture: 'users.json' }).as('getUsers')
    cy.intercept('POST', '/api/users', { statusCode: 201, body: { id: 123 } }).as('createUser')
  })

  it('should handle user creation flow', () => {
    cy.visit('/users')
    
    // Wait for initial data load
    cy.wait('@getUsers')
    cy.get('[data-cy=user-list]').should('be.visible')

    // Create new user
    cy.get('[data-cy=add-user-button]').click()
    cy.get('[data-cy=name-input]').type('John Doe')
    cy.get('[data-cy=email-input]').type('john@example.com')
    cy.get('[data-cy=submit-button]').click()

    // Verify API call and response
    cy.wait('@createUser').then((interception) => {
      expect(interception.request.body).to.include({
        name: 'John Doe',
        email: 'john@example.com'
      })
    })

    // Verify UI updates
    cy.get('[data-cy=success-message]').should('contain', 'User created successfully')
  })
})
```

### Custom Commands and Utilities
```javascript
// cypress/support/commands.js
Cypress.Commands.add('login', (email = 'user@example.com', password = 'password123') => {
  cy.session([email, password], () => {
    cy.visit('/login')
    cy.get('[data-cy=email-input]').type(email)
    cy.get('[data-cy=password-input]').type(password)
    cy.get('[data-cy=login-button]').click()
    cy.url().should('include', '/dashboard')
  })
})

Cypress.Commands.add('selectByTestId', (testId) => {
  return cy.get(`[data-cy=${testId}]`)
})

Cypress.Commands.add('uploadFile', (selector, fileName) => {
  cy.get(selector).selectFile(`cypress/fixtures/${fileName}`)
})

// Usage in tests
cy.login()  // Login with default credentials
cy.login('admin@example.com', 'adminpass')  // Login with custom credentials
cy.selectByTestId('submit-button').click()
cy.uploadFile('[data-cy=file-input]', 'sample.pdf')
```

## Common Patterns and Examples

### Pattern 1: Component Testing
**Scenario**: Test individual components in isolation
**Implementation**:
```javascript
// cypress/component/UserCard.cy.js
import UserCard from '../../src/components/UserCard'

describe('UserCard Component', () => {
  it('should display user information correctly', () => {
    const user = {
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      avatar: '/images/john.jpg'
    }

    cy.mount(<UserCard user={user} />)
    
    cy.get('[data-cy=user-name]').should('contain', 'John Doe')
    cy.get('[data-cy=user-email]').should('contain', 'john@example.com')
    cy.get('[data-cy=user-avatar]').should('have.attr', 'src', '/images/john.jpg')
  })

  it('should handle click events', () => {
    const onClickSpy = cy.spy().as('onClickSpy')
    const user = { id: 1, name: 'John Doe', email: 'john@example.com' }

    cy.mount(<UserCard user={user} onClick={onClickSpy} />)
    cy.get('[data-cy=user-card]').click()
    cy.get('@onClickSpy').should('have.been.calledWith', user)
  })
})
```
**Expected Outcomes**: Faster feedback for component-level issues and better isolation

### Pattern 2: Visual Testing
**Scenario**: Ensure UI consistency across changes
**Implementation**:
```javascript
// cypress/e2e/visual-regression.cy.js
describe('Visual Regression Tests', () => {
  it('should match homepage design', () => {
    cy.visit('/')
    cy.get('[data-cy=header]').should('be.visible')
    
    // Visual comparison (requires cypress-image-diff or similar plugin)
    cy.compareSnapshot('homepage')
  })

  it('should handle responsive design', () => {
    cy.viewport(375, 667)  // Mobile viewport
    cy.visit('/')
    cy.compareSnapshot('homepage-mobile')

    cy.viewport(1280, 720)  // Desktop viewport
    cy.visit('/')
    cy.compareSnapshot('homepage-desktop')
  })
})
```
**Expected Outcomes**: Automated detection of unintended visual changes

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Brittle Selectors
- **Description**: Using CSS selectors that change frequently
- **Why It's Problematic**: Tests break with UI changes unrelated to functionality
- **Better Approach**: Use data-cy attributes or stable selectors

#### Anti-Pattern 2: Overly Complex Tests
- **Description**: Single test covering multiple user journeys
- **Why It's Problematic**: Hard to debug and maintain, unclear test intent
- **Better Approach**: Break into focused, single-responsibility tests

## Tools and Resources

### Essential Configuration
```javascript
// cypress.config.js
const { defineConfig } = require('cypress')

module.exports = defineConfig({
  e2e: {
    baseUrl: 'http://localhost:3000',
    supportFile: 'cypress/support/e2e.js',
    specPattern: 'cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',
    viewportWidth: 1280,
    viewportHeight: 720,
    video: true,
    screenshotOnRunFailure: true,
    retries: {
      runMode: 2,
      openMode: 0
    }
  },
  component: {
    devServer: {
      framework: 'react',
      bundler: 'vite'
    },
    specPattern: 'cypress/component/**/*.cy.{js,jsx,ts,tsx}'
  }
})
```

### Useful Plugins
- **@cypress/code-coverage**: Code coverage reporting
- **cypress-image-diff**: Visual regression testing
- **cypress-axe**: Accessibility testing
- **cypress-real-events**: Real browser events for complex interactions

### Learning Resources
- **Cypress Documentation**: https://docs.cypress.io/
- **Best Practices Guide**: https://docs.cypress.io/guides/references/best-practices
- **Cypress Real World App**: https://github.com/cypress-io/cypress-realworld-app
- **Testing Trophy**: https://kentcdodds.com/blog/the-testing-trophy-and-testing-classifications

## Quality and Compliance

### Quality Standards
- Test coverage >80% for critical user journeys
- All tests should run in under 5 minutes in CI/CD
- Zero flaky tests in the main test suite
- Clear test descriptions following Given-When-Then pattern

### Performance Standards
- Page load assertions within 2 seconds
- API response time monitoring under 500ms
- Visual regression tests complete within 30 seconds
- Parallel test execution to reduce overall runtime

### Audit and Review Processes
- Weekly test maintenance and cleanup
- Monthly performance review and optimization
- Quarterly accessibility audit integration
- Annual testing strategy review and updates

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Flaky Tests Due to Timing
**Symptoms**: Tests pass sometimes, fail other times
**Root Causes**: Race conditions, improper waiting, network delays
**Solutions**:
1. Use cy.wait() with proper aliases for network requests
2. Implement custom waiting commands for dynamic content
3. Use cy.should() for automatic retrying of assertions
4. Avoid cy.wait(number) for arbitrary time delays
**Prevention**: Always wait for specific conditions rather than arbitrary timeouts

#### Issue 2: Cross-Origin Errors
**Symptoms**: Tests fail when navigating between different domains
**Root Causes**: Browser security restrictions, subdomain differences
**Solutions**:
1. Configure chromeWebSecurity: false for development
2. Use cy.origin() for cross-origin testing
3. Set up proper CORS configuration
4. Use API testing instead of cross-origin navigation
**Prevention**: Design test flows to minimize cross-origin navigation

### Escalation Procedures
- **Test Failures**: Developer → QA lead → Product team review
- **Performance Issues**: QA team → DevOps → Infrastructure optimization
- **Tool Issues**: Team lead → Cypress community → Enterprise support

### Continuous Improvement
- Regular test code reviews and refactoring
- Performance monitoring and optimization
- Tool and plugin evaluation and updates
- Team training and best practices sharing

## AI Assistant Guidelines

When helping with Cypress Testing:

1. **Test Strategy First**: Always understand the application architecture and user flows before writing tests
2. **Selector Strategy**: Prioritize data-cy attributes over CSS selectors for stability
3. **Modern Patterns**: Use session-based authentication and proper API interception
4. **Performance Focus**: Include timing considerations and proper waiting strategies
5. **Maintainability**: Structure tests with page objects and custom commands for reusability
6. **Debugging Support**: Include proper error handling and debugging strategies
7. **CI/CD Integration**: Consider CI/CD requirements and parallel execution patterns
8. **Comprehensive Coverage**: Balance E2E, integration, and component testing approaches

### Decision Making Framework
When helping teams choose Cypress approaches:

1. **Testing Strategy**: Understand application type and critical user journeys
2. **Tool Selection**: Evaluate Cypress vs alternatives based on team needs
3. **Architecture Design**: Plan test organization and maintenance strategies
4. **Performance Planning**: Design for fast feedback and reliable execution
5. **Integration Strategy**: Plan for CI/CD and development workflow integration

### Code Generation Rules
- Generate tests using modern Cypress syntax and best practices
- Include proper selectors with data-cy attributes
- Use session-based authentication for performance
- Implement proper waiting and assertion patterns
- Include custom commands for common operations
- Generate corresponding fixtures and test data
- Include accessibility and performance considerations
- Provide debugging and troubleshooting guidance

### Quality Enforcement
- ✅ Enforce data-cy attribute usage for selectors
- ✅ Require proper API interception and mocking
- ✅ Block arbitrary waits in favor of conditional waiting
- ✅ Enforce test isolation and independence
- ✅ Require meaningful test descriptions and organization
- ✅ Promote session-based authentication patterns
- ✅ Enforce proper error handling and debugging
- ✅ Require CI/CD integration considerations