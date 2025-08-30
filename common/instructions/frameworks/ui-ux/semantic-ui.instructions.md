---
applyTo: '**/*.html,**/*.css,**/*.js,**/*.jsx'
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

```bash
# CDN (quick start)
# CSS: https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.css
# JS: https://cdn.jsdelivr.net/npm/semantic-ui@2.5.0/dist/semantic.min.js

# NPM installation
npm install semantic-ui-css
# OR for full customization
npm install semantic-ui

# Including in project
import 'semantic-ui-css/semantic.min.css'
import 'semantic-ui-css/semantic.min.js'
```

## Project Structure

```
project-root/
├── src/
│   ├── semantic/
│   │   ├── dist/           # Compiled CSS/JS
│   │   ├── src/            # Source files for customization
│   │   └── tasks/          # Build tasks
│   ├── components/         # Custom components
│   └── pages/
├── semantic.json           # Configuration
└── gulpfile.js            # Build configuration
```

## Core Concepts

### Semantic Naming

- **Purpose**: Use natural language class names that describe meaning, not appearance
- **Usage**: Classes like `ui primary button` instead of `btn btn-blue`
- **Example**:

```html
<button class="ui primary button">Save Changes</button>
<div class="ui warning message">Please check your input</div>
```

### Component Collections

- **Purpose**: Group related UI components with consistent behavior
- **Usage**: Use `ui` class prefix with component type and modifiers
- **Example**:

```html
<div class="ui cards">
  <div class="card">
    <div class="content">
      <div class="header">Project Alpha</div>
      <div class="description">A web application</div>
    </div>
  </div>
</div>
```

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

```html
<form class="ui form">
  <div class="field">
    <label>Name</label>
    <input type="text" placeholder="Enter your name" />
  </div>
  <div class="field">
    <label>Email</label>
    <input type="email" placeholder="Enter your email" />
  </div>
  <button class="ui submit button">Submit</button>
</form>
```

### Navigation Menu

```html
<div class="ui menu">
  <div class="header item">Brand</div>
  <a class="item">Home</a>
  <a class="item">About</a>
  <div class="right menu">
    <a class="item">Login</a>
  </div>
</div>
```

### Modal Dialog

```html
<div class="ui modal">
  <div class="header">Confirm Action</div>
  <div class="content">
    <p>Are you sure you want to proceed?</p>
  </div>
  <div class="actions">
    <div class="ui cancel button">Cancel</div>
    <div class="ui ok primary button">Confirm</div>
  </div>
</div>
```

## Configuration

### Custom Theme (theme.config)

```less
/* Global */
@fontName: 'Open Sans';
@primaryColor: #3498db;
@secondaryColor: #2ecc71;

/* Elements */
@buttonPrimaryColor: @primaryColor;
@buttonSecondaryColor: @secondaryColor;

/* Collections */
@menuPrimaryColor: @primaryColor;
```

### JavaScript Initialization

```javascript
// Initialize dropdowns
$('.ui.dropdown').dropdown();

// Initialize modals
$('.ui.modal').modal();

// Initialize tabs
$('.tabular.menu .item').tab();

// Custom settings
$('.ui.modal').modal({
  blurring: true,
  transition: 'scale',
});
```

## Essential Commands

```bash
# Install Semantic UI build tools
npm install -g gulp

# Initialize Semantic UI in project
npx semantic-ui init

# Build custom theme
gulp build

# Watch for changes
gulp watch
```

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

```jsx
// Using semantic-ui-react
import { Button, Modal, Form } from 'semantic-ui-react';

const MyComponent = () => (
  <Form>
    <Form.Input label="Name" placeholder="Enter name" />
    <Button primary type="submit">
      Submit
    </Button>
  </Form>
);
```

### Vue.js Integration

```vue
<template>
  <div class="ui form">
    <div class="field">
      <input v-model="name" placeholder="Name" />
    </div>
    <button class="ui primary button" @click="submit">Submit</button>
  </div>
</template>
```

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
```

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

## Configuration

### [Config File 1]

```[format]
# Configuration options
[example configuration]
```

### [Config File 2]

```[format]
# Configuration options
[example configuration]
```

## Essential Commands

```bash
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
```

## Common Issues & Solutions

### [Issue 1]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization

- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations

- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources

- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines

### Code Style

- [Coding conventions specific to this framework]
- [Naming conventions]
- [File organization patterns]

### Architecture Patterns

- [Recommended architectural patterns]
- [State management approaches]
- [Component/module organization]

## Integration Points

### [External Service/Tool 1]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

### [External Service/Tool 2]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

## Version Compatibility

- **Node.js**: [Supported versions]
- **Dependencies**: [Key dependency versions]
- **Browser Support**: [If applicable]
- **OS Support**: [If applicable]

## Troubleshooting

### Debug Mode

```bash
[debug commands]
```

### Log Analysis

- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages

- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]
