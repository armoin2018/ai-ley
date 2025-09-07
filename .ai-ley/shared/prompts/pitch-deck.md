---
agentMode: general
applyTo: general
author: AI-LEY
description: Build a complete pitch deck based on the requirements found in files.requirements with structured slides covering problem, solution, business model, financials, team, and implementation
extensions:
  - .md
guidelines: Follow AI-LEY project standards and best practices for business pitch deck creation
instructionType: general
keywords: [pitch-deck, business, presentation, slides, funding, startup, investment]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 3.0
title: Pitch Deck Generator
version: 1.0.0
---

# Copilot Command: Pitch Deck Generator

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Given:

- Project requirements and specifications from `{{files.requirements}}`
- Business context and market analysis requirements
- Investment and funding presentation needs
- Professional pitch deck structure and content standards

Produce:

- Complete pitch deck document in `{{folders.plan}}/business/pitch-deck.md`
- Problem and Market Opportunity (slides 1-3)
- Solution and Product Demo (slides 4-6)
- Business Model and Go-to-Market (slides 7-9)
- Financial Projections and Funding (slides 10-12)
- Team and Implementation Plan (slides 13-15)
- Appendix with Supporting Data
- Professional formatting and investor-ready content

## Command

You are a business strategy consultant and pitch deck specialist with expertise in creating compelling investor presentations and startup funding materials.

### 1. **Requirements Analysis and Business Context**

**Project Requirements Loading**:

```markdown
**Step 1.1: Requirements and Context Analysis**

**Load Project Foundation**:

- Read and analyze `{{files.requirements}}` for project specifications
- Extract key business objectives and value propositions
- Identify target market and customer segments
- Understand technical capabilities and competitive advantages
- Determine funding needs and growth objectives

**Business Context Research**:

- Analyze market opportunity and size estimation
- Research competitive landscape and positioning
- Identify key business risks and mitigation strategies
- Understand regulatory environment and compliance requirements
- Assess scalability potential and market timing

**Stakeholder Analysis**:

- Define target investor profiles and investment criteria
- Understand audience expectations and decision factors
- Identify key value drivers and investment highlights
- Determine appropriate funding stage and amount
- Plan presentation style and communication approach
```

### 2. **Problem and Market Opportunity Development (Slides 1-3)**

**Market Analysis and Problem Definition**:

````markdown
**Step 2.1: Slide 1 - Problem Statement**

**Problem Identification and Validation**:

- Define the core problem or pain point being addressed
- Quantify the problem size and impact on target customers
- Provide specific examples and use cases demonstrating the problem
- Include market research data and customer validation
- Position the problem as urgent and growing

**Slide 1 Content Structure**:

```markdown
# Slide 1: The Problem

## Core Problem Statement

{Clear, compelling one-sentence problem description}

## Problem Details

- **Scale**: {quantified impact - users affected, market size, etc.}
- **Pain Points**: {specific customer pain points and frustrations}
- **Current Solutions**: {inadequate existing solutions and their limitations}
- **Evidence**: {market research, surveys, customer interviews}

## Why Now?

- {market trends making this problem more urgent}
- {technological/regulatory changes creating opportunity}
- {customer behavior shifts increasing problem importance}

> "Quote from target customer describing the problem impact"
```
````

**Step 2.2: Slide 2 - Market Size and Opportunity**

**Market Opportunity Quantification**:

- Calculate Total Addressable Market (TAM), Serviceable Addressable Market (SAM), and Serviceable Obtainable Market (SOM)
- Research market growth rates and trends
- Identify market drivers and accelerators
- Analyze customer segments and buying behavior
- Project market evolution and timing

**Slide 2 Content Structure**:

```markdown
# Slide 2: Market Opportunity

## Market Size Analysis

- **TAM (Total Addressable Market)**: ${amount} - {description of total market}
- **SAM (Serviceable Addressable Market)**: ${amount} - {realistic addressable portion}
- **SOM (Serviceable Obtainable Market)**: ${amount} - {achievable market share}

## Market Growth

- **Growth Rate**: {percentage}% CAGR over {timeframe}
- **Market Drivers**: {key factors driving growth}
- **Timing**: {why now is the right time to enter this market}

## Customer Segments

| Segment     | Size   | Growth    | Pain Level     | Willingness to Pay |
| ----------- | ------ | --------- | -------------- | ------------------ |
| {segment-1} | {size} | {growth}% | {high/med/low} | ${amount}          |
| {segment-2} | {size} | {growth}% | {high/med/low} | ${amount}          |

## Market Validation

- {customer research findings}
- {pilot program results}
- {partnership interest indicators}
```

**Step 2.3: Slide 3 - Target Customer and Use Cases**

**Customer Profile Development**:

- Create detailed customer personas and profiles
- Define customer journey and decision-making process
- Identify key stakeholders and influencers
- Analyze customer acquisition costs and lifetime value
- Document specific use cases and scenarios

**Slide 3 Content Structure**:

```markdown
# Slide 3: Target Customer & Use Cases

## Primary Customer Profile

- **Industry**: {target industry or sector}
- **Company Size**: {employee count, revenue range}
- **Role/Title**: {decision maker titles and responsibilities}
- **Demographics**: {relevant demographic information}
- **Current Behavior**: {how they currently solve the problem}

## Customer Persona: "{Persona Name}"

- **Background**: {professional background and experience}
- **Goals**: {primary objectives and success metrics}
- **Challenges**: {current obstacles and frustrations}
- **Decision Criteria**: {factors influencing purchase decisions}
- **Budget Authority**: {spending power and approval process}

## Key Use Cases

1. **Use Case 1**: {scenario name}

   - **Context**: {when and why this occurs}
   - **Current Process**: {existing workflow or solution}
   - **Pain Points**: {specific problems in current approach}
   - **Value**: {benefit of solving this use case}

2. **Use Case 2**: {scenario name}
   - **Context**: {when and why this occurs}
   - **Current Process**: {existing workflow or solution}
   - **Pain Points**: {specific problems in current approach}
   - **Value**: {benefit of solving this use case}

## Customer Validation

- **Interviews Conducted**: {number} with {description of participants}
- **Key Findings**: {top insights from customer research}
- **Validation Metrics**: {specific data supporting customer need}
```

````

### 3. **Solution and Product Demo Development (Slides 4-6)**

**Solution Architecture and Demonstration**:
```markdown
**Step 3.1: Slide 4 - Solution Overview**

**Solution Design and Positioning**:
- Define core solution approach and methodology
- Explain unique value proposition and differentiation
- Outline key features and capabilities
- Position solution against alternatives
- Demonstrate solution-problem fit

**Slide 4 Content Structure**:
```markdown
# Slide 4: Our Solution

## Solution Statement
{One-sentence description of how you solve the problem}

## Core Approach
- **Methodology**: {fundamental approach to solving the problem}
- **Key Innovation**: {what makes your solution unique}
- **Technology Stack**: {relevant technical foundation}
- **Delivery Model**: {how solution is provided to customers}

## Value Proposition
| Customer Need | Our Solution | Benefit |
|---------------|--------------|---------|
| {need-1} | {feature-1} | {specific benefit} |
| {need-2} | {feature-2} | {specific benefit} |
| {need-3} | {feature-3} | {specific benefit} |

## Differentiation
- **vs. Status Quo**: {how we improve on current solutions}
- **vs. Competitors**: {key advantages over existing alternatives}
- **Unique Assets**: {proprietary technology, data, partnerships}

## Solution Validation
- **Proof Points**: {evidence that solution works}
- **Early Results**: {metrics from pilots or beta testing}
- **Customer Feedback**: {testimonials or validation quotes}
````

**Step 3.2: Slide 5 - Product Demo and Features**

**Product Demonstration Strategy**:

- Showcase key product features and functionality
- Demonstrate user experience and interface
- Highlight technical capabilities and performance
- Show integration possibilities and scalability
- Provide concrete examples of value delivery

**Slide 5 Content Structure**:

```markdown
# Slide 5: Product Demo & Key Features

## Product Overview

{Brief description of product architecture and design}

## Core Features

### Feature 1: {Feature Name}

- **Description**: {what this feature does}
- **User Benefit**: {how it helps the customer}
- **Demo**: {brief walkthrough or example}
- **Metrics**: {performance/usage statistics}

### Feature 2: {Feature Name}

- **Description**: {what this feature does}
- **User Benefit**: {how it helps the customer}
- **Demo**: {brief walkthrough or example}
- **Metrics**: {performance/usage statistics}

### Feature 3: {Feature Name}

- **Description**: {what this feature does}
- **User Benefit**: {how it helps the customer}
- **Demo**: {brief walkthrough or example}
- **Metrics**: {performance/usage statistics}

## User Experience

- **Interface**: {description of user interface approach}
- **Workflow**: {typical user workflow or journey}
- **Integration**: {how it fits into existing customer systems}
- **Mobile/Desktop**: {platform availability and optimization}

## Technical Highlights

- **Performance**: {speed, reliability, scalability metrics}
- **Security**: {data protection and compliance features}
- **Integrations**: {key third-party integrations available}
- **APIs**: {developer tools and customization options}

## Demo Results

> "{Customer quote about product experience}"

- **Time Savings**: {quantified efficiency improvements}
- **Cost Reduction**: {quantified cost benefits}
- **Quality Improvement**: {quantified quality metrics}
```

**Step 3.3: Slide 6 - Technology and IP**

**Technology Foundation and Intellectual Property**:

- Detail technical architecture and infrastructure
- Highlight proprietary technology and algorithms
- Explain scalability and performance capabilities
- Document intellectual property and competitive moats
- Address security and compliance considerations

**Slide 6 Content Structure**:

```markdown
# Slide 6: Technology & Intellectual Property

## Technology Architecture

- **Core Platform**: {description of underlying technology}
- **Scalability**: {how system scales with growth}
- **Performance**: {key performance metrics and benchmarks}
- **Reliability**: {uptime, redundancy, disaster recovery}

## Proprietary Technology

- **Algorithms**: {unique algorithms or methodologies}
- **Data Assets**: {proprietary data sets or insights}
- **Integration Layer**: {unique integration capabilities}
- **AI/ML**: {artificial intelligence or machine learning components}

## Intellectual Property

| Type          | Description             | Status                  | Competitive Advantage     |
| ------------- | ----------------------- | ----------------------- | ------------------------- |
| Patent        | {patent description}    | {filed/pending/granted} | {advantage provided}      |
| Trademark     | {trademark details}     | {registered/pending}    | {brand protection}        |
| Copyright     | {software/content}      | {protected}             | {content differentiation} |
| Trade Secrets | {proprietary processes} | {confidential}          | {operational advantage}   |

## Technical Moats

- **Network Effects**: {how product gets better with more users}
- **Data Moats**: {unique data that improves over time}
- **Technical Complexity**: {barriers to replication}
- **Integration Depth**: {switching costs for customers}

## Security & Compliance

- **Security Standards**: {certifications and security measures}
- **Compliance**: {regulatory compliance achievements}
- **Data Privacy**: {privacy protection and GDPR compliance}
- **Auditing**: {third-party security audits and certifications}

## Development Roadmap

- **Current Capabilities**: {existing technical features}
- **Next 6 Months**: {planned technical enhancements}
- **Next 12 Months**: {major technical milestones}
- **Long-term Vision**: {future technical capabilities}
```

````

### 4. **Business Model and Go-to-Market Strategy (Slides 7-9)**

**Revenue Model and Market Entry Strategy**:
```markdown
**Step 4.1: Slide 7 - Business Model**

**Revenue Model Design**:
- Define primary revenue streams and pricing strategy
- Explain customer acquisition and retention approach
- Detail unit economics and profitability model
- Analyze pricing sensitivity and optimization
- Project revenue scalability and growth potential

**Slide 7 Content Structure**:
```markdown
# Slide 7: Business Model

## Revenue Streams
### Primary Revenue: {Revenue Type}
- **Model**: {subscription/transaction/license/etc.}
- **Pricing**: {pricing structure and tiers}
- **Target Price Point**: ${amount} per {unit/month/year}
- **Revenue Potential**: {projected revenue per customer}

### Secondary Revenue: {Revenue Type}
- **Model**: {additional revenue opportunities}
- **Pricing**: {pricing approach for secondary streams}
- **Timing**: {when these streams activate}
- **Contribution**: {percentage of total revenue}

## Unit Economics
| Metric | Amount | Notes |
|--------|--------|-------|
| Customer Acquisition Cost (CAC) | ${amount} | {acquisition strategy cost} |
| Customer Lifetime Value (CLV) | ${amount} | {retention and expansion value} |
| CLV:CAC Ratio | {ratio}:1 | {target ratio 3:1 or higher} |
| Gross Margin | {percentage}% | {after direct costs} |
| Time to Payback | {months} | {months to recover CAC} |

## Pricing Strategy
- **Value-Based Pricing**: {how pricing reflects customer value}
- **Competitive Positioning**: {pricing vs. alternatives}
- **Price Elasticity**: {customer sensitivity to pricing}
- **Tier Strategy**: {multiple pricing tiers and benefits}

## Customer Success & Retention
- **Onboarding**: {customer success process}
- **Support**: {ongoing customer support approach}
- **Expansion**: {upselling and cross-selling opportunities}
- **Retention Rate**: {projected customer retention}

## Scalability
- **Marginal Costs**: {cost structure as scale increases}
- **Operational Leverage**: {fixed costs spread over larger base}
- **Technology Scaling**: {technical scalability approach}
- **Team Scaling**: {human resource scaling plan}
````

**Step 4.2: Slide 8 - Go-to-Market Strategy**

**Market Entry and Customer Acquisition**:

- Define target customer segments and prioritization
- Plan marketing and sales strategies
- Design partnership and channel strategies
- Create customer acquisition funnel and metrics
- Establish brand positioning and messaging

**Slide 8 Content Structure**:

```markdown
# Slide 8: Go-to-Market Strategy

## Target Market Prioritization

### Phase 1: {Primary Segment} (Months 1-6)

- **Customer Profile**: {detailed customer description}
- **Market Size**: {addressable customers in this segment}
- **Entry Strategy**: {how to reach and acquire these customers}
- **Success Metrics**: {KPIs for this segment}

### Phase 2: {Secondary Segment} (Months 7-12)

- **Customer Profile**: {detailed customer description}
- **Market Size**: {addressable customers in this segment}
- **Entry Strategy**: {how to reach and acquire these customers}
- **Success Metrics**: {KPIs for this segment}

## Sales & Marketing Strategy

### Sales Approach

- **Sales Model**: {direct/inside/channel/self-service}
- **Sales Cycle**: {typical length and stages}
- **Sales Team**: {team structure and hiring plan}
- **Sales Tools**: {CRM and sales enablement tools}

### Marketing Strategy

- **Positioning**: {core brand and product positioning}
- **Messaging**: {key value propositions and messages}
- **Channels**: {primary marketing channels and tactics}
- **Content**: {content marketing and thought leadership}
- **Events**: {industry events and conference participation}

## Customer Acquisition Funnel

| Stage         | Conversion Rate | Volume          | Cost    | Notes                |
| ------------- | --------------- | --------------- | ------- | -------------------- |
| Awareness     | {rate}%         | {leads}         | ${cost} | {marketing channels} |
| Interest      | {rate}%         | {qualified}     | ${cost} | {nurturing process}  |
| Consideration | {rate}%         | {opportunities} | ${cost} | {sales process}      |
| Purchase      | {rate}%         | {customers}     | ${cost} | {closing process}    |

## Partnership Strategy

- **Technology Partners**: {integration and technology partnerships}
- **Channel Partners**: {reseller and distribution partnerships}
- **Strategic Partners**: {industry and market access partnerships}
- **Implementation Partners**: {service and consulting partnerships}

## Launch Plan

### Pre-Launch (Months -3 to 0)

- {key preparation activities}
- {beta testing and customer validation}
- {team building and system setup}

### Launch (Months 1-3)

- {launch activities and milestones}
- {initial customer acquisition targets}
- {marketing campaign execution}

### Scale (Months 4-12)

- {scaling activities and growth targets}
- {channel expansion and partnerships}
- {team growth and operational scaling}
```

**Step 4.3: Slide 9 - Competitive Analysis**

**Competitive Landscape and Positioning**:

- Map competitive landscape and key players
- Analyze competitive strengths and weaknesses
- Define competitive differentiation and advantages
- Plan competitive response and market positioning
- Identify competitive threats and opportunities

**Slide 9 Content Structure**:

```markdown
# Slide 9: Competitive Landscape

## Competitive Map

### Direct Competitors

| Competitor     | Market Share  | Strengths       | Weaknesses       | Our Advantage        |
| -------------- | ------------- | --------------- | ---------------- | -------------------- |
| {Competitor 1} | {percentage}% | {key strengths} | {key weaknesses} | {our differentiator} |
| {Competitor 2} | {percentage}% | {key strengths} | {key weaknesses} | {our differentiator} |
| {Competitor 3} | {percentage}% | {key strengths} | {key weaknesses} | {our differentiator} |

### Indirect Competitors

- **Alternative 1**: {description of alternative approach}

  - **Market Impact**: {how this affects our market}
  - **Customer Overlap**: {customer segment overlap}
  - **Our Position**: {how we compete against this}

- **Alternative 2**: {description of alternative approach}
  - **Market Impact**: {how this affects our market}
  - **Customer Overlap**: {customer segment overlap}
  - **Our Position**: {how we compete against this}

## Competitive Advantages

### Sustainable Competitive Moats

1. **{Advantage Type}**: {description of competitive advantage}

   - **Barrier Height**: {how difficult to replicate}
   - **Time to Build**: {time required for competitors}
   - **Defensibility**: {ongoing protection strategy}

2. **{Advantage Type}**: {description of competitive advantage}
   - **Barrier Height**: {how difficult to replicate}
   - **Time to Build**: {time required for competitors}
   - **Defensibility**: {ongoing protection strategy}

## Market Positioning

- **Category**: {market category we're creating or competing in}
- **Position**: {how we want to be perceived in the market}
- **Messaging**: {core differentiating messages}
- **Proof Points**: {evidence supporting our position}

## Competitive Response Strategy

- **Monitoring**: {how we track competitive activity}
- **Response Framework**: {how we respond to competitive threats}
- **Innovation Pipeline**: {ongoing innovation to stay ahead}
- **Customer Retention**: {strategies to protect customer base}

## Market Evolution

- **Trend 1**: {market trend and our response}
- **Trend 2**: {market trend and our response}
- **Future State**: {where we see the market heading}
- **Our Vision**: {how we plan to shape market evolution}
```

````

### 5. **Financial Projections and Funding (Slides 10-12)**

**Financial Planning and Investment Requirements**:
```markdown
**Step 5.1: Slide 10 - Financial Projections**

**Financial Model Development**:
- Build comprehensive 3-5 year financial projections
- Model revenue growth and cost structure
- Project profitability timeline and cash flow
- Analyze key financial metrics and ratios
- Validate assumptions with market data

**Slide 10 Content Structure**:
```markdown
# Slide 10: Financial Projections

## Revenue Projections (5-Year)
| Year | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|------|---------|---------|---------|---------|---------|
| **Revenue** | ${amount} | ${amount} | ${amount} | ${amount} | ${amount} |
| **Growth Rate** | -{baseline} | {rate}% | {rate}% | {rate}% | {rate}% |
| **Customers** | {count} | {count} | {count} | {count} | {count} |
| **ARPU** | ${amount} | ${amount} | ${amount} | ${amount} | ${amount} |

## Revenue Breakdown by Stream
### Year 3 Target Revenue: ${total-amount}
- **Primary Revenue**: ${amount} ({percentage}%)
- **Secondary Revenue**: ${amount} ({percentage}%)
- **Services Revenue**: ${amount} ({percentage}%)
- **Partnership Revenue**: ${amount} ({percentage}%)

## Cost Structure
| Cost Category | Year 1 | Year 2 | Year 3 | % of Revenue |
|---------------|---------|---------|---------|--------------|
| **Cost of Goods Sold** | ${amount} | ${amount} | ${amount} | {percentage}% |
| **Sales & Marketing** | ${amount} | ${amount} | ${amount} | {percentage}% |
| **Research & Development** | ${amount} | ${amount} | ${amount} | {percentage}% |
| **General & Administrative** | ${amount} | ${amount} | ${amount} | {percentage}% |
| **Total Operating Expenses** | ${amount} | ${amount} | ${amount} | {percentage}% |

## Profitability Timeline
| Metric | Year 1 | Year 2 | Year 3 | Year 4 | Year 5 |
|--------|---------|---------|---------|---------|---------|
| **Gross Profit** | ${amount} | ${amount} | ${amount} | ${amount} | ${amount} |
| **Gross Margin** | {rate}% | {rate}% | {rate}% | {rate}% | {rate}% |
| **EBITDA** | (${amount}) | (${amount}) | ${amount} | ${amount} | ${amount} |
| **EBITDA Margin** | ({rate})% | ({rate})% | {rate}% | {rate}% | {rate}% |
| **Net Income** | (${amount}) | (${amount}) | ${amount} | ${amount} | ${amount} |

## Key Financial Metrics
- **Customer Acquisition Cost (CAC)**: ${amount}
- **Customer Lifetime Value (CLV)**: ${amount}
- **CLV:CAC Ratio**: {ratio}:1
- **Monthly Recurring Revenue Growth**: {rate}%
- **Cash Burn Rate**: ${amount}/month
- **Runway**: {months} months
- **Break-even Timeline**: Month {month} of Year {year}
````

**Step 5.2: Slide 11 - Funding Requirements**

**Investment Strategy and Capital Requirements**:

- Define funding amount and use of proceeds
- Explain investment timeline and milestones
- Detail investor requirements and terms
- Plan exit strategy and return projections
- Address investment risks and mitigation

**Slide 11 Content Structure**:

```markdown
# Slide 11: Funding Requirements

## Funding Request

### Total Funding Sought: ${total-amount}

- **Series/Round**: {seed/series-a/series-b/etc.}
- **Funding Type**: {equity/convertible/debt}
- **Timeline**: {when funding is needed}
- **Runway**: {months of operation funded}

## Use of Proceeds

| Category                        | Amount    | Percentage    | Purpose                           |
| ------------------------------- | --------- | ------------- | --------------------------------- |
| **Product Development**         | ${amount} | {percentage}% | {specific development goals}      |
| **Sales & Marketing**           | ${amount} | {percentage}% | {customer acquisition and growth} |
| **Team Expansion**              | ${amount} | {percentage}% | {key hires and team building}     |
| **Operations & Infrastructure** | ${amount} | {percentage}% | {operational scaling needs}       |
| **Working Capital**             | ${amount} | {percentage}% | {cash flow and reserves}          |

## Funding Milestones

### 6-Month Milestones

- **Revenue Target**: ${amount} ({growth}% growth)
- **Customer Target**: {count} customers
- **Product Milestone**: {key product achievement}
- **Team Milestone**: {key team expansion}

### 12-Month Milestones

- **Revenue Target**: ${amount} ({growth}% growth)
- **Customer Target**: {count} customers
- **Market Milestone**: {market expansion goals}
- **Profitability**: {path to profitability progress}

### 18-Month Milestones

- **Revenue Target**: ${amount} ({growth}% growth)
- **Market Position**: {competitive position goals}
- **Next Funding**: {preparation for next round}
- **Exit Readiness**: {exit preparation activities}

## Investment Terms

- **Valuation**: ${pre-money-amount} pre-money, ${post-money-amount} post-money
- **Equity Offered**: {percentage}%
- **Investor Rights**: {key rights and board participation}
- **Use Restrictions**: {any restrictions on fund usage}
- **Reporting**: {investor reporting and communication}

## Risk Factors & Mitigation

| Risk            | Impact         | Probability    | Mitigation Strategy   |
| --------------- | -------------- | -------------- | --------------------- |
| **Market Risk** | {high/med/low} | {high/med/low} | {mitigation approach} |
| **Competition** | {high/med/low} | {high/med/low} | {mitigation approach} |
| **Technology**  | {high/med/low} | {high/med/low} | {mitigation approach} |
| **Execution**   | {high/med/low} | {high/med/low} | {mitigation approach} |

## Exit Strategy

- **Exit Timeline**: {years from now}
- **Exit Options**: {acquisition/ipo/strategic sale}
- **Comparable Exits**: {recent exits in space}
- **Expected Valuation**: ${amount} ({multiple}x return)
- **Strategic Acquirers**: {potential acquirer types}
```

**Step 5.3: Slide 12 - Return Projections**

**Investment Returns and Value Creation**:

- Project investor returns and exit scenarios
- Analyze comparable transactions and valuations
- Model value creation drivers and catalysts
- Plan value realization timeline and strategies
- Address return expectations and risk-reward

**Slide 12 Content Structure**:

```markdown
# Slide 12: Return Projections

## Investment Return Scenarios

### Base Case (70% probability)

- **Exit Timeline**: {years}
- **Exit Valuation**: ${amount}
- **Revenue Multiple**: {multiple}x
- **Investor Return**: {multiple}x
- **IRR**: {percentage}%

### Upside Case (20% probability)

- **Exit Timeline**: {years}
- **Exit Valuation**: ${amount}
- **Revenue Multiple**: {multiple}x
- **Investor Return**: {multiple}x
- **IRR**: {percentage}%

### Downside Case (10% probability)

- **Exit Timeline**: {years}
- **Exit Valuation**: ${amount}
- **Revenue Multiple**: {multiple}x
- **Investor Return**: {multiple}x
- **IRR**: {percentage}%

## Comparable Company Analysis

| Company     | Exit Year | Exit Value | Revenue Multiple | Business Model Similarity |
| ----------- | --------- | ---------- | ---------------- | ------------------------- |
| {Company 1} | {year}    | ${amount}  | {multiple}x      | {similarity description}  |
| {Company 2} | {year}    | ${amount}  | {multiple}x      | {similarity description}  |
| {Company 3} | {year}    | ${amount}  | {multiple}x      | {similarity description}  |
| **Average** | -         | ${amount}  | {multiple}x      | -                         |

## Value Creation Drivers

1. **Market Expansion**

   - **Driver**: {how market growth creates value}
   - **Impact**: {quantified value impact}
   - **Timeline**: {when this value is realized}

2. **Product Innovation**

   - **Driver**: {how product development creates value}
   - **Impact**: {quantified value impact}
   - **Timeline**: {when this value is realized}

3. **Operational Leverage**
   - **Driver**: {how operational scaling creates value}
   - **Impact**: {quantified value impact}
   - **Timeline**: {when this value is realized}

## Exit Strategy Analysis

### Strategic Acquisition (Most Likely)

- **Potential Acquirers**: {list of strategic acquirers}
- **Acquisition Rationale**: {why they would acquire us}
- **Valuation Basis**: {how they would value the company}
- **Transaction Timeline**: {expected timeline to acquisition}

### IPO Scenario (Alternative)

- **IPO Readiness**: {requirements for public offering}
- **Market Conditions**: {favorable IPO market timing}
- **Comparable Public Companies**: {public company comparisons}
- **Valuation Multiples**: {expected public market multiples}

## Value Realization Timeline

- **Year 1-2**: {value building activities}
- **Year 2-3**: {major value catalysts}
- **Year 3-4**: {exit preparation activities}
- **Year 4-5**: {exit execution and value realization}

## Risk-Adjusted Returns

- **Probability-Weighted Return**: {blended return across scenarios}
- **Risk-Adjusted IRR**: {IRR adjusted for execution risk}
- **Benchmark Comparison**: {vs. venture capital benchmarks}
- **Liquidity Timeline**: {expected time to liquidity}
```

````

### 6. **Team and Implementation Plan (Slides 13-15)**

**Leadership Team and Execution Strategy**:
```markdown
**Step 6.1: Slide 13 - Leadership Team**

**Team Presentation and Credentials**:
- Showcase key leadership team members and backgrounds
- Highlight relevant experience and expertise
- Demonstrate team complementarity and skills coverage
- Address key advisor and board member contributions
- Plan team expansion and key hire requirements

**Slide 13 Content Structure**:
```markdown
# Slide 13: Leadership Team

## Founding Team
### {Founder Name}, {Title}
- **Background**: {relevant professional background}
- **Experience**: {years} years in {relevant industry/function}
- **Previous Roles**: {key previous positions and companies}
- **Expertise**: {key skills and domain knowledge}
- **Education**: {relevant educational background}
- **Achievements**: {notable accomplishments and recognition}

### {Co-Founder Name}, {Title}
- **Background**: {relevant professional background}
- **Experience**: {years} years in {relevant industry/function}
- **Previous Roles**: {key previous positions and companies}
- **Expertise**: {key skills and domain knowledge}
- **Education**: {relevant educational background}
- **Achievements**: {notable accomplishments and recognition}

## Key Team Members
### {Team Member Name}, {Title}
- **Role**: {primary responsibilities}
- **Background**: {relevant experience}
- **Previous Companies**: {notable previous employers}
- **Expertise**: {specialized skills}

### {Team Member Name}, {Title}
- **Role**: {primary responsibilities}
- **Background**: {relevant experience}
- **Previous Companies**: {notable previous employers}
- **Expertise**: {specialized skills}

## Advisory Board
### {Advisor Name}, {Title/Company}
- **Expertise**: {domain expertise and contribution}
- **Background**: {relevant background and credentials}
- **Value Add**: {specific ways they help the company}

### {Advisor Name}, {Title/Company}
- **Expertise**: {domain expertise and contribution}
- **Background**: {relevant background and credentials}
- **Value Add**: {specific ways they help the company}

## Team Strengths & Coverage
| Function | Team Member | Experience | Coverage Level |
|----------|-------------|------------|----------------|
| **Product & Technology** | {name} | {years} years | {complete/strong/adequate} |
| **Sales & Marketing** | {name} | {years} years | {complete/strong/adequate} |
| **Operations** | {name} | {years} years | {complete/strong/adequate} |
| **Finance** | {name} | {years} years | {complete/strong/adequate} |
| **Legal/Compliance** | {advisor} | {years} years | {complete/strong/adequate} |

## Team Track Record
- **Previous Exits**: {team members with successful exits}
- **Revenue Generated**: {total revenue generated by team members}
- **Teams Built**: {size of teams previously managed}
- **Fundraising Experience**: {previous fundraising success}
- **Industry Recognition**: {awards, speaking, thought leadership}

## Why This Team Wins
1. **Domain Expertise**: {deep industry knowledge and experience}
2. **Execution Experience**: {proven track record of building and scaling}
3. **Complementary Skills**: {well-rounded team with necessary capabilities}
4. **Network & Relationships**: {industry connections and partnerships}
5. **Cultural Fit**: {shared values and working relationship}
````

**Step 6.2: Slide 14 - Implementation Roadmap**

**Execution Plan and Timeline**:

- Create detailed implementation roadmap and milestones
- Define key performance indicators and success metrics
- Plan resource allocation and capacity requirements
- Identify critical dependencies and risk factors
- Establish governance and decision-making processes

**Slide 14 Content Structure**:

```markdown
# Slide 14: Implementation Roadmap

## 18-Month Execution Plan

### Phase 1: Foundation (Months 1-6)

#### Key Objectives

- {primary objective 1}
- {primary objective 2}
- {primary objective 3}

#### Major Milestones

| Milestone     | Target Month | Success Criteria   | Owner         |
| ------------- | ------------ | ------------------ | ------------- |
| {Milestone 1} | Month {#}    | {success criteria} | {team member} |
| {Milestone 2} | Month {#}    | {success criteria} | {team member} |
| {Milestone 3} | Month {#}    | {success criteria} | {team member} |

#### Key Activities

- **Product Development**: {specific development activities}
- **Market Validation**: {customer validation and testing}
- **Team Building**: {key hires and team expansion}
- **Partnership Development**: {strategic partnerships}
- **Funding**: {funding activities and milestones}

#### Success Metrics

- **Revenue**: ${amount} by Month 6
- **Customers**: {count} by Month 6
- **Team Size**: {count} employees
- **Product Metrics**: {key product KPIs}

### Phase 2: Growth (Months 7-12)

#### Key Objectives

- {growth objective 1}
- {growth objective 2}
- {growth objective 3}

#### Major Milestones

| Milestone     | Target Month | Success Criteria   | Owner         |
| ------------- | ------------ | ------------------ | ------------- |
| {Milestone 1} | Month {#}    | {success criteria} | {team member} |
| {Milestone 2} | Month {#}    | {success criteria} | {team member} |
| {Milestone 3} | Month {#}    | {success criteria} | {team member} |

#### Key Activities

- **Market Expansion**: {geographic or segment expansion}
- **Product Enhancement**: {major product improvements}
- **Sales Scaling**: {sales team and process scaling}
- **Operations**: {operational infrastructure}
- **Partnerships**: {channel and strategic partnerships}

#### Success Metrics

- **Revenue**: ${amount} by Month 12
- **Growth Rate**: {percentage}% monthly growth
- **Market Share**: {percentage}% in target segment
- **Team Size**: {count} employees

### Phase 3: Scale (Months 13-18)

#### Key Objectives

- {scaling objective 1}
- {scaling objective 2}
- {scaling objective 3}

#### Major Milestones

| Milestone     | Target Month | Success Criteria   | Owner         |
| ------------- | ------------ | ------------------ | ------------- |
| {Milestone 1} | Month {#}    | {success criteria} | {team member} |
| {Milestone 2} | Month {#}    | {success criteria} | {team member} |
| {Milestone 3} | Month {#}    | {success criteria} | {team member} |

## Resource Requirements by Phase

### Phase 1 Resources

- **Team**: {headcount} employees ({new hires})
- **Budget**: ${amount}
- **Technology**: {key technology investments}
- **Infrastructure**: {operational infrastructure needs}

### Phase 2 Resources

- **Team**: {headcount} employees ({new hires})
- **Budget**: ${amount}
- **Technology**: {additional technology needs}
- **Market Expansion**: {market entry investments}

### Phase 3 Resources

- **Team**: {headcount} employees ({new hires})
- **Budget**: ${amount}
- **Scaling Infrastructure**: {operational scaling needs}
- **International Expansion**: {global expansion resources}

## Risk Mitigation & Contingency

| Risk     | Impact         | Mitigation Plan       | Contingency Plan          |
| -------- | -------------- | --------------------- | ------------------------- |
| {Risk 1} | {high/med/low} | {prevention strategy} | {response if risk occurs} |
| {Risk 2} | {high/med/low} | {prevention strategy} | {response if risk occurs} |
| {Risk 3} | {high/med/low} | {prevention strategy} | {response if risk occurs} |

## Success Dependencies

- **Critical Path Items**: {items that could delay overall timeline}
- **External Dependencies**: {dependencies on partners/vendors}
- **Funding Dependencies**: {funding milestones required}
- **Market Dependencies**: {market conditions required}
```

**Step 6.3: Slide 15 - Key Hires and Organizational Plan**

**Team Expansion and Organizational Development**:

- Plan key leadership and team member recruitment
- Define organizational structure and reporting relationships
- Create hiring timeline and compensation strategy
- Design company culture and values framework
- Establish performance management and development systems

**Slide 15 Content Structure**:

```markdown
# Slide 15: Key Hires & Organizational Plan

## Hiring Plan (18 Months)

### Immediate Hires (Months 1-6)

| Role     | Priority | Timing    | Rationale                     | Budget    |
| -------- | -------- | --------- | ----------------------------- | --------- |
| {Role 1} | Critical | Month {#} | {why this role is needed now} | ${amount} |
| {Role 2} | High     | Month {#} | {impact on company growth}    | ${amount} |
| {Role 3} | Medium   | Month {#} | {capability gap to fill}      | ${amount} |

### Growth Hires (Months 7-12)

| Role     | Priority | Timing    | Rationale               | Budget    |
| -------- | -------- | --------- | ----------------------- | --------- |
| {Role 1} | Critical | Month {#} | {scaling requirement}   | ${amount} |
| {Role 2} | High     | Month {#} | {new capability needed} | ${amount} |
| {Role 3} | Medium   | Month {#} | {operational support}   | ${amount} |

### Scale Hires (Months 13-18)

| Role     | Priority | Timing    | Rationale                  | Budget    |
| -------- | -------- | --------- | -------------------------- | --------- |
| {Role 1} | Critical | Month {#} | {leadership scaling}       | ${amount} |
| {Role 2} | High     | Month {#} | {market expansion support} | ${amount} |
| {Role 3} | Medium   | Month {#} | {specialized expertise}    | ${amount} |

## Organizational Structure

### Current Structure (Team of {count})
```

CEO
├── CTO ({name})
│ ├── Engineering Team ({count})
│ └── Product Team ({count})
├── VP Sales & Marketing ({name})
│ ├── Sales Team ({count})
│ └── Marketing Team ({count})
└── Operations ({name})
├── Customer Success ({count})
└── Admin/Finance ({count})

```

### Target Structure (Team of {count} by Month 18)
```

CEO
├── CTO
│ ├── Engineering ({count})
│ ├── Product ({count})
│ └── DevOps/Infrastructure ({count})
├── VP Sales & Marketing
│ ├── Sales ({count})
│ ├── Marketing ({count})
│ └── Business Development ({count})
├── VP Operations
│ ├── Customer Success ({count})
│ ├── HR ({count})
│ └── Finance/Admin ({count})
└── Advisory Board ({count})

```

## Key Leadership Profiles
### {Role Title} - Priority Hire
- **Experience Required**: {years} years in {domain}
- **Background**: {ideal background and experience}
- **Responsibilities**: {key responsibilities and deliverables}
- **Success Metrics**: {how success will be measured}
- **Compensation**: ${amount} + equity
- **Timeline**: Target start Month {#}

### {Role Title} - Strategic Hire
- **Experience Required**: {years} years in {domain}
- **Background**: {ideal background and experience}
- **Responsibilities**: {key responsibilities and deliverables}
- **Success Metrics**: {how success will be measured}
- **Compensation**: ${amount} + equity
- **Timeline**: Target start Month {#}

## Compensation Philosophy
- **Cash Compensation**: {market positioning - 50th/75th/90th percentile}
- **Equity Program**: {equity pool size and allocation strategy}
- **Benefits Package**: {health, retirement, professional development}
- **Performance Incentives**: {bonus and commission structures}
- **Retention Strategy**: {vesting schedules and retention programs}

## Company Culture & Values
### Core Values
1. **{Value 1}**: {description of value and behaviors}
2. **{Value 2}**: {description of value and behaviors}
3. **{Value 3}**: {description of value and behaviors}
4. **{Value 4}**: {description of value and behaviors}

### Culture Elements
- **Remote/Hybrid Policy**: {work location philosophy}
- **Decision Making**: {decision-making process and empowerment}
- **Innovation Time**: {time allocated for innovation/learning}
- **Diversity & Inclusion**: {D&I commitments and programs}

## Talent Acquisition Strategy
- **Recruiting Approach**: {internal vs. external recruiting}
- **Sourcing Channels**: {universities, competitors, networks}
- **Employer Branding**: {building attractive employer brand}
- **Interview Process**: {standardized interview process}
- **Onboarding Program**: {new employee integration}

## Performance Management
- **Goal Setting**: {OKR or other goal-setting framework}
- **Performance Reviews**: {frequency and process}
- **Career Development**: {growth paths and development programs}
- **Recognition Programs**: {employee recognition and rewards}
- **Retention Metrics**: {retention targets and measurement}
```

````

### 7. **Appendix Development with Supporting Data**

**Supporting Documentation and Data**:
```markdown
**Step 7.1: Comprehensive Appendix Creation**

**Market Research and Validation Data**:
- Compile detailed market research reports and analysis
- Include customer interview transcripts and survey data
- Provide competitive analysis and benchmarking studies
- Document technical specifications and architecture details
- Include financial model assumptions and calculations

**Appendix Content Structure**:
```markdown
# Appendix: Supporting Data & Documentation

## A. Market Research & Analysis
### A1. Market Size Calculations
#### Total Addressable Market (TAM)
- **Data Sources**: {research sources and methodology}
- **Market Definition**: {how market is defined and segmented}
- **Size Calculation**: {step-by-step TAM calculation}
- **Growth Assumptions**: {market growth rate sources and rationale}
- **Geographic Breakdown**: {market size by region/country}

#### Serviceable Addressable Market (SAM)
- **Filtering Criteria**: {criteria used to filter TAM to SAM}
- **Size Calculation**: {SAM calculation methodology}
- **Target Segments**: {specific segments within SAM}
- **Penetration Assumptions**: {market penetration assumptions}

#### Serviceable Obtainable Market (SOM)
- **Market Share Assumptions**: {realistic market share projections}
- **Competitive Analysis**: {competitive landscape impact on SOM}
- **Timeline**: {timeline for achieving SOM penetration}
- **Supporting Evidence**: {evidence for market share assumptions}

### A2. Customer Research
#### Customer Interview Summary
| Interview # | Customer Type | Industry | Key Insights | Problem Validation |
|-------------|---------------|----------|--------------|-------------------|
| 1 | {customer-type} | {industry} | {key insights} | {validation-level} |
| 2 | {customer-type} | {industry} | {key insights} | {validation-level} |
| 3 | {customer-type} | {industry} | {key insights} | {validation-level} |

#### Survey Results
- **Response Rate**: {responses}/{sent} ({percentage}%)
- **Key Findings**:
  - {finding 1 with percentage}
  - {finding 2 with percentage}
  - {finding 3 with percentage}
- **Statistical Significance**: {confidence level and margin of error}
- **Survey Methodology**: {how survey was conducted}

### A3. Competitive Intelligence
#### Detailed Competitive Analysis
| Competitor | Founded | Funding | Revenue | Employees | Key Metrics |
|------------|---------|---------|---------|-----------|-------------|
| {Company 1} | {year} | ${amount} | ${amount} | {count} | {key metrics} |
| {Company 2} | {year} | ${amount} | ${amount} | {count} | {key metrics} |
| {Company 3} | {year} | ${amount} | ${amount} | {count} | {key metrics} |

#### Feature Comparison Matrix
| Feature | Our Solution | Competitor 1 | Competitor 2 | Competitor 3 |
|---------|-------------|-------------|-------------|-------------|
| {Feature 1} | ✅ Advanced | ⚠️ Basic | ❌ None | ✅ Standard |
| {Feature 2} | ✅ Advanced | ✅ Standard | ✅ Advanced | ⚠️ Basic |
| {Feature 3} | ✅ Standard | ❌ None | ⚠️ Basic | ✅ Advanced |

## B. Technical Documentation
### B1. Product Architecture
#### System Architecture Diagram
````

[Include technical architecture diagram]

```

#### Technology Stack
| Layer | Technology | Version | Rationale |
|-------|------------|---------|-----------|
| Frontend | {technology} | {version} | {why chosen} |
| Backend | {technology} | {version} | {why chosen} |
| Database | {technology} | {version} | {why chosen} |
| Infrastructure | {technology} | {version} | {why chosen} |

### B2. Security & Compliance
#### Security Measures
- **Data Encryption**: {encryption standards and implementation}
- **Access Control**: {authentication and authorization systems}
- **Network Security**: {firewall and network protection}
- **Monitoring**: {security monitoring and alerting}
- **Compliance**: {regulatory compliance achievements}

#### Compliance Certifications
| Certification | Status | Completion Date | Scope |
|--------------|---------|----------------|-------|
| {Cert 1} | {status} | {date} | {scope} |
| {Cert 2} | {status} | {date} | {scope} |

## C. Financial Model Details
### C1. Revenue Model Assumptions
#### Customer Acquisition
- **CAC by Channel**: {cost per channel with rationale}
- **Conversion Rates**: {funnel conversion rates with sources}
- **Sales Cycle**: {average sales cycle by segment}
- **Churn Rates**: {customer churn assumptions and benchmarks}

#### Pricing Analysis
- **Price Sensitivity**: {customer price sensitivity research}
- **Competitive Pricing**: {competitor pricing analysis}
- **Value-Based Pricing**: {value proposition to price correlation}
- **Price Elasticity**: {demand response to price changes}

### C2. Financial Projections Detail
#### Monthly Financial Model (Year 1-3)
[Include detailed monthly financial projections]

#### Scenario Analysis
| Scenario | Probability | Year 3 Revenue | Key Assumptions |
|----------|------------|----------------|-----------------|
| Conservative | 30% | ${amount} | {conservative assumptions} |
| Base Case | 50% | ${amount} | {base case assumptions} |
| Optimistic | 20% | ${amount} | {optimistic assumptions} |

## D. Partnership & Business Development
### D1. Strategic Partnerships
#### Confirmed Partnerships
| Partner | Type | Status | Value/Impact |
|---------|------|--------|--------------|
| {Partner 1} | {type} | {status} | {value description} |
| {Partner 2} | {type} | {status} | {value description} |

#### Partnership Pipeline
| Partner | Type | Stage | Potential Impact | Timeline |
|---------|------|-------|------------------|----------|
| {Partner 1} | {type} | {stage} | {impact} | {timeline} |
| {Partner 2} | {type} | {stage} | {impact} | {timeline} |

### D2. Pilot Programs & Case Studies
#### Current Pilots
| Customer | Industry | Start Date | Status | Results |
|----------|----------|------------|--------|---------|
| {Customer 1} | {industry} | {date} | {status} | {results} |
| {Customer 2} | {industry} | {date} | {status} | {results} |

## E. Team & Advisory Details
### E1. Detailed Team Profiles
[Extended bios and backgrounds for key team members]

### E2. Advisory Board Expertise
| Advisor | Primary Expertise | Secondary Expertise | Network Value |
|---------|------------------|-------------------|---------------|
| {Name 1} | {expertise 1} | {expertise 2} | {network description} |
| {Name 2} | {expertise 1} | {expertise 2} | {network description} |

## F. Risk Analysis & Mitigation
### F1. Risk Register
| Risk Category | Specific Risk | Impact | Probability | Mitigation Plan | Contingency |
|---------------|---------------|--------|-------------|----------------|-------------|
| Market | {risk} | {H/M/L} | {H/M/L} | {mitigation} | {contingency} |
| Technology | {risk} | {H/M/L} | {H/M/L} | {mitigation} | {contingency} |
| Competitive | {risk} | {H/M/L} | {H/M/L} | {mitigation} | {contingency} |
| Execution | {risk} | {H/M/L} | {H/M/L} | {mitigation} | {contingency} |

### F2. Sensitivity Analysis
#### Key Variables Impact Analysis
| Variable | Base Case | -20% Impact | +20% Impact | Sensitivity |
|----------|-----------|-------------|-------------|-------------|
| Market Growth | {rate}% | {impact} | {impact} | {high/med/low} |
| Customer Acquisition Cost | ${amount} | {impact} | {impact} | {high/med/low} |
| Customer Lifetime Value | ${amount} | {impact} | {impact} | {high/med/low} |
| Competition Intensity | {level} | {impact} | {impact} | {high/med/low} |

## G. Legal & Intellectual Property
### G1. Intellectual Property Portfolio
| IP Type | Description | Status | Protection Scope | Strategic Value |
|---------|-------------|--------|------------------|-----------------|
| Patent | {patent description} | {status} | {geographic scope} | {strategic value} |
| Trademark | {trademark details} | {status} | {geographic scope} | {brand protection} |
| Copyright | {copyright description} | {status} | {protection scope} | {content value} |

### G2. Legal Structure
- **Corporate Structure**: {legal entity structure}
- **Shareholder Structure**: {current ownership breakdown}
- **Employee Equity Pool**: {equity pool size and allocation}
- **Board Structure**: {board composition and governance}
- **Key Contracts**: {material contracts and agreements}

## H. References & Sources
### H1. Market Research Sources
- {source 1}: {description and credibility}
- {source 2}: {description and credibility}
- {source 3}: {description and credibility}

### H2. Industry Reports
- {report 1}: {publisher, date, key findings used}
- {report 2}: {publisher, date, key findings used}
- {report 3}: {publisher, date, key findings used}

### H3. Expert Interviews
| Expert | Title/Company | Expertise Area | Key Insights |
|--------|---------------|----------------|--------------|
| {Name 1} | {title/company} | {expertise} | {insights provided} |
| {Name 2} | {title/company} | {expertise} | {insights provided} |
```

````

### 8. **Final Assembly and Quality Assurance**

**Pitch Deck Compilation and Review**:
```markdown
**Step 8.1: Document Assembly and Formatting**

**Final Document Creation**:
- Compile all slide content into cohesive presentation format
- Ensure consistent formatting and professional appearance
- Validate that all variable references resolve correctly
- Check for content flow and narrative coherence
- Optimize for presentation delivery and investor review

**Quality Assurance Checklist**:
- [ ] All 15 slides completed with comprehensive content
- [ ] Appendix includes all supporting documentation
- [ ] Financial projections are realistic and well-supported
- [ ] Market analysis is thorough and data-driven
- [ ] Team credentials are compelling and relevant
- [ ] Business model is clearly articulated and scalable
- [ ] Competitive analysis addresses key threats and opportunities
- [ ] Implementation plan is detailed and achievable
- [ ] Funding request is justified and appropriate
- [ ] Risk factors are identified and mitigated
- [ ] Document formatting is professional and consistent
- [ ] All sources and references are properly cited
````

## Examples

### Example 1: Tech Startup Pitch Deck

**Input**:

```
pitch-deck
```

**Expected Output**:

```markdown
🎯 Building comprehensive pitch deck...

📋 Loading project requirements from {{files.requirements}}
✅ Project: AI-powered data analytics platform
✅ Target: B2B SaaS market
✅ Stage: Series A funding

📊 Creating pitch deck structure:
├── Slides 1-3: Problem & Market Opportunity
├── Slides 4-6: Solution & Product Demo
├── Slides 7-9: Business Model & Go-to-Market
├── Slides 10-12: Financial Projections & Funding
├── Slides 13-15: Team & Implementation Plan
└── Appendix: Supporting Data

💰 Financial Summary:

- Market Size: $45B TAM, $12B SAM, $500M SOM
- Funding Request: $5M Series A
- Projected Revenue: $50M by Year 5
- Expected Return: 10x in 5 years

👥 Team Highlights:

- Experienced founding team with 40+ years combined experience
- Advisory board includes 3 industry executives
- Hiring plan for 25 employees over 18 months

📄 Pitch deck saved to: {{folders.plan}}/business/pitch-deck.md
📊 Document includes 15 slides + comprehensive appendix
🎯 Ready for investor presentations and funding discussions
```

### Example 2: Healthcare Startup Pitch Deck

**Input**:

```
pitch-deck
```

**Expected Output**:

```markdown
🏥 Building healthcare industry pitch deck...

📋 Analysis Complete:

- Market: Digital health and telemedicine
- Problem: Access to specialized healthcare
- Solution: AI-powered remote diagnosis platform
- Target: $2.5M seed funding

📊 Key Metrics Generated:

- TAM: $350B healthcare market
- Customer Acquisition Cost: $1,200
- Lifetime Value: $15,000
- Break-even: Month 24

🎯 Regulatory Considerations:

- HIPAA compliance framework included
- FDA regulatory pathway outlined
- Clinical validation requirements addressed

📄 Complete pitch deck created with:

- 15 comprehensive slides
- Regulatory compliance appendix
- Clinical validation data
- Healthcare-specific financial modeling

✅ Investor-ready presentation saved to {{folders.plan}}/business/pitch-deck.md
```

## Notes

- **Requirements integration** ensures pitch deck aligns with project specifications and goals
- **Professional formatting** creates investor-ready presentation materials
- **Comprehensive content** covers all essential elements investors expect to see
- **Supporting data** in appendix provides detailed backup for key claims and projections
- **Slide structure** follows proven investor presentation best practices
- **Financial modeling** includes realistic projections with supporting assumptions
- **Risk assessment** addresses key concerns investors typically raise
- **Implementation focus** demonstrates execution capability and planning depth
