---
applyTo: "**/*.css,**/*.scss,**/*.sass,**/*.less"
---

# CSS Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for CSS development. These include AI linting hints to automatically enforce style rules and maintain clean, maintainable, and performant stylesheets.

⸻

📂 Project Architecture

✅ Rule: Enforce component-based architecture

- Organize CSS into logical components and modules
- Use consistent naming conventions (BEM, OOCSS, or SMACSS)
- Separate layout, components, utilities, and theme styles
- Implement proper CSS cascade and inheritance principles

✅ Rule: Strict separation of concerns

- CSS → Visual presentation and layout only
- HTML → Structural markup with semantic class names
- JavaScript → Behavior and interaction (no inline styles)
- Assets → Images, fonts, and media in organized directories

✅ Rule: File Organization

- Use modular CSS files organized by component or feature
- Implement consistent import/include order for preprocessors
- Separate vendor styles from custom styles
- Use meaningful file names that reflect content and purpose

✅ Rule: Responsive Design

- Mobile-first approach for all layouts and components
- Use consistent breakpoint system across the project
- Implement flexible grid systems and responsive typography
- Optimize for performance across all device types

✅ Rule: CSS Methodology

- Follow consistent CSS methodology (BEM recommended)
- Use utility classes for common patterns and spacing
- Implement design system tokens for colors, typography, and spacing

⸻

📜 CSS Frameworks & Tools

✅ Rule: Approved frameworks and libraries

- **Frameworks**: Bootstrap, Tailwind CSS, Bulma for rapid development
- **Preprocessors**: Sass (SCSS), Less, Stylus for enhanced CSS capabilities
- **PostCSS**: Autoprefixer, cssnano, postcss-preset-env for processing
- **Grid Systems**: CSS Grid, Flexbox, Bootstrap Grid for layouts
- **Reset/Normalize**: Normalize.css, CSS resets for cross-browser consistency

✅ Rule: Development Tools

- Use Stylelint for CSS linting and code quality
- Use Prettier for consistent code formatting
- Use browser dev tools for debugging and performance analysis
- Use build tools (webpack, Gulp, Parcel) for optimization

✅ Rule: Performance Tools

- Use PurgeCSS or similar tools to remove unused styles
- Implement critical CSS extraction for above-the-fold content
- Use CSS minification and compression for production builds
- Monitor CSS bundle sizes and loading performance

⸻

🖋 CSS Coding Standards

✅ Selector and Naming Conventions

- Use BEM (Block Element Modifier) methodology for consistent naming
- Use lowercase with hyphens for class names
- Avoid overly specific selectors and excessive nesting
- Use semantic class names that describe purpose, not appearance

✅ Example:

```css
/* Good: BEM methodology */
.card {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card__header {
  padding: 1rem;
  border-bottom: 1px solid #e0e0e0;
}

.card__title {
  font-size: 1.25rem;
  font-weight: 600;
  margin: 0;
}

.card--featured {
  border: 2px solid #007bff;
}

.card--large {
  padding: 2rem;
}
```

⸻

✅ Property Order and Organization

- Group related properties together (positioning, box model, typography, visual)
- Use consistent property ordering across the codebase
- Add comments for complex calculations or browser-specific hacks
- Use shorthand properties when appropriate

✅ Example:

```css
.component {
  /* Positioning */
  position: relative;
  top: 0;
  left: 0;
  z-index: 10;
  
  /* Box Model */
  display: flex;
  width: 100%;
  height: auto;
  padding: 1rem;
  margin: 0 auto;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  
  /* Typography */
  font-family: 'Helvetica Neue', Arial, sans-serif;
  font-size: 1rem;
  line-height: 1.5;
  text-align: left;
  
  /* Visual */
  background-color: white;
  color: #333;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  opacity: 1;
  
  /* Animation */
  transition: all 0.3s ease;
}
```

⸻

✅ Performance & Efficiency

- 🚫 Avoid inefficient selectors and excessive specificity
- 🚫 Avoid inline styles and !important declarations
- ✅ Use efficient selectors (class-based over descendant)
- ✅ Implement consistent spacing and sizing systems

❌ Bad:

```css
/* Avoid overly specific selectors */
body div.container ul.navigation li.nav-item a.nav-link {
  color: blue !important; /* Avoid !important */
}

/* Avoid inefficient selectors */
* {
  box-sizing: border-box; /* Too broad */
}

.content > div > p > span {
  font-weight: bold; /* Too specific */
}
```

✅ Good:

```css
/* Use specific, efficient selectors */
.nav-link {
  color: #007bff;
  text-decoration: none;
  transition: color 0.2s ease;
}

.nav-link:hover {
  color: #0056b3;
}

/* Use utility classes for common patterns */
.text-center { text-align: center; }
.mt-1 { margin-top: 0.25rem; }
.mb-2 { margin-bottom: 0.5rem; }
.p-3 { padding: 1rem; }
```

⸻

✅ Responsive Design Patterns

- Use mobile-first media queries with consistent breakpoints
- Implement fluid typography and spacing systems
- Use CSS Grid and Flexbox for flexible layouts
- Optimize for touch interfaces and accessibility

✅ Example:

```css
/* Mobile-first approach */
.grid-container {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
  padding: 1rem;
}

.card {
  background: white;
  border-radius: 8px;
  padding: 1rem;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* Tablet breakpoint */
@media (min-width: 768px) {
  .grid-container {
    grid-template-columns: repeat(2, 1fr);
    gap: 1.5rem;
    padding: 2rem;
  }
  
  .card {
    padding: 1.5rem;
  }
}

/* Desktop breakpoint */
@media (min-width: 1024px) {
  .grid-container {
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
    max-width: 1200px;
    margin: 0 auto;
  }
  
  .card {
    padding: 2rem;
  }
}

/* Large desktop breakpoint */
@media (min-width: 1400px) {
  .grid-container {
    grid-template-columns: repeat(4, 1fr);
  }
}
```

⸻

✅ CSS Custom Properties (Variables)

- Use CSS custom properties for design tokens and theming
- Implement consistent color palettes and spacing scales
- Use meaningful variable names that describe purpose
- Create fallback values for better browser compatibility

✅ Example:

```css
:root {
  /* Color System */
  --color-primary: #007bff;
  --color-primary-dark: #0056b3;
  --color-secondary: #6c757d;
  --color-success: #28a745;
  --color-danger: #dc3545;
  --color-warning: #ffc107;
  
  /* Neutral Colors */
  --color-white: #ffffff;
  --color-gray-100: #f8f9fa;
  --color-gray-200: #e9ecef;
  --color-gray-300: #dee2e6;
  --color-gray-800: #343a40;
  --color-black: #000000;
  
  /* Typography */
  --font-family-base: 'Helvetica Neue', Arial, sans-serif;
  --font-family-heading: 'Georgia', serif;
  --font-size-base: 1rem;
  --line-height-base: 1.5;
  
  /* Spacing Scale */
  --spacing-xs: 0.25rem;
  --spacing-sm: 0.5rem;
  --spacing-md: 1rem;
  --spacing-lg: 1.5rem;
  --spacing-xl: 2rem;
  --spacing-xxl: 3rem;
  
  /* Border Radius */
  --border-radius-sm: 4px;
  --border-radius-md: 8px;
  --border-radius-lg: 12px;
  
  /* Shadows */
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.1);
  --shadow-md: 0 2px 4px rgba(0, 0, 0, 0.1);
  --shadow-lg: 0 4px 8px rgba(0, 0, 0, 0.15);
}

/* Using custom properties */
.button {
  background-color: var(--color-primary);
  color: var(--color-white);
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--border-radius-md);
  box-shadow: var(--shadow-sm);
  transition: all 0.2s ease;
}

.button:hover {
  background-color: var(--color-primary-dark);
  box-shadow: var(--shadow-md);
}
```

⸻

✅ Animations and Transitions

- Use CSS animations sparingly and purposefully
- Implement consistent timing functions and durations
- Respect user preferences for reduced motion
- Optimize animations for performance (use transform and opacity)

✅ Example:

```css
/* Respect user preferences */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}

/* Smooth transitions */
.button {
  background-color: var(--color-primary);
  transform: translateY(0);
  transition: background-color 0.2s ease, transform 0.2s ease;
}

.button:hover {
  background-color: var(--color-primary-dark);
  transform: translateY(-2px);
}

/* Purposeful animations */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.card {
  animation: fadeInUp 0.6s ease-out;
}

/* Loading animation */
@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.spinner {
  width: 20px;
  height: 20px;
  border: 2px solid var(--color-gray-300);
  border-top-color: var(--color-primary);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}
```

⸻

🧠 Performance & Optimization

- Minimize CSS file sizes through efficient selectors and code organization
- Use CSS-in-JS or atomic CSS when appropriate for component-based architectures
- Implement critical CSS loading strategies for better perceived performance
- Optimize images and assets referenced in CSS

✅ Example:

```css
/* Efficient selector patterns */
.btn { /* Base styles */ }
.btn-primary { /* Modifier styles */ }
.btn-large { /* Size modifier */ }

/* Avoid deep nesting */
.nav .nav-list .nav-item .nav-link { /* Too nested */ }
.nav-link { /* Better - direct class targeting */ }

/* Use efficient properties for animations */
.smooth-transform {
  will-change: transform;
  transform: translateZ(0); /* Force hardware acceleration */
}

/* Optimize font loading */
@font-face {
  font-family: 'CustomFont';
  src: url('/fonts/custom-font.woff2') format('woff2'),
       url('/fonts/custom-font.woff') format('woff');
  font-display: swap; /* Improve loading performance */
}
```

⸻

🧪 Testing Standards

✅ CSS Testing and Quality Assurance

- Use Stylelint for automated CSS linting and error detection
- Test styles across different browsers and devices
- Validate accessibility compliance and color contrast
- Implement visual regression testing for critical components

✅ Example Configuration:

```css
/* Stylelint configuration example */
/* .stylelintrc.json */
{
  "extends": ["stylelint-config-standard"],
  "rules": {
    "indentation": 2,
    "string-quotes": "single",
    "no-duplicate-selectors": true,
    "color-hex-case": "lower",
    "color-hex-length": "short",
    "declaration-block-trailing-semicolon": "always",
    "declaration-colon-space-after": "always",
    "declaration-colon-space-before": "never",
    "block-opening-brace-space-before": "always",
    "selector-combinator-space-after": "always",
    "selector-combinator-space-before": "always"
  }
}

/* Accessibility testing considerations */
.accessible-button {
  /* Ensure sufficient color contrast */
  background-color: var(--color-primary);
  color: var(--color-white);
  
  /* Ensure adequate touch target size */
  min-height: 44px;
  min-width: 44px;
  
  /* Provide focus indicators */
  outline: 2px solid transparent;
  outline-offset: 2px;
}

.accessible-button:focus {
  outline-color: var(--color-primary);
}

.accessible-button:focus:not(:focus-visible) {
  outline: none;
}
```

⸻

⚡ Performance Rules

✅ CSS-Specific Optimization

- 🚫 Avoid overly specific selectors and excessive nesting
- 🚫 Avoid !important declarations and inline styles
- ✅ Use class-based selectors over element or ID selectors
- ✅ Implement consistent spacing and sizing systems
- ✅ Use CSS custom properties for maintainable theming
- ✅ Optimize for critical rendering path

⸻

✍️ Commit Message Conventions

- Prefix commits with: `style:`, `feat:`, `fix:`, `refactor:`, `perf:`
- Example: `style: add responsive grid system with mobile-first approach`

⸻

🚦 AI Enforcement Summary

✅ Enforce BEM methodology for consistent naming
✅ Block overly specific selectors and excessive nesting
✅ Block !important declarations except for utility classes
✅ Require mobile-first responsive design approach
✅ Enforce consistent property ordering within rule sets
✅ Require CSS custom properties for design tokens
✅ Enforce accessibility best practices and color contrast
✅ Prefer class-based selectors over element selectors
✅ Require performance-optimized animation properties
✅ Use Stylelint for automated code quality enforcement
✅ Auto-fix formatting violations with Prettier where possible
