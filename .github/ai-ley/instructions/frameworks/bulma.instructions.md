---
name: 'Bulma.Instructions'
description: 'AI agent guidelines for using Bulma CSS framework effectively and following modern CSS best practices.'
keywords: [api, [config, avoid, (sass), agents, architecture, analysis, alternatives, based, breaking]
---



# Bulma CSS Framework Instructions

AI agent guidelines for using Bulma CSS framework effectively and following modern CSS best practices.

## Framework Overview

- **Framework Name**: Bulma
- **Version**: 0.9.4+
- **Type**: Modern CSS framework
- **Language**: CSS/Sass
- **Use Cases**: Responsive web applications, landing pages, admin dashboards, prototypes

## Installation & Setup

See [example-1](./examples/bulma/example-1.bash)

## Project Structure

See [example-2](./examples/bulma/example-2.txt)

## Core Concepts

### Flexbox-Based Grid

- **Purpose**: Create responsive layouts using CSS Flexbox
- **Usage**: Use `.columns` container with `.column` elements
- **Example**:

See [example-3](./examples/bulma/example-3.html)

### Modifier Classes

- **Purpose**: Consistent sizing, colors, and states across components
- **Usage**: Add modifiers like `is-primary`, `is-large`, `is-active`
- **Example**:

See [example-4](./examples/bulma/example-4.html)

## Development Workflow

1. **Setup**: Import Bulma into your Sass file or use CDN
2. **Development**: Use class-based styling with optional Sass customization
3. **Testing**: Test responsive behavior across breakpoints
4. **Building**: Compile Sass if using custom variables
5. **Deployment**: Include compiled CSS in production build

## Best Practices

### ✅ Good Practices

- Use semantic HTML elements with Bulma classes
- Customize variables instead of overriding CSS rules
- Leverage Bulma's responsive utilities (`is-hidden-mobile`, etc.)
- Keep custom CSS minimal by using Bulma modifiers
- Use consistent spacing with Bulma's spacing helpers

### ❌ Avoid These

- Don't override Bulma classes directly (use Sass variables)
- Avoid mixing Bulma with other CSS frameworks
- Don't ignore mobile-first responsive design
- Avoid inline styles when Bulma classes exist

## Common Patterns

### Responsive Navigation

See [example-5](./examples/bulma/example-5.html)

### Card Layout

See [example-6](./examples/bulma/example-6.html)

### Form Components

See [example-7](./examples/bulma/example-7.html)

## Configuration

### Custom Variables (Sass)

See [example-8](./examples/bulma/example-8.scss)

### Main Sass File

See [example-9](./examples/bulma/example-9.scss)

## Essential Commands

See [example-10](./examples/bulma/example-10.bash)

## Common Issues & Solutions

### Layout Breaking on Mobile

**Problem**: Columns stack incorrectly on mobile devices
**Solution**: Use responsive column classes like `is-half-tablet is-full-mobile`

### Custom Colors Not Working

**Problem**: Custom color variables not applying
**Solution**: Define custom colors before importing Bulma and use proper Sass variable syntax

### JavaScript Functionality Missing

**Problem**: Navbar burger, dropdowns not working
**Solution**: Bulma is CSS-only; add JavaScript for interactive components

## Performance Optimization

- Import only needed Bulma components in Sass
- Use PurgeCSS to remove unused styles in production
- Optimize custom Sass compilation
- Leverage browser caching for compiled CSS

## Security Considerations

- Sanitize user-generated content in dynamic layouts
- Use proper ARIA attributes for accessibility
- Validate form inputs on both client and server
- Avoid inline styles that could introduce XSS vulnerabilities

## Framework-Specific Guidelines

### CSS Organization

- Define custom variables in separate file
- Keep component overrides minimal
- Use Bulma's modifier system instead of custom CSS
- Follow mobile-first responsive design principles

### Component Architecture

- Build reusable component templates
- Use consistent spacing and sizing modifiers
- Implement proper semantic HTML structure
- Test accessibility with screen readers

## Integration Points

### JavaScript Frameworks

- **React**: Use className instead of class
- **Vue.js**: Bind classes dynamically with :class
- **Angular**: Use [ngClass] for conditional classes

### Build Tools

- **Webpack**: Configure Sass loader for Bulma imports
- **Vite**: Install sass and import Bulma in main CSS file
- **Parcel**: Zero-config Sass compilation with Bulma

## Common Error Messages

- **Error**: `File to import not found or unreadable: ~bulma/bulma.sass`
  **Cause**: Sass cannot resolve node_modules path
  **Solution**: Use proper import syntax or configure includePaths

- **Error**: `Undefined variable: $primary`
  **Cause**: Variable defined after Bulma import
  **Solution**: Define variables before importing Bulma

## Decision Guidelines for AI Agents

### When to Use Bulma

- ✅ Rapid prototyping needs
- ✅ Teams preferring utility-first approach
- ✅ Projects requiring clean, modern design
- ✅ Need for responsive layouts without JavaScript

### When to Consider Alternatives

- ❌ Highly customized design requirements
- ❌ Very small projects (use minimal CSS)
- ❌ Teams already invested in other frameworks
- ❌ Need for extensive JavaScript components

### Decision Tree

1. **Need rapid development?** → Yes: Bulma is good choice
2. **Design heavily customized?** → Yes: Consider custom CSS or other frameworks
3. **Team familiar with CSS frameworks?** → No: Bulma has gentle learning curve
4. **Project size small?** → Yes: Consider lighter alternatives

### Code Quality Checks

- Verify responsive behavior across breakpoints
- Check accessibility with proper ARIA labels
- Validate HTML semantic structure
- Test form usability and validation states
- Ensure consistent spacing and typography

## Configuration

### [Config File 1]

```[format]
# Configuration options
[example configuration]
See [example-11](./examples/bulma/example-11.txt)[format]
# Configuration options
[example configuration]
See [example-12](./examples/bulma/example-12.txt)bash
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
See [example-13](./examples/bulma/example-13.txt)bash
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
