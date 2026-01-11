---
name: 'Cypress.Instructions'
description: 'See [example-1](./examples/cypress/example-1.'
keywords: [api, avoid, agent, agents, [related, [feature, authentication, ci/cd, automation, cases]
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

See [example-1](./examples/cypress/example-1.bash)

### ✅ Project Setup and Configuration

See [example-2](./examples/cypress/example-2.javascript)

### ✅ Support Files and Custom Commands

See [example-3](./examples/cypress/example-3.javascript)

See [example-4](./examples/cypress/example-4.javascript)

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

See [example-5](./examples/cypress/example-5.javascript)

### API Testing and Network Stubbing

✅ **Best Practice**: Test API interactions and mock network requests

See [example-6](./examples/cypress/example-6.javascript)

### Component Testing

✅ **Best Practice**: Test individual components in isolation

See [example-7](./examples/cypress/example-7.javascript)

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

See [example-8](./examples/cypress/example-8.javascript)

See [example-9](./examples/cypress/example-9.javascript)

## Development Workflow

### ✅ Cypress Development Process

See [example-10](./examples/cypress/example-10.bash)

### ✅ CI/CD Integration

See [example-11](./examples/cypress/example-11.yaml)

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

See [example-12](./examples/cypress/example-12.javascript)

### TypeScript Integration

See [example-13](./examples/cypress/example-13.typescript)

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

See [example-14](./examples/cypress/example-14.bash)

## Core Features

### [Feature 1]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

See [example-15](./examples/cypress/example-15.bash)

### [Feature 2]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

See [example-16](./examples/cypress/example-16.bash)

### [Feature 3]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

See [example-17](./examples/cypress/example-17.bash)

## Common Commands

See [example-18](./examples/cypress/example-18.bash)

## Workflow Integration

### Development Workflow

1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

See [example-19](./examples/cypress/example-19.bash)

### Git Hooks Integration

See [example-20](./examples/cypress/example-20.bash)

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

#
### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-21](./examples/cypress/example-21.bash)

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-22](./examples/cypress/example-22.bash)

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-23](./examples/cypress/example-23.bash)

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

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
