---
applyTo: '**/*.html,**/*.css,**/*.scss'
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

```bash
# NPM installation (recommended)
npm install bulma

# CDN (quick prototyping)
# <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">

# Sass customization setup
npm install -D sass
```

## Project Structure

```
project-root/
├── src/
│   ├── scss/
│   │   ├── main.scss          # Main Sass file
│   │   ├── _variables.scss    # Custom variables
│   │   └── _custom.scss       # Custom components
│   ├── css/
│   └── js/
├── node_modules/
├── package.json
└── index.html
```

## Core Concepts

### Flexbox-Based Grid

- **Purpose**: Create responsive layouts using CSS Flexbox
- **Usage**: Use `.columns` container with `.column` elements
- **Example**:

```html
<div class="columns">
  <div class="column">Auto-width column</div>
  <div class="column is-half">Half-width column</div>
</div>
```

### Modifier Classes

- **Purpose**: Consistent sizing, colors, and states across components
- **Usage**: Add modifiers like `is-primary`, `is-large`, `is-active`
- **Example**:

```html
<button class="button is-primary is-large">Primary Large Button</button>
```

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

```html
<nav class="navbar" role="navigation" aria-label="main navigation">
  <div class="navbar-brand">
    <a class="navbar-item" href="/">Logo</a>
    <a role="button" class="navbar-burger" aria-label="menu">
      <span></span><span></span><span></span>
    </a>
  </div>
  <div class="navbar-menu">
    <div class="navbar-start">
      <a class="navbar-item">Home</a>
      <a class="navbar-item">About</a>
    </div>
  </div>
</nav>
```

### Card Layout

```html
<div class="card">
  <div class="card-image">
    <figure class="image is-4by3">
      <img src="image.jpg" alt="Description" />
    </figure>
  </div>
  <div class="card-content">
    <div class="content">
      <h4>Card Title</h4>
      <p>Card content goes here.</p>
    </div>
  </div>
</div>
```

### Form Components

```html
<div class="field">
  <label class="label">Name</label>
  <div class="control">
    <input class="input" type="text" placeholder="Enter name" />
  </div>
</div>
```

## Configuration

### Custom Variables (Sass)

```scss
// _variables.scss
$primary: #3273dc;
$family-primary: 'Open Sans', sans-serif;
$radius-large: 8px;

// Import Bulma
@import '~bulma/bulma.sass';
```

### Main Sass File

```scss
// main.scss
@import 'variables';
@import 'custom';
```

## Essential Commands

```bash
# Watch Sass compilation
sass --watch src/scss:dist/css

# Build for production
sass src/scss/main.scss dist/css/main.css --style=compressed

# Using with build tools
npm run build
```

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
