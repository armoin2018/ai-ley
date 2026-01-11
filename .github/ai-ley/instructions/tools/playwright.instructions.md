---
name: 'Playwright.Instructions'
description: 'See [example-19](./examples/playwright/example-19.'
keywords: [api, basic, browser, automation, [related, authentication, best-practices, advanced, (playwright.config.ts), cases]
---



# Playwright End-to-End Testing Framework Instructions

## Tool Overview
- **Tool Name**: Playwright
- **Version**: 1.40+ (stable), 1.41+ (latest with enhanced features)
- **Category**: Testing Tools
- **Purpose**: Modern end-to-end testing framework for web applications
- **Prerequisites**: Node.js 18+ (16+ minimum), npm/yarn/pnpm

## Installation & Setup
### Installation Methods
See [example-1](./examples/playwright/example-1.bash)

### Project Initialization
See [example-2](./examples/playwright/example-2.bash)

## Configuration

### Basic Configuration (playwright.config.ts)
See [example-3](./examples/playwright/example-3.typescript)

### Advanced Configuration
See [example-4](./examples/playwright/example-4.typescript)

### Environment-Specific Configuration
See [example-5](./examples/playwright/example-5.typescript)

## Core Features

### Page Object Model
- **Purpose**: Organize test code with reusable page objects
- **Usage**: Create maintainable test suites with clear separation of concerns
- **Example**:
See [example-6](./examples/playwright/example-6.typescript)

### Browser Automation
- **Purpose**: Control browsers programmatically for testing web applications
- **Usage**: Navigate, interact with elements, and verify application behavior
- **Example**:
See [example-7](./examples/playwright/example-7.typescript)

### Mobile Testing
- **Purpose**: Test web applications on mobile devices and different screen sizes
- **Usage**: Ensure responsive design and mobile-specific functionality works correctly
- **Example**:
See [example-8](./examples/playwright/example-8.typescript)

## Common Commands
See [example-9](./examples/playwright/example-9.bash)

## Advanced Features

### Custom Fixtures
See [example-10](./examples/playwright/example-10.typescript)

### Network Interception
See [example-11](./examples/playwright/example-11.typescript)

### Visual Testing
See [example-12](./examples/playwright/example-12.typescript)

### Performance Testing
See [example-13](./examples/playwright/example-13.typescript)

## Testing Patterns

### Authentication Testing
See [example-14](./examples/playwright/example-14.typescript)

### Form Testing
See [example-15](./examples/playwright/example-15.typescript)

### E-commerce Testing
See [example-16](./examples/playwright/example-16.typescript)

## Environment-Specific Configuration

### CI/CD Integration
See [example-17](./examples/playwright/example-17.yaml)

### Docker Integration
See [example-18](./examples/playwright/example-18.dockerfile)

See [example-19](./examples/playwright/example-19.yaml)

## Common Issues & Solutions

### Flaky Tests
**Problem**: Tests fail intermittently due to timing issues
**Solution**: Use proper waiting strategies and assertions
See [example-20](./examples/playwright/example-20.typescript)

### Element Selection Issues
**Problem**: Elements not found or ambiguous selectors
**Solution**: Use robust locator strategies
See [example-21](./examples/playwright/example-21.typescript)

### Network and API Issues
**Problem**: Tests fail due to external dependencies
**Solution**: Mock external services and APIs
See [example-22](./examples/playwright/example-22.typescript)

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
See [example-23](./examples/playwright/example-23.bash)

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

See [example-24](./examples/playwright/example-24.bash)

### Git Hooks Integration

See [example-25](./examples/playwright/example-25.bash)

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

See [example-26](./examples/playwright/example-26.bash)

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-27](./examples/playwright/example-27.bash)

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-28](./examples/playwright/example-28.bash)

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

See [example-29](./examples/playwright/example-29.bash)

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
See [example-30](./examples/playwright/example-30.txt)bash
# Advanced scripting examples
[automation-script-example]
See [example-31](./examples/playwright/example-31.txt)[config-format]
# Performance optimization settings
[performance-config-example]

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
