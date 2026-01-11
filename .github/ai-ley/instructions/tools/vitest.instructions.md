---
name: 'Vitest.Instructions'
description: 'See [example-28](./examples/vitest/example-28.'
keywords: [(basic), api, (react), automation, commands, async, [related, ci/cd, advanced, cases]
---



# Vitest Testing Framework Instructions

## Tool Overview
- **Tool Name**: Vitest
- **Version**: 0.34+ (stable), 1.0+ (latest with enhanced features)
- **Category**: Testing Tools
- **Purpose**: Blazing fast unit testing framework powered by Vite
- **Prerequisites**: Node.js 16+, Vite project (recommended), npm/yarn/pnpm

## Installation & Setup
### Package Manager Installation
See [example-1](./examples/vitest/example-1.bash)

### Project Integration
See [example-2](./examples/vitest/example-2.bash)

## Configuration

### vitest.config.ts (Basic)
See [example-3](./examples/vitest/example-3.typescript)

### Advanced Configuration
See [example-4](./examples/vitest/example-4.typescript)

### Setup Files
See [example-5](./examples/vitest/example-5.typescript)

### Mock Configuration
See [example-6](./examples/vitest/example-6.typescript)

## Core Features

### Unit Testing
- **Purpose**: Test individual functions and components in isolation
- **Usage**: Write focused tests for specific functionality
- **Example**:
See [example-7](./examples/vitest/example-7.typescript)

### Component Testing (React)
- **Purpose**: Test React components behavior and rendering
- **Usage**: Test component props, state, events, and DOM interaction
- **Example**:
See [example-8](./examples/vitest/example-8.typescript)

### Mocking and Spying
- **Purpose**: Replace dependencies with controlled test doubles
- **Usage**: Mock external APIs, modules, and functions
- **Example**:
See [example-9](./examples/vitest/example-9.typescript)

## Common Commands
See [example-10](./examples/vitest/example-10.bash)

## Advanced Features

### Custom Matchers
See [example-11](./examples/vitest/example-11.typescript)

### Test Fixtures and Factories
See [example-12](./examples/vitest/example-12.typescript)

### Snapshot Testing
See [example-13](./examples/vitest/example-13.typescript)

### Performance Testing
See [example-14](./examples/vitest/example-14.typescript)

## Common Patterns

### Testing React Hooks
See [example-15](./examples/vitest/example-15.typescript)

### Testing Async Operations
See [example-16](./examples/vitest/example-16.typescript)

### Testing Context and Providers
See [example-17](./examples/vitest/example-17.typescript)

## Performance Optimization

### Test Execution Speed
See [example-18](./examples/vitest/example-18.typescript)

### Memory Optimization
See [example-19](./examples/vitest/example-19.typescript)

### Selective Test Running
See [example-20](./examples/vitest/example-20.bash)

## Common Issues & Solutions

### Mock Resolution Issues
**Problem**: Mocks not working correctly
**Solution**: Ensure proper mock setup and placement
See [example-21](./examples/vitest/example-21.typescript)

### Async Test Issues
**Problem**: Tests timing out or not waiting for async operations
**Solution**: Proper async/await usage and increased timeouts
See [example-22](./examples/vitest/example-22.typescript)

### Environment Setup Issues
**Problem**: Browser APIs not available in test environment
**Solution**: Proper environment configuration and polyfills
See [example-23](./examples/vitest/example-23.typescript)

## Integration with Development Tools

### CI/CD Integration
See [example-24](./examples/vitest/example-24.yaml)

### VS Code Integration
See [example-25](./examples/vitest/example-25.json)

### ESLint Integration
See [example-26](./examples/vitest/example-26.javascript)

## Useful Resources
- **Official Documentation**: https://vitest.dev/
- **API Reference**: https://vitest.dev/api/
- **Configuration Guide**: https://vitest.dev/config/
- **Examples**: https://github.com/vitest-dev/vitest/tree/main/examples
- **Testing Library Integration**: https://testing-library.com/docs/react-testing-library/intro/
- **Migration from Jest**: https://vitest.dev/guide/migration.html

## Tool-Specific Guidelines

### Test Organization
- Group related tests in describe blocks
- Use descriptive test names that explain the expected behavior
- Follow the Arrange-Act-Assert pattern
- Keep tests focused and independent
- Use proper setup and teardown for test isolation

### Mocking Best Practices
- Mock at the boundary of your system (external APIs, file system)
- Use factory functions for creating test data
- Reset mocks between tests to prevent interference
- Mock only what you need for the specific test
- Verify mock calls when testing interactions

### Performance Considerations
- Run tests in parallel when possible
- Use selective test execution during development
- Monitor test execution time and optimize slow tests
- Use proper cleanup to prevent memory leaks
- Cache dependencies for faster startup

## Version Compatibility
- **Vitest**: 0.34+ (stable), 1.0+ (latest features)
- **Node.js**: 16+ (minimum), 18+ (recommended)
- **Vite**: 4.0+ (recommended), works with 3.x
- **Testing Library**: @testing-library/react 13+, @testing-library/jest-dom 5+

## Troubleshooting

### Debug Mode
See [example-27](./examples/vitest/example-27.bash)

### Common Error Messages
- **Error**: `ReferenceError: vi is not defined`
  **Cause**: Missing globals configuration
  **Solution**: Add `globals: true` in vitest config

- **Error**: `Cannot find module '@testing-library/jest-dom'`
  **Cause**: Missing setup file configuration
  **Solution**: Configure setupFiles in vitest config

- **Error**: `TypeError: Cannot read property 'mockImplementation' of undefined`
  **Cause**: Incorrect mock syntax
  **Solution**: Use `vi.fn()` instead of `jest.fn()`
1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

See [example-28](./examples/vitest/example-28.bash)

### Git Hooks Integration

See [example-29](./examples/vitest/example-29.bash)

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

See [example-30](./examples/vitest/example-30.bash)

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-31](./examples/vitest/example-31.bash)

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-32](./examples/vitest/example-32.bash)

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

See [example-33](./examples/vitest/example-33.bash)

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
