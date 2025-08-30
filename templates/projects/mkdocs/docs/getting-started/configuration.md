# Configuration

Learn how to configure {{PROJECT_TITLE}} for your specific needs.

## Basic Configuration

The main configuration file is `mkdocs.yml` in the root directory. Here's a basic structure:

```yaml
site_name: Your Site Name
site_description: Your site description
site_url: https://yoursite.com

theme:
  name: material
  palette:
    primary: blue
    accent: blue
```

## Theme Customization

### Color Palette

You can customize the color palette by modifying the theme configuration:

```yaml
theme:
  name: material
  palette:
    # Light mode
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    # Dark mode
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-4
        name: Switch to light mode
```

### Features

Enable additional features:

```yaml
theme:
  features:
    - navigation.tabs
    - navigation.sections
    - navigation.expand
    - navigation.top
    - search.highlight
    - search.share
    - content.code.copy
```

## Plugins

### Search Plugin

The search plugin is enabled by default:

```yaml
plugins:
  - search
```

### Git Revision Date

Add last updated dates to your pages:

```yaml
plugins:
  - git-revision-date-localized:
      enable_creation_date: true
```

## Markdown Extensions

Enable additional Markdown features:

```yaml
markdown_extensions:
  - pymdownx.highlight:
      anchor_linenums: true
  - pymdownx.superfences
  - pymdownx.tabbed:
      alternate_style: true
  - admonition
  - pymdownx.details
```

## Navigation

Structure your site navigation:

```yaml
nav:
  - Home: index.md
  - Getting Started:
    - Installation: getting-started/installation.md
    - Configuration: getting-started/configuration.md
  - Guides:
    - User Guide: guides/user-guide.md
```

## Advanced Configuration

For more advanced configuration options, refer to the [MkDocs documentation](https://www.mkdocs.org/user-guide/configuration/) and [Material for MkDocs documentation](https://squidfunk.github.io/mkdocs-material/).