---
name: 'Bun.Instructions'
description: 'See [example-32](./examples/bun/example-32.'
keywords: [api, automation, built, building, (global, async, [related, build, advanced, bun.instructions]
---



# Bun JavaScript Runtime & Package Manager Instructions

## Tool Overview
- **Tool Name**: Bun
- **Version**: 1.0+ (stable), 1.0.25+ (latest with enhanced features)
- **Category**: JavaScript Runtime & Package Manager
- **Purpose**: All-in-one JavaScript runtime, bundler, test runner, and package manager
- **Prerequisites**: No dependencies (self-contained), compatible with Node.js APIs

## Installation & Setup
### Installation Methods
See [example-1](./examples/bun/example-1.bash)

### Project Initialization
See [example-2](./examples/bun/example-2.bash)

## Configuration

### bunfig.toml (Global Configuration)
See [example-3](./examples/bun/example-3.toml)

### Package.json Configuration
See [example-4](./examples/bun/example-4.json)

### TypeScript Configuration for Bun
See [example-5](./examples/bun/example-5.json)

## Core Features

### Package Management
- **Purpose**: Ultra-fast package installation and management
- **Usage**: Install, update, and manage JavaScript dependencies
- **Example**:
See [example-6](./examples/bun/example-6.bash)

### JavaScript Runtime
- **Purpose**: Execute JavaScript and TypeScript directly without compilation
- **Usage**: Run scripts with built-in TypeScript support and Node.js compatibility
- **Example**:
See [example-7](./examples/bun/example-7.bash)

### Testing Framework
- **Purpose**: Built-in test runner with Jest-compatible API
- **Usage**: Run unit tests with excellent performance and built-in mocking
- **Example**:
See [example-8](./examples/bun/example-8.bash)

### Bundling and Building
- **Purpose**: Bundle JavaScript/TypeScript for production deployment
- **Usage**: Create optimized bundles for web and Node.js targets
- **Example**:
See [example-9](./examples/bun/example-9.bash)

## Common Commands
See [example-10](./examples/bun/example-10.bash)

## Advanced Features

### Built-in APIs
See [example-11](./examples/bun/example-11.typescript)

### Environment and Configuration
See [example-12](./examples/bun/example-12.typescript)

### SQLite Integration
See [example-13](./examples/bun/example-13.typescript)

## Performance Optimization

### Installation Speed
See [example-14](./examples/bun/example-14.bash)

### Runtime Performance
See [example-15](./examples/bun/example-15.typescript)

### Build Optimization
See [example-16](./examples/bun/example-16.bash)

## Testing Patterns

### Unit Testing
See [example-17](./examples/bun/example-17.typescript)

### Async Testing
See [example-18](./examples/bun/example-18.typescript)

### Mocking and Spying
See [example-19](./examples/bun/example-19.typescript)

## Common Patterns

### Web Server with Routing
See [example-20](./examples/bun/example-20.typescript)

### CLI Tool Development
See [example-21](./examples/bun/example-21.typescript)

### Database Operations
See [example-22](./examples/bun/example-22.typescript)

## Environment-Specific Configuration

### Development Environment
See [example-23](./examples/bun/example-23.toml)

### Production Environment
See [example-24](./examples/bun/example-24.toml)

### Docker Integration
See [example-25](./examples/bun/example-25.dockerfile)

## Common Issues & Solutions

### Module Resolution Issues
**Problem**: Import errors or module not found
**Solution**: Configure TypeScript and check file extensions
See [example-26](./examples/bun/example-26.typescript)

### Performance Issues
**Problem**: Slow startup or execution
**Solution**: Optimize imports and use Bun APIs
See [example-27](./examples/bun/example-27.typescript)

### Testing Issues
**Problem**: Tests fail or behave differently than Jest
**Solution**: Use Bun-compatible patterns
See [example-28](./examples/bun/example-28.typescript)

## Integration with Development Tools

### VS Code Configuration
See [example-29](./examples/bun/example-29.json)

### ESLint Configuration
See [example-30](./examples/bun/example-30.javascript)

## Useful Resources
- **Official Documentation**: https://bun.sh/docs
- **API Reference**: https://bun.sh/docs/api
- **Examples Repository**: https://github.com/oven-sh/bun/tree/main/examples
- **Discord Community**: https://bun.sh/discord
- **GitHub**: https://github.com/oven-sh/bun

## Tool-Specific Guidelines

### Best Practices
- Use Bun's built-in APIs when available for better performance
- Leverage TypeScript support without additional compilation
- Use the built-in test runner for fastest test execution
- Take advantage of fast bundling for production builds
- Use SQLite integration for local development databases

### Performance Tips
- Prefer Bun.file() over Node.js fs operations
- Use Bun.serve() for HTTP servers instead of Express
- Leverage built-in bundling instead of separate tools
- Use hot reload during development for faster iteration
- Take advantage of fast package installation

### Migration from Node.js
- Most Node.js APIs work out of the box
- Replace fs operations with Bun.file() for better performance
- Use Bun.serve() instead of Express for new projects
- Convert package-lock.json to bun.lockb automatically
- Update build scripts to use `bun build`

## Version Compatibility
- **Bun**: 1.0+ (stable release)
- **Node.js APIs**: Compatible with Node.js 18+ APIs
- **TypeScript**: Native support, no compilation needed
- **npm packages**: Full compatibility with npm ecosystem

## Troubleshooting

### Debug Mode
See [example-31](./examples/bun/example-31.bash)

### Common Error Messages
- **Error**: `Module not found`
  **Cause**: Incorrect import path or missing extension
  **Solution**: Use explicit .ts extensions, check file paths

- **Error**: `Cannot resolve module`
  **Cause**: Package not installed or wrong registry
  **Solution**: Run `bun install`, check bunfig.toml registry

- **Error**: `Permission denied`
  **Cause**: File permissions or execution rights
  **Solution**: Check file permissions, use `chmod +x`
1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

See [example-32](./examples/bun/example-32.bash)

### Git Hooks Integration

See [example-33](./examples/bun/example-33.bash)

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

See [example-34](./examples/bun/example-34.bash)

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-35](./examples/bun/example-35.bash)

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-36](./examples/bun/example-36.bash)

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

See [example-37](./examples/bun/example-37.bash)

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

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
