# Content Management System Instructions Template

## CMS Overview
- **CMS Name**: [Name of the CMS]
- **Version**: [Current stable version]
- **Type**: [Headless, Traditional, Hybrid]
- **Technology Stack**: [PHP/WordPress, Node.js, Python/Django, etc.]
- **License**: [Open Source, Commercial]
- **Use Cases**: [Blogs, E-commerce, Enterprise, etc.]

## Installation & Setup
### System Requirements
- **Server Requirements**: [OS, web server, database]
- **PHP/Runtime Version**: [Required version]
- **Database**: [Required database and version]
- **Memory**: [Minimum RAM requirements]
- **Storage**: [Disk space requirements]

### Installation Methods
```bash
# Package manager installation
[package-manager] install [cms-name]

# Manual installation
wget [download-url]
unzip [cms-package]
[installation-commands]

# Docker installation
docker run -d --name [cms-name] \
  -p 80:80 \
  -v [volume-mounts] \
  [docker-image]

# Cloud marketplace (AWS, Azure, GCP)
[cloud-deployment-command]
```

### Initial Configuration
```[config-format]
# Main configuration file ([config-file-name])
[configuration-example]

# Database configuration
[database-config-example]

# Security configuration
[security-config-example]
```

## Architecture & Core Concepts
### System Architecture
- **Frontend Layer**: [Template engine, theme system]
- **Backend Layer**: [Admin interface, API layer]
- **Data Layer**: [Database structure, content storage]
- **Cache Layer**: [Caching mechanisms, CDN integration]

### Content Types
- **Posts/Articles**: [Blog posts, news articles]
- **Pages**: [Static pages, landing pages]
- **Custom Content Types**: [Products, events, portfolios]
- **Media**: [Images, videos, documents]

### User Management
- **Roles**: [Administrator, Editor, Author, Subscriber]
- **Permissions**: [Content creation, editing, publishing]
- **Authentication**: [Login systems, SSO integration]

## Development Workflow
### Local Development Setup
```bash
# Development environment setup
[dev-setup-commands]

# Local server start
[local-server-command]

# Development tools installation
[dev-tools-installation]
```

### Theme Development
```[template-language]
<!-- Theme structure -->
[theme-file-structure]

<!-- Template hierarchy -->
[template-hierarchy-example]

<!-- Custom template example -->
[custom-template-example]
```

### Plugin/Module Development
```[language]
// Plugin structure
[plugin-structure-example]

// Hook system usage
[hooks-example]

// Custom functionality
[custom-functionality-example]
```

## Content Management
### Content Creation
```[markup-language]
<!-- Content structure -->
[content-structure-example]

<!-- Custom fields -->
[custom-fields-example]

<!-- SEO optimization -->
[seo-fields-example]
```

### Content Organization
- **Categories**: [Hierarchical organization]
- **Tags**: [Non-hierarchical labeling]
- **Custom Taxonomies**: [Custom classification systems]
- **Content Relationships**: [Related content, parent-child]

### Media Management
```[language]
// Media upload handling
[media-upload-example]

// Image processing
[image-processing-example]

// CDN integration
[cdn-integration-example]
```

## Customization & Theming
### Theme Development
```[template-language]
<!-- Base template structure -->
[base-template]

<!-- Component templates -->
[component-templates]

<!-- Responsive design -->
[responsive-design-example]
```

### Custom Post Types
```[language]
// Custom post type registration
[custom-post-type-example]

// Custom fields integration
[custom-fields-integration]

// Template customization
[template-customization]
```

### Hooks & Filters
```[language]
// Action hooks
[action-hooks-example]

// Filter hooks
[filter-hooks-example]

// Custom hooks
[custom-hooks-example]
```

## API Integration
### REST API
```[language]
// API endpoint examples
[rest-api-endpoints]

// Authentication
[api-authentication]

// CRUD operations
[api-crud-examples]
```

### GraphQL (if supported)
```[language]
// GraphQL schema
[graphql-schema-example]

// Query examples
[graphql-queries]

// Mutations
[graphql-mutations]
```

### Headless CMS Usage
```[language]
// Frontend framework integration
[frontend-integration-example]

// API consumption
[api-consumption-example]

// Static site generation
[ssg-integration]
```

## Performance Optimization
### Caching Strategies
```[config-format]
# Object caching
[object-cache-config]

# Page caching
[page-cache-config]

# CDN configuration
[cdn-config]
```

### Database Optimization
```sql
-- Database indexing
[database-indexes]

-- Query optimization
[query-optimization]

-- Database maintenance
[maintenance-queries]
```

### Frontend Optimization
```[language]
// Asset minification
[asset-minification]

// Lazy loading
[lazy-loading-example]

// Critical CSS
[critical-css-example]
```

## Security Best Practices
### Core Security
- **Updates**: [Regular core, theme, and plugin updates]
- **Authentication**: [Strong passwords, 2FA, login limiting]
- **File Permissions**: [Proper directory and file permissions]
- **Security Headers**: [HTTP security headers configuration]

### Security Plugins/Modules
```[config-format]
# Security plugin configuration
[security-plugin-config]

# Firewall settings
[firewall-config]

# Malware scanning
[malware-scan-config]
```

### Backup and Recovery
```bash
# Database backup
[database-backup-command]

# File system backup
[filesystem-backup-command]

# Automated backup setup
[automated-backup-setup]

# Recovery procedures
[recovery-commands]
```

## SEO & Content Optimization
### SEO Best Practices
- **Meta Tags**: [Title, description, keywords optimization]
- **URL Structure**: [SEO-friendly permalinks]
- **Schema Markup**: [Structured data implementation]
- **Site Speed**: [Performance optimization for SEO]

### Content Optimization
```[markup-language]
<!-- SEO-optimized content structure -->
[seo-content-structure]

<!-- Schema markup examples -->
[schema-markup-examples]

<!-- Open Graph tags -->
[open-graph-example]
```

## Multilingual & Accessibility
### Multilingual Setup
```[config-format]
# Language configuration
[multilingual-config]

# Translation management
[translation-management]
```

### Accessibility
```[markup-language]
<!-- Accessible HTML structure -->
[accessible-html-example]

<!-- ARIA attributes -->
[aria-attributes-example]

<!-- Alt text optimization -->
[alt-text-example]
```

## E-commerce Integration (if applicable)
### E-commerce Setup
```[language]
// Product management
[product-management-example]

// Shopping cart integration
[shopping-cart-example]

// Payment gateway setup
[payment-gateway-example]
```

### Inventory Management
```[language]
// Stock management
[stock-management-example]

// Order processing
[order-processing-example]

// Shipping integration
[shipping-integration]
```

## Migration & Deployment
### Content Migration
```bash
# Export data
[export-command]

# Import data
[import-command]

# Migration scripts
[migration-scripts]
```

### Deployment Strategies
```bash
# Production deployment
[deployment-commands]

# Staging environment setup
[staging-setup]

# Blue-green deployment
[blue-green-deployment]
```

### Version Control
```bash
# Git integration
git add [cms-specific-files]
git commit -m "CMS update"

# Environment-specific configurations
[env-config-management]
```

## Monitoring & Maintenance
### Performance Monitoring
```[config-format]
# Performance monitoring setup
[performance-monitoring]

# Uptime monitoring
[uptime-monitoring]

# Error tracking
[error-tracking]
```

### Regular Maintenance
```bash
# Update procedures
[update-commands]

# Database optimization
[database-optimization]

# Cache clearing
[cache-clear-commands]

# Log rotation
[log-rotation-setup]
```

### Analytics Integration
```[language]
// Google Analytics integration
[ga-integration-example]

// Custom event tracking
[event-tracking-example]

// Conversion tracking
[conversion-tracking]
```

## Common Issues & Troubleshooting
### Performance Issues
- **Issue**: [Slow page loading]
  **Solution**: [Enable caching, optimize database, compress images]

- **Issue**: [High memory usage]
  **Solution**: [Disable unused plugins, optimize queries, increase memory limit]

### Security Issues
- **Issue**: [Malware infection]
  **Solution**: [Clean infected files, update security, scan regularly]

- **Issue**: [Brute force attacks]
  **Solution**: [Implement login limiting, use strong passwords, enable 2FA]

### Compatibility Issues
- **Issue**: [Plugin conflicts]
  **Solution**: [Deactivate plugins systematically, check error logs, update]

- **Issue**: [Theme compatibility]
  **Solution**: [Switch to default theme, check theme documentation, update]

## Testing Strategies
### Content Testing
```[language]
// Automated content testing
[content-testing-example]

// Link checking
[link-checking-example]

// Form testing
[form-testing-example]
```

### Performance Testing
```bash
# Load testing
[load-testing-command]

# Speed testing
[speed-testing-command]

# Database performance testing
[db-performance-testing]
```

## Best Practices Summary
### Development Best Practices
- [Development best practice 1]
- [Development best practice 2]
- [Development best practice 3]

### Content Best Practices
- [Content best practice 1]
- [Content best practice 2]
- [Content best practice 3]

### Security Best Practices
- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Common Anti-Patterns to Avoid
- **Anti-Pattern 1**: [Using too many plugins/modules]
- **Anti-Pattern 2**: [Neglecting updates and backups]
- **Anti-Pattern 3**: [Poor content organization]
- **Anti-Pattern 4**: [Ignoring SEO best practices]

## Useful Resources
- **Official Documentation**: [URL]
- **Community Forums**: [URLs]
- **Theme/Template Marketplaces**: [URLs]
- **Plugin/Extension Directories**: [URLs]
- **Learning Resources**: [URLs]
- **Development Tools**: [List of helpful tools]

## AI Assistant Guidelines
When helping with [CMS Name]:

1. **Always consider security implications of customizations**
2. **Suggest performance optimization alongside functionality**
3. **Include SEO best practices in content recommendations**
4. **Provide accessibility considerations for frontend changes**
5. **Include backup recommendations before major changes**
6. **Consider mobile responsiveness in theme development**
7. **Suggest appropriate caching strategies**
8. **Include update and maintenance procedures**

### Code Generation Rules
- Generate code that follows CMS coding standards
- Include security validations (input sanitization, nonce verification)
- Provide responsive design considerations
- Include error handling and fallbacks
- Follow SEO best practices in generated markup
- Include comments explaining CMS-specific functions
- Consider performance implications of generated code
- Provide both basic and advanced implementation examples