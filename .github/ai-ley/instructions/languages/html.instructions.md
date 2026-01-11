---
name: 'Html.Instructions'
description: 'Development guidelines and best practices for Html.Instructions'
keywords: [languages, linting, coding, async, html.instructions, gui, architecture, hints), (with, guide]
---



# HTML Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for HTML development. These include AI linting hints to automatically enforce style rules and maintain clean, semantic, accessible, and performant markup.

⸻

📂 Project Architecture

✅ Rule: Enforce semantic HTML5 architecture

- Use semantic HTML5 elements for proper document structure
- Implement accessible markup patterns and ARIA standards
- Maintain clean separation between content, presentation, and behavior
- Follow progressive enhancement principles

✅ Rule: Document Structure Standards

- HTML → Semantic structure and content only
- CSS → External stylesheets for presentation
- JavaScript → External scripts for behavior and interactivity
- Assets → Organized media files with proper optimization

✅ Rule: Template Organization

- Use consistent HTML template structure across pages
- Implement reusable component patterns
- Maintain proper meta tag organization and SEO optimization
- Use meaningful file names and directory structure

✅ Rule: Performance Architecture

- Optimize critical rendering path with proper resource loading
- Implement lazy loading for images and non-critical content
- Use proper caching strategies and resource hints
- Minimize DOM complexity and optimize for parsing speed

⸻

📜 HTML Standards & Tools

✅ Rule: HTML5 Semantic Elements

- **Structure**: `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>`, `<footer>`
- **Content**: `<figure>`, `<figcaption>`, `<details>`, `<summary>`, `<mark>`, `<time>`
- **Forms**: `<fieldset>`, `<legend>`, proper input types and attributes
- **Media**: `<picture>`, `<source>`, `<video>`, `<audio>` with fallbacks

✅ Rule: Accessibility Standards

- Follow WCAG 2.1 AA guidelines for accessibility compliance
- Use ARIA attributes appropriately for enhanced screen reader support
- Implement proper heading hierarchy and landmark navigation
- Ensure keyboard navigation and focus management

✅ Rule: Development Tools

- Use HTML validators (W3C Markup Validator, Nu Html Checker)
- Use accessibility testing tools (axe, WAVE, Lighthouse)
- Use linting tools (HTMLHint, html-validate) for code quality
- Use browser dev tools for debugging and performance analysis

⸻

🖋 HTML Coding Standards

✅ Document Structure and Meta Tags

- Use proper HTML5 doctype and language declaration
- Include comprehensive meta tags for SEO and social sharing
- Implement proper viewport configuration for responsive design
- Use structured data markup for enhanced search results

✅ Example:

See [example-1](./examples/html/example-1.html)

⸻

✅ Semantic HTML5 Structure

- Use appropriate semantic elements for content organization
- Implement proper heading hierarchy (h1-h6) for document outline
- Use landmarks and sectioning elements for screen reader navigation
- Maintain logical tab order and keyboard accessibility

✅ Example:

See [example-2](./examples/html/example-2.html)

⸻

✅ Forms and Input Elements

- Use proper form structure with fieldsets and legends
- Implement appropriate input types for enhanced user experience
- Use labels, placeholders, and help text effectively
- Include proper validation and error handling markup

✅ Example:

See [example-3](./examples/html/example-3.html)

⸻

✅ Images and Media Elements

- Use appropriate image formats and responsive images
- Implement proper alt text for accessibility
- Use lazy loading for performance optimization
- Include proper fallbacks for media elements

✅ Example:

See [example-4](./examples/html/example-4.html)

⸻

✅ Performance Optimization

- 🚫 Avoid inline styles and scripts in production
- 🚫 Avoid excessive DOM nesting and complexity
- ✅ Use proper resource loading strategies (defer, async, preload)
- ✅ Implement lazy loading for images and non-critical content

❌ Bad:

See [example-5](./examples/html/example-5.html)

✅ Good:

See [example-6](./examples/html/example-6.html)

⸻

✅ Accessibility Best Practices

- Use ARIA attributes appropriately to enhance accessibility
- Implement proper focus management and keyboard navigation
- Ensure sufficient color contrast and readable text
- Provide alternative content for media and interactive elements

✅ Example:

See [example-7](./examples/html/example-7.html)

⸻

🧠 Performance & SEO

- Optimize HTML structure for search engines and performance
- Use structured data markup for enhanced search results
- Implement proper meta tags and social sharing optimization
- Minimize HTML file sizes and optimize critical rendering path

✅ Example:

See [example-8](./examples/html/example-8.html)

⸻

🧪 Testing Standards

✅ HTML Validation and Quality Assurance

- Use W3C Markup Validator for HTML compliance
- Test accessibility with automated tools (axe, WAVE, Lighthouse)
- Validate semantic structure and heading hierarchy
- Test keyboard navigation and screen reader compatibility

✅ Example Testing Checklist:

See [example-9](./examples/html/example-9.html)

⸻

⚡ Performance Rules

✅ HTML-Specific Optimization

- 🚫 Avoid inline styles and scripts in production
- 🚫 Avoid excessive DOM nesting and complexity
- 🚫 Avoid blocking resources in critical rendering path
- ✅ Use semantic HTML5 elements for proper structure
- ✅ Implement lazy loading for images and non-critical content
- ✅ Use proper resource hints (preload, prefetch, preconnect)
- ✅ Optimize meta tags for SEO and social sharing

⸻

✍️ Commit Message Conventions

- Prefix commits with: `feat:`, `fix:`, `style:`, `refactor:`, `perf:`
- Example: `feat: add semantic HTML5 structure with ARIA landmarks`

⸻

🚦 AI Enforcement Summary

✅ Enforce semantic HTML5 element usage
✅ Block inline styles and scripts in production code
✅ Require proper ARIA attributes for accessibility
✅ Enforce proper heading hierarchy (h1-h6)
✅ Require alt text for all images
✅ Block excessive DOM nesting and complexity
✅ Require proper form label associations
✅ Enforce keyboard navigation support
✅ Require proper meta tags for SEO and social sharing
✅ Use HTML validators for automated compliance checking
✅ Auto-fix formatting violations where possible

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
