---
name: 'Semantic Ui.Instructions'
description: 'AI agent guidelines for using Semantic UI effectively, focusing on semantic HTML and component-based development.'
keywords: [alternatives, [pattern, [concept, analysis, api, appearing, agents, (theme.config), avoid, authentication]
---



# Semantic UI Framework Instructions

AI agent guidelines for using Semantic UI effectively, focusing on semantic HTML and component-based development.

## Framework Overview

- **Framework Name**: Semantic UI
- **Version**: 2.9.0+
- **Type**: UI component framework with semantic HTML
- **Language**: CSS/JavaScript/HTML
- **Use Cases**: Content-rich websites, admin dashboards, prototypes with natural language naming

## Installation & Setup

See [example-1](./examples/semantic-ui/example-1.bash)

## Project Structure

See [example-2](./examples/semantic-ui/example-2.txt)

## Core Concepts

### Semantic Naming

- **Purpose**: Use natural language class names that describe meaning, not appearance
- **Usage**: Classes like `ui primary button` instead of `btn btn-blue`
- **Example**:

See [example-3](./examples/semantic-ui/example-3.html)

### Component Collections

- **Purpose**: Group related UI components with consistent behavior
- **Usage**: Use `ui` class prefix with component type and modifiers
- **Example**:

See [example-4](./examples/semantic-ui/example-4.html)

## Development Workflow

1. **Setup**: Include Semantic UI CSS and JS files
2. **Development**: Use semantic class names for components
3. **Testing**: Test component interactions and responsive behavior
4. **Building**: Customize themes and compile if using source version
5. **Deployment**: Include compiled assets in production build

## Best Practices

### ✅ Good Practices

- Use semantic HTML elements with Semantic UI classes
- Follow natural language naming patterns
- Leverage built-in responsive utilities
- Use theming system for consistent design
- Test JavaScript component interactions

### ❌ Avoid These

- Don't mix Semantic UI with other CSS frameworks
- Avoid overriding Semantic UI classes directly
- Don't ignore accessibility features built into components
- Avoid inline styles when Semantic UI classes exist

## Common Patterns

### Form Layout

See [example-5](./examples/semantic-ui/example-5.html)

### Navigation Menu

See [example-6](./examples/semantic-ui/example-6.html)

### Modal Dialog

See [example-7](./examples/semantic-ui/example-7.html)

## Configuration

### Custom Theme (theme.config)

See [example-8](./examples/semantic-ui/example-8.less)

### JavaScript Initialization

See [example-9](./examples/semantic-ui/example-9.javascript)

## Essential Commands

See [example-10](./examples/semantic-ui/example-10.bash)

## Common Issues & Solutions

### Dropdown Not Working

**Problem**: Dropdown menus not responding to clicks
**Solution**: Ensure jQuery is loaded before Semantic UI JS and initialize dropdowns with `$('.ui.dropdown').dropdown()`

### Modal Not Appearing

**Problem**: Modal windows not showing on trigger
**Solution**: Check modal markup structure and ensure proper JavaScript initialization

### Responsive Layout Issues

**Problem**: Components not responsive on mobile
**Solution**: Use Semantic UI's grid system and responsive utilities like `mobile hidden`, `tablet only`

## Performance Optimization

- Use semantic-ui-css for faster loading (pre-compiled)
- Include only needed components when building from source
- Optimize jQuery usage for better performance
- Use CDN for faster asset delivery

## Security Considerations

- Sanitize user input in forms and dynamic content
- Validate form data on both client and server
- Use proper CSRF protection for form submissions
- Implement proper authentication for admin interfaces

## Framework-Specific Guidelines

### Component Usage

- Always use `ui` class as base for components
- Follow the pattern: `ui [size] [color] [state] [component]`
- Use semantic modifiers like `primary`, `secondary`, `positive`, `negative`
- Implement proper loading and error states

### HTML Structure

- Use semantic HTML5 elements as foundation
- Follow Semantic UI's expected markup structure
- Add ARIA attributes for accessibility
- Test with screen readers and keyboard navigation

## Integration Points

### React Integration

See [example-11](./examples/semantic-ui/example-11.jsx)

### Vue.js Integration

See [example-12](./examples/semantic-ui/example-12.vue)

## Common Error Messages

- **Error**: `Uncaught TypeError: $(...).dropdown is not a function`
  **Cause**: Semantic UI JavaScript not loaded or jQuery missing
  **Solution**: Ensure proper script loading order

- **Error**: Theme files not found during build
  **Cause**: Incorrect semantic.json configuration
  **Solution**: Check paths in semantic.json and ensure source files exist

## Decision Guidelines for AI Agents

### When to Use Semantic UI

- ✅ Projects needing rapid prototyping
- ✅ Content-heavy websites and dashboards
- ✅ Teams preferring semantic HTML approach
- ✅ Applications requiring rich component interactions

### When to Consider Alternatives

- ❌ Very small projects (overhead too large)
- ❌ Projects requiring extensive customization
- ❌ Modern frameworks with component systems (React, Vue)
- ❌ Performance-critical applications

### Decision Tree

1. **Need semantic HTML approach?** → Yes: Semantic UI is good choice
2. **Project uses modern JS framework?** → Yes: Consider framework-specific alternatives
3. **Need extensive customization?** → Yes: Consider more flexible alternatives
4. **Team familiar with jQuery?** → No: Consider learning curve

### Code Quality Checks

- Verify semantic class naming follows patterns
- Check component JavaScript initialization
- Test responsive behavior and accessibility
- Validate form handling and error states
- Ensure proper theme consistency across components
- **Example**: [Code example]

### [Concept 2]

- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

## Development Workflow

1. **Setup**: [Initial project setup steps]
2. **Development**: [Development server, hot reload, etc.]
3. **Testing**: [Testing framework and commands]
4. **Building**: [Build process and commands]
5. **Deployment**: [Deployment strategies]

## Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

## Common Patterns

### [Pattern Name]

```[language]
// Example implementation
[code example]
See [example-13](./examples/semantic-ui/example-13.txt)[language]
// Example implementation
[code example]
See [example-14](./examples/semantic-ui/example-14.txt)[format]
# Configuration options
[example configuration]
See [example-15](./examples/semantic-ui/example-15.txt)[format]
# Configuration options
[example configuration]
See [example-16](./examples/semantic-ui/example-16.txt)bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
See [example-17](./examples/semantic-ui/example-17.txt)bash
[debug commands]
```

### Log Analysis

- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages

- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]

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
