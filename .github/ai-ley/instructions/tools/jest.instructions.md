---
name: 'Jest.Instructions'
description: 'Development guidelines and best practices for Jest.Instructions'
keywords: [api, basic, assertions, async, (matchers), ci/cd, authentication, (jest.config.js), authorization, advanced]
---



# Jest Testing Framework Instructions

## Tool Overview
- **Tool Name**: Jest
- **Version**: 29.7+ (stable), 30.0+ (latest with enhanced features)
- **Category**: Testing Tools
- **Purpose**: Comprehensive JavaScript testing framework with built-in assertions, mocking, and coverage
- **Prerequisites**: Node.js 16+ (18+ recommended), npm/yarn/pnpm

## Installation & Setup
### Basic Installation
See [example-1](./examples/jest/example-1.bash)

### TypeScript Setup
See [example-2](./examples/jest/example-2.bash)

### React Testing Setup
See [example-3](./examples/jest/example-3.bash)

## Configuration

### Basic Configuration (jest.config.js)
See [example-4](./examples/jest/example-4.javascript)

### TypeScript Configuration (jest.config.js)
See [example-5](./examples/jest/example-5.javascript)

### React Configuration (jest.config.js)
See [example-6](./examples/jest/example-6.javascript)

### Advanced Configuration
See [example-7](./examples/jest/example-7.javascript)

## Core Features

### Test Structure
- **Purpose**: Organize tests with describe blocks and individual test cases
- **Usage**: Group related tests and define test scenarios
- **Example**:
See [example-8](./examples/jest/example-8.javascript)

### Assertions (Matchers)
- **Purpose**: Verify that values meet certain conditions
- **Usage**: Use Jest's built-in matchers to test various conditions
- **Example**:
See [example-9](./examples/jest/example-9.javascript)

### Mocking
- **Purpose**: Replace real implementations with mock functions for testing
- **Usage**: Mock modules, functions, and external dependencies
- **Example**:
See [example-10](./examples/jest/example-10.javascript)

## Common Commands
See [example-11](./examples/jest/example-11.bash)

## Advanced Features

### Snapshot Testing
See [example-12](./examples/jest/example-12.javascript)

### Setup and Teardown
See [example-13](./examples/jest/example-13.javascript)

### Custom Matchers
See [example-14](./examples/jest/example-14.javascript)

## Testing Patterns

### React Component Testing
See [example-15](./examples/jest/example-15.javascript)

### API Testing
See [example-16](./examples/jest/example-16.javascript)

### Utility Functions Testing
See [example-17](./examples/jest/example-17.javascript)

### Error Handling Testing
See [example-18](./examples/jest/example-18.javascript)

## Environment-Specific Configuration

### package.json Scripts
See [example-19](./examples/jest/example-19.json)

### CI/CD Configuration
See [example-20](./examples/jest/example-20.yaml)

### Docker Integration
See [example-21](./examples/jest/example-21.dockerfile)

## Common Issues & Solutions

### Mocking Issues
**Problem**: Mock not working or being overridden
**Solution**: Proper mock placement and clearing
See [example-22](./examples/jest/example-22.javascript)

### Async Testing Issues
**Problem**: Tests passing when they should fail
**Solution**: Proper async/await usage
See [example-23](./examples/jest/example-23.javascript)

### Memory Leaks
**Problem**: Tests running slowly or failing due to memory issues
**Solution**: Proper cleanup and mocking
See [example-24](./examples/jest/example-24.javascript)

## Useful Resources
- **Official Documentation**: https://jestjs.io/docs/getting-started
- **API Reference**: https://jestjs.io/docs/api
- **Expect API**: https://jestjs.io/docs/expect
- **Mock Functions**: https://jestjs.io/docs/mock-functions
- **Testing Library**: https://testing-library.com/docs/react-testing-library/intro

## Tool-Specific Guidelines

### Best Practices
- Write descriptive test names that explain what is being tested
- Use `describe` blocks to group related tests logically
- Mock external dependencies to ensure test isolation
- Test both success and error scenarios
- Use setup/teardown methods for common test preparation

### Performance Tips
- Use `--maxWorkers` to optimize parallel execution
- Mock heavy operations and external services
- Use `--onlyChanged` to run only tests related to changed files
- Configure coverage collection to avoid performance overhead
- Use `--cache` to speed up subsequent test runs

### Security Considerations
- Never commit real API keys or credentials in test files
- Use environment variables for sensitive test configuration
- Mock authentication services rather than using real credentials
- Validate input sanitization in your tests
- Test authorization boundaries and access controls

## Version Compatibility
- **Node.js**: 16+ (18+ recommended)
- **TypeScript**: 4.3+ (with ts-jest)
- **Babel**: 7+ (for modern JavaScript features)
- **React**: 16.8+ (with React Testing Library)

## Troubleshooting

### Common Error Messages
- **Error**: `Cannot find module` during imports
  **Cause**: Module path resolution issues
  **Solution**: Check `moduleNameMapping` in jest.config.js

- **Error**: `ReferenceError: regeneratorRuntime is not defined`
  **Cause**: Missing async/await support
  **Solution**: Install and configure @babel/preset-env

- **Error**: `Tests are not defined`
  **Cause**: Jest not finding test files
  **Solution**: Check `testMatch` patterns in configuration

- **Error**: `Cannot read property of undefined`
  **Cause**: Improper mocking or missing setup
  **Solution**: Verify mock implementations and setup files

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
