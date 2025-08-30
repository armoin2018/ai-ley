# Tool Instructions Template

## Tool Overview
- **Tool Name**: [Name of the tool]
- **Version**: [Current stable version or version range]
- **Category**: [Development, Testing, Deployment, Monitoring, etc.]
- **Purpose**: [Primary use case and problem it solves]
- **Prerequisites**: [Required dependencies or tools]

## Installation & Setup
### Package Manager Installation
```bash
# npm/yarn installation
npm install -g [tool-name]
# or
yarn global add [tool-name]

# pip installation
pip install [tool-name]

# homebrew installation (macOS)
brew install [tool-name]

# Other platform-specific commands
[other installation methods]
```

### Project Integration
```bash
# Initialize in project
[tool] init

# Add to existing project
[project setup commands]
```

## Configuration
### Configuration File
```[config-format]
# [config-file-name] (e.g., .toolrc, tool.config.js, tool.yaml)
[configuration-example]
```

### Environment Variables
```bash
# Environment-specific settings
[TOOL_ENV_VAR]=[value]
[TOOL_CONFIG_PATH]=[path]
```

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
