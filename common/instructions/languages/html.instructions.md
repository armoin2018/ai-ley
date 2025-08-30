---
applyTo: "**/*.html,**/*.htm,**/*.xhtml"
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

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Comprehensive description of page content for SEO">
  <meta name="keywords" content="relevant, keywords, for, search">
  <meta name="author" content="Author Name">
  
  <!-- Open Graph Meta Tags -->
  <meta property="og:title" content="Page Title">
  <meta property="og:description" content="Page description for social sharing">
  <meta property="og:image" content="/assets/images/og-image.jpg">
  <meta property="og:url" content="https://example.com/page">
  <meta property="og:type" content="website">
  
  <!-- Twitter Card Meta Tags -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="Page Title">
  <meta name="twitter:description" content="Page description for Twitter">
  <meta name="twitter:image" content="/assets/images/twitter-image.jpg">
  
  <!-- Favicon and Touch Icons -->
  <link rel="icon" type="image/x-icon" href="/favicon.ico">
  <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
  
  <!-- Preload Critical Resources -->
  <link rel="preload" href="/assets/css/critical.css" as="style">
  <link rel="preload" href="/assets/fonts/main-font.woff2" as="font" type="font/woff2" crossorigin>
  
  <title>Page Title - Site Name</title>
  
  <!-- Critical CSS Inline -->
  <style>
    /* Critical above-the-fold styles */
  </style>
  
  <!-- Non-critical CSS -->
  <link rel="stylesheet" href="/assets/css/main.css">
</head>
<body>
  <!-- Page content -->
</body>
</html>
```

⸻

✅ Semantic HTML5 Structure

- Use appropriate semantic elements for content organization
- Implement proper heading hierarchy (h1-h6) for document outline
- Use landmarks and sectioning elements for screen reader navigation
- Maintain logical tab order and keyboard accessibility

✅ Example:

```html
<body>
  <!-- Skip navigation for accessibility -->
  <a href="#main-content" class="skip-link">Skip to main content</a>
  
  <!-- Page header -->
  <header role="banner">
    <nav role="navigation" aria-label="Main navigation">
      <ul>
        <li><a href="/" aria-current="page">Home</a></li>
        <li><a href="/about">About</a></li>
        <li><a href="/services">Services</a></li>
        <li><a href="/contact">Contact</a></li>
      </ul>
    </nav>
  </header>
  
  <!-- Main content area -->
  <main id="main-content" role="main">
    <h1>Page Title</h1>
    
    <section aria-labelledby="intro-heading">
      <h2 id="intro-heading">Introduction</h2>
      <p>Page introduction content...</p>
    </section>
    
    <section aria-labelledby="content-heading">
      <h2 id="content-heading">Main Content</h2>
      
      <article>
        <h3>Article Title</h3>
        <time datetime="2025-01-08">January 8, 2025</time>
        <p>Article content...</p>
        
        <figure>
          <img src="/assets/images/example.jpg" 
               alt="Descriptive alt text for image"
               loading="lazy"
               width="800" 
               height="600">
          <figcaption>Image caption describing the content</figcaption>
        </figure>
      </article>
    </section>
    
    <!-- Sidebar content -->
    <aside aria-labelledby="sidebar-heading">
      <h2 id="sidebar-heading">Related Information</h2>
      <p>Sidebar content...</p>
    </aside>
  </main>
  
  <!-- Page footer -->
  <footer role="contentinfo">
    <p>&copy; 2025 Company Name. All rights reserved.</p>
  </footer>
  
  <!-- Scripts at bottom for performance -->
  <script src="/assets/js/main.js" defer></script>
</body>
```

⸻

✅ Forms and Input Elements

- Use proper form structure with fieldsets and legends
- Implement appropriate input types for enhanced user experience
- Use labels, placeholders, and help text effectively
- Include proper validation and error handling markup

✅ Example:

```html
<form action="/contact" method="post" novalidate>
  <fieldset>
    <legend>Personal Information</legend>
    
    <div class="form-group">
      <label for="name">Full Name <span aria-label="required">*</span></label>
      <input type="text" 
             id="name" 
             name="name" 
             required 
             aria-describedby="name-help"
             autocomplete="name">
      <small id="name-help">Enter your first and last name</small>
    </div>
    
    <div class="form-group">
      <label for="email">Email Address <span aria-label="required">*</span></label>
      <input type="email" 
             id="email" 
             name="email" 
             required 
             aria-describedby="email-help"
             autocomplete="email">
      <small id="email-help">We'll never share your email address</small>
    </div>
    
    <div class="form-group">
      <label for="phone">Phone Number</label>
      <input type="tel" 
             id="phone" 
             name="phone" 
             aria-describedby="phone-help"
             autocomplete="tel">
      <small id="phone-help">Optional: Include area code for faster response</small>
    </div>
  </fieldset>
  
  <fieldset>
    <legend>Message Details</legend>
    
    <div class="form-group">
      <label for="subject">Subject <span aria-label="required">*</span></label>
      <select id="subject" name="subject" required aria-describedby="subject-help">
        <option value="">Please select a subject</option>
        <option value="general">General Inquiry</option>
        <option value="support">Technical Support</option>
        <option value="billing">Billing Question</option>
      </select>
      <small id="subject-help">Choose the category that best fits your inquiry</small>
    </div>
    
    <div class="form-group">
      <label for="message">Message <span aria-label="required">*</span></label>
      <textarea id="message" 
                name="message" 
                rows="5" 
                required 
                aria-describedby="message-help"
                maxlength="1000"></textarea>
      <small id="message-help">Please provide details about your inquiry (max 1000 characters)</small>
    </div>
  </fieldset>
  
  <div class="form-group">
    <button type="submit" class="btn btn-primary">Send Message</button>
    <button type="reset" class="btn btn-secondary">Clear Form</button>
  </div>
</form>
```

⸻

✅ Images and Media Elements

- Use appropriate image formats and responsive images
- Implement proper alt text for accessibility
- Use lazy loading for performance optimization
- Include proper fallbacks for media elements

✅ Example:

```html
<!-- Responsive Images -->
<picture>
  <source media="(max-width: 768px)" 
          srcset="/assets/images/hero-mobile.webp 1x, 
                  /assets/images/hero-mobile@2x.webp 2x"
          type="image/webp">
  <source media="(max-width: 768px)" 
          srcset="/assets/images/hero-mobile.jpg 1x, 
                  /assets/images/hero-mobile@2x.jpg 2x"
          type="image/jpeg">
  <source media="(min-width: 769px)" 
          srcset="/assets/images/hero-desktop.webp 1x, 
                  /assets/images/hero-desktop@2x.webp 2x"
          type="image/webp">
  <img src="/assets/images/hero-desktop.jpg" 
       srcset="/assets/images/hero-desktop.jpg 1x, 
               /assets/images/hero-desktop@2x.jpg 2x"
       alt="Descriptive text about the hero image content"
       loading="lazy"
       width="1200" 
       height="600">
</picture>

<!-- Video with Accessibility -->
<video controls 
       width="800" 
       height="450" 
       poster="/assets/images/video-poster.jpg"
       aria-labelledby="video-title"
       aria-describedby="video-description">
  <source src="/assets/videos/example.mp4" type="video/mp4">
  <source src="/assets/videos/example.webm" type="video/webm">
  <track kind="captions" 
         src="/assets/captions/example-en.vtt" 
         srclang="en" 
         label="English captions">
  <track kind="subtitles" 
         src="/assets/subtitles/example-es.vtt" 
         srclang="es" 
         label="Spanish subtitles">
  <p>Your browser doesn't support HTML video. 
     <a href="/assets/videos/example.mp4">Download the video</a> instead.</p>
</video>
<h3 id="video-title">Video Title</h3>
<p id="video-description">Brief description of video content for screen readers</p>
```

⸻

✅ Performance Optimization

- 🚫 Avoid inline styles and scripts in production
- 🚫 Avoid excessive DOM nesting and complexity
- ✅ Use proper resource loading strategies (defer, async, preload)
- ✅ Implement lazy loading for images and non-critical content

❌ Bad:

```html
<!-- Avoid inline styles -->
<div style="color: red; font-size: 16px;">Content</div>

<!-- Avoid inline scripts -->
<button onclick="doSomething()">Click me</button>

<!-- Avoid blocking scripts in head -->
<head>
  <script src="/assets/js/large-library.js"></script>
</head>

<!-- Avoid excessive nesting -->
<div class="wrapper">
  <div class="container">
    <div class="row">
      <div class="col">
        <div class="content">
          <div class="inner">
            <p>Overly nested content</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
```

✅ Good:

```html
<!-- Use external stylesheets -->
<link rel="stylesheet" href="/assets/css/main.css">

<!-- Use external scripts with proper loading -->
<script src="/assets/js/main.js" defer></script>

<!-- Use semantic, efficient structure -->
<main class="container">
  <section class="content">
    <p>Well-structured content</p>
  </section>
</main>

<!-- Use resource hints for performance -->
<head>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preload" href="/assets/css/critical.css" as="style">
  <link rel="prefetch" href="/assets/js/non-critical.js" as="script">
</head>
```

⸻

✅ Accessibility Best Practices

- Use ARIA attributes appropriately to enhance accessibility
- Implement proper focus management and keyboard navigation
- Ensure sufficient color contrast and readable text
- Provide alternative content for media and interactive elements

✅ Example:

```html
<!-- Custom Components with ARIA -->
<div class="dropdown" role="combobox" aria-expanded="false" aria-haspopup="listbox">
  <button class="dropdown-toggle" 
          aria-label="Choose an option"
          aria-describedby="dropdown-help">
    Select Option
  </button>
  <ul class="dropdown-menu" role="listbox" aria-hidden="true">
    <li role="option" aria-selected="false">
      <a href="#" tabindex="-1">Option 1</a>
    </li>
    <li role="option" aria-selected="false">
      <a href="#" tabindex="-1">Option 2</a>
    </li>
    <li role="option" aria-selected="true">
      <a href="#" tabindex="-1">Option 3</a>
    </li>
  </ul>
  <small id="dropdown-help">Use arrow keys to navigate options</small>
</div>

<!-- Table with Accessibility -->
<table role="table" aria-labelledby="table-title">
  <caption id="table-title">Sales Data for Q4 2024</caption>
  <thead>
    <tr>
      <th scope="col">Month</th>
      <th scope="col">Sales</th>
      <th scope="col">Growth</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">October</th>
      <td>$50,000</td>
      <td>+5%</td>
    </tr>
    <tr>
      <th scope="row">November</th>
      <td>$55,000</td>
      <td>+10%</td>
    </tr>
  </tbody>
</table>

<!-- Interactive Content with Accessibility -->
<button type="button" 
        aria-label="Toggle navigation menu"
        aria-expanded="false"
        aria-controls="mobile-menu"
        class="menu-toggle">
  <span class="sr-only">Menu</span>
  <span class="hamburger-icon" aria-hidden="true"></span>
</button>

<nav id="mobile-menu" aria-hidden="true" aria-labelledby="mobile-menu-title">
  <h2 id="mobile-menu-title" class="sr-only">Main Navigation</h2>
  <!-- Navigation items -->
</nav>
```

⸻

🧠 Performance & SEO

- Optimize HTML structure for search engines and performance
- Use structured data markup for enhanced search results
- Implement proper meta tags and social sharing optimization
- Minimize HTML file sizes and optimize critical rendering path

✅ Example:

```html
<!-- Structured Data for SEO -->
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Article Title",
  "author": {
    "@type": "Person",
    "name": "Author Name"
  },
  "datePublished": "2025-01-08",
  "dateModified": "2025-01-08",
  "description": "Article description",
  "image": "https://example.com/article-image.jpg"
}
</script>

<!-- Performance Optimization -->
<head>
  <!-- Critical resource hints -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="dns-prefetch" href="https://analytics.google.com">
  
  <!-- Critical CSS inline -->
  <style>
    /* Above-the-fold critical styles */
  </style>
  
  <!-- Non-critical CSS with media queries -->
  <link rel="stylesheet" 
        href="/assets/css/print.css" 
        media="print" 
        onload="this.media='all'">
</head>

<!-- Lazy loading for performance -->
<img src="/assets/images/placeholder.jpg" 
     data-src="/assets/images/actual-image.jpg"
     alt="Image description"
     loading="lazy"
     class="lazy-load"
     width="400" 
     height="300">
```

⸻

🧪 Testing Standards

✅ HTML Validation and Quality Assurance

- Use W3C Markup Validator for HTML compliance
- Test accessibility with automated tools (axe, WAVE, Lighthouse)
- Validate semantic structure and heading hierarchy
- Test keyboard navigation and screen reader compatibility

✅ Example Testing Checklist:

```html
<!-- HTML Validation Checklist -->
<!-- ✅ Valid HTML5 doctype -->
<!-- ✅ Proper meta tags and character encoding -->
<!-- ✅ Valid nested elements and proper closing tags -->
<!-- ✅ Unique IDs throughout the document -->
<!-- ✅ Proper form label associations -->

<!-- Accessibility Testing Checklist -->
<!-- ✅ Proper heading hierarchy (h1-h6) -->
<!-- ✅ Alternative text for all images -->
<!-- ✅ ARIA attributes used appropriately -->
<!-- ✅ Keyboard navigation works throughout -->
<!-- ✅ Color contrast meets WCAG AA standards -->
<!-- ✅ Focus indicators are visible -->

<!-- Performance Testing -->
<!-- ✅ Minimal DOM depth and complexity -->
<!-- ✅ Proper resource loading strategies -->
<!-- ✅ Optimized images with proper dimensions -->
<!-- ✅ Critical CSS inlined, non-critical deferred -->

<!-- SEO Testing -->
<!-- ✅ Proper meta tags for search and social -->
<!-- ✅ Structured data markup where appropriate -->
<!-- ✅ Semantic HTML5 elements used correctly -->
<!-- ✅ Proper internal linking structure -->
```

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
