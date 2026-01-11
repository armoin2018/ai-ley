---
name: 'Gatsby.Instructions'
description: 'See [example-1](./examples/gatsby/example-1.'
keywords: [build, agent, [pattern, architecture, analysis, api, agents, avoid, building, authentication]
---



# Gatsby Framework Instructions for AI Agents

## When to Use Gatsby

Use Gatsby when you need:

- Static site generation with React and GraphQL
- Content-heavy websites (blogs, documentation, marketing sites)
- E-commerce sites with excellent performance requirements
- SEO-optimized websites with server-side rendering
- Integration with headless CMS systems
- Image optimization and progressive web app features
- Sites requiring fast build times and excellent developer experience

## When to Avoid Gatsby

Consider alternatives when:

- Building dynamic applications with frequent data updates
- Simple static sites without React complexity (use Astro, Hugo)
- Real-time applications requiring WebSocket connections
- Large-scale applications with complex routing needs (use Next.js)
- Projects requiring server-side functionality (use Next.js, Remix)
- Team lacks React/GraphQL expertise

## Framework Overview

- **Framework**: Gatsby 5.x
- **Type**: Static site generator with React and GraphQL
- **Architecture**: Build-time data fetching with static generation
- **Language**: JavaScript/TypeScript with React and GraphQL
- **Use Cases**: Static websites, blogs, documentation, e-commerce, portfolios

## Installation & Setup

### ✅ Recommended: Gatsby CLI

See [example-1](./examples/gatsby/example-1.bash)

### ✅ TypeScript Setup

See [example-2](./examples/gatsby/example-2.bash)

### AI Agent Decision Tree

- **For blogs**: Use gatsby-starter-blog with markdown
- **For business sites**: Use gatsby-starter-default with CMS
- **For e-commerce**: Use gatsby-starter-shopify
- **For documentation**: Use gatsby-starter-docusaurus or custom setup
- **For portfolios**: Use gatsby-starter-portfolio or custom design

## Project Structure

### ✅ Standard Gatsby Structure

See [example-3](./examples/gatsby/example-3.txt)

## Core Concepts

### Pages and Routing

✅ **Best Practice**: File-based routing with TypeScript

See [example-4](./examples/gatsby/example-4.typescript)

### GraphQL Data Layer

✅ **Best Practice**: Type-safe GraphQL queries

See [example-5](./examples/gatsby/example-5.typescript)

### Image Optimization

✅ **Best Practice**: gatsby-plugin-image for performance

See [example-6](./examples/gatsby/example-6.typescript)

### Gatsby Configuration

✅ **Best Practice**: Comprehensive gatsby-config.js

See [example-7](./examples/gatsby/example-7.javascript)

### Creating Pages Programmatically

✅ **Best Practice**: gatsby-node.js for dynamic pages

See [example-8](./examples/gatsby/example-8.javascript)

## Best Practices

### ✅ Do's

- Use GraphQL for all data fetching and type generation
- Implement proper SEO with gatsby-plugin-react-helmet
- Optimize images with gatsby-plugin-image and sharp
- Use TypeScript for better development experience
- Implement Progressive Web App features
- Use static queries for component-level data fetching
- Cache expensive operations in gatsby-node.js
- Implement proper error boundaries and 404 pages

### ❌ Don'ts

- Don't use external data fetching (fetch/axios) in components
- Don't ignore image optimization opportunities
- Don't forget to implement proper metadata and SEO
- Don't use large unoptimized images
- Don't skip accessibility considerations
- Don't ignore build performance optimization
- Don't forget to implement proper caching strategies

### Performance Optimization

See [example-9](./examples/gatsby/example-9.typescript)

See [example-10](./examples/gatsby/example-10.typescript)

## Development Workflow

### ✅ Recommended Development Setup

See [example-11](./examples/gatsby/example-11.bash)

### IDE Configuration

- **VS Code Extensions**: GraphQL, Gatsby Snippets, ES7+ React snippets
- **Settings**: Enable TypeScript strict mode, GraphQL schema validation
- **Tools**: GraphQL Playground for query development

### AI Agent Decision Matrix

| Scenario           | Recommended Approach          | Avoid                          |
| ------------------ | ----------------------------- | ------------------------------ |
| Blog site          | Markdown + gatsby-transformer | External CMS for simple blogs  |
| E-commerce         | Shopify + gatsby-source       | Custom e-commerce from scratch |
| Documentation      | MDX + organized content       | Complex routing solutions      |
| Image-heavy sites  | gatsby-plugin-image           | Unoptimized image handling     |
| SEO-critical sites | Static generation + metadata  | Client-side data fetching      |
| Content management | Headless CMS integration      | File-based content for scale   |

## Integration Guidelines

- **With CMS**: Use source plugins (Contentful, Strapi, WordPress)
- **With E-commerce**: Integrate with Shopify, Snipcart, or similar
- **With Analytics**: Use gatsby-plugin-google-analytics or similar
- **With Forms**: Use Netlify Forms, Formspree, or custom solutions
- **With Authentication**: Implement client-side auth with Gatsby
- **With Search**: Use Algolia, Elasticsearch, or static search solutions

## Testing

### ✅ Component Testing

See [example-12](./examples/gatsby/example-12.typescript)

### ✅ Build Testing

See [example-13](./examples/gatsby/example-13.bash)

## Security Considerations

- Sanitize markdown content to prevent XSS
- Use environment variables for sensitive configuration
- Implement proper Content Security Policy headers
- Validate and sanitize form inputs
- Use HTTPS for all external data sources
- Implement proper authentication for admin areas
- Regular dependency updates for security patches

## Error Handling

See [example-14](./examples/gatsby/example-14.typescript)

See [example-15](./examples/gatsby/example-15.typescript)

## AI Agent Quick Reference

- **Project Setup**: Use Gatsby CLI with appropriate starter template
- **Data Fetching**: Use GraphQL for all data, static queries for components
- **Page Creation**: File-based routing in src/pages, programmatic in gatsby-node.js
- **Content Management**: Markdown with frontmatter or headless CMS integration
- **Performance**: Leverage image optimization, static generation, and PWA features
- **SEO**: Implement proper metadata, structured data, and accessibility
- **Deployment**: Build static files for CDN deployment (Netlify, Vercel, S3)

### [Pattern Name]

```[language]
// Example implementation
[code example]
See [example-16](./examples/gatsby/example-16.txt)[language]
// Example implementation
[code example]
See [example-17](./examples/gatsby/example-17.txt)[format]
# Configuration options
[example configuration]
See [example-18](./examples/gatsby/example-18.txt)[format]
# Configuration options
[example configuration]
See [example-19](./examples/gatsby/example-19.txt)bash
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
See [example-20](./examples/gatsby/example-20.txt)bash
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
