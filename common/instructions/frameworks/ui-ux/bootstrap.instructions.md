---
applyTo: 'bootstrap, bootstrap-css, bootstrap-framework'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Bootstrap CSS framework for responsive web design'
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

```html
<!-- Bootstrap CSS -->
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
  rel="stylesheet"
/>

<!-- Bootstrap JavaScript Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
```

### ✅ NPM Installation for Build Process

```bash
# Install Bootstrap and dependencies
npm install bootstrap @popperjs/core

# If using Sass
npm install sass --save-dev

# Create basic HTML structure
touch index.html src/scss/styles.scss src/js/main.js
```

### ✅ Webpack/Vite Integration

```javascript
// webpack.config.js
const path = require('path');

module.exports = {
  entry: './src/js/main.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js',
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: ['style-loader', 'css-loader', 'sass-loader'],
      },
    ],
  },
};
```

```scss
// src/scss/styles.scss - Custom Bootstrap compilation
// Import Bootstrap functions first
@import 'bootstrap/scss/functions';

// Custom variables (override defaults)
$primary: #007bff;
$secondary: #6c757d;
$border-radius: 0.375rem;
$font-family-base: 'Inter', sans-serif;

// Import Bootstrap variables and mixins
@import 'bootstrap/scss/variables';
@import 'bootstrap/scss/mixins';

// Import specific Bootstrap components (tree-shaking)
@import 'bootstrap/scss/root';
@import 'bootstrap/scss/reboot';
@import 'bootstrap/scss/type';
@import 'bootstrap/scss/grid';
@import 'bootstrap/scss/containers';
@import 'bootstrap/scss/buttons';
@import 'bootstrap/scss/forms';
@import 'bootstrap/scss/navbar';
@import 'bootstrap/scss/card';
@import 'bootstrap/scss/modal';
@import 'bootstrap/scss/utilities';

// Custom styles
.custom-button {
  @include button-variant($primary, $primary);
}
```

### AI Agent Decision Tree

- **For rapid prototyping**: Use CDN version for immediate setup
- **For production projects**: Use npm with custom Sass compilation
- **For modern frameworks**: Consider CSS modules or styled-components integration
- **For performance-critical sites**: Use only required components via Sass imports

## Project Structure

### ✅ Basic Bootstrap Project

```
bootstrap-project/
├── index.html              # Main HTML file
├── css/
│   ├── bootstrap.min.css   # Bootstrap CSS
│   └── custom.css          # Custom overrides
├── js/
│   ├── bootstrap.bundle.js # Bootstrap JavaScript
│   └── main.js             # Custom JavaScript
├── images/                 # Image assets
└── docs/                   # Documentation
```

### ✅ Advanced Bootstrap with Build Process

```
advanced-bootstrap/
├── package.json            # Dependencies
├── webpack.config.js       # Build configuration
├── src/
│   ├── scss/
│   │   ├── styles.scss     # Main Sass file
│   │   ├── variables.scss  # Custom variables
│   │   └── components/     # Custom components
│   │       ├── buttons.scss
│   │       ├── cards.scss
│   │       └── navigation.scss
│   ├── js/
│   │   ├── main.js         # JavaScript entry
│   │   └── components/     # JS components
│   │       ├── modal.js
│   │       └── carousel.js
│   └── html/
│       ├── index.html
│       └── partials/       # HTML partials
├── dist/                   # Built files
└── assets/                 # Static assets
```

## Core Concepts

### Grid System and Layout

✅ **Best Practice**: Use Bootstrap's 12-column grid system effectively

```html
<!-- Responsive grid layout -->
<div class="container-fluid">
  <div class="row">
    <div class="col-12 col-md-6 col-lg-4">
      <div class="card h-100">
        <div class="card-body">
          <h5 class="card-title">Column 1</h5>
          <p class="card-text">Content adapts to screen size.</p>
        </div>
      </div>
    </div>
    <div class="col-12 col-md-6 col-lg-4">
      <div class="card h-100">
        <div class="card-body">
          <h5 class="card-title">Column 2</h5>
          <p class="card-text">Equal height columns with flex utilities.</p>
        </div>
      </div>
    </div>
    <div class="col-12 col-md-12 col-lg-4">
      <div class="card h-100">
        <div class="card-body">
          <h5 class="card-title">Column 3</h5>
          <p class="card-text">Responsive breakpoints ensure optimal layout.</p>
        </div>
      </div>
    </div>
  </div>
</div>
```

### Components and JavaScript Integration

✅ **Best Practice**: Proper component initialization and interaction

```html
<!-- Modal component with proper accessibility -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Open Modal
</button>

<div
  class="modal fade"
  id="exampleModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal Title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="modalForm">
          <div class="mb-3">
            <label for="userName" class="form-label">Name</label>
            <input type="text" class="form-control" id="userName" required />
            <div class="invalid-feedback">Please provide a valid name.</div>
          </div>
          <div class="mb-3">
            <label for="userEmail" class="form-label">Email</label>
            <input type="email" class="form-control" id="userEmail" required />
            <div class="invalid-feedback">Please provide a valid email.</div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="submit" form="modalForm" class="btn btn-primary">Save</button>
      </div>
    </div>
  </div>
</div>
```

```javascript
// Advanced JavaScript integration
document.addEventListener('DOMContentLoaded', function () {
  // Initialize tooltips
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  const tooltipList = [...tooltipTriggerList].map(
    (tooltipTriggerEl) => new bootstrap.Tooltip(tooltipTriggerEl),
  );

  // Form validation
  const forms = document.querySelectorAll('.needs-validation');
  Array.from(forms).forEach((form) => {
    form.addEventListener(
      'submit',
      (event) => {
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      },
      false,
    );
  });

  // Modal events
  const modal = document.getElementById('exampleModal');
  if (modal) {
    modal.addEventListener('show.bs.modal', function (event) {
      // Reset form when modal opens
      const form = modal.querySelector('form');
      if (form) {
        form.reset();
        form.classList.remove('was-validated');
      }
    });
  }
});
```

### Utility Classes and Customization

✅ **Best Practice**: Leverage utility classes for rapid development

```html
<!-- Effective use of utility classes -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-center p-4 mb-4 bg-light rounded"
>
  <div class="mb-3 mb-md-0">
    <h4 class="mb-1 text-primary">Dashboard Header</h4>
    <p class="mb-0 text-muted">Welcome back to your dashboard</p>
  </div>
  <div class="d-flex gap-2">
    <button class="btn btn-outline-primary btn-sm">Settings</button>
    <button class="btn btn-primary btn-sm">New Project</button>
  </div>
</div>

<!-- Responsive image with utilities -->
<figure class="text-center">
  <img
    src="image.jpg"
    class="img-fluid rounded shadow-sm"
    alt="Responsive image"
    style="max-height: 400px;"
  />
  <figcaption class="figure-caption mt-2 text-muted">Image caption with proper styling</figcaption>
</figure>

<!-- Complex layout with utilities -->
<div class="row g-4">
  <div class="col-lg-8">
    <div class="card border-0 shadow-sm h-100">
      <div class="card-header bg-transparent border-bottom-0 pb-0">
        <div class="d-flex justify-content-between align-items-center">
          <h5 class="card-title mb-0">Main Content</h5>
          <div class="dropdown">
            <button class="btn btn-link p-0" data-bs-toggle="dropdown">
              <i class="bi bi-three-dots-vertical"></i>
            </button>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Edit</a></li>
              <li><a class="dropdown-item" href="#">Share</a></li>
              <li><hr class="dropdown-divider" /></li>
              <li><a class="dropdown-item text-danger" href="#">Delete</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="card-body">
        <p class="card-text">Main content area with proper spacing and typography.</p>
      </div>
    </div>
  </div>
  <div class="col-lg-4">
    <div class="card border-0 shadow-sm h-100">
      <div class="card-body">
        <h6 class="card-title">Sidebar</h6>
        <p class="card-text small text-muted">Additional information or navigation.</p>
      </div>
    </div>
  </div>
</div>
```

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

```html
<!-- Proper accessibility implementation -->
<nav aria-label="Main navigation" class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container">
    <a class="navbar-brand" href="#" aria-label="Company homepage">
      <img src="logo.svg" alt="Company Logo" height="32" />
    </a>

    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarNav"
      aria-controls="navbarNav"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">About</a>
        </li>
        <li class="nav-item dropdown">
          <a
            class="nav-link dropdown-toggle"
            href="#"
            role="button"
            data-bs-toggle="dropdown"
            aria-expanded="false"
            >Services</a
          >
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Web Design</a></li>
            <li><a class="dropdown-item" href="#">Development</a></li>
            <li><hr class="dropdown-divider" /></li>
            <li><a class="dropdown-item" href="#">Consulting</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Performance optimized image carousel -->
<div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-indicators">
    <button
      type="button"
      data-bs-target="#heroCarousel"
      data-bs-slide-to="0"
      class="active"
      aria-current="true"
      aria-label="Slide 1"
    ></button>
    <button
      type="button"
      data-bs-target="#heroCarousel"
      data-bs-slide-to="1"
      aria-label="Slide 2"
    ></button>
  </div>

  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="hero1.jpg" class="d-block w-100" alt="Hero image 1" loading="eager" />
      <div class="carousel-caption d-none d-md-block">
        <h5>First slide label</h5>
        <p>Representative placeholder content for the first slide.</p>
      </div>
    </div>
    <div class="carousel-item">
      <img src="hero2.jpg" class="d-block w-100" alt="Hero image 2" loading="lazy" />
      <div class="carousel-caption d-none d-md-block">
        <h5>Second slide label</h5>
        <p>Representative placeholder content for the second slide.</p>
      </div>
    </div>
  </div>

  <button
    class="carousel-control-prev"
    type="button"
    data-bs-target="#heroCarousel"
    data-bs-slide="prev"
  >
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button
    class="carousel-control-next"
    type="button"
    data-bs-target="#heroCarousel"
    data-bs-slide="next"
  >
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
```

## Development Workflow

### ✅ Bootstrap Development Process

```bash
# 1. Setup project with npm
npm init -y
npm install bootstrap @popperjs/core sass --save
npm install webpack webpack-cli sass-loader css-loader style-loader --save-dev

# 2. Create build script
npm pkg set scripts.dev="webpack --mode development --watch"
npm pkg set scripts.build="webpack --mode production"
npm pkg set scripts.serve="python -m http.server 8000"

# 3. Development workflow
npm run dev        # Start development build with watch
npm run serve      # Serve files for testing
npm run build      # Production build

# 4. Testing responsive design
# Use browser dev tools to test all breakpoints:
# - xs: <576px
# - sm: ≥576px
# - md: ≥768px
# - lg: ≥992px
# - xl: ≥1200px
# - xxl: ≥1400px
```

### Component Development Pattern

```html
<!-- Reusable component pattern -->
<template id="alert-component">
  <div class="alert alert-dismissible fade show" role="alert">
    <strong class="alert-title"></strong>
    <span class="alert-message"></span>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
</template>

<script>
  // Component factory function
  function createAlert(type, title, message, container) {
    const template = document.getElementById('alert-component');
    const alertElement = template.content.cloneNode(true);

    const alertDiv = alertElement.querySelector('.alert');
    alertDiv.classList.add(`alert-${type}`);

    alertElement.querySelector('.alert-title').textContent = title;
    alertElement.querySelector('.alert-message').textContent = message;

    container.appendChild(alertElement);

    // Auto-dismiss after 5 seconds
    setTimeout(() => {
      const alert = container.querySelector('.alert:last-child');
      if (alert) {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }
    }, 5000);
  }

  // Usage
  const container = document.getElementById('alert-container');
  createAlert('success', 'Success!', 'Your action was completed successfully.', container);
</script>
```

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

```jsx
// React Bootstrap example
import { Button, Modal, Form } from 'react-bootstrap';
import { useState } from 'react';

function BootstrapModal() {
  const [show, setShow] = useState(false);
  const [formData, setFormData] = useState({ name: '', email: '' });

  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);

  const handleSubmit = (e) => {
    e.preventDefault();
    console.log('Form submitted:', formData);
    handleClose();
  };

  return (
    <>
      <Button variant="primary" onClick={handleShow}>
        Open Modal
      </Button>

      <Modal show={show} onHide={handleClose} centered>
        <Modal.Header closeButton>
          <Modal.Title>Contact Form</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-3">
              <Form.Label>Name</Form.Label>
              <Form.Control
                type="text"
                value={formData.name}
                onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                required
              />
            </Form.Group>
            <Form.Group className="mb-3">
              <Form.Label>Email</Form.Label>
              <Form.Control
                type="email"
                value={formData.email}
                onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                required
              />
            </Form.Group>
          </Form>
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={handleClose}>
            Cancel
          </Button>
          <Button variant="primary" type="submit" form="contact-form">
            Save Changes
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  );
}
```

### Vue.js Integration

```vue
<template>
  <div class="container mt-4">
    <div class="row">
      <div class="col-md-8 mx-auto">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">Vue.js + Bootstrap Form</h5>
          </div>
          <div class="card-body">
            <form @submit.prevent="submitForm" class="needs-validation" novalidate>
              <div class="mb-3">
                <label for="name" class="form-label">Name</label>
                <input
                  v-model="form.name"
                  type="text"
                  class="form-control"
                  :class="{ 'is-invalid': errors.name }"
                  id="name"
                  required
                />
                <div class="invalid-feedback">{{ errors.name }}</div>
              </div>

              <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input
                  v-model="form.email"
                  type="email"
                  class="form-control"
                  :class="{ 'is-invalid': errors.email }"
                  id="email"
                  required
                />
                <div class="invalid-feedback">{{ errors.email }}</div>
              </div>

              <button type="submit" class="btn btn-primary" :disabled="isSubmitting">
                <span v-if="isSubmitting" class="spinner-border spinner-border-sm me-2"></span>
                {{ isSubmitting ? 'Submitting...' : 'Submit' }}
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        name: '',
        email: '',
      },
      errors: {},
      isSubmitting: false,
    };
  },
  methods: {
    validateForm() {
      this.errors = {};

      if (!this.form.name.trim()) {
        this.errors.name = 'Name is required';
      }

      if (!this.form.email.trim()) {
        this.errors.email = 'Email is required';
      } else if (!/\S+@\S+\.\S+/.test(this.form.email)) {
        this.errors.email = 'Please enter a valid email';
      }

      return Object.keys(this.errors).length === 0;
    },

    async submitForm() {
      if (!this.validateForm()) return;

      this.isSubmitting = true;
      try {
        // Simulate API call
        await new Promise((resolve) => setTimeout(resolve, 1000));
        console.log('Form submitted:', this.form);

        // Reset form
        this.form = { name: '', email: '' };
        this.errors = {};
      } catch (error) {
        console.error('Submission failed:', error);
      } finally {
        this.isSubmitting = false;
      }
    },
  },
};
</script>
```

## Version Compatibility and Migration

- **Bootstrap 5.3+**: Latest stable version with CSS Grid support
- **Browser Support**: All modern browsers, IE11+ (with polyfills)
- **Node.js**: 16+ for build tools
- **Sass**: 1.32+ for latest features

### Migration from Bootstrap 4 to 5

```scss
// Bootstrap 4 to 5 migration helpers
// Update these common class changes:

// .form-group → .mb-3
// .form-control-file → .form-control
// .custom-select → .form-select
// .custom-control → .form-check
// .text-left → .text-start
// .text-right → .text-end
// .float-left → .float-start
// .float-right → .float-end

// jQuery dependency removed in Bootstrap 5
// Update JavaScript initialization:
// $('.modal').modal() → new bootstrap.Modal(element)
```

## Common Issues & Solutions

### Modal Not Opening

**Problem**: Modal doesn't trigger when button is clicked
**Solution**:

```html
<!-- Ensure proper data attributes -->
<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#myModal">Open Modal</button>

<!-- Ensure modal has correct id -->
<div class="modal fade" id="myModal" tabindex="-1">
  <!-- modal content -->
</div>

<!-- Ensure Bootstrap JS is loaded -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
```

### Grid Columns Not Responsive

**Problem**: Columns don't stack properly on mobile
**Solution**:

```html
<!-- Use proper responsive classes -->
<div class="row">
  <!-- This will be full width on mobile, half width on tablet+ -->
  <div class="col-12 col-md-6">Content 1</div>
  <div class="col-12 col-md-6">Content 2</div>
</div>
```

### Custom Styles Not Applying

**Problem**: Custom CSS is overridden by Bootstrap
**Solution**:

```scss
// Use proper CSS specificity and cascade order
// 1. Include Bootstrap first
@import 'bootstrap/scss/bootstrap';

// 2. Add custom styles after Bootstrap
.my-custom-button {
  // Use Bootstrap's existing classes as base
  @extend .btn;
  @extend .btn-primary;

  // Add custom modifications
  border-radius: 50px;
  font-weight: 600;
}

// 3. Or use CSS custom properties for theming
:root {
  --bs-primary: #007bff;
  --bs-secondary: #6c757d;
}
```

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
