---
templateType: intake
category: web-app
version: 1.0.0
author: AI-LEY
created: 2025-11-09T00:00:00.000000
description: Interactive intake template for web application projects
---

# Web Application Project Intake

## Project Overview

### Q1: Project Name

**Question**: What is the name of your web application?
**Type**: text
**Required**: yes

### Q2: Project Description

**Question**: Provide a brief description of the web application (1-2 paragraphs). What problem does it solve and who are the target users?
**Type**: textarea
**Required**: yes

### Q3: Project Goals

**Question**: What are the primary goals and objectives for this web application?
**Type**: list
**Required**: yes
**Suggestions**:

- Increase user engagement
- Improve conversion rates
- Streamline business processes
- Provide self-service capabilities
- Enhance brand presence
- Generate revenue
- Reduce operational costs
- Replace legacy system
- Enter new market segment
- Improve customer satisfaction

## Technical Context

### Q4: Technology Stack

**Question**: What technologies will be used? (frontend framework, backend, database, infrastructure)
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/tech-stack.md`
**Allow Custom**: yes

**Common Web Stack Options**:

Frontend:

- React
- Vue.js
- Angular
- Svelte
- Next.js
- Nuxt.js
- SolidJS

Backend:

- Node.js/Express
- Python/FastAPI
- Python/Django
- Ruby on Rails
- PHP/Laravel
- Java/Spring Boot
- .NET Core

Database:

- PostgreSQL
- MySQL
- MongoDB
- Redis
- Supabase
- Firebase

Infrastructure:

- Docker
- Kubernetes
- AWS
- Azure
- GCP
- Vercel
- Netlify
- Heroku

### Q5: Target Platforms & Browsers

**Question**: What platforms and browsers must the web application support?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Desktop (Chrome, Firefox, Safari, Edge)
- Mobile Web (iOS Safari, Android Chrome)
- Tablet Web
- Progressive Web App (PWA)
- Responsive design (all screen sizes)
- Accessibility compliance (WCAG 2.1 AA)

### Q6: Authentication & Authorization

**Question**: What authentication and authorization mechanisms are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Email/Password authentication
- Social login (Google, Facebook, GitHub, etc.)
- Single Sign-On (SSO) / SAML
- OAuth 2.0 / OpenID Connect
- Multi-factor authentication (MFA)
- Role-based access control (RBAC)
- Fine-grained permissions
- API key authentication
- Session management
- Password reset functionality

## Features & Functionality

### Q7: Core Features

**Question**: What are the essential features that must be delivered in the initial release?
**Type**: list
**Required**: yes
**Suggestions**:

- User registration and profiles
- Dashboard/Admin panel
- Content management
- Search functionality
- File upload/management
- Notifications (email, in-app, push)
- Analytics and reporting
- Payment processing
- API integrations
- Real-time updates (WebSockets)
- Commenting/messaging
- Data export/import

### Q8: User Interface Requirements

**Question**: What are the key UI/UX requirements and design considerations?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Design system or UI framework (Material-UI, Ant Design, Tailwind, etc.)
- Accessibility standards (WCAG compliance level)
- Internationalization/localization needs
- Dark mode support
- Responsive design requirements
- Brand guidelines to follow
- User testing requirements

### Q9: Third-Party Integrations

**Question**: What third-party services or APIs need to be integrated?
**Type**: list
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/integrations.md`
**Allow Custom**: yes
**Common Integrations**:

- Payment gateways (Stripe, PayPal, Square)
- Email services (SendGrid, Mailgun, AWS SES)
- Analytics (Google Analytics, Mixpanel, Amplitude)
- Error tracking (Sentry, Rollbar, Bugsnag)
- Cloud storage (AWS S3, Cloudinary, uploadcare)
- Authentication providers (Auth0, Firebase Auth, Clerk)
- CRM systems (Salesforce, HubSpot)
- Communication (Twilio, Slack, Discord)

## Team & Resources

### Q10: Team Composition

**Question**: What roles and expertise are available on the team?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/personas.md`
**Allow Custom**: yes
**Create If Missing**: yes (persona)
**Common Roles**:

- Frontend Developer
- Backend Developer
- Full-stack Developer
- UI/UX Designer
- DevOps Engineer
- QA Engineer
- Product Manager
- Technical Lead
- Database Administrator

### Q11: Required Instructions

**Question**: What technical guidance and best practices will the team need?
**Type**: multi-select
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/instructions.md`
**Allow Custom**: yes
**Create If Missing**: yes (instruction)
**Common Instructions**:

- React best practices
- API design guidelines
- Security standards
- Testing strategy
- Code review process
- Deployment procedures
- Performance optimization
- Accessibility guidelines

## Performance & Scalability

### Q12: Performance Requirements

**Question**: What are the performance targets and expectations?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Page load time targets (e.g., < 3 seconds on 3G)
- Time to Interactive (TTI) requirements
- Core Web Vitals targets (LCP, FID, CLS)
- Concurrent user capacity
- API response time requirements
- Database query performance
- Asset optimization requirements

### Q13: Scalability Needs

**Question**: What are the expected scalability requirements?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Expected number of users (current and 12-month projection)
- Traffic patterns (steady, seasonal spikes, etc.)
- Data volume growth expectations
- Geographic distribution of users
- Horizontal vs vertical scaling approach
- Auto-scaling requirements
- Load balancing needs

## Security & Compliance

### Q14: Security Requirements

**Question**: What security measures and standards must be implemented?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- HTTPS/TLS encryption
- SQL injection prevention
- XSS protection
- CSRF protection
- Content Security Policy (CSP)
- Secure session management
- Input validation and sanitization
- Rate limiting and DDoS protection
- Security headers (HSTS, X-Frame-Options, etc.)
- Regular security audits
- Vulnerability scanning
- Penetration testing

### Q15: Compliance Requirements

**Question**: What regulatory or compliance standards must be met?
**Type**: multi-select
**Required**: no
**Suggestions**:

- GDPR (EU data protection)
- CCPA (California privacy)
- HIPAA (healthcare data)
- PCI DSS (payment card data)
- SOC 2 (security controls)
- WCAG 2.1 AA (accessibility)
- ISO 27001 (information security)
- COPPA (children's privacy)
- Data residency requirements

## Constraints & Timeline

### Q16: Timeline

**Question**: What is the target timeline and key milestones?
**Type**: textarea
**Required**: yes
**Format**:

```
MVP/Beta: [date]
Public Launch: [date]
Key Milestones:
- Milestone 1: [description] - [date]
- Milestone 2: [description] - [date]
```

### Q17: Budget

**Question**: What is the project budget or budget range?
**Type**: text
**Required**: no
**Note**: This helps scope features and technology choices appropriately.

### Q18: Technical Constraints

**Question**: Are there any technical, infrastructure, or platform constraints?
**Type**: textarea
**Required**: no
**Suggestions**:

- Must use existing company infrastructure
- Legacy system integration requirements
- Specific technology mandates or restrictions
- Browser version support requirements
- Network or bandwidth limitations
- Offline functionality requirements
- Existing authentication system to integrate with

### Q19: Business Constraints

**Question**: Are there any business, regulatory, or organizational constraints?
**Type**: textarea
**Required**: no
**Suggestions**:

- Regulatory approval processes
- Vendor or partner dependencies
- Budget limitations
- Resource availability constraints
- Marketing launch dependencies
- Existing contractual obligations
- Competitive timing considerations

## Data & Content

### Q20: Data Management

**Question**: What are the data storage, management, and migration requirements?
**Type**: textarea
**Required**: yes
**Suggestions**:

- Data models and entities
- Data migration from existing systems
- Backup and disaster recovery requirements
- Data retention policies
- Archive and purge requirements
- Data import/export capabilities
- Real-time vs batch processing needs

### Q21: Content Management

**Question**: What content management capabilities are needed?
**Type**: multi-select
**Required**: no
**Suggestions**:

- WYSIWYG content editor
- Media library management
- Version control for content
- Multi-language content support
- Content workflow and approvals
- SEO optimization tools
- Content scheduling/publishing
- Template management

## Success Metrics

### Q22: Key Performance Indicators

**Question**: How will success be measured? What are the key metrics?
**Type**: list
**Required**: yes
**Suggestions**:

- User acquisition rate
- User retention rate
- Conversion rate
- Average session duration
- Page views per session
- Bounce rate
- Revenue per user
- Customer satisfaction score (CSAT)
- Net Promoter Score (NPS)
- Time to complete key tasks
- Error rate
- System uptime/availability

### Q23: Success Criteria

**Question**: What specific outcomes would indicate the project is successful?
**Type**: textarea
**Required**: yes
**Examples**:

- "Achieve 10,000 active users within 6 months"
- "Reduce customer support tickets by 30%"
- "Process 1,000 transactions per day"
- "Achieve 99.9% uptime"
- "Load pages in under 2 seconds on 4G"
