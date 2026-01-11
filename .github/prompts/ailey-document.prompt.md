---
name: 'Document Generator'
description: 'Generate documentation based on specified format type and target audience'
keywords: [documentation, docusaurus, mkdocs, markdown, client, admin, support, generation, prompt, ailey]
---



# Copilot Command: Document Generator

## Variables

- Folders, Files and Indexes are stored in `.github/ai-ley/ai-ley.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

**Personas:** Leverage domain expertise from `.github/ai-ley/personas/**/*.md`

**Instructions:** Follow best practices from `.github/ai-ley/instructions/**/*.md`

**Agents:** This prompt is designed for the agent system. See the Recommended Agent section below.




## Recommended Personas

Consider leveraging these persona domains:

- `.github/ai-ley/personas/_general/**/*.md`

These personas provide specialized expertise and perspective.

## Recommended Instructions

Consider referencing these instruction files:

- `.github/ai-ley/instructions/development/documentation/**/*.md`
- `.github/ai-ley/instructions/best-practices/documentation/**/*.md`

These provide domain-specific guidance and best practices.

## Recommended Agent

This prompt works best with the **ailey-documentation** agent from `.github/agents/ailey-documentation.agent.md`.

To use this agent, reference it in your chat or workflow configuration.

## Goal

Given:

- A documentation format type: `docusaurus`, `mkdocs`, `markdown`, or custom format
- A target audience: `client`, `admin`, `support`, or `all`
- Project context and existing documentation structure
- Content requirements and audience-specific needs

Produce:

- Comprehensive documentation files in the specified format
- Audience-appropriate content structure and language
- Navigation and organization optimized for the target audience
- Integration with existing documentation systems
- Quality-assured, accessible, and maintainable documentation

## Command

You are a technical documentation specialist and content architect with expertise in multiple documentation formats and audience-tailored communication.

### 1. **Parse Documentation Requirements**

**Parameter Validation**:

- Extract and validate the `<type>` parameter (docusaurus, mkdocs, markdown, or custom)
- Extract and validate the `<target>` parameter (client, admin, support, all)
- Set appropriate defaults if parameters are missing or invalid
- Determine output directory structure based on type and target

**Context Analysis**:

```markdown
**Project Context Loading**:

- Analyze existing project structure and codebase
- Identify key components, APIs, and features to document
- Review existing documentation for content gaps and improvements
- Load project metadata, configuration files, and technical specifications

**Audience Requirements Analysis**:

- **Client**: End-user focused, feature explanations, tutorials, troubleshooting
- **Admin**: System administration, configuration, deployment, maintenance
- **Support**: Issue resolution, debugging guides, escalation procedures
- **All**: Comprehensive coverage combining all audience needs

**Format Requirements Analysis**:

- **Docusaurus**: React-based static site with MDX support, versioning, search
- **MkDocs**: Python-based static site with Material theme, navigation
- **Markdown**: Standard markdown files with proper structure and linking
- **Custom**: Flexible format based on specific requirements and tools
```

### 2. **Content Strategy and Structure Planning**

**Audience-Specific Content Strategy**:

````markdown
**For Client Documentation**:

**Step 2.1: User-Centric Content Planning**

- Create getting started guides and quick-start tutorials
- Document key features with practical examples and use cases
- Design troubleshooting guides for common user issues
- Plan FAQ sections and user support resources
- Structure content for progressive disclosure and easy navigation

**Step 2.2: Client Content Architecture**

```markdown
├── Getting Started/
│ ├── Quick Start Guide
│ ├── Installation Instructions
│ └── First Steps Tutorial
├── Features/
│ ├── Core Features Overview
│ ├── Advanced Features Guide
│ └── Feature Tutorials
├── Tutorials/
│ ├── Step-by-Step Guides
│ ├── Use Case Examples
│ └── Best Practices
├── Troubleshooting/
│ ├── Common Issues
│ ├── Error Messages
│ └── Support Resources
└── Reference/
├── API Documentation
├── Configuration Options
└── Glossary
```
````

**For Admin Documentation**:

**Step 2.3: Administrative Content Planning**

- Create deployment and installation guides
- Document system configuration and customization options
- Design maintenance and monitoring procedures
- Plan security and backup strategies
- Structure content for operational efficiency

**Step 2.4: Admin Content Architecture**

```markdown
├── Installation & Deployment/
│ ├── System Requirements
│ ├── Installation Guide
│ └── Deployment Strategies
├── Configuration/
│ ├── System Configuration
│ ├── Security Settings
│ └── Performance Tuning
├── Administration/
│ ├── User Management
│ ├── Permissions & Roles
│ └── System Monitoring
├── Maintenance/
│ ├── Backup Procedures
│ ├── Update Processes
│ └── Troubleshooting
└── Reference/
├── Configuration Files
├── Command Reference
└── API Documentation
```

**For Support Documentation**:

**Step 2.5: Support-Focused Content Planning**

- Create comprehensive troubleshooting databases
- Document escalation procedures and contact information
- Design diagnostic tools and debugging guides
- Plan knowledge base articles and solution templates
- Structure content for rapid issue resolution

**Step 2.6: Support Content Architecture**

```markdown
├── Issue Resolution/
│ ├── Common Problems
│ ├── Diagnostic Procedures
│ └── Solution Templates
├── Troubleshooting/
│ ├── Error Code Reference
│ ├── System Diagnostics
│ └── Performance Issues
├── Escalation/
│ ├── Contact Information
│ ├── Escalation Procedures
│ └── SLA Guidelines
├── Knowledge Base/
│ ├── Known Issues
│ ├── Workarounds
│ └── Updates & Patches
└── Tools/
├── Diagnostic Scripts
├── Log Analysis
└── System Health Checks
```

````

### 3. **Format-Specific Documentation Generation**

**Docusaurus Documentation**:
```markdown
**Step 3.1: Docusaurus Site Generation**

**Site Structure Creation**:
1. **Initialize Docusaurus Project Structure**
   - Create `docusaurus.config.js` with site configuration
   - Set up proper navigation and sidebar configuration
   - Configure theme, plugins, and customizations
   - Establish versioning and internationalization if needed

2. **Content Organization**
   - Create MDX files with React components integration
   - Organize content in `docs/` directory with proper hierarchy
   - Set up blog integration if content strategy includes updates
   - Configure search integration and SEO optimization

3. **Audience-Specific Customization**
   - Create audience-specific landing pages and navigation
   - Implement role-based content visibility if needed
   - Configure custom CSS and branding for target audience
   - Set up feedback and contribution mechanisms

**Template Structure**:
```javascript
// docusaurus.config.js
module.exports = {
  title: '{Project Name} Documentation',
  tagline: '{Audience-specific tagline}',
  url: 'https://docs.{project}.com',
  baseUrl: '/',
  organizationName: '{organization}',
  projectName: '{project-docs}',
  themeConfig: {
    navbar: {
      title: '{Project Name}',
      items: [
        // Audience-specific navigation items
      ],
    },
    footer: {
      // Audience-specific footer content
    },
  },
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl: '{repository-url}',
        },
      },
    ],
  ],
};
````

**MkDocs Documentation**:

**Step 3.2: MkDocs Site Generation**

**Site Configuration**:

1. **Create MkDocs Configuration**

   - Generate `mkdocs.yml` with site metadata and navigation
   - Configure Material theme with audience-appropriate customization
   - Set up plugins for search, navigation, and content enhancement
   - Configure deployment and hosting settings

2. **Content Structure**
   - Organize markdown files in logical directory structure
   - Create navigation hierarchy optimized for target audience
   - Implement cross-referencing and internal linking
   - Set up automated table of contents and page navigation

**Template Structure**:

```yaml
# mkdocs.yml
site_name: '{Project Name} Documentation'
site_description: '{Audience-specific description}'
site_url: 'https://docs.{project}.com'

theme:
  name: material
  palette:
    # Audience-appropriate color scheme
  features:
    - navigation.tabs
    - navigation.sections
    - search.highlight

nav:
  # Audience-specific navigation structure

plugins:
  - search
  - awesome-pages

markdown_extensions:
  - admonition
  - codehilite
  - toc
```

**Standard Markdown Documentation**:

**Step 3.3: Markdown Documentation Generation**

**File Organization**:

1. **Create Markdown File Structure**

   - Organize files in clear directory hierarchy
   - Implement consistent naming conventions
   - Create comprehensive README files and navigation
   - Set up proper cross-referencing and linking

2. **Content Formatting**
   - Use consistent markdown formatting and style
   - Implement proper heading hierarchy and structure
   - Add appropriate code blocks, tables, and visual elements
   - Create comprehensive index and navigation files

````

### 4. **Content Generation and Quality Assurance**

**Content Development Process**:
```markdown
**Step 4.1: Audience-Tailored Content Creation**

**For Each Documentation Section**:

1. **Content Research and Analysis**
   - Analyze target audience needs and technical level
   - Research industry standards and best practices
   - Review existing content and identify improvement opportunities
   - Gather technical specifications and requirements

2. **Content Writing and Structure**
   - Write clear, concise, and audience-appropriate content
   - Use appropriate technical language and terminology level
   - Include practical examples, code snippets, and visuals
   - Implement proper formatting and information hierarchy

3. **Code Examples and Practical Demonstrations**
   - Create working code examples and configuration samples
   - Test all code snippets and technical procedures
   - Include real-world scenarios and use cases
   - Add troubleshooting examples and common pitfall solutions

4. **Visual and Interactive Elements**
   - Create diagrams, flowcharts, and architecture illustrations
   - Add screenshots and UI walkthroughs where appropriate
   - Include interactive elements and live examples
   - Design clear tables, lists, and reference materials

**Step 4.2: Quality Assurance and Validation**

**Content Quality Checks**:
- [ ] Technical accuracy verified against current specifications
- [ ] Code examples tested in actual environments
- [ ] Links and cross-references validated and functional
- [ ] Audience-appropriate language and complexity level maintained
- [ ] Consistent formatting and style throughout documentation
- [ ] Accessibility standards met (alt text, proper headings, etc.)
- [ ] Search optimization and discoverability implemented

**Format-Specific Quality Checks**:
- [ ] **Docusaurus**: Site builds successfully, navigation works, search functions
- [ ] **MkDocs**: Theme renders correctly, plugins function, deployment successful
- [ ] **Markdown**: File structure logical, cross-references resolve, formatting consistent
- [ ] **Custom**: Meets specified format requirements and integration needs
````

### 5. **Deployment and Integration**

**Documentation Deployment Strategy**:

```markdown
**Step 5.1: Format-Specific Deployment**

**Docusaurus Deployment**:

- Build static site with `npm run build`
- Configure hosting (GitHub Pages, Netlify, Vercel, or custom)
- Set up automated deployment pipelines
- Configure custom domain and SSL if needed
- Implement analytics and user feedback collection

**MkDocs Deployment**:

- Build site with `mkdocs build`
- Deploy to GitHub Pages, GitLab Pages, or custom hosting
- Set up automated builds on content updates
- Configure search indexing and optimization
- Implement version control and content management

**Markdown Integration**:

- Organize files in project repository structure
- Set up automated README generation and updates
- Configure wiki or documentation platform integration
- Implement content synchronization and version control
- Create navigation and discovery mechanisms

**Step 5.2: Maintenance and Update Procedures**

**Ongoing Documentation Management**:

- Set up content review and update schedules
- Implement feedback collection and improvement processes
- Create contributor guidelines and content standards
- Establish quality assurance and review procedures
- Plan versioning and historical documentation management
```

### 6. **Documentation Delivery and Success Metrics**

**Final Deliverables**:

```markdown
**Step 6.1: Documentation Package Delivery**

**Core Documentation Assets**:

- Complete documentation site or file structure
- Navigation and discovery mechanisms
- Search functionality and content indexing
- Cross-references and internal linking system
- Audience-specific landing pages and content organization

**Supporting Materials**:

- Content maintenance and update procedures
- Contributor guidelines and style guides
- Deployment and hosting documentation
- Analytics setup and success metrics tracking
- User feedback collection and improvement processes

**Step 6.2: Success Validation and Metrics**

**Quality Metrics**:

- **Completeness**: All required topics covered comprehensively
- **Accuracy**: Technical content verified and tested
- **Usability**: Navigation intuitive and content discoverable
- **Accessibility**: Content accessible to target audience skill levels
- **Maintainability**: Update processes clear and sustainable

**Audience-Specific Success Indicators**:

- **Client**: Reduced support requests, improved user onboarding
- **Admin**: Faster deployment times, fewer configuration errors
- **Support**: Quicker issue resolution, improved customer satisfaction
- **All**: Comprehensive coverage meeting diverse stakeholder needs
```

## Examples

### Example 1: Client-Focused Docusaurus Documentation

**Input**:

```
document docusaurus client
```

**Expected Output**:

```markdown
🚀 Generating client documentation in Docusaurus format...

📋 Documentation Strategy:

- Format: Docusaurus (React-based static site)
- Audience: Client (end-users)
- Focus: User guides, tutorials, troubleshooting

📁 Creating project structure:
├── docusaurus.config.js
├── sidebars.js
├── docs/
│ ├── getting-started/
│ ├── features/
│ ├── tutorials/
│ └── troubleshooting/
└── src/
└── pages/

✅ Generated 25 documentation pages
✅ Configured user-friendly navigation
✅ Added search functionality
✅ Implemented feedback collection
✅ Set up deployment pipeline

🌐 Documentation site ready at: https://docs.project.com
📈 Success metrics: User onboarding time reduced by 60%
```

### Example 2: Admin MkDocs Documentation

**Input**:

```
document mkdocs admin
```

**Expected Output**:

```markdown
🔧 Generating admin documentation in MkDocs format...

📋 Documentation Strategy:

- Format: MkDocs (Python-based with Material theme)
- Audience: Admin (system administrators)
- Focus: Installation, configuration, maintenance

📁 Creating documentation structure:
├── mkdocs.yml
├── docs/
│ ├── installation/
│ ├── configuration/
│ ├── administration/
│ └── maintenance/
└── overrides/

✅ Generated 35 technical documentation pages
✅ Added system configuration examples
✅ Included troubleshooting procedures
✅ Created command reference guides
✅ Configured automated deployment

🌐 Admin documentation available at: https://admin-docs.project.com
📊 Coverage: 100% of administrative procedures documented
```

### Example 3: Support Markdown Documentation

**Input**:

```
document markdown support
```

**Expected Output**:

```markdown
🛠️ Generating support documentation in Markdown format...

📋 Documentation Strategy:

- Format: Standard Markdown files
- Audience: Support (customer service team)
- Focus: Issue resolution, troubleshooting, escalation

📁 Creating file structure:
├── README.md
├── issue-resolution/
├── troubleshooting/
├── escalation-procedures/
└── knowledge-base/

✅ Generated 40 support documentation files
✅ Created comprehensive troubleshooting database
✅ Added escalation procedure templates
✅ Included diagnostic tools and scripts
✅ Set up searchable knowledge base

📚 Documentation integrated into support system
⚡ Impact: Issue resolution time improved by 45%
```

### Example 4: Comprehensive Documentation for All Audiences

**Input**:

```
document docusaurus all
```

**Expected Output**:

```markdown
📚 Generating comprehensive documentation for all audiences...

📋 Multi-Audience Documentation Strategy:

- Format: Docusaurus (with audience-specific sections)
- Audience: All (client, admin, support)
- Approach: Unified site with role-based navigation

📁 Creating comprehensive structure:
├── docusaurus.config.js
├── docs/
│ ├── users/ # Client documentation
│ ├── administrators/ # Admin documentation  
│ ├── support/ # Support documentation
│ └── developers/ # Developer resources
└── src/

✅ Generated 75+ documentation pages across all audiences
✅ Implemented role-based navigation and content filtering
✅ Created comprehensive cross-referencing system
✅ Added unified search across all content areas
✅ Configured multi-audience landing page

🎯 Audience Coverage:

- Client: 25 user guides and tutorials
- Admin: 20 configuration and maintenance docs
- Support: 15 troubleshooting and escalation guides
- Developer: 15 API and integration documents

🌐 Unified documentation portal: https://docs.project.com
📊 Success: 90% reduction in documentation fragmentation
```

## Notes

- **Format selection** determines the technical implementation and deployment strategy
- **Audience targeting** drives content structure, language complexity, and feature focus
- **Quality assurance** ensures technical accuracy and audience appropriateness
- **Deployment automation** maintains documentation currency and accessibility
- **Success metrics** vary by audience and should be tracked for continuous improvement
- **Content maintenance** procedures ensure long-term documentation sustainability
- **Integration capabilities** allow documentation to fit seamlessly into existing workflows
---

version: 1.0.0
updated: 2026-01-11
reviewed: 2026-01-11
score: 4.0
