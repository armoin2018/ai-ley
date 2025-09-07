---
agentMode: general
applyTo: general
author: AI-LEY
description: Build a complete detailed business plan based on the requirements found in files.requirements
extensions:
  - .md
guidelines: Follow AI-LEY project standards and best practices for comprehensive business plan development
instructionType: general
keywords:
  [business-plan, strategy, market-analysis, financial-planning, operations, competitive-analysis]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 3.0
title: Business Plan Generator
version: 1.0.0
---

# Copilot Command: Business Plan Generator

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Given:

- Project requirements and specifications from `{{files.requirements}}`
- Business objectives and strategic goals
- Market analysis and competitive landscape requirements
- Financial planning and operational needs

Produce:

- Complete detailed business plan document in `{{folders.plan}}/business/business-plan.md`
- Comprehensive business strategy and implementation roadmap
- Market analysis and competitive positioning
- Financial projections and funding requirements
- Operations plan and organizational structure
- Risk analysis and mitigation strategies

## Command

You are a business strategy consultant and comprehensive business plan specialist with expertise in creating detailed strategic business documents for startups and established companies.

### 1. **Requirements Analysis and Business Foundation**

**Project Requirements Loading**:

```markdown
**Step 1.1: Requirements and Strategic Context Analysis**

**Load Project Foundation**:

- Read and analyze `{{files.requirements}}` for project specifications
- Extract key business objectives and strategic goals
- Identify target market segments and customer profiles
- Understand competitive landscape and market positioning
- Determine operational requirements and resource needs

**Business Context Research**:

- Analyze industry trends and market dynamics
- Research regulatory environment and compliance requirements
- Identify key stakeholders and partnership opportunities
- Understand technology requirements and capabilities
- Assess scalability potential and growth strategies

**Strategic Framework Development**:

- Define mission, vision, and core values
- Establish strategic objectives and success metrics
- Identify key value propositions and competitive advantages
- Plan business model and revenue strategies
- Create implementation timeline and milestones
```

### 2. **Executive Summary Development**

**Strategic Overview Creation**:

````markdown
**Step 2.1: Executive Summary Structure**

**Business Overview**:

- Company description and legal structure
- Mission statement and vision
- Products/services overview
- Target market and customer base
- Unique value proposition and competitive advantages
- Key success factors and strategic differentiators

**Market Opportunity**:

- Market size and growth potential
- Target customer segments and demographics
- Market trends and drivers
- Competitive landscape overview
- Market entry strategy and timing

**Financial Highlights**:

- Revenue projections and growth trajectory
- Profitability timeline and key metrics
- Funding requirements and capital structure
- Financial returns and exit strategy
- Key financial assumptions and risks

**Executive Summary Content Structure**:

```markdown
# Executive Summary

## Company Overview

**Company Name**: {company-name}
**Industry**: {industry-sector}
**Legal Structure**: {corporation/LLC/partnership}
**Location**: {headquarters-location}
**Founded**: {founding-date}

## Mission & Vision

**Mission**: {mission-statement}
**Vision**: {vision-statement}
**Core Values**: {core-values-list}

## Business Concept

{2-3 paragraph description of business concept, value proposition, and market opportunity}

## Products & Services

- **Primary Offering**: {primary-product-service}
- **Secondary Offerings**: {additional-products-services}
- **Key Features**: {differentiating-features}
- **Target Market**: {primary-customer-segments}

## Market Opportunity

- **Market Size**: ${tam-amount} Total Addressable Market
- **Growth Rate**: {market-growth-rate}% annually
- **Target Segments**: {key-customer-segments}
- **Market Trends**: {favorable-market-trends}

## Competitive Advantage

1. {competitive-advantage-1}
2. {competitive-advantage-2}
3. {competitive-advantage-3}

## Financial Summary

| Metric           | Year 1      | Year 2    | Year 3    | Year 5    |
| ---------------- | ----------- | --------- | --------- | --------- |
| **Revenue**      | ${amount}   | ${amount} | ${amount} | ${amount} |
| **Gross Profit** | ${amount}   | ${amount} | ${amount} | ${amount} |
| **Net Income**   | (${amount}) | ${amount} | ${amount} | ${amount} |

## Funding Requirements

- **Total Funding Needed**: ${amount}
- **Funding Stage**: {seed/series-a/growth}
- **Use of Funds**: {primary-use-categories}
- **Timeline**: {funding-timeline}

## Key Success Factors

- {success-factor-1}
- {success-factor-2}
- {success-factor-3}
```
````

````

### 3. **Company Description and History**

**Organizational Foundation**:
```markdown
**Step 3.1: Company Background and Structure**

**Company Formation and Legal Structure**:
```markdown
# Company Description

## Company History & Background
**Founding Story**: {how-and-why-company-was-founded}

**Key Milestones**:
| Date | Milestone | Impact |
|------|-----------|--------|
| {date} | {milestone-1} | {business-impact} |
| {date} | {milestone-2} | {business-impact} |
| {date} | {milestone-3} | {business-impact} |

## Legal Structure & Ownership
- **Legal Entity**: {corporation-type}
- **State of Incorporation**: {state}
- **Federal Tax ID**: {tax-id-status}
- **Ownership Structure**: {ownership-breakdown}
- **Board of Directors**: {board-composition}

## Location & Facilities
- **Headquarters**: {address-and-description}
- **Additional Locations**: {other-facilities}
- **Facility Requirements**: {space-and-infrastructure-needs}
- **Future Expansion Plans**: {facility-growth-strategy}

## Products & Services Portfolio
### Primary Products/Services
**Product/Service 1**: {name}
- **Description**: {detailed-description}
- **Target Market**: {specific-customer-segments}
- **Key Features**: {differentiating-features}
- **Revenue Model**: {how-monetized}
- **Development Status**: {current-status}

**Product/Service 2**: {name}
- **Description**: {detailed-description}
- **Target Market**: {specific-customer-segments}
- **Key Features**: {differentiating-features}
- **Revenue Model**: {how-monetized}
- **Development Status**: {current-status}

### Product Development Pipeline
- **Next 6 Months**: {planned-developments}
- **Next 12 Months**: {medium-term-roadmap}
- **Long-term Vision**: {future-product-strategy}
````

````

### 4. **Market Analysis and Industry Overview**

**Comprehensive Market Research**:
```markdown
**Step 4.1: Industry Analysis and Market Dynamics**

**Industry Overview and Market Size**:
```markdown
# Market Analysis

## Industry Overview
**Industry Definition**: {industry-sector-definition}
**Industry Classification**: {NAICS-or-SIC-codes}
**Industry Life Cycle Stage**: {emerging/growth/mature/declining}

## Market Size & Growth
### Total Addressable Market (TAM)
- **Global Market Size**: ${global-market-size}
- **Regional Market Size**: ${regional-market-size}
- **Growth Rate**: {cagr}% CAGR (20XX-20XX)
- **Market Drivers**: {key-growth-drivers}

### Serviceable Addressable Market (SAM)
- **Serviceable Market**: ${serviceable-market-size}
- **Geographic Scope**: {target-geographic-markets}
- **Segment Focus**: {target-market-segments}
- **Penetration Strategy**: {market-entry-approach}

### Serviceable Obtainable Market (SOM)
- **Obtainable Market**: ${obtainable-market-size}
- **Market Share Goal**: {target-market-share}%
- **Timeline**: {timeline-to-achieve-share}
- **Justification**: {rationale-for-market-share}

## Industry Trends & Drivers
### Key Industry Trends
1. **Trend 1**: {trend-description}
   - **Impact**: {impact-on-industry}
   - **Timeline**: {trend-timeline}
   - **Opportunity**: {opportunity-for-business}

2. **Trend 2**: {trend-description}
   - **Impact**: {impact-on-industry}
   - **Timeline**: {trend-timeline}
   - **Opportunity**: {opportunity-for-business}

3. **Trend 3**: {trend-description}
   - **Impact**: {impact-on-industry}
   - **Timeline**: {trend-timeline}
   - **Opportunity**: {opportunity-for-business}

### Market Drivers
- **Technology Advancement**: {tech-drivers}
- **Regulatory Changes**: {regulatory-drivers}
- **Economic Factors**: {economic-drivers}
- **Social/Cultural Shifts**: {social-drivers}
- **Environmental Factors**: {environmental-drivers}

## Target Market Segmentation
### Primary Target Segment
**Segment Name**: {segment-name}
- **Demographics**: {demographic-profile}
- **Psychographics**: {lifestyle-and-values}
- **Geographic**: {geographic-distribution}
- **Behavioral**: {purchasing-behavior}
- **Size**: {segment-size-and-value}
- **Growth Rate**: {segment-growth-rate}

### Secondary Target Segments
**Segment 2**: {segment-description}
**Segment 3**: {segment-description}

## Customer Analysis
### Customer Persona 1: "{Persona-Name}"
- **Demographics**: {age, income, education, occupation}
- **Pain Points**: {current-problems-and-frustrations}
- **Buying Behavior**: {how-they-make-purchasing-decisions}
- **Preferred Channels**: {where-they-shop-and-research}
- **Price Sensitivity**: {willingness-to-pay}
- **Decision Criteria**: {factors-influencing-purchase}

### Customer Journey Mapping
| Stage | Customer Actions | Pain Points | Our Touchpoints | Opportunities |
|-------|-----------------|-------------|----------------|---------------|
| Awareness | {actions} | {pain-points} | {touchpoints} | {opportunities} |
| Consideration | {actions} | {pain-points} | {touchpoints} | {opportunities} |
| Purchase | {actions} | {pain-points} | {touchpoints} | {opportunities} |
| Usage | {actions} | {pain-points} | {touchpoints} | {opportunities} |
| Loyalty | {actions} | {pain-points} | {touchpoints} | {opportunities} |
```
```

### 5. **Competitive Analysis**

**Competitor Research and Positioning**:
```markdown
**Step 5.1: Competitive Landscape Analysis**

**Direct and Indirect Competitor Mapping**:
```markdown
# Competitive Analysis

## Competitive Landscape Overview
**Market Structure**: {oligopoly/fragmented/monopolistic}
**Competitive Intensity**: {high/medium/low}
**Barriers to Entry**: {high/medium/low}
**Threat of Substitutes**: {high/medium/low}

## Direct Competitors
### Competitor 1: {Company Name}
- **Market Position**: {market-leader/challenger/follower/niche}
- **Market Share**: {percentage}%
- **Revenue**: ${annual-revenue}
- **Founded**: {year}
- **Employees**: {employee-count}
- **Headquarters**: {location}

**Strengths**:
- {strength-1}
- {strength-2}
- {strength-3}

**Weaknesses**:
- {weakness-1}
- {weakness-2}
- {weakness-3}

**Strategy**: {their-go-to-market-strategy}
**Target Market**: {their-customer-segments}
**Pricing**: {their-pricing-strategy}

### Competitive Positioning Map
| Factor | Our Company | Competitor 1 | Competitor 2 | Competitor 3 |
|--------|-------------|-------------|-------------|-------------|
| Price | {position} | {position} | {position} | {position} |
| Quality | {position} | {position} | {position} | {position} |
| Features | {position} | {position} | {position} | {position} |
| Service | {position} | {position} | {position} | {position} |

## Our Competitive Advantages
1. **Advantage 1**: {competitive-advantage}
   - **Sustainability**: {how-sustainable}
   - **Time to Replicate**: {competitor-replication-time}
   - **Barrier Strength**: {barrier-strength}

2. **Advantage 2**: {competitive-advantage}
   - **Sustainability**: {how-sustainable}
   - **Time to Replicate**: {competitor-replication-time}
   - **Barrier Strength**: {barrier-strength}

## Competitive Response Strategy
- **Monitoring**: {how-we-track-competitors}
- **Response Framework**: {how-we-respond-to-threats}
- **Differentiation**: {how-we-stay-different}
- **Innovation**: {our-innovation-strategy}
```
```

### 6. **Marketing and Sales Strategy**

**Go-to-Market Strategy and Customer Acquisition**:
```markdown
**Step 6.1: Marketing Strategy and Brand Positioning**

**Brand Strategy and Market Positioning**:
```markdown
# Marketing & Sales Strategy

## Brand Positioning
**Brand Promise**: {what-we-promise-customers}
**Brand Personality**: {brand-characteristics}
**Value Proposition**: {core-value-delivered}
**Positioning Statement**: {how-we-position-vs-competition}

## Marketing Strategy
### Target Market Strategy
- **Primary Target**: {primary-customer-segment}
- **Secondary Target**: {secondary-customer-segment}
- **Market Entry**: {how-we-enter-market}
- **Market Development**: {how-we-grow-market-share}

### Marketing Mix (4Ps)
#### Product Strategy
- **Core Product**: {main-product-offering}
- **Product Differentiation**: {how-we-differentiate}
- **Product Development**: {future-product-plans}
- **Product Lifecycle**: {where-products-are-in-lifecycle}

#### Pricing Strategy
- **Pricing Model**: {cost-plus/value-based/competitive/penetration}
- **Price Points**: {actual-pricing-tiers}
- **Pricing Rationale**: {why-these-prices}
- **Price Sensitivity**: {customer-price-sensitivity}

#### Promotion Strategy
- **Marketing Channels**: {advertising/pr/digital/events}
- **Marketing Budget**: ${annual-marketing-budget}
- **Message Strategy**: {key-marketing-messages}
- **Content Strategy**: {content-marketing-approach}

#### Place/Distribution Strategy
- **Sales Channels**: {direct/indirect/online/retail}
- **Distribution Partners**: {key-distribution-partners}
- **Geographic Strategy**: {market-rollout-strategy}
- **Channel Conflicts**: {how-managed}

## Sales Strategy
### Sales Model
- **Sales Approach**: {B2B/B2C/B2B2C}
- **Sales Process**: {steps-in-sales-process}
- **Sales Cycle**: {average-length}
- **Sales Team Structure**: {inside/outside/channel}

### Customer Acquisition
**Customer Acquisition Strategy**:
| Channel | Cost per Acquisition | Conversion Rate | Customer Lifetime Value |
|---------|-------------------|----------------|----------------------|
| Digital Marketing | ${cac} | {rate}% | ${clv} |
| Sales Team | ${cac} | {rate}% | ${clv} |
| Referrals | ${cac} | {rate}% | ${clv} |
| Partnerships | ${cac} | {rate}% | ${clv} |

### Sales Projections
| Year | Sales Team Size | Average Deal Size | Deals per Rep | Annual Sales |
|------|----------------|------------------|---------------|--------------|
| 1 | {count} | ${amount} | {count} | ${amount} |
| 2 | {count} | ${amount} | {count} | ${amount} |
| 3 | {count} | ${amount} | {count} | ${amount} |
```
```

### 7. **Operations Plan**

**Operational Structure and Processes**:
```markdown
**Step 7.1: Operations and Supply Chain Management**

**Production and Service Delivery**:
```markdown
# Operations Plan

## Operational Model
**Business Model**: {how-we-create-and-deliver-value}
**Operational Philosophy**: {operational-approach}
**Key Success Factors**: {critical-operational-elements}

## Production/Service Delivery
### Production Process
- **Production Method**: {how-products-are-made}
- **Capacity**: {current-and-planned-capacity}
- **Quality Control**: {quality-assurance-processes}
- **Scalability**: {how-operations-scale}

### Supply Chain Management
- **Key Suppliers**: {critical-suppliers}
- **Supply Chain Risk**: {supply-chain-vulnerabilities}
- **Inventory Management**: {inventory-approach}
- **Logistics**: {distribution-and-fulfillment}

## Technology Infrastructure
- **Core Systems**: {key-technology-systems}
- **IT Infrastructure**: {technology-architecture}
- **Cybersecurity**: {security-measures}
- **Technology Roadmap**: {planned-tech-investments}

## Quality Management
- **Quality Standards**: {quality-standards-followed}
- **Quality Metrics**: {how-quality-measured}
- **Continuous Improvement**: {improvement-processes}
- **Customer Satisfaction**: {satisfaction-measurement}

## Regulatory Compliance
- **Key Regulations**: {applicable-regulations}
- **Compliance Procedures**: {how-compliance-ensured}
- **Regulatory Risks**: {compliance-risks}
- **Compliance Costs**: {cost-of-compliance}
```
```

### 8. **Financial Projections and Analysis**

**Comprehensive Financial Planning**:
```markdown
**Step 8.1: Financial Model and Projections**

**Revenue and Expense Modeling**:
```markdown
# Financial Plan

## Financial Projections Summary
### 5-Year Revenue Projections
| Year | Revenue | Growth Rate | Gross Profit | Gross Margin |
|------|---------|-------------|-------------|-------------|
| 1 | ${amount} | - | ${amount} | {percentage}% |
| 2 | ${amount} | {percentage}% | ${amount} | {percentage}% |
| 3 | ${amount} | {percentage}% | ${amount} | {percentage}% |
| 4 | ${amount} | {percentage}% | ${amount} | {percentage}% |
| 5 | ${amount} | {percentage}% | ${amount} | {percentage}% |

## Revenue Model
### Revenue Streams
1. **Primary Revenue Stream**: {revenue-source-1}
   - **Description**: {how-revenue-generated}
   - **Pricing Model**: {pricing-approach}
   - **Year 3 Revenue**: ${amount}
   - **Percentage of Total**: {percentage}%

2. **Secondary Revenue Stream**: {revenue-source-2}
   - **Description**: {how-revenue-generated}
   - **Pricing Model**: {pricing-approach}
   - **Year 3 Revenue**: ${amount}
   - **Percentage of Total**: {percentage}%

### Unit Economics
- **Customer Acquisition Cost (CAC)**: ${amount}
- **Customer Lifetime Value (CLV)**: ${amount}
- **CLV:CAC Ratio**: {ratio}:1
- **Payback Period**: {months} months
- **Monthly Churn Rate**: {percentage}%

## Expense Structure
### Operating Expenses (Year 3)
| Category | Annual Amount | % of Revenue | Notes |
|----------|---------------|-------------|-------|
| Cost of Goods Sold | ${amount} | {percentage}% | {description} |
| Sales & Marketing | ${amount} | {percentage}% | {description} |
| Research & Development | ${amount} | {percentage}% | {description} |
| General & Administrative | ${amount} | {percentage}% | {description} |
| **Total OpEx** | **${amount}** | **{percentage}%** | |

## Profitability Analysis
### Break-even Analysis
- **Break-even Revenue**: ${monthly-amount} per month
- **Break-even Timeline**: Month {month} of Year {year}
- **Break-even Unit Sales**: {units} per month
- **Margin of Safety**: {percentage}% above break-even

### Profitability Metrics
| Metric | Year 1 | Year 2 | Year 3 | Year 5 |
|--------|---------|---------|---------|---------|
| **EBITDA** | (${amount}) | ${amount} | ${amount} | ${amount} |
| **EBITDA Margin** | ({percentage})% | {percentage}% | {percentage}% | {percentage}% |
| **Net Income** | (${amount}) | ${amount} | ${amount} | ${amount} |
| **Net Margin** | ({percentage})% | {percentage}% | {percentage}% | {percentage}% |

## Cash Flow Analysis
### Cash Flow Projections
| Year | Operating CF | Investing CF | Financing CF | Net CF | Cash Balance |
|------|-------------|-------------|-------------|--------|-------------|
| 1 | (${amount}) | (${amount}) | ${amount} | ${amount} | ${amount} |
| 2 | ${amount} | (${amount}) | ${amount} | ${amount} | ${amount} |
| 3 | ${amount} | (${amount}) | ${amount} | ${amount} | ${amount} |

### Working Capital Requirements
- **Accounts Receivable**: {days} days sales outstanding
- **Inventory**: {days} days inventory on hand
- **Accounts Payable**: {days} days payable outstanding
- **Cash Conversion Cycle**: {days} days

## Funding Requirements
### Capital Requirements
- **Startup Capital**: ${amount}
- **Working Capital**: ${amount}
- **Growth Capital**: ${amount}
- **Total Funding Needed**: ${amount}

### Funding Timeline
| Stage | Amount | Timeline | Use of Funds | Milestones |
|-------|--------|----------|-------------|------------|
| Seed | ${amount} | {timeline} | {use} | {milestones} |
| Series A | ${amount} | {timeline} | {use} | {milestones} |
| Series B | ${amount} | {timeline} | {use} | {milestones} |
```
```

### 9. **Examples and Quality Assurance**

**Implementation Examples**:
```markdown

## Examples

### Example 1: SaaS Business Plan

**Input**:
```
business-plan
```

**Expected Output**:
```markdown
📊 Building comprehensive SaaS business plan...

📋 Requirements Analysis:
✅ Product: Cloud-based project management software
✅ Target: SMB market (50-500 employees)
✅ Revenue Model: Subscription-based SaaS

📈 Market Analysis Complete:
- TAM: $45B project management software market
- SAM: $12B SMB segment
- SOM: $500M addressable market
- Growth Rate: 15% CAGR

💰 Financial Projections:
- Year 1 Revenue: $500K
- Year 3 Revenue: $10M
- Break-even: Month 18
- Funding Required: $3M Series A

👥 Business Strategy:
- Go-to-market: Inbound marketing + inside sales
- Competitive advantage: AI-powered insights
- Customer acquisition: $1,200 CAC, $15K LTV

📄 Complete business plan saved to: {{folders.plan}}/business/business-plan.md
📊 Document includes: Executive summary, market analysis, competitive analysis,
    financial projections, operations plan, and implementation roadmap
🎯 Ready for investor presentations and strategic planning
```

### Example 2: E-commerce Business Plan

**Input**:
```
business-plan
```

**Expected Output**:
```markdown
🛒 Building e-commerce business plan...

📋 Business Model Analysis:
- Product: Direct-to-consumer health supplements
- Market: Health-conscious millennials
- Channels: Online direct sales + Amazon marketplace

📊 Key Business Metrics:
- Average Order Value: $85
- Customer Acquisition Cost: $45
- Lifetime Value: $380
- Gross Margin: 65%

🎯 Growth Strategy:
- Year 1: Launch core product line (5 SKUs)
- Year 2: Expand to 20 SKUs + subscription model
- Year 3: International expansion (Canada, UK)

💼 Complete 47-page business plan generated with:
- Detailed market research and customer personas
- Competitive analysis of 12 key competitors
- 5-year financial model with scenario planning
- Operations plan including fulfillment strategy
- Marketing plan with customer acquisition funnels

✅ Business plan ready for funding discussions and strategic execution
```

## Notes

- **Requirements integration** ensures business plan aligns with project specifications
- **Comprehensive structure** covers all essential business plan elements
- **Financial modeling** includes realistic projections with detailed assumptions
- **Market analysis** provides thorough industry and competitive research
- **Implementation focus** demonstrates execution capability and strategic planning
- **Professional formatting** creates investor and stakeholder-ready documentation
- **Risk assessment** addresses key business risks and mitigation strategies
- **Scalability planning** shows growth potential and expansion strategies
```
````

```

```
