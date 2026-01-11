---
name: 'UIKit CSS Framework Instructions'
description: 'Comprehensive guide for using UIKit CSS framework for modern, lightweight'
keywords: [agent, **common, **architecture, api, advanced, **responsive, **performance, **use, (cdn), **avoid]
---


# UIKit CSS Framework Instructions

## Framework Overview

- **Framework Name**: UIKit
- **Version**: 3.21+ (Latest stable with modern features)
- **Type**: CSS Framework for lightweight responsive web development
- **Language**: CSS, Less/Sass, JavaScript, HTML
- **Use Cases**: Modern websites, web applications, dashboard interfaces, content management systems, e-commerce platforms

## When to Use UIKit

### ✅ **Use UIKit When**

- Building modern, clean websites with minimal design philosophy
- Need lightweight framework with excellent performance characteristics
- Working on projects requiring extensive customization and theme flexibility
- Developing responsive web applications with complex UI components
- Need comprehensive JavaScript component library with smooth animations
- Building admin dashboards or content management interfaces
- Working with teams that prefer modular, component-based development
- Require extensive form components and data input handling
- Need consistent cross-browser compatibility and performance
- Working on projects where bundle size optimization is important

### ❌ **Avoid UIKit When**

- Need rapid prototyping with extensive pre-built themes (Bootstrap ecosystem)
- Working with teams unfamiliar with component-based CSS architectures
- Project requires utility-first CSS approach (Tailwind CSS would be better)
- Need extensive third-party plugin ecosystem and community themes
- Building simple static websites that don't need advanced components
- Working with legacy systems that cannot support modern CSS features
- Team strongly prefers opinionated design systems with limited customization

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type        | UIKit Recommendation                                                     | Alternative                   |
| ------------------- | ------------------------------------------------------------------------ | ----------------------------- |
| Admin Dashboard     | ✅ **Strongly Recommended** - Clean UI components and data visualization | Ant Design                    |
| Corporate Website   | ✅ **Recommended** - Professional, customizable design                   | Foundation or Bootstrap       |
| E-commerce Platform | ✅ **Recommended** - Comprehensive form and layout components            | Tailwind CSS                  |
| Content Management  | ✅ **Strongly Recommended** - Rich content components                    | Semantic UI                   |
| Landing Page        | 🔄 **Consider** - May be over-engineered for simple sites                | Tailwind or custom CSS        |
| Web Application     | ✅ **Recommended** - Modular components and customization                | React/Vue component libraries |

### Complexity Assessment

| Factor             | Low Complexity     | Medium Complexity           | High Complexity                   |
| ------------------ | ------------------ | --------------------------- | --------------------------------- |
| **Setup Time**     | 15 minutes (CDN)   | 1-2 hours (custom build)    | 4+ hours (complete customization) |
| **Learning Curve** | HTML/CSS knowledge | Less/Sass familiarity       | Advanced customization skills     |
| **Customization**  | Theme variables    | Custom components           | Complete design system            |
| **Build Process**  | None (CDN)         | Basic Less/Sass compilation | Webpack with optimization         |

## Installation & Setup

### Quick Start (CDN)

See [example-1](./examples/uikit/example-1.html)

### Package Manager Installation

See [example-2](./examples/uikit/example-2.bash)

### Project Setup with Build Tools

See [example-3](./examples/uikit/example-3.bash)

### Custom Build Integration

See [example-4](./examples/uikit/example-4.javascript)

## Project Structure

### Standard UIKit Project

See [example-5](./examples/uikit/example-5.txt)

### Custom Theme Structure

See [example-6](./examples/uikit/example-6.txt)

## Core Concepts

### Grid System and Layout

- **Purpose**: Flexible grid system using CSS Grid and Flexbox for responsive layouts
- **Usage**: Create responsive designs with automatic spacing and alignment
- **Example**:

See [example-7](./examples/uikit/example-7.html)

### Component Architecture

- **Purpose**: Modular, reusable UI components with consistent design patterns
- **Usage**: Build complex interfaces using pre-built, customizable components
- **Example**:

See [example-8](./examples/uikit/example-8.html)

### JavaScript Components and Interactions

- **Purpose**: Rich interactive components with smooth animations and user feedback
- **Usage**: Add behavior to UI components with data attributes or JavaScript API
- **Example**:

See [example-9](./examples/uikit/example-9.html)

### Customization with Less/Sass

- **Purpose**: Deep customization through variables, mixins, and theme development
- **Usage**: Override default styles and create custom design systems
- **Example**:

See [example-10](./examples/uikit/example-10.less)

## Development Workflow

### 1. Setup and Installation

See [example-11](./examples/uikit/example-11.bash)

### 2. Development Process

See [example-12](./examples/uikit/example-12.bash)

### 3. Custom Theme Development

See [example-13](./examples/uikit/example-13.less)

### 4. Building for Production

See [example-14](./examples/uikit/example-14.bash)

### 5. Testing and Quality Assurance

See [example-15](./examples/uikit/example-15.bash)

## Configuration

### Webpack Configuration for Custom Builds

See [example-16](./examples/uikit/example-16.javascript)

### Package.json Scripts

See [example-17](./examples/uikit/example-17.json)

### Less Configuration

See [example-18](./examples/uikit/example-18.less)

## Essential Commands

### Development Commands

See [example-19](./examples/uikit/example-19.bash)

### Asset Compilation

See [example-20](./examples/uikit/example-20.bash)

### Testing and Quality

See [example-21](./examples/uikit/example-21.bash)

## Best Practices

### ✅ **Architecture Best Practices**

- **Use modular component approach** - Import only needed UIKit components to reduce bundle size
- **Implement consistent spacing** using UIKit's margin and padding utility classes
- **Follow semantic HTML structure** with proper heading hierarchy and ARIA attributes
- **Utilize UIKit's responsive classes** for mobile-first design implementation
- **Create reusable custom components** by extending UIKit's base components
- **Organize styles logically** with separate files for variables, components, and utilities

### ✅ **Performance Optimization**

- **Import specific components** rather than the entire UIKit library
- **Use UIKit's lazy loading** for images and content that's below the fold
- **Optimize custom Less compilation** by minimizing nested selectors and mixins
- **Implement critical CSS** for above-the-fold content to improve loading performance
- **Use UIKit's built-in animations** efficiently to avoid JavaScript-heavy solutions
- **Minimize DOM manipulation** by leveraging UIKit's data attribute API

### ✅ **Responsive Design Patterns**

- **Mobile-first approach** using UIKit's breakpoint system (@s, @m, @l, @xl)
- **Use flexible grid widths** with fractional and auto-sizing options
- **Implement responsive typography** using UIKit's responsive text utility classes
- **Test across device sizes** using UIKit's responsive visibility classes
- **Design touch-friendly interfaces** with appropriate spacing and component sizing
- **Use UIKit's responsive utilities** for showing/hiding content across breakpoints

### ❌ **Common Pitfalls to Avoid**

- **Don't override UIKit core files** - use custom Less files and variable overrides
- **Avoid excessive customization** that defeats UIKit's design consistency
- **Don't mix multiple CSS frameworks** - commit to UIKit's methodology
- **Avoid inline styles** when UIKit utility classes are available
- **Don't ignore browser compatibility** - test UIKit components across target browsers
- **Avoid complex nested grids** that can cause layout issues on smaller screens

## Advanced Component Patterns

### Complex Dashboard Layout

See [example-22](./examples/uikit/example-22.html)

### Advanced Form Components

See [example-23](./examples/uikit/example-23.html)

## JavaScript Integration and Custom Components

### Advanced JavaScript Integration

See [example-24](./examples/uikit/example-24.javascript)

### TypeScript Integration

See [example-25](./examples/uikit/example-25.typescript)

## Troubleshooting

### Common Issues

#### Less Compilation Errors

**Problem**: Less compilation fails with import or variable errors
**Symptoms**: Build process fails with UIKit-related import errors
**Solution**:

See [example-26](./examples/uikit/example-26.bash)

#### JavaScript Components Not Working

**Problem**: UIKit JavaScript components don't initialize or function properly
**Symptoms**: Dropdowns, modals, and other interactive elements are non-functional
**Solution**:

See [example-27](./examples/uikit/example-27.javascript)

#### Grid Layout Issues

**Problem**: Grid columns don't align or behave responsively
**Symptoms**: Columns stack incorrectly or don't maintain proper spacing
**Solution**:

See [example-28](./examples/uikit/example-28.html)

#### Performance Issues

**Problem**: Large bundle size or slow loading times
**Symptoms**: Slow page loads, large CSS/JS bundles
**Solution**:

See [example-29](./examples/uikit/example-29.javascript)

### Debug Mode

See [example-30](./examples/uikit/example-30.javascript)

### Performance Optimization

See [example-31](./examples/uikit/example-31.bash)

## AI Assistant Guidelines

When helping with UIKit:

1. **Always suggest UIKit 3.21+** for new projects with modern features and performance improvements
2. **Provide modular component examples** that demonstrate UIKit's component-based architecture
3. **Include responsive design patterns** using UIKit's breakpoint system and grid classes
4. **Suggest performance optimizations** through selective component imports and efficient Less compilation
5. **Provide JavaScript integration examples** for dynamic content and custom component development
6. **Include accessibility considerations** using UIKit's semantic HTML and ARIA attribute patterns
7. **Reference build tool configurations** for modern development workflows with Webpack/Vite
8. **Provide troubleshooting guidance** for common Less compilation and component initialization issues

### Code Generation Rules

- Generate semantic HTML with proper UIKit classes and data attributes for component functionality
- Include responsive design considerations using UIKit's breakpoint classes (@s, @m, @l, @xl)
- Provide Less/Sass examples for customization when deep styling is needed
- Include JavaScript initialization patterns for interactive components and dynamic content
- Follow UIKit's naming conventions and component methodology for consistency
- Add performance optimization suggestions for bundle size and loading speed
- Include cross-browser compatibility considerations for UIKit component support
- Provide both basic and advanced examples based on project complexity requirements

## Installation & Setup

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
