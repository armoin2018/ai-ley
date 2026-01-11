---
name: 'Pytest.Instructions'
description: 'See [example-21](./examples/pytest/example-21.'
keywords: [api, basic, (modern), automation, actions, async, [related, ci/cd, advanced, cases]
---



# Pytest Testing Framework Instructions

## Tool Overview
- **Tool Name**: pytest
- **Version**: 7.4+ (Python 3.8+ required)
- **Category**: Testing Framework
- **Purpose**: Comprehensive Python testing framework for unit, integration, and functional testing
- **Prerequisites**: Python 3.8+, pip package manager

## Installation & Setup
### Package Manager Installation
See [example-1](./examples/pytest/example-1.bash)

### Project Integration
See [example-2](./examples/pytest/example-2.bash)

## Configuration

### pytest.ini Configuration
See [example-3](./examples/pytest/example-3.ini)

### pyproject.toml Configuration (Modern)
See [example-4](./examples/pytest/example-4.toml)

### conftest.py - Shared Configuration
See [example-5](./examples/pytest/example-5.python)

## Core Features

### Basic Test Structure
- **Purpose**: Write clear, maintainable tests with consistent structure
- **Usage**: Follow AAA (Arrange, Act, Assert) pattern
- **Example**:
See [example-6](./examples/pytest/example-6.python)

### Async Testing
- **Purpose**: Test asynchronous code with async/await patterns
- **Usage**: Use pytest-asyncio for async test support
- **Example**:
See [example-7](./examples/pytest/example-7.python)

### Fixtures and Dependency Injection
- **Purpose**: Provide reusable test data and mock objects
- **Usage**: Use fixtures for setup, teardown, and data provision
- **Example**:
See [example-8](./examples/pytest/example-8.python)

## Common Commands
See [example-9](./examples/pytest/example-9.bash)

## Advanced Testing Patterns

### Parametrized Testing
See [example-10](./examples/pytest/example-10.python)

### Exception Testing
See [example-11](./examples/pytest/example-11.python)

### Database Testing
See [example-12](./examples/pytest/example-12.python)

## Performance and Load Testing
See [example-13](./examples/pytest/example-13.python)

## Common Issues & Solutions

### Test Discovery Issues
**Problem**: pytest not finding tests
**Solution**: Check naming conventions and directory structure
See [example-14](./examples/pytest/example-14.bash)

### Fixture Scope Issues
**Problem**: Fixtures not behaving as expected
**Solution**: Understand fixture scopes and dependencies
See [example-15](./examples/pytest/example-15.python)

### Import and Path Issues
**Problem**: Import errors when running tests
**Solution**: Configure Python path and project structure
See [example-16](./examples/pytest/example-16.python)

### Async Test Issues
**Problem**: Async tests not running properly
**Solution**: Ensure proper async configuration
See [example-17](./examples/pytest/example-17.python)

## Integration with CI/CD

### GitHub Actions Configuration
See [example-18](./examples/pytest/example-18.yaml)

### Pre-commit Hook
See [example-19](./examples/pytest/example-19.yaml)

## Useful Resources
- **Official Documentation**: https://docs.pytest.org/
- **Pytest Plugins**: https://plugincompat.herokuapp.com/
- **Best Practices**: https://docs.pytest.org/en/latest/goodpractices.html
- **pytest-asyncio**: https://pytest-asyncio.readthedocs.io/
- **pytest-cov**: https://pytest-cov.readthedocs.io/
- **pytest-mock**: https://pytest-mock.readthedocs.io/

## Version Compatibility
- **Python**: 3.8+ (pytest 7.x), 3.7+ (pytest 6.x)
- **pytest**: 7.4+ recommended, 6.x legacy support
- **Popular Plugins**: pytest-cov 4.x, pytest-xdist 3.x, pytest-asyncio 0.21+
- **Framework Integration**: FastAPI, Django, Flask, SQLAlchemy

## Troubleshooting

### Debug Mode
See [example-20](./examples/pytest/example-20.bash)

### Common Error Messages
- **Error**: `FAILED test_file.py::test_name - fixture 'fixture_name' not found`
  **Cause**: Fixture not defined or not in scope
  **Solution**: Define fixture in conftest.py or same file

- **Error**: `ImportError: attempted relative import with no known parent package`
  **Cause**: Python path issues
  **Solution**: Add project root to Python path or use absolute imports

- **Error**: `RuntimeError: There is no current event loop in thread`
  **Cause**: Async test configuration issues
  **Solution**: Install pytest-asyncio and configure properly
1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

See [example-21](./examples/pytest/example-21.bash)

### Git Hooks Integration

See [example-22](./examples/pytest/example-22.bash)

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

See [example-23](./examples/pytest/example-23.bash)

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-24](./examples/pytest/example-24.bash)

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-25](./examples/pytest/example-25.bash)

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

See [example-26](./examples/pytest/example-26.bash)

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
See [example-27](./examples/pytest/example-27.txt)bash
# Advanced scripting examples
[automation-script-example]
See [example-28](./examples/pytest/example-28.txt)[config-format]
# Performance optimization settings
[performance-config-example]
See [example-29](./examples/pytest/example-29.txt)[language]
// Example usage in context
[practical-example]
See [example-30](./examples/pytest/example-30.txt)[language]
// Advanced usage pattern
[advanced-example]
See [example-31](./examples/pytest/example-31.txt)[format]
# Template configuration
[template-example]
See [example-32](./examples/pytest/example-32.txt)

```

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
