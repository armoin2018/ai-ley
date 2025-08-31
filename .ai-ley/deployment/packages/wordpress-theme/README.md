# WordPress Theme Deployment Template

## Overview

This template provides comprehensive WordPress theme development and deployment with automated testing, distribution, and customization support for WordPress.org repository and premium marketplaces.

## Features

- **WordPress Standards**: Follows WordPress theme standards and guidelines
- **Theme Repository**: WordPress.org repository integration and SVN management
- **Premium Distribution**: Integration with premium marketplaces (ThemeForest, etc.)
- **Customizer Integration**: Advanced Theme Customizer support
- **Block Editor**: Gutenberg block editor and Full Site Editing (FSE) support
- **Responsive Design**: Mobile-first responsive design framework
- **Performance**: Optimized for Core Web Vitals and performance
- **Accessibility**: WCAG compliance and accessibility features
- **Child Theme**: Child theme generation and support

## Structure

```
wordpress-theme/
├── theme-name/                 # Main theme directory
│   ├── style.css              # Main theme stylesheet with headers
│   ├── index.php              # Main template file
│   ├── functions.php          # Theme functions and features
│   ├── screenshot.png         # Theme screenshot (1200x900px)
│   ├── readme.txt             # WordPress.org readme
│   ├── README.md              # GitHub readme
│   ├── LICENSE                # License file
│   ├── templates/             # Block templates (FSE)
│   │   ├── index.html
│   │   ├── single.html
│   │   ├── page.html
│   │   └── archive.html
│   ├── parts/                 # Template parts (FSE)
│   │   ├── header.html
│   │   ├── footer.html
│   │   └── sidebar.html
│   ├── patterns/              # Block patterns
│   │   ├── hero-banner.php
│   │   ├── call-to-action.php
│   │   └── testimonials.php
│   ├── inc/                   # Theme includes
│   │   ├── customizer.php
│   │   ├── template-functions.php
│   │   ├── template-tags.php
│   │   ├── class-walker-nav.php
│   │   └── jetpack.php
│   ├── template-parts/        # Template parts (classic)
│   │   ├── header/
│   │   ├── footer/
│   │   ├── content/
│   │   └── navigation/
│   ├── assets/                # Theme assets
│   │   ├── css/
│   │   │   ├── main.css
│   │   │   ├── editor-style.css
│   │   │   └── rtl.css
│   │   ├── js/
│   │   │   ├── navigation.js
│   │   │   ├── customizer.js
│   │   │   └── theme.js
│   │   ├── images/
│   │   └── fonts/
│   ├── languages/             # Translation files
│   │   └── theme-name.pot
│   └── theme.json             # Global settings (FSE)
├── theme-name-child/          # Child theme
│   ├── style.css
│   ├── functions.php
│   └── screenshot.png
├── tests/                     # Test files
│   ├── phpunit.xml
│   ├── test-theme.php
│   └── bin/
│       └── install-wp-tests.sh
├── tools/                     # Development tools
│   ├── build-theme.sh         # Theme build script
│   ├── deploy-wporg.sh        # WordPress.org deployment
│   ├── deploy-premium.sh      # Premium marketplace deployment
│   ├── test-theme.sh          # Testing script
│   ├── generate-child-theme.sh # Child theme generator
│   └── i18n-tools.sh          # Internationalization tools
├── docs/                      # Documentation
│   ├── installation.md
│   ├── customization.md
│   ├── child-themes.md
│   └── changelog.md
├── src/                       # Source files
│   ├── scss/
│   │   ├── main.scss
│   │   ├── variables.scss
│   │   ├── mixins.scss
│   │   └── components/
│   ├── js/
│   │   ├── main.js
│   │   └── modules/
│   └── images/
├── package.json               # NPM dependencies
├── Gruntfile.js              # Grunt build configuration
├── webpack.config.js         # Webpack configuration
├── phpcs.xml                 # PHP CodeSniffer configuration
└── .github/                  # GitHub workflows
    └── workflows/
        ├── test.yml
        ├── deploy-wporg.yml
        └── deploy-premium.yml
```

## Quick Start

### 1. Setup Development Environment

```bash
# Install WordPress development environment
wp package install wp-cli/wp-cli-dev-command

# Setup local WordPress installation
wp core download
wp config create --dbname=wp_theme_dev --dbuser=root --dbpass=password
wp core install --url=localhost --title="Theme Dev Site" --admin_user=admin --admin_password=password --admin_email=admin@example.com

# Install theme dependencies
npm install
```

### 2. Configure Theme

```bash
# Update theme headers
vim theme-name/style.css

# Configure theme.json for Full Site Editing
vim theme-name/theme.json

# Setup theme functions
vim theme-name/functions.php
```

### 3. Build and Test

```bash
# Build theme assets
./tools/build-theme.sh

# Run theme tests
./tools/test-theme.sh

# Generate child theme
./tools/generate-child-theme.sh
```

### 4. Deploy Theme

```bash
# Deploy to WordPress.org (requires SVN access)
./tools/deploy-wporg.sh 1.0.0

# Deploy to premium marketplace
./tools/deploy-premium.sh 1.0.0

# Create release package
./tools/build-theme.sh --release
```

## Theme Development Features

### Full Site Editing (FSE) Support

- **theme.json**: Global settings and styles
- **Block Templates**: Custom templates for different page types
- **Template Parts**: Reusable template components
- **Block Patterns**: Pre-designed block layouts

### Classic Theme Support

- **Template Hierarchy**: Complete WordPress template hierarchy
- **Custom Post Types**: Support for custom content types
- **Theme Customizer**: Advanced customization options
- **Widget Areas**: Multiple widget-ready areas

### Performance Optimization

- **Critical CSS**: Above-the-fold CSS optimization
- **Lazy Loading**: Image and content lazy loading
- **Minification**: CSS and JavaScript minification
- **Caching**: Browser and server-side caching support

### Accessibility Features

- **ARIA Labels**: Proper ARIA labeling
- **Keyboard Navigation**: Full keyboard accessibility
- **Screen Reader**: Screen reader optimization
- **Color Contrast**: WCAG color contrast compliance

## Best Practices

- **WordPress Standards**: Follow WordPress theme development standards
- **Responsive Design**: Mobile-first responsive approach
- **Performance**: Optimize for Core Web Vitals
- **Security**: Implement proper sanitization and validation
- **Internationalization**: Make theme translation-ready
- **Child Theme**: Always provide child theme support
- **Documentation**: Comprehensive user documentation

## Integration with AI Agents

### Model Recommendations

- **Theme Development**: GPT-4 (High/Technical)
- **Design System**: Claude-3-Sonnet (High/Creative)
- **Frontend Development**: Claude-3-Sonnet (High/Technical)
- **Performance Optimization**: GPT-4 (High/Technical)

### Personas to Use

- `wordpress-developer.md` - WordPress theme development expertise
- `frontend-developer.md` - Frontend development and CSS/JavaScript
- `ux-designer.md` - User experience and design systems
- `performance-engineer.md` - Performance optimization and Core Web Vitals
