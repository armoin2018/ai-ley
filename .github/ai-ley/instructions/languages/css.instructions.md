---
name: 'Css.Instructions'
description: 'Development guidelines and best practices for Css.Instructions'
keywords: [(with, api, languages, coding, gui, architecture, hints), css.instructions, guide, framework]
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

See [example-1](./examples/css/example-1.css)

⸻

✅ Property Order and Organization

- Group related properties together (positioning, box model, typography, visual)
- Use consistent property ordering across the codebase
- Add comments for complex calculations or browser-specific hacks
- Use shorthand properties when appropriate

✅ Example:

See [example-2](./examples/css/example-2.css)

⸻

✅ Performance & Efficiency

- 🚫 Avoid inefficient selectors and excessive specificity
- 🚫 Avoid inline styles and !important declarations
- ✅ Use efficient selectors (class-based over descendant)
- ✅ Implement consistent spacing and sizing systems

❌ Bad:

See [example-3](./examples/css/example-3.css)

✅ Good:

See [example-4](./examples/css/example-4.css)

⸻

✅ Responsive Design Patterns

- Use mobile-first media queries with consistent breakpoints
- Implement fluid typography and spacing systems
- Use CSS Grid and Flexbox for flexible layouts
- Optimize for touch interfaces and accessibility

✅ Example:

See [example-5](./examples/css/example-5.css)

⸻

✅ CSS Custom Properties (Variables)

- Use CSS custom properties for design tokens and theming
- Implement consistent color palettes and spacing scales
- Use meaningful variable names that describe purpose
- Create fallback values for better browser compatibility

✅ Example:

See [example-6](./examples/css/example-6.css)

⸻

✅ Animations and Transitions

- Use CSS animations sparingly and purposefully
- Implement consistent timing functions and durations
- Respect user preferences for reduced motion
- Optimize animations for performance (use transform and opacity)

✅ Example:

See [example-7](./examples/css/example-7.css)

⸻

🧠 Performance & Optimization

- Minimize CSS file sizes through efficient selectors and code organization
- Use CSS-in-JS or atomic CSS when appropriate for component-based architectures
- Implement critical CSS loading strategies for better perceived performance
- Optimize images and assets referenced in CSS

✅ Example:

See [example-8](./examples/css/example-8.css)

⸻

🧪 Testing Standards

✅ CSS Testing and Quality Assurance

- Use Stylelint for automated CSS linting and error detection
- Test styles across different browsers and devices
- Validate accessibility compliance and color contrast
- Implement visual regression testing for critical components

✅ Example Configuration:

See [example-9](./examples/css/example-9.css)

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
