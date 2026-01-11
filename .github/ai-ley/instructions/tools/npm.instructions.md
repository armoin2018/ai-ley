---
name: 'Npm.Instructions'
description: 'See [example-11](./examples/npm/example-11.'
keywords: [automation, .npmrc, [related, bundle, authentication, cache, analysis, advanced, auditing, (monorepo)]
---



# npm Package Manager Instructions

## Tool Overview
- **Tool Name**: npm (Node Package Manager)
- **Version**: 9.0+ (Node.js 18+), npm 10.0+ (Node.js 20+)
- **Category**: Package Management
- **Purpose**: Manage JavaScript/Node.js dependencies, scripts, and package publishing
- **Prerequisites**: Node.js 16.0+ (includes npm), internet connection for registry access

## Installation & Setup
### Node.js and npm Installation
See [example-1](./examples/npm/example-1.bash)

### Project Integration
See [example-2](./examples/npm/example-2.bash)

## Configuration

### package.json Configuration
See [example-3](./examples/npm/example-3.json)

### .npmrc Configuration
See [example-4](./examples/npm/example-4.ini)

### Environment Variables
See [example-5](./examples/npm/example-5.bash)

## Core Features

### Package Installation
- **Purpose**: Install and manage project dependencies
- **Usage**: Add libraries and tools to your project
- **Example**:
See [example-6](./examples/npm/example-6.bash)

### Package Management
- **Purpose**: Manage installed packages and dependencies
- **Usage**: Update, remove, and audit packages
- **Example**:
See [example-7](./examples/npm/example-7.bash)

### Script Execution
- **Purpose**: Run predefined scripts and commands
- **Usage**: Execute build, test, and development tasks
- **Example**:
See [example-8](./examples/npm/example-8.bash)

## Common Commands
See [example-9](./examples/npm/example-9.bash)

## Advanced Features

### Workspaces (Monorepo)
See [example-10](./examples/npm/example-10.json)

See [example-11](./examples/npm/example-11.bash)

### Package Scripts with Advanced Patterns
See [example-12](./examples/npm/example-12.json)

### Security and Auditing
See [example-13](./examples/npm/example-13.bash)

### Publishing Packages
See [example-14](./examples/npm/example-14.bash)

## Common Patterns

### Development Workflow
See [example-15](./examples/npm/example-15.bash)

### Dependency Management Best Practices
See [example-16](./examples/npm/example-16.json)

### Version Management
See [example-17](./examples/npm/example-17.bash)

## Performance Optimization

### Installation Speed
See [example-18](./examples/npm/example-18.bash)

### Cache Management
See [example-19](./examples/npm/example-19.bash)

### Bundle Analysis
See [example-20](./examples/npm/example-20.bash)

## Common Issues & Solutions

### Dependency Conflicts
**Problem**: Conflicting dependency versions
**Solution**: Use npm overrides or peer dependencies
See [example-21](./examples/npm/example-21.json)

### Permission Errors
**Problem**: Permission denied when installing global packages
**Solution**: Configure npm to use different directory or use nvm
See [example-22](./examples/npm/example-22.bash)

### Package-lock.json Conflicts
**Problem**: Merge conflicts in package-lock.json
**Solution**: Delete and regenerate
See [example-23](./examples/npm/example-23.bash)

### Network Issues
**Problem**: Network connectivity problems
**Solution**: Configure proxy or use different registry
See [example-24](./examples/npm/example-24.bash)

## Integration with Development Tools

### CI/CD Integration
See [example-25](./examples/npm/example-25.yaml)

### Docker Integration
See [example-26](./examples/npm/example-26.dockerfile)

### IDE Integration
See [example-27](./examples/npm/example-27.json)

## Useful Resources
- **Official Documentation**: https://docs.npmjs.com/
- **npm CLI Reference**: https://docs.npmjs.com/cli/
- **Package.json Guide**: https://docs.npmjs.com/cli/configuring-npm/package-json
- **npm Registry**: https://www.npmjs.com/
- **Semantic Versioning**: https://semver.org/
- **Node.js Best Practices**: https://github.com/goldbergyoni/nodebestpractices

## Tool-Specific Guidelines

### Package.json Best Practices
- Use exact versions for critical dependencies
- Keep dependencies up to date but test thoroughly
- Use peerDependencies for libraries that expect the host to provide dependencies
- Include engines field to specify Node.js/npm versions
- Add keywords for better discoverability

### Script Organization
- Use meaningful script names that describe their purpose
- Organize scripts logically (build, test, lint, etc.)
- Use pre/post hooks sparingly and document their purpose
- Consider using npm-run-all for running multiple scripts

### Security Guidelines
- Regularly run npm audit and fix vulnerabilities
- Use .npmignore to exclude sensitive files from published packages
- Enable two-factor authentication for npm account
- Use npm tokens for CI/CD instead of passwords

## Version Compatibility
- **Node.js**: 16.0+ (npm 8.x), 18.0+ (npm 9.x), 20.0+ (npm 10.x)
- **npm**: 8.0+ (legacy), 9.0+ (current), 10.0+ (latest)
- **Package managers**: Compatible with yarn, pnpm for most operations
- **Platform Support**: Windows, macOS, Linux

## Troubleshooting

### Debug Mode
See [example-28](./examples/npm/example-28.bash)

### Common Error Messages
- **Error**: `EACCES: permission denied`
  **Cause**: Insufficient permissions for global install
  **Solution**: Use nvm or change npm prefix

- **Error**: `Cannot resolve dependency`
  **Cause**: Conflicting dependency versions
  **Solution**: Use npm overrides or update dependencies

- **Error**: `Network timeout`
  **Cause**: Network connectivity issues
  **Solution**: Configure registry timeout or use different registry
1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

See [example-29](./examples/npm/example-29.bash)

### Git Hooks Integration

See [example-30](./examples/npm/example-30.bash)

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

See [example-31](./examples/npm/example-31.bash)

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-32](./examples/npm/example-32.bash)

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

See [example-33](./examples/npm/example-33.bash)

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

See [example-34](./examples/npm/example-34.bash)

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
