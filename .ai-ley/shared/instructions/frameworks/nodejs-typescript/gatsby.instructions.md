---
applyTo: 'gatsby, gatsby.js'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Gatsby 5+ with GraphQL and modern static site generation'
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

```bash
# Install Gatsby CLI globally
npm install -g gatsby-cli

# Create new site from starter
gatsby new my-site
gatsby new my-site https://github.com/gatsbyjs/gatsby-starter-default

# Navigate and start development
cd my-site
gatsby develop

# Alternative with npm/yarn
npm init gatsby my-site
yarn create gatsby my-site
```

### ✅ TypeScript Setup

```bash
# Create TypeScript project
gatsby new my-site https://github.com/gatsbyjs/gatsby-starter-typescript

# Add TypeScript to existing project
npm install typescript @types/node @types/react @types/react-dom
```

### AI Agent Decision Tree

- **For blogs**: Use gatsby-starter-blog with markdown
- **For business sites**: Use gatsby-starter-default with CMS
- **For e-commerce**: Use gatsby-starter-shopify
- **For documentation**: Use gatsby-starter-docusaurus or custom setup
- **For portfolios**: Use gatsby-starter-portfolio or custom design

## Project Structure

### ✅ Standard Gatsby Structure

```
gatsby-site/
├── src/
│   ├── components/          # React components
│   │   ├── layout.tsx      # Layout components
│   │   ├── seo.tsx         # SEO component
│   │   └── header.tsx      # Header component
│   ├── pages/              # Page components (auto-routing)
│   │   ├── index.tsx       # Homepage
│   │   ├── about.tsx       # About page
│   │   └── 404.tsx         # 404 page
│   ├── templates/          # Page templates
│   │   ├── blog-post.tsx   # Blog post template
│   │   └── product.tsx     # Product template
│   ├── hooks/              # Custom React hooks
│   ├── utils/              # Utility functions
│   ├── styles/             # Global styles
│   └── images/             # Static images
├── content/                # Markdown/MDX content
│   ├── blog/              # Blog posts
│   └── pages/             # Content pages
├── static/                 # Static assets
├── gatsby-config.js       # Gatsby configuration
├── gatsby-node.js         # Node.js APIs
├── gatsby-browser.js      # Browser APIs
├── gatsby-ssr.js          # Server-side rendering APIs
└── package.json
```

## Core Concepts

### Pages and Routing

✅ **Best Practice**: File-based routing with TypeScript

```typescript
// src/pages/index.tsx
import React from 'react';
import { graphql, PageProps } from 'gatsby';
import Layout from '../components/layout';
import SEO from '../components/seo';

interface IndexPageData {
  site: {
    siteMetadata: {
      title: string;
      description: string;
    };
  };
  allMarkdownRemark: {
    nodes: Array<{
      id: string;
      frontmatter: {
        title: string;
        date: string;
        description: string;
      };
      fields: {
        slug: string;
      };
      excerpt: string;
    }>;
  };
}

const IndexPage: React.FC<PageProps<IndexPageData>> = ({ data }) => {
  const { site, allMarkdownRemark } = data;
  const posts = allMarkdownRemark.nodes;

  return (
    <Layout>
      <SEO title="Home" description={site.siteMetadata.description} />
      <h1>{site.siteMetadata.title}</h1>
      <div className="posts">
        {posts.map((post) => (
          <article key={post.id} className="post-preview">
            <h2>
              <a href={post.fields.slug}>{post.frontmatter.title}</a>
            </h2>
            <p>{post.frontmatter.date}</p>
            <p>{post.excerpt}</p>
          </article>
        ))}
      </div>
    </Layout>
  );
};

export default IndexPage;

export const query = graphql`
  query {
    site {
      siteMetadata {
        title
        description
      }
    }
    allMarkdownRemark(sort: { frontmatter: { date: DESC } }) {
      nodes {
        id
        frontmatter {
          title
          date(formatString: "MMMM DD, YYYY")
          description
        }
        fields {
          slug
        }
        excerpt
      }
    }
  }
`;
```

### GraphQL Data Layer

✅ **Best Practice**: Type-safe GraphQL queries

```typescript
// src/templates/blog-post.tsx
import React from 'react';
import { graphql, PageProps } from 'gatsby';
import Layout from '../components/layout';
import SEO from '../components/seo';

interface BlogPostData {
  markdownRemark: {
    id: string;
    html: string;
    frontmatter: {
      title: string;
      date: string;
      description: string;
      featuredImage?: {
        childImageSharp: {
          gatsbyImageData: any;
        };
      };
    };
  };
  previous?: {
    fields: {
      slug: string;
    };
    frontmatter: {
      title: string;
    };
  };
  next?: {
    fields: {
      slug: string;
    };
    frontmatter: {
      title: string;
    };
  };
}

const BlogPostTemplate: React.FC<PageProps<BlogPostData>> = ({ data, location }) => {
  const post = data.markdownRemark;
  const { previous, next } = data;

  return (
    <Layout location={location}>
      <SEO
        title={post.frontmatter.title}
        description={post.frontmatter.description || post.excerpt}
      />
      <article className="blog-post">
        <header>
          <h1>{post.frontmatter.title}</h1>
          <p>{post.frontmatter.date}</p>
        </header>
        <section dangerouslySetInnerHTML={{ __html: post.html }} itemProp="articleBody" />
      </article>
      <nav className="blog-post-nav">
        <ul>
          <li>
            {previous && (
              <a href={previous.fields.slug} rel="prev">
                ← {previous.frontmatter.title}
              </a>
            )}
          </li>
          <li>
            {next && (
              <a href={next.fields.slug} rel="next">
                {next.frontmatter.title} →
              </a>
            )}
          </li>
        </ul>
      </nav>
    </Layout>
  );
};

export default BlogPostTemplate;

export const query = graphql`
  query BlogPostBySlug($id: String!, $previousPostId: String, $nextPostId: String) {
    markdownRemark(id: { eq: $id }) {
      id
      excerpt(pruneLength: 160)
      html
      frontmatter {
        title
        date(formatString: "MMMM DD, YYYY")
        description
        featuredImage {
          childImageSharp {
            gatsbyImageData(width: 1200, placeholder: BLURRED, formats: [AUTO, WEBP, AVIF])
          }
        }
      }
    }
    previous: markdownRemark(id: { eq: $previousPostId }) {
      fields {
        slug
      }
      frontmatter {
        title
      }
    }
    next: markdownRemark(id: { eq: $nextPostId }) {
      fields {
        slug
      }
      frontmatter {
        title
      }
    }
  }
`;
```

### Image Optimization

✅ **Best Practice**: gatsby-plugin-image for performance

```typescript
// src/components/hero-image.tsx
import React from 'react';
import { GatsbyImage, getImage, IGatsbyImageData } from 'gatsby-plugin-image';

interface HeroImageProps {
  image: {
    childImageSharp: {
      gatsbyImageData: IGatsbyImageData;
    };
  };
  alt: string;
  title?: string;
}

export const HeroImage: React.FC<HeroImageProps> = ({ image, alt, title }) => {
  const gatsbyImage = getImage(image);

  if (!gatsbyImage) {
    return null;
  }

  return (
    <div className="hero-image">
      <GatsbyImage
        image={gatsbyImage}
        alt={alt}
        title={title}
        loading="eager"
        placeholder="blurred"
      />
    </div>
  );
};
```

### Gatsby Configuration

✅ **Best Practice**: Comprehensive gatsby-config.js

```javascript
// gatsby-config.js
module.exports = {
  siteMetadata: {
    title: 'My Gatsby Site',
    description: 'A description of my site.',
    author: '@yourusername',
    siteUrl: 'https://mysite.com',
  },
  plugins: [
    'gatsby-plugin-react-helmet',
    'gatsby-plugin-image',
    'gatsby-plugin-sharp',
    'gatsby-transformer-sharp',
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        name: 'images',
        path: `${__dirname}/src/images`,
      },
    },
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        name: 'blog',
        path: `${__dirname}/content/blog`,
      },
    },
    {
      resolve: 'gatsby-transformer-remark',
      options: {
        plugins: [
          {
            resolve: 'gatsby-remark-images',
            options: {
              maxWidth: 1200,
              quality: 90,
              withWebp: true,
              loading: 'lazy',
            },
          },
          'gatsby-remark-prismjs',
          'gatsby-remark-copy-linked-files',
          'gatsby-remark-smartypants',
        ],
      },
    },
    {
      resolve: 'gatsby-plugin-manifest',
      options: {
        name: 'My Gatsby Site',
        short_name: 'Gatsby Site',
        start_url: '/',
        background_color: '#663399',
        theme_color: '#663399',
        display: 'minimal-ui',
        icon: 'src/images/gatsby-icon.png',
      },
    },
    'gatsby-plugin-offline',
    {
      resolve: 'gatsby-plugin-google-analytics',
      options: {
        trackingId: 'UA-XXXXXXXXX-X',
        head: false,
        anonymize: true,
        respectDNT: true,
      },
    },
    'gatsby-plugin-sitemap',
    {
      resolve: 'gatsby-plugin-robots-txt',
      options: {
        host: 'https://mysite.com',
        sitemap: 'https://mysite.com/sitemap.xml',
        policy: [{ userAgent: '*', allow: '/' }],
      },
    },
  ],
};
```

### Creating Pages Programmatically

✅ **Best Practice**: gatsby-node.js for dynamic pages

```javascript
// gatsby-node.js
const path = require('path');
const { createFilePath } = require('gatsby-source-filesystem');

exports.createPages = async ({ graphql, actions, reporter }) => {
  const { createPage } = actions;

  // Define templates
  const blogPost = path.resolve('./src/templates/blog-post.tsx');

  // Get all markdown blog posts sorted by date
  const result = await graphql(`
    {
      allMarkdownRemark(sort: { frontmatter: { date: ASC } }, limit: 1000) {
        nodes {
          id
          fields {
            slug
          }
        }
      }
    }
  `);

  if (result.errors) {
    reporter.panicOnBuild('There was an error loading your blog posts', result.errors);
    return;
  }

  const posts = result.data.allMarkdownRemark.nodes;

  // Create blog posts pages
  if (posts.length > 0) {
    posts.forEach((post, index) => {
      const previousPostId = index === 0 ? null : posts[index - 1].id;
      const nextPostId = index === posts.length - 1 ? null : posts[index + 1].id;

      createPage({
        path: post.fields.slug,
        component: blogPost,
        context: {
          id: post.id,
          previousPostId,
          nextPostId,
        },
      });
    });
  }
};

exports.onCreateNode = ({ node, actions, getNode }) => {
  const { createNodeField } = actions;

  if (node.internal.type === 'MarkdownRemark') {
    const value = createFilePath({ node, getNode });

    createNodeField({
      name: 'slug',
      node,
      value,
    });
  }
};

exports.createSchemaCustomization = ({ actions }) => {
  const { createTypes } = actions;

  createTypes(`
    type SiteSiteMetadata {
      author: Author
      siteUrl: String
      social: Social
    }

    type Author {
      name: String
      summary: String
    }

    type Social {
      twitter: String
    }

    type MarkdownRemark implements Node {
      frontmatter: Frontmatter
      fields: Fields
    }

    type Frontmatter {
      title: String
      description: String
      date: Date @dateformat
      featuredImage: File @fileByRelativePath
    }

    type Fields {
      slug: String
    }
  `);
};
```

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

```typescript
// src/hooks/useStaticQuery.ts
import { useStaticQuery, graphql } from 'gatsby';

interface SiteMetadata {
  site: {
    siteMetadata: {
      title: string;
      description: string;
      author: string;
      siteUrl: string;
    };
  };
}

export const useSiteMetadata = (): SiteMetadata['site']['siteMetadata'] => {
  const data = useStaticQuery<SiteMetadata>(graphql`
    query {
      site {
        siteMetadata {
          title
          description
          author
          siteUrl
        }
      }
    }
  `);

  return data.site.siteMetadata;
};
```

```typescript
// src/components/seo.tsx
import React from 'react';
import { Helmet } from 'react-helmet';
import { useSiteMetadata } from '../hooks/useSiteMetadata';

interface SEOProps {
  title: string;
  description?: string;
  lang?: string;
  meta?: Array<{ name: string; content: string }>;
}

export const SEO: React.FC<SEOProps> = ({ title, description = '', lang = 'en', meta = [] }) => {
  const siteMetadata = useSiteMetadata();
  const metaDescription = description || siteMetadata.description;
  const defaultTitle = siteMetadata.title;

  return (
    <Helmet
      htmlAttributes={{ lang }}
      title={title}
      titleTemplate={defaultTitle ? `%s | ${defaultTitle}` : undefined}
      meta={[
        {
          name: 'description',
          content: metaDescription,
        },
        {
          property: 'og:title',
          content: title,
        },
        {
          property: 'og:description',
          content: metaDescription,
        },
        {
          property: 'og:type',
          content: 'website',
        },
        {
          name: 'twitter:card',
          content: 'summary',
        },
        {
          name: 'twitter:creator',
          content: siteMetadata.author || '',
        },
        {
          name: 'twitter:title',
          content: title,
        },
        {
          name: 'twitter:description',
          content: metaDescription,
        },
        ...meta,
      ]}
    />
  );
};
```

## Development Workflow

### ✅ Recommended Development Setup

```bash
# Development
gatsby develop

# Clean cache and public folder
gatsby clean

# Build for production
gatsby build

# Serve production build locally
gatsby serve

# Type checking (if using TypeScript)
tsc --noEmit

# GraphQL playground
# Available at http://localhost:8000/___graphql during development
```

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

```typescript
// src/__tests__/header.test.tsx
import React from 'react';
import { render, screen } from '@testing-library/react';
import { useStaticQuery } from 'gatsby';
import Header from '../components/header';

// Mock Gatsby's useStaticQuery
const mockUseStaticQuery = useStaticQuery as jest.Mock;

describe('Header', () => {
  beforeEach(() => {
    mockUseStaticQuery.mockReturnValue({
      site: {
        siteMetadata: {
          title: 'Test Site',
        },
      },
    });
  });

  it('renders site title', () => {
    render(<Header />);
    expect(screen.getByText('Test Site')).toBeInTheDocument();
  });

  it('renders navigation links', () => {
    render(<Header />);
    expect(screen.getByText('Home')).toBeInTheDocument();
    expect(screen.getByText('About')).toBeInTheDocument();
  });
});
```

### ✅ Build Testing

```bash
# Test production build
gatsby build && gatsby serve

# Audit build output
npx lighthouse http://localhost:9000 --view

# Test PWA functionality
npx lighthouse http://localhost:9000 --view --only-categories=pwa
```

## Security Considerations

- Sanitize markdown content to prevent XSS
- Use environment variables for sensitive configuration
- Implement proper Content Security Policy headers
- Validate and sanitize form inputs
- Use HTTPS for all external data sources
- Implement proper authentication for admin areas
- Regular dependency updates for security patches

## Error Handling

```typescript
// src/components/error-boundary.tsx
import React, { Component, ReactNode } from 'react';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error?: Error;
}

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        <div style={{ padding: '2rem', textAlign: 'center' }}>
          <h2>Something went wrong</h2>
          <p>{this.state.error?.message}</p>
          <button onClick={() => window.location.reload()}>Reload Page</button>
        </div>
      );
    }

    return this.props.children;
  }
}
```

```typescript
// src/pages/404.tsx
import React from 'react';
import { PageProps } from 'gatsby';
import Layout from '../components/layout';
import SEO from '../components/seo';

const NotFoundPage: React.FC<PageProps> = ({ location }) => (
  <Layout location={location}>
    <SEO title="404: Not Found" />
    <h1>404: Not Found</h1>
    <p>You just hit a route that doesn&#39;t exist... the sadness.</p>
    <a href="/">Go back home</a>
  </Layout>
);

export default NotFoundPage;
```

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
