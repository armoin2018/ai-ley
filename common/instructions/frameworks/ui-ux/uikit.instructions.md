---
title: 'UIKit CSS Framework Instructions'
description: 'Comprehensive guide for using UIKit CSS framework for modern, lightweight responsive web development with modular components and customizable design'
category: 'UI/UX Frameworks'

tags:
  [
    'uikit',
    'css-framework',
    'responsive-design',
    'modular-components',
    'lightweight',
    'customizable',
    'less',
    'sass',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/*.html'
  - '**/*.css'
  - '**/*.scss'
  - '**/*.less'
  - '**/*.js'
  - '**/uikit.config.js'
  - '**/webpack.config.js'
  - '**/package.json'
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

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>UIKit Site</title>
    <!-- UIKit CSS -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/uikit@3.21.9/dist/css/uikit.min.css"
    />
    <!-- UIKit Icons -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/uikit@3.21.9/dist/css/uikit-icons.min.css"
    />
  </head>
  <body>
    <div class="uk-container">
      <div class="uk-grid-match uk-child-width-1-3@m" uk-grid>
        <div>
          <div class="uk-card uk-card-default uk-card-body">
            <h3 class="uk-card-title">Default</h3>
            <p>Lorem ipsum dolor sit amet.</p>
          </div>
        </div>
        <div>
          <div class="uk-card uk-card-primary uk-card-body">
            <h3 class="uk-card-title">Primary</h3>
            <p>Lorem ipsum dolor sit amet.</p>
          </div>
        </div>
        <div>
          <div class="uk-card uk-card-secondary uk-card-body">
            <h3 class="uk-card-title">Secondary</h3>
            <p>Lorem ipsum dolor sit amet.</p>
          </div>
        </div>
      </div>
    </div>

    <!-- UIKit JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/uikit@3.21.9/dist/js/uikit.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/uikit@3.21.9/dist/js/uikit-icons.min.js"></script>
  </body>
</html>
```

### Package Manager Installation

```bash
# npm installation (recommended for projects)
npm install uikit --save

# yarn installation
yarn add uikit

# Include development dependencies for customization
npm install uikit less less-loader css-loader --save-dev

# TypeScript definitions
npm install @types/uikit --save-dev
```

### Project Setup with Build Tools

```bash
# Initialize project with custom build setup
npm init -y
npm install uikit webpack webpack-cli less less-loader css-loader style-loader html-webpack-plugin --save-dev

# Create project structure
mkdir src dist
touch src/index.html src/styles.less src/scripts.js
```

### Custom Build Integration

```javascript
// webpack.config.js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
  entry: './src/index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'bundle.js',
    clean: true,
  },
  module: {
    rules: [
      {
        test: /\.less$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
          {
            loader: 'less-loader',
            options: {
              lessOptions: {
                math: 'always',
              },
            },
          },
        ],
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf|svg)$/,
        type: 'asset/resource',
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html',
    }),
    new MiniCssExtractPlugin({
      filename: 'styles.css',
    }),
  ],
  devServer: {
    static: './dist',
    port: 3000,
    open: true,
  },
};
```

## Project Structure

### Standard UIKit Project

```
uikit-project/
├── src/
│   ├── styles/
│   │   ├── main.less
│   │   ├── variables.less
│   │   ├── components/
│   │   └── themes/
│   ├── scripts/
│   │   ├── main.js
│   │   └── components/
│   ├── assets/
│   │   ├── images/
│   │   └── icons/
│   └── index.html
├── dist/
│   ├── css/
│   ├── js/
│   └── assets/
├── webpack.config.js
├── package.json
└── README.md
```

### Custom Theme Structure

```
custom-uikit/
├── less/
│   ├── uikit-theme.less
│   ├── variables/
│   │   ├── global.less
│   │   ├── components.less
│   │   └── mixins.less
│   ├── components/
│   │   ├── button.less
│   │   ├── card.less
│   │   └── navigation.less
│   └── themes/
│       ├── dark.less
│       └── light.less
├── js/
│   ├── custom-components.js
│   └── extensions/
└── build/
    ├── gulpfile.js
    └── webpack.config.js
```

## Core Concepts

### Grid System and Layout

- **Purpose**: Flexible grid system using CSS Grid and Flexbox for responsive layouts
- **Usage**: Create responsive designs with automatic spacing and alignment
- **Example**:

```html
<!-- Container with responsive grid -->
<div class="uk-container">
  <!-- Auto-width columns -->
  <div class="uk-grid-small uk-child-width-auto" uk-grid>
    <div>Auto</div>
    <div>Auto</div>
    <div>Auto</div>
  </div>

  <!-- Responsive fractional widths -->
  <div class="uk-grid-match uk-child-width-1-2@s uk-child-width-1-3@m uk-child-width-1-4@l" uk-grid>
    <div>
      <div class="uk-card uk-card-default uk-card-body">
        <h3>Card 1</h3>
      </div>
    </div>
    <div>
      <div class="uk-card uk-card-primary uk-card-body">
        <h3>Card 2</h3>
      </div>
    </div>
  </div>

  <!-- Column widths and offsets -->
  <div class="uk-grid" uk-grid>
    <div class="uk-width-1-3@m">1/3</div>
    <div class="uk-width-2-3@m">2/3</div>
  </div>

  <!-- Nested grids -->
  <div class="uk-grid" uk-grid>
    <div class="uk-width-2-3@m">
      <div class="uk-grid-small" uk-grid>
        <div class="uk-width-1-2">Nested 1/2</div>
        <div class="uk-width-1-2">Nested 1/2</div>
      </div>
    </div>
    <div class="uk-width-1-3@m">Sidebar</div>
  </div>
</div>
```

### Component Architecture

- **Purpose**: Modular, reusable UI components with consistent design patterns
- **Usage**: Build complex interfaces using pre-built, customizable components
- **Example**:

```html
<!-- Advanced Navigation -->
<nav class="uk-navbar-container" uk-navbar>
  <div class="uk-navbar-left">
    <ul class="uk-navbar-nav">
      <li class="uk-active"><a href="#">Active</a></li>
      <li>
        <a href="#">Parent</a>
        <div class="uk-navbar-dropdown">
          <ul class="uk-nav uk-navbar-dropdown-nav">
            <li class="uk-active"><a href="#">Active</a></li>
            <li><a href="#">Item</a></li>
            <li class="uk-nav-header">Header</li>
            <li><a href="#">Item</a></li>
          </ul>
        </div>
      </li>
    </ul>
  </div>
  <div class="uk-navbar-right">
    <div>
      <a
        class="uk-navbar-toggle"
        uk-search-icon
        uk-toggle="target: .nav-overlay; animation: uk-animation-fade"
        href="#"
      ></a>
    </div>
  </div>
</nav>

<!-- Modal Component -->
<div id="modal-example" uk-modal>
  <div class="uk-modal-dialog uk-modal-body">
    <h2 class="uk-modal-title">Headline</h2>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
    <p class="uk-text-right">
      <button class="uk-button uk-button-default uk-modal-close" type="button">Cancel</button>
      <button class="uk-button uk-button-primary" type="button">Save</button>
    </p>
  </div>
</div>

<!-- Advanced Card Layout -->
<div class="uk-card uk-card-default">
  <div class="uk-card-header">
    <div class="uk-grid-small uk-flex-middle" uk-grid>
      <div class="uk-width-auto">
        <img class="uk-border-circle" width="40" height="40" src="avatar.jpg" alt="Avatar" />
      </div>
      <div class="uk-width-expand">
        <h3 class="uk-card-title uk-margin-remove-bottom">Title</h3>
        <p class="uk-text-meta uk-margin-remove-top">Subtitle</p>
      </div>
    </div>
  </div>
  <div class="uk-card-body">
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
  </div>
  <div class="uk-card-footer">
    <a href="#" class="uk-button uk-button-text">Read more</a>
  </div>
</div>
```

### JavaScript Components and Interactions

- **Purpose**: Rich interactive components with smooth animations and user feedback
- **Usage**: Add behavior to UI components with data attributes or JavaScript API
- **Example**:

```html
<!-- Slider/Carousel -->
<div class="uk-position-relative uk-visible-toggle uk-light" tabindex="-1" uk-slider>
  <ul class="uk-slider-items uk-child-width-1-2@s uk-child-width-1-3@m">
    <li>
      <img src="image1.jpg" alt="" />
      <div class="uk-position-center uk-panel"><h1>1</h1></div>
    </li>
    <li>
      <img src="image2.jpg" alt="" />
      <div class="uk-position-center uk-panel"><h1>2</h1></div>
    </li>
  </ul>
  <a
    class="uk-position-center-left uk-position-small uk-hidden-hover"
    href="#"
    uk-slidenav-previous
    uk-slider-item="previous"
  ></a>
  <a
    class="uk-position-center-right uk-position-small uk-hidden-hover"
    href="#"
    uk-slidenav-next
    uk-slider-item="next"
  ></a>
</div>

<!-- Accordion -->
<ul uk-accordion>
  <li class="uk-open">
    <a class="uk-accordion-title" href="#">Item 1</a>
    <div class="uk-accordion-content">
      <p>Lorem ipsum dolor sit amet.</p>
    </div>
  </li>
  <li>
    <a class="uk-accordion-title" href="#">Item 2</a>
    <div class="uk-accordion-content">
      <p>Ut enim ad minim veniam.</p>
    </div>
  </li>
</ul>

<!-- Dropdown with Animations -->
<div class="uk-inline">
  <button class="uk-button uk-button-default" type="button">Dropdown</button>
  <div uk-dropdown="animation: uk-animation-slide-top-small; duration: 1000">
    <ul class="uk-nav uk-dropdown-nav">
      <li class="uk-active"><a href="#">Active</a></li>
      <li><a href="#">Item</a></li>
      <li class="uk-nav-header">Header</li>
      <li><a href="#">Item</a></li>
      <li class="uk-nav-divider"></li>
      <li><a href="#">Item</a></li>
    </ul>
  </div>
</div>
```

### Customization with Less/Sass

- **Purpose**: Deep customization through variables, mixins, and theme development
- **Usage**: Override default styles and create custom design systems
- **Example**:

```less
// variables.less - Custom theme variables
@global-primary-background: #1e87f0;
@global-secondary-background: #222;
@global-success-background: #32d296;
@global-warning-background: #faa05a;
@global-danger-background: #f0506e;

@global-color: #666;
@global-emphasis-color: #333;
@global-muted-color: #999;

@global-font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
@global-font-size: 14px;
@global-line-height: 1.5;

@global-xxlarge-font-size: 2.625rem;
@global-xlarge-font-size: 2rem;
@global-large-font-size: 1.5rem;
@global-medium-font-size: 1.25rem;
@global-small-font-size: 0.875rem;

// Border and spacing
@global-border-width: 1px;
@global-border: @global-border-width solid @global-border;
@global-border-radius: 6px;

@global-gutter: 30px;
@global-small-gutter: 15px;
@global-medium-gutter: 40px;
@global-large-gutter: 70px;

// Custom component variables
@button-font-size: @global-small-font-size;
@button-line-height: 38px;
@button-small-line-height: 28px;
@button-large-line-height: 54px;

@card-body-padding-horizontal: @global-gutter;
@card-body-padding-vertical: @global-gutter;
@card-header-padding-horizontal: @global-gutter;
@card-header-padding-vertical: round(@global-gutter * 0.5);

// Import UIKit after variables
@import 'uikit/src/less/uikit.less';

// Custom component styles
.uk-button-gradient {
  background: linear-gradient(
    135deg,
    @global-primary-background 0%,
    darken(@global-primary-background, 10%) 100%
  );
  border: none;

  &:hover {
    background: linear-gradient(
      135deg,
      lighten(@global-primary-background, 5%) 0%,
      @global-primary-background 100%
    );
  }
}

.uk-card-premium {
  border: 2px solid @global-primary-background;
  box-shadow: 0 14px 25px rgba(0, 0, 0, 0.16);

  &:hover {
    transform: translateY(-2px);
    transition: all 0.3s ease;
  }
}
```

## Development Workflow

### 1. Setup and Installation

```bash
# Create new project
mkdir my-uikit-project
cd my-uikit-project

# Initialize package.json
npm init -y

# Install UIKit and build tools
npm install uikit less webpack webpack-cli webpack-dev-server --save
npm install less-loader css-loader style-loader html-webpack-plugin --save-dev

# Create project structure
mkdir src dist
touch src/index.html src/styles.less src/scripts.js
```

### 2. Development Process

```bash
# Development server
npm run dev

# Watch for changes
npm run watch

# Build for development
npm run build:dev

# Lint styles
npm run lint:css
```

### 3. Custom Theme Development

```less
// main.less
// Import UIKit source for customization
@import '~uikit/src/less/uikit.less';

// Custom theme variables
@global-primary-background: #e74c3c;
@navbar-background: @global-primary-background;
@button-primary-background: @global-primary-background;

// Custom components
.uk-button-custom {
  background: linear-gradient(
    135deg,
    @global-primary-background 0%,
    darken(@global-primary-background, 15%) 100%
  );
  border: none;
  border-radius: 25px;
  padding: 0 30px;

  &:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  }
}
```

### 4. Building for Production

```bash
# Production build
npm run build

# Optimize assets
npm run optimize

# Analyze bundle
npm run analyze

# Deploy
npm run deploy
```

### 5. Testing and Quality Assurance

```bash
# Visual regression testing
npm run test:visual

# Cross-browser testing
npm run test:browsers

# Accessibility testing
npm run test:a11y

# Performance testing
npm run test:performance
```

## Configuration

### Webpack Configuration for Custom Builds

```javascript
// webpack.config.js - Complete UIKit build setup
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');

module.exports = (env, argv) => {
  const isProduction = argv.mode === 'production';

  return {
    entry: {
      main: './src/index.js',
    },
    output: {
      path: path.resolve(__dirname, 'dist'),
      filename: isProduction ? '[name].[contenthash].js' : '[name].js',
      publicPath: '/',
    },
    module: {
      rules: [
        {
          test: /\.less$/,
          use: [
            isProduction ? MiniCssExtractPlugin.loader : 'style-loader',
            {
              loader: 'css-loader',
              options: {
                sourceMap: !isProduction,
              },
            },
            {
              loader: 'less-loader',
              options: {
                lessOptions: {
                  math: 'always',
                  sourceMap: !isProduction,
                },
              },
            },
          ],
        },
        {
          test: /\.(png|jpe?g|gif|svg|woff|woff2|eot|ttf|otf)$/,
          type: 'asset/resource',
          generator: {
            filename: 'assets/[hash][ext][query]',
          },
        },
      ],
    },
    plugins: [
      new CleanWebpackPlugin(),
      new HtmlWebpackPlugin({
        template: './src/index.html',
        minify: isProduction,
      }),
      ...(isProduction
        ? [
            new MiniCssExtractPlugin({
              filename: '[name].[contenthash].css',
            }),
          ]
        : []),
    ],
    optimization: {
      splitChunks: {
        chunks: 'all',
        cacheGroups: {
          vendor: {
            test: /[\/]node_modules[\/]/,
            name: 'vendors',
            chunks: 'all',
          },
        },
      },
      ...(isProduction
        ? {
            minimizer: [new OptimizeCSSAssetsPlugin()],
          }
        : {}),
    },
    devServer: {
      static: './dist',
      port: 3000,
      open: true,
      hot: true,
    },
    devtool: isProduction ? 'source-map' : 'eval-source-map',
  };
};
```

### Package.json Scripts

```json
{
  "scripts": {
    "dev": "webpack serve --mode development",
    "build": "webpack --mode production",
    "build:dev": "webpack --mode development",
    "watch": "webpack --mode development --watch",
    "clean": "rimraf dist",
    "lint:css": "stylelint 'src/**/*.less'",
    "lint:js": "eslint src/**/*.js",
    "test": "npm run test:lint && npm run test:build",
    "test:lint": "npm run lint:css && npm run lint:js",
    "test:build": "npm run build",
    "analyze": "webpack-bundle-analyzer dist/main.*.js"
  }
}
```

### Less Configuration

```less
// uikit-config.less
// Global settings
@global-color: #333;
@global-emphasis-color: #000;
@global-muted-color: #999;
@global-link-color: #1e87f0;
@global-link-hover-color: #0f6ecd;

// Typography
@global-font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
@global-font-size: 14px;
@global-line-height: 1.5;

// Spacing
@global-margin: 20px;
@global-small-margin: 10px;
@global-medium-margin: 40px;
@global-large-margin: 70px;

// Component-specific variables
@navbar-nav-item-height: 80px;
@navbar-nav-item-padding-horizontal: 15px;
@navbar-nav-item-color: @global-muted-color;
@navbar-nav-item-font-size: @global-font-size;
@navbar-nav-item-font-family: @global-font-family;
@navbar-nav-item-hover-color: @global-color;
@navbar-nav-item-onclick-color: @global-emphasis-color;
@navbar-nav-item-active-color: @global-emphasis-color;

// Import UIKit
@import 'uikit/src/less/uikit.less';
```

## Essential Commands

### Development Commands

```bash
# Project creation and setup
mkdir uikit-project && cd uikit-project
npm init -y
npm install uikit

# Development server
webpack serve --mode development
npm run dev

# Build commands
webpack --mode production
npm run build

# Watch mode
webpack --watch
npm run watch
```

### Asset Compilation

```bash
# Compile Less to CSS
lessc src/styles.less dist/styles.css

# Compile with source maps
lessc src/styles.less dist/styles.css --source-map

# Minify CSS
lessc src/styles.less dist/styles.css --compress

# Watch Less files
lessc src/styles.less dist/styles.css --watch
```

### Testing and Quality

```bash
# Lint Less/CSS
stylelint "src/**/*.less"

# Lint JavaScript
eslint src/**/*.js

# Run accessibility tests
pa11y http://localhost:3000

# Performance testing
lighthouse http://localhost:3000 --output html --output-path ./report.html
```

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

```html
<!-- Admin Dashboard with Sidebar -->
<div class="uk-offcanvas-content">
  <!-- Top Navigation -->
  <nav class="uk-navbar-container uk-navbar-transparent" uk-navbar>
    <div class="uk-navbar-left">
      <a class="uk-navbar-toggle" uk-navbar-toggle-icon uk-toggle="target: #offcanvas-nav"></a>
      <div class="uk-navbar-item uk-logo">Dashboard</div>
    </div>
    <div class="uk-navbar-right">
      <ul class="uk-navbar-nav">
        <li>
          <a href="#">
            <span class="uk-icon uk-margin-small-right" uk-icon="icon: bell"></span>
            <span class="uk-badge">5</span>
          </a>
        </li>
        <li>
          <a href="#">Profile</a>
          <div class="uk-navbar-dropdown">
            <ul class="uk-nav uk-navbar-dropdown-nav">
              <li><a href="#">Settings</a></li>
              <li><a href="#">Profile</a></li>
              <li class="uk-nav-divider"></li>
              <li><a href="#">Logout</a></li>
            </ul>
          </div>
        </li>
      </ul>
    </div>
  </nav>

  <!-- Sidebar Navigation -->
  <div id="offcanvas-nav" uk-offcanvas="overlay: true">
    <div class="uk-offcanvas-bar uk-flex uk-flex-column">
      <ul class="uk-nav uk-nav-primary uk-nav-center uk-margin-auto-vertical">
        <li class="uk-active">
          <a href="#"><span uk-icon="home"></span> Dashboard</a>
        </li>
        <li>
          <a href="#"><span uk-icon="users"></span> Users</a>
        </li>
        <li>
          <a href="#"><span uk-icon="cog"></span> Settings</a>
        </li>
      </ul>
    </div>
  </div>

  <!-- Main Content -->
  <div class="uk-container uk-container-expand">
    <div class="uk-grid-match uk-child-width-1-4@l uk-child-width-1-2@m" uk-grid>
      <!-- Stats Cards -->
      <div>
        <div class="uk-card uk-card-default uk-card-body uk-text-center">
          <h3 class="uk-card-title">1,234</h3>
          <p>Total Users</p>
        </div>
      </div>
      <!-- More stats cards... -->
    </div>

    <!-- Data Table -->
    <div class="uk-card uk-card-default uk-margin-top">
      <div class="uk-card-header">
        <h3 class="uk-card-title">Recent Activity</h3>
      </div>
      <div class="uk-card-body">
        <table class="uk-table uk-table-striped">
          <thead>
            <tr>
              <th>User</th>
              <th>Action</th>
              <th>Date</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>John Doe</td>
              <td>Login</td>
              <td>2025-08-14</td>
              <td><span class="uk-label uk-label-success">Success</span></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
```

### Advanced Form Components

```html
<!-- Multi-step Form with Validation -->
<form class="uk-form-stacked" uk-form>
  <div class="uk-margin">
    <label class="uk-form-label" for="form-stacked-text">Name</label>
    <div class="uk-form-controls">
      <input
        class="uk-input"
        id="form-stacked-text"
        type="text"
        placeholder="Enter your name"
        required
      />
    </div>
  </div>

  <div class="uk-margin">
    <label class="uk-form-label" for="form-stacked-select">Country</label>
    <div class="uk-form-controls">
      <select class="uk-select" id="form-stacked-select" required>
        <option value="">Select country</option>
        <option value="us">United States</option>
        <option value="uk">United Kingdom</option>
      </select>
    </div>
  </div>

  <div class="uk-margin">
    <div class="uk-form-label">Newsletter</div>
    <div class="uk-form-controls uk-form-controls-text">
      <label><input class="uk-checkbox" type="checkbox" checked /> Send weekly newsletter</label>
    </div>
  </div>

  <div class="uk-margin">
    <button class="uk-button uk-button-primary" type="submit">Submit</button>
  </div>
</form>

<!-- File Upload with Progress -->
<div class="js-upload uk-placeholder uk-text-center">
  <span uk-icon="icon: cloud-upload; ratio: 3"></span>
  <span class="uk-text-middle">Attach files by dropping them here or</span>
  <div uk-form-custom>
    <input type="file" multiple />
    <span class="uk-link">selecting one</span>
  </div>
</div>

<progress id="js-progressbar" class="uk-progress" value="0" max="100" hidden></progress>
```

## JavaScript Integration and Custom Components

### Advanced JavaScript Integration

```javascript
// Custom UIKit component initialization
import UIkit from 'uikit';
import Icons from 'uikit/dist/js/uikit-icons';

// Load UIKit icons
UIkit.use(Icons);

// Custom component creation
UIkit.component('custom-slider', {
  mixins: [UIkit.mixin.class],

  props: {
    autoplay: Boolean,
    interval: Number,
  },

  defaults: {
    autoplay: true,
    interval: 5000,
  },

  init() {
    this.startAutoplay();
  },

  methods: {
    startAutoplay() {
      if (this.autoplay) {
        this.timer = setInterval(() => {
          this.next();
        }, this.interval);
      }
    },

    next() {
      // Custom next logic
    },

    prev() {
      // Custom previous logic
    },
  },
});

// Event handling for dynamic content
UIkit.util.on(document, 'click', '.js-dynamic-modal', function (e) {
  e.preventDefault();

  const content = this.getAttribute('data-content');

  UIkit.modal.dialog(`
    <div class="uk-modal-header">
      <h2 class="uk-modal-title">Dynamic Content</h2>
    </div>
    <div class="uk-modal-body">
      <p>${content}</p>
    </div>
    <div class="uk-modal-footer uk-text-right">
      <button class="uk-button uk-button-default uk-modal-close" type="button">Close</button>
    </div>
  `);
});

// Notification system
function showNotification(message, type = 'primary') {
  UIkit.notification({
    message: message,
    status: type,
    pos: 'top-right',
    timeout: 5000,
  });
}

// Custom data loading with UIKit components
async function loadData() {
  try {
    const response = await fetch('/api/data');
    const data = await response.json();

    // Update UIKit components with new data
    const container = document.querySelector('#data-container');
    container.innerHTML = data
      .map(
        (item) => `
      <div class="uk-card uk-card-default uk-margin-bottom">
        <div class="uk-card-body">
          <h3 class="uk-card-title">${item.title}</h3>
          <p>${item.description}</p>
        </div>
      </div>
    `,
      )
      .join('');

    showNotification('Data loaded successfully', 'success');
  } catch (error) {
    showNotification('Failed to load data', 'danger');
  }
}
```

### TypeScript Integration

```typescript
// types/uikit.d.ts
import UIkit from 'uikit';

declare global {
  interface Window {
    UIkit: typeof UIkit;
  }
}

// Custom component types
interface CustomSliderOptions {
  autoplay?: boolean;
  interval?: number;
  animation?: string;
}

class CustomSlider {
  private element: HTMLElement;
  private options: CustomSliderOptions;
  private timer?: NodeJS.Timeout;

  constructor(element: HTMLElement, options: CustomSliderOptions = {}) {
    this.element = element;
    this.options = {
      autoplay: true,
      interval: 5000,
      animation: 'slide',
      ...options,
    };

    this.init();
  }

  private init(): void {
    if (this.options.autoplay) {
      this.startAutoplay();
    }

    this.bindEvents();
  }

  private bindEvents(): void {
    this.element.addEventListener('mouseenter', () => this.pause());
    this.element.addEventListener('mouseleave', () => this.resume());
  }

  private startAutoplay(): void {
    this.timer = setInterval(() => {
      this.next();
    }, this.options.interval);
  }

  public pause(): void {
    if (this.timer) {
      clearInterval(this.timer);
    }
  }

  public resume(): void {
    if (this.options.autoplay) {
      this.startAutoplay();
    }
  }

  public next(): void {
    // Implementation for next slide
  }

  public previous(): void {
    // Implementation for previous slide
  }
}

// Usage
document.addEventListener('DOMContentLoaded', () => {
  const sliders = document.querySelectorAll<HTMLElement>('.custom-slider');
  sliders.forEach((slider) => {
    new CustomSlider(slider, {
      autoplay: true,
      interval: 3000,
    });
  });
});
```

## Troubleshooting

### Common Issues

#### Less Compilation Errors

**Problem**: Less compilation fails with import or variable errors
**Symptoms**: Build process fails with UIKit-related import errors
**Solution**:

```bash
# Ensure correct UIKit path in Less imports
# Check node_modules path
ls node_modules/uikit/src/less/

# Verify import syntax
@import "~uikit/src/less/uikit.less"; // Webpack
@import "node_modules/uikit/src/less/uikit.less"; // Direct path

# Check Less loader configuration
# webpack.config.js
{
  test: /\.less$/,
  use: [
    'style-loader',
    'css-loader',
    {
      loader: 'less-loader',
      options: {
        lessOptions: {
          math: 'always' // Required for UIKit
        }
      }
    }
  ]
}
```

#### JavaScript Components Not Working

**Problem**: UIKit JavaScript components don't initialize or function properly
**Symptoms**: Dropdowns, modals, and other interactive elements are non-functional
**Solution**:

```javascript
// Ensure UIKit is properly loaded
import UIkit from 'uikit';
import Icons from 'uikit/dist/js/uikit-icons';
UIkit.use(Icons);

// Check for proper DOM ready initialization
document.addEventListener('DOMContentLoaded', function () {
  // UIKit components should initialize automatically
  // For manual initialization:
  UIkit.modal('#my-modal');
});

// For dynamically added content
function initDynamicContent() {
  UIkit.update(); // Re-scan for new components
}

// Debug component initialization
console.log(UIkit.components); // List available components
```

#### Grid Layout Issues

**Problem**: Grid columns don't align or behave responsively
**Symptoms**: Columns stack incorrectly or don't maintain proper spacing
**Solution**:

```html
<!-- Ensure proper grid structure -->
<div class="uk-container">
  <div class="uk-grid-match uk-child-width-1-3@m" uk-grid>
    <div>Content 1</div>
    <div>Content 2</div>
    <div>Content 3</div>
  </div>
</div>

<!-- Check for missing uk-grid attribute -->
<div class="uk-grid" uk-grid>
  <!-- uk-grid attribute required -->
  <div class="uk-width-1-2">Half</div>
  <div class="uk-width-1-2">Half</div>
</div>

<!-- Debug grid with visible borders -->
<style>
  .uk-grid > * {
    border: 1px solid red;
  }
</style>
```

#### Performance Issues

**Problem**: Large bundle size or slow loading times
**Symptoms**: Slow page loads, large CSS/JS bundles
**Solution**:

```javascript
// Import only needed components
import { modal, dropdown, navbar } from 'uikit/dist/js/uikit.min.js';

// Or import specific components
import Modal from 'uikit/src/js/components/modal';
import Dropdown from 'uikit/src/js/components/dropdown';

// Use UIKit's tree shaking
// webpack.config.js optimization
module.exports = {
  optimization: {
    usedExports: true,
    sideEffects: false,
  },
};
```

### Debug Mode

```javascript
// Enable UIKit debugging
UIkit.debug = true;

// Check component status
console.log(UIkit.components);

// Monitor events
UIkit.util.on(document, 'show.uk.modal', function (e) {
  console.log('Modal showing:', e.target);
});

// Check for initialization issues
document.addEventListener('DOMContentLoaded', function () {
  console.log('UIKit loaded:', typeof UIkit !== 'undefined');
  console.log('Available components:', Object.keys(UIkit.components));
});
```

### Performance Optimization

```bash
# Analyze bundle size
webpack-bundle-analyzer dist/main.*.js

# Optimize Less compilation
lessc --compress --source-map src/styles.less dist/styles.css

# Use CDN for production
# Include only core components locally
# Load additional components on demand
```

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

```bash
# Installation commands
[package manager install command]

# Project initialization
[framework CLI or setup commands]
```

## Project Structure

```
project-root/
├── [typical folder structure]
├── [configuration files]
├── [source directories]
└── [other important directories]
```

## Core Concepts

### [Concept 1]

- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

### [Concept 2]

- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

## Development Workflow

1. **Setup**: [Initial project setup steps]
2. **Development**: [Development server, hot reload, etc.]
3. **Testing**: [Testing framework and commands]
4. **Building**: [Build process and commands]
5. **Deployment**: [Deployment strategies]

## Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

## Common Patterns

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
