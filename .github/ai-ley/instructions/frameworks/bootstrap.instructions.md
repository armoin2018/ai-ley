---
name: 'Bootstrap.Instructions'
description: 'See [example-1](./examples/bootstrap/example-1.'
keywords: [applying, agent, [pattern, analysis, api, basic, advanced, agents, avoid, accessibility]
---



# Bootstrap Framework Instructions for AI Agents

## When to Use Bootstrap

Use Bootstrap when you need:

- Rapid prototyping with pre-built components
- Responsive design out-of-the-box
- Consistent UI patterns across team projects
- Cross-browser compatibility without custom CSS
- Accessibility features built into components
- Large ecosystem of themes and plugins
- Projects where design consistency is more important than uniqueness
- Enterprise applications requiring standard UI patterns

## When to Avoid Bootstrap

Consider alternatives when:

- Creating highly custom, unique designs (use Tailwind CSS)
- Bundle size is critical concern (use custom CSS or lighter frameworks)
- Team prefers utility-first approach (use Tailwind CSS)
- Need specific design system compliance (create custom solution)
- Working with modern component frameworks that provide their own styling
- Project requires extensive customization that fights Bootstrap defaults

## Framework Overview

- **Framework**: Bootstrap
- **Version**: 5.3+
- **Type**: CSS framework with optional JavaScript components
- **Language**: CSS/SCSS, JavaScript (optional)
- **Use Cases**: Responsive web design, admin dashboards, corporate websites, rapid prototyping

## Installation & Setup

### ✅ Recommended: CDN for Quick Start

See [example-1](./examples/bootstrap/example-1.html)

### ✅ NPM Installation for Build Process

See [example-2](./examples/bootstrap/example-2.bash)

### ✅ Webpack/Vite Integration

See [example-3](./examples/bootstrap/example-3.javascript)

See [example-4](./examples/bootstrap/example-4.scss)

### AI Agent Decision Tree

- **For rapid prototyping**: Use CDN version for immediate setup
- **For production projects**: Use npm with custom Sass compilation
- **For modern frameworks**: Consider CSS modules or styled-components integration
- **For performance-critical sites**: Use only required components via Sass imports

## Project Structure

### ✅ Basic Bootstrap Project

See [example-5](./examples/bootstrap/example-5.txt)

### ✅ Advanced Bootstrap with Build Process

See [example-6](./examples/bootstrap/example-6.txt)

## Core Concepts

### Grid System and Layout

✅ **Best Practice**: Use Bootstrap's 12-column grid system effectively

See [example-7](./examples/bootstrap/example-7.html)

### Components and JavaScript Integration

✅ **Best Practice**: Proper component initialization and interaction

See [example-8](./examples/bootstrap/example-8.html)

See [example-9](./examples/bootstrap/example-9.javascript)

### Utility Classes and Customization

✅ **Best Practice**: Leverage utility classes for rapid development

See [example-10](./examples/bootstrap/example-10.html)

## Best Practices

### ✅ Do's

- Use semantic HTML elements (`<nav>`, `<main>`, `<section>`, `<article>`)
- Implement proper ARIA attributes for accessibility
- Customize Bootstrap variables instead of overriding CSS classes
- Use responsive utility classes for different screen sizes
- Implement form validation with Bootstrap's built-in classes
- Test components across different browsers and devices
- Use Bootstrap's spacing utilities (m-, p-) consistently
- Leverage flexbox utilities for complex layouts

### ❌ Don'ts

- Don't override Bootstrap classes with `!important` (customize variables instead)
- Don't mix Bootstrap grid with other CSS grid systems
- Don't forget to include proper meta viewport tag for responsive design
- Don't use inline styles when Bootstrap utilities are available
- Don't ignore accessibility guidelines and ARIA attributes
- Don't load entire Bootstrap if only using specific components
- Don't forget to test JavaScript components on mobile devices
- Don't use outdated Bootstrap versions (security and feature updates)

### Accessibility and Performance

See [example-11](./examples/bootstrap/example-11.html)

## Development Workflow

### ✅ Bootstrap Development Process

See [example-12](./examples/bootstrap/example-12.bash)

### Component Development Pattern

See [example-13](./examples/bootstrap/example-13.html)

## AI Agent Decision Matrix

| Scenario                    | Recommended Approach                  | Avoid                                  |
| --------------------------- | ------------------------------------- | -------------------------------------- |
| Rapid prototyping           | Bootstrap CDN + default theme         | Custom CSS from scratch                |
| Corporate/Admin dashboard   | Bootstrap with custom variables       | Highly stylized design frameworks      |
| Marketing website           | Bootstrap + custom components         | If brand requires unique design        |
| Component library           | Bootstrap as base with extensions     | If team prefers utility-first approach |
| Mobile-first responsive     | Bootstrap grid + utility classes      | Fixed-width layouts                    |
| Accessibility-critical apps | Bootstrap with ARIA enhancements      | Custom solutions without testing       |
| Performance-critical sites  | Custom Bootstrap build (tree-shaking) | Full Bootstrap bundle                  |
| Team with CSS expertise     | Bootstrap + Sass customization        | If team prefers styled-components      |

## Integration Points

### React Integration

See [example-14](./examples/bootstrap/example-14.jsx)

### Vue.js Integration

See [example-15](./examples/bootstrap/example-15.vue)

## Version Compatibility and Migration

- **Bootstrap 5.3+**: Latest stable version with CSS Grid support
- **Browser Support**: All modern browsers, IE11+ (with polyfills)
- **Node.js**: 16+ for build tools
- **Sass**: 1.32+ for latest features

### Migration from Bootstrap 4 to 5

See [example-16](./examples/bootstrap/example-16.scss)

## Common Issues & Solutions

### Modal Not Opening

**Problem**: Modal doesn't trigger when button is clicked
**Solution**:

See [example-17](./examples/bootstrap/example-17.html)

### Grid Columns Not Responsive

**Problem**: Columns don't stack properly on mobile
**Solution**:

See [example-18](./examples/bootstrap/example-18.html)

### Custom Styles Not Applying

**Problem**: Custom CSS is overridden by Bootstrap
**Solution**:

See [example-19](./examples/bootstrap/example-19.scss)

## Performance Optimization

- Only import required Bootstrap components via Sass
- Use CSS purging tools to remove unused styles
- Optimize images with proper responsive attributes
- Implement lazy loading for carousel images
- Use CSS custom properties for dynamic theming
- Minimize JavaScript component initialization
- Use Bootstrap's built-in optimization features

## Security Considerations

- Validate all form inputs server-side regardless of Bootstrap validation
- Implement proper CSRF protection for forms
- Use HTTPS for all CDN resources
- Sanitize user-generated content in dynamic components
- Implement proper content security policy (CSP)
- Regular updates to latest Bootstrap version for security patches

## AI Agent Quick Reference

- **Component Selection**: Choose appropriate Bootstrap components based on content structure and user interaction needs
- **Responsive Design**: Always consider mobile-first approach with proper breakpoint usage
- **Accessibility**: Implement ARIA attributes and semantic HTML with Bootstrap components
- **Customization**: Use Sass variables and custom CSS properties instead of overriding classes
- **Performance**: Optimize by importing only required components and using proper image loading strategies
- **Integration**: Adapt Bootstrap patterns to work with modern JavaScript frameworks while maintaining functionality

### [Pattern Name]

```[language]
// Example implementation
[code example]
See [example-20](./examples/bootstrap/example-20.txt)[language]
// Example implementation
[code example]
See [example-21](./examples/bootstrap/example-21.txt)[format]
# Configuration options
[example configuration]
See [example-22](./examples/bootstrap/example-22.txt)[format]
# Configuration options
[example configuration]
See [example-23](./examples/bootstrap/example-23.txt)bash
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
See [example-24](./examples/bootstrap/example-24.txt)bash
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
