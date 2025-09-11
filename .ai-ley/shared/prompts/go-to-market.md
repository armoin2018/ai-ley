---
agentMode: general
applyTo: general
author: AI-LEY
description: Build a complete go-to-market strategy based on the requirements found in files.requirements
extensions:
  - .md
guidelines: Follow AI-LEY project standards and best practices for go-to-market strategy development
instructionType: general
keywords: [go-to-market, gtm, strategy, launch, customer-acquisition, marketing, sales]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 3.0
title: Go-to-Market Strategy
version: 1.0.0
---

# Copilot Command: Go-to-Market Strategy

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- Project requirements and specifications from `{{files.requirements}}`
- Product or service launch objectives
- Target market and customer segments
- Competitive landscape and positioning needs

Produce:

- Complete go-to-market strategy document in `{{folders.plan}}/business/go-to-market.md`
- Market entry strategy and customer acquisition plan
- Pricing and positioning framework
- Sales and marketing channel strategy
- Launch timeline and execution roadmap
- Success metrics and KPI framework

## Command

You are a go-to-market strategy specialist and product launch expert with expertise in customer acquisition, market penetration, and revenue growth strategies.

### 1. **Requirements Analysis and Market Foundation**

**Strategic Context Loading**:

```markdown
**Step 1.1: Requirements and Market Context Analysis**

**Load Project Foundation**:

- Read and analyze `{{files.requirements}}` for product specifications
- Extract target market and customer segment definitions
- Identify competitive landscape and positioning requirements
- Understand revenue goals and growth objectives
- Determine launch timeline and resource constraints

**Market Entry Analysis**:

- Analyze market readiness and timing factors
- Research customer buying behavior and decision processes
- Identify market entry barriers and success factors
- Understand channel dynamics and partner ecosystem
- Assess regulatory requirements and compliance needs

**Competitive Intelligence**:

- Map competitive landscape and key players
- Analyze competitor go-to-market strategies
- Identify market gaps and differentiation opportunities
- Understand pricing dynamics and value propositions
- Assess competitive response scenarios
```

### 2. **Target Market and Customer Segmentation**

**Customer-Centric Market Analysis**:

````markdown
**Step 2.1: Target Market Definition and Prioritization**

**Market Segmentation Strategy**:

```markdown
# Target Market Analysis

## Market Segmentation Framework

### Primary Target Segment: {Segment Name}

**Segment Characteristics**:

- **Industry/Vertical**: {specific-industry-focus}
- **Company Size**: {employee-count-revenue-range}
- **Geographic Location**: {target-regions-countries}
- **Technology Adoption**: {early-adopter-mainstream-laggard}
- **Budget Range**: ${budget-range-for-solution}

**Customer Profile**:

- **Decision Makers**: {titles-and-roles}
- **Buying Process**: {typical-decision-process}
- **Purchase Triggers**: {events-that-trigger-buying}
- **Pain Points**: {critical-problems-they-face}
- **Success Metrics**: {how-they-measure-success}

**Market Size and Opportunity**:

- **Segment Size**: {number-of-potential-customers}
- **Market Value**: ${total-segment-value}
- **Growth Rate**: {segment-growth-percentage}%
- **Penetration Strategy**: {how-to-enter-segment}

### Secondary Target Segments

**Segment 2**: {segment-name}

- **Opportunity Size**: ${market-value}
- **Entry Timeline**: {when-to-target}
- **Strategic Rationale**: {why-target-this-segment}

**Segment 3**: {segment-name}

- **Opportunity Size**: ${market-value}
- **Entry Timeline**: {when-to-target}
- **Strategic Rationale**: {why-target-this-segment}

## Customer Personas

### Persona 1: "{Persona Name}" - {Role Title}

**Demographics**:

- **Age Range**: {age-range}
- **Education**: {education-level}
- **Experience**: {years-in-role}
- **Industry Background**: {industry-experience}

**Psychographics**:

- **Goals & Motivations**: {what-drives-them}
- **Challenges**: {biggest-work-challenges}
- **Information Sources**: {where-they-get-information}
- **Decision Criteria**: {how-they-evaluate-solutions}

**Buying Behavior**:

- **Budget Authority**: ${spending-authority}
- **Decision Process**: {steps-in-buying-process}
- **Evaluation Criteria**: {key-factors-in-decision}
- **Preferred Vendors**: {existing-vendor-relationships}

**Pain Points & Use Cases**:

1. **Pain Point 1**: {specific-problem}

   - **Impact**: {business-impact}
   - **Current Solution**: {how-currently-handled}
   - **Urgency**: {how-urgent-to-solve}

2. **Pain Point 2**: {specific-problem}
   - **Impact**: {business-impact}
   - **Current Solution**: {how-currently-handled}
   - **Urgency**: {how-urgent-to-solve}

**Message Resonance**:

- **Primary Message**: {most-compelling-value-prop}
- **Supporting Messages**: {additional-value-props}
- **Proof Points**: {evidence-they-need-to-see}
- **Communication Preferences**: {preferred-channels}
```
````

````

### 3. **Value Proposition and Positioning Strategy**

**Market Positioning and Messaging Framework**:
```markdown
**Step 3.1: Value Proposition Development**

**Positioning Strategy and Competitive Differentiation**:
```markdown
# Value Proposition & Positioning

## Core Value Proposition
**Primary Value Statement**: {one-sentence-value-proposition}

**Value Proposition Canvas**:
| Customer Jobs | Pain Points | Gain Creators | Pain Relievers |
|---------------|-------------|---------------|----------------|
| {job-to-be-done-1} | {pain-point-1} | {gain-creator-1} | {pain-reliever-1} |
| {job-to-be-done-2} | {pain-point-2} | {gain-creator-2} | {pain-reliever-2} |
| {job-to-be-done-3} | {pain-point-3} | {gain-creator-3} | {pain-reliever-3} |

## Market Positioning
### Positioning Statement
"For {target-customer} who {customer-need}, our {product-category} is {key-benefit} that {proof-point}. Unlike {primary-competitor}, we {key-differentiator}."

### Competitive Positioning Map
| Competitive Factor | Our Solution | Competitor 1 | Competitor 2 | Competitor 3 |
|-------------------|--------------|-------------|-------------|-------------|
| **Price** | {position} | {position} | {position} | {position} |
| **Features** | {position} | {position} | {position} | {position} |
| **Ease of Use** | {position} | {position} | {position} | {position} |
| **Integration** | {position} | {position} | {position} | {position} |
| **Support** | {position} | {position} | {position} | {position} |

## Messaging Framework
### Master Message Architecture
**Primary Message**: {core-message}
**Supporting Pillars**:
1. **Pillar 1**: {supporting-message-1}
   - **Proof Points**: {evidence-and-benefits}
   - **Customer Stories**: {relevant-use-cases}

2. **Pillar 2**: {supporting-message-2}
   - **Proof Points**: {evidence-and-benefits}
   - **Customer Stories**: {relevant-use-cases}

3. **Pillar 3**: {supporting-message-3}
   - **Proof Points**: {evidence-and-benefits}
   - **Customer Stories**: {relevant-use-cases}

### Segment-Specific Messaging
**For {Segment 1}**: {tailored-message}
**For {Segment 2}**: {tailored-message}
**For {Segment 3}**: {tailored-message}

## Competitive Differentiation
### Key Differentiators
1. **Differentiator 1**: {unique-advantage}
   - **Competitive Moat**: {barrier-to-replication}
   - **Customer Benefit**: {specific-customer-value}
   - **Proof Strategy**: {how-to-demonstrate}

2. **Differentiator 2**: {unique-advantage}
   - **Competitive Moat**: {barrier-to-replication}
   - **Customer Benefit**: {specific-customer-value}
   - **Proof Strategy**: {how-to-demonstrate}

### Battle Cards
**vs. {Primary Competitor}**:
- **Why We Win**: {our-advantages}
- **Why We Lose**: {their-advantages}
- **Competitive Response**: {how-to-handle-objections}
- **Win Strategies**: {tactics-to-win-deals}
````

````

### 4. **Customer Acquisition Strategy**

**Multi-Channel Customer Acquisition Framework**:
```markdown
**Step 4.1: Customer Acquisition Channel Strategy**

**Acquisition Channel Design and Optimization**:
```markdown
# Customer Acquisition Strategy

## Customer Acquisition Funnel
### Funnel Metrics Overview
| Stage | Volume | Conversion Rate | Cost | Time |
|-------|--------|----------------|------|------|
| **Awareness** | {monthly-impressions} | {rate}% | ${cost-per-impression} | - |
| **Interest** | {monthly-leads} | {rate}% | ${cost-per-lead} | - |
| **Consideration** | {monthly-mqls} | {rate}% | ${cost-per-mql} | {days} |
| **Intent** | {monthly-sqls} | {rate}% | ${cost-per-sql} | {days} |
| **Purchase** | {monthly-customers} | {rate}% | ${cac} | {days} |

### Customer Acquisition Channels
#### Digital Marketing Channels
**1. Content Marketing & SEO**
- **Strategy**: {content-marketing-approach}
- **Content Types**: {blog-posts-whitepapers-videos}
- **SEO Focus**: {target-keywords-and-topics}
- **Expected Results**: {monthly-leads} leads/month
- **Investment**: ${monthly-budget}
- **Timeline**: {months} to see results

**2. Paid Digital Advertising**
- **Platforms**: {google-ads-linkedin-facebook}
- **Ad Strategy**: {targeting-and-messaging}
- **Budget Allocation**: ${monthly-ad-spend}
- **Target Metrics**: {cpc-ctr-conversion-rates}
- **Expected CAC**: ${customer-acquisition-cost}

**3. Social Media Marketing**
- **Primary Platforms**: {linkedin-twitter-youtube}
- **Content Strategy**: {thought-leadership-engagement}
- **Organic vs. Paid**: {strategy-split}
- **Influencer Strategy**: {industry-influencer-partnerships}

#### Sales-Driven Channels
**1. Direct Sales Team**
- **Sales Model**: {inside-outside-hybrid}
- **Territory Strategy**: {geographic-vertical-account}
- **Quota Per Rep**: ${annual-quota}
- **Average Deal Size**: ${deal-size}
- **Sales Cycle**: {length} months

**2. Partner Channel Program**
- **Partner Types**: {resellers-integrators-consultants}
- **Partner Recruitment**: {how-to-find-partners}
- **Partner Enablement**: {training-and-support}
- **Channel Conflict**: {management-strategy}
- **Revenue Attribution**: {percentage}% through partners

**3. Customer Referral Program**
- **Referral Incentives**: {incentive-structure}
- **Referral Process**: {how-referrals-work}
- **Expected Referral Rate**: {percentage}% of customers
- **Referral Quality**: {conversion-rate-of-referrals}

## Channel Performance Metrics
### Channel ROI Analysis
| Channel | Monthly Investment | Monthly Customers | CAC | LTV:CAC Ratio | Payback Period |
|---------|-------------------|-------------------|-----|---------------|----------------|
| Content/SEO | ${amount} | {count} | ${amount} | {ratio}:1 | {months} |
| Paid Ads | ${amount} | {count} | ${amount} | {ratio}:1 | {months} |
| Direct Sales | ${amount} | {count} | ${amount} | {ratio}:1 | {months} |
| Partners | ${amount} | {count} | ${amount} | {ratio}:1 | {months} |
| Referrals | ${amount} | {count} | ${amount} | {ratio}:1 | {months} |

### Customer Acquisition Scaling Plan
**Phase 1 (Months 1-6)**: {focus-channels-and-strategy}
**Phase 2 (Months 7-12)**: {expansion-channels-and-scaling}
**Phase 3 (Months 13-18)**: {optimization-and-new-channels}
````

````

### 5. **Pricing Strategy**

**Revenue Model and Pricing Framework**:
```markdown
**Step 5.1: Pricing Strategy Development**

**Pricing Model Design and Optimization**:
```markdown
# Pricing Strategy

## Pricing Model Overview
**Primary Pricing Model**: {subscription-transaction-license-usage}
**Pricing Philosophy**: {value-based-cost-plus-competitive}
**Price Positioning**: {premium-mid-market-value}

## Pricing Tiers and Structure
### Tier 1: {Tier Name}
- **Target Customer**: {customer-segment}
- **Price Point**: ${price} per {unit-period}
- **Key Features**: {included-features}
- **Usage Limits**: {limits-and-restrictions}
- **Value Proposition**: {why-customers-choose-this}

### Tier 2: {Tier Name}
- **Target Customer**: {customer-segment}
- **Price Point**: ${price} per {unit-period}
- **Key Features**: {included-features}
- **Usage Limits**: {limits-and-restrictions}
- **Value Proposition**: {why-customers-choose-this}

### Tier 3: {Tier Name}
- **Target Customer**: {customer-segment}
- **Price Point**: ${price} per {unit-period}
- **Key Features**: {included-features}
- **Usage Limits**: {limits-and-restrictions}
- **Value Proposition**: {why-customers-choose-this}

## Pricing Strategy Rationale
### Value-Based Pricing Analysis
- **Customer Value Created**: ${quantified-value}
- **Value Capture %**: {percentage-of-value-captured}%
- **ROI for Customer**: {customer-return-multiple}x
- **Willingness to Pay**: ${price-sensitivity-research}

### Competitive Pricing Comparison
| Solution | Our Price | Competitor 1 | Competitor 2 | Competitor 3 |
|----------|-----------|-------------|-------------|-------------|
| **Basic Tier** | ${amount} | ${amount} | ${amount} | ${amount} |
| **Professional** | ${amount} | ${amount} | ${amount} | ${amount} |
| **Enterprise** | ${amount} | ${amount} | ${amount} | ${amount} |

## Pricing Tactics and Programs
### Launch Pricing Strategy
- **Launch Discount**: {percentage}% off for {time-period}
- **Early Adopter Program**: {special-pricing-for-early-customers}
- **Freemium/Trial Strategy**: {free-trial-or-freemium-approach}

### Revenue Optimization
- **Upselling Strategy**: {how-to-move-customers-up-tiers}
- **Cross-selling Opportunities**: {additional-products-services}
- **Renewal Strategy**: {customer-retention-pricing}
- **Enterprise Deals**: {custom-pricing-for-large-deals}

## Unit Economics
### Customer Economics
- **Average Revenue Per User (ARPU)**: ${monthly-arpu}
- **Customer Lifetime Value (CLV)**: ${total-clv}
- **Customer Acquisition Cost (CAC)**: ${total-cac}
- **CLV:CAC Ratio**: {ratio}:1
- **Gross Margin**: {percentage}%
- **Payback Period**: {months} months

### Revenue Projections by Tier
| Tier | % of Customers | Avg. Price | Monthly Revenue | Annual Revenue |
|------|----------------|------------|-----------------|----------------|
| Basic | {percentage}% | ${price} | ${amount} | ${amount} |
| Professional | {percentage}% | ${price} | ${amount} | ${amount} |
| Enterprise | {percentage}% | ${price} | ${amount} | ${amount} |
| **Total** | **100%** | **${avg-price}** | **${total-monthly}** | **${total-annual}** |
````

````

### 6. **Launch Strategy and Timeline**

**Market Entry Execution Plan**:
```markdown
**Step 6.1: Go-to-Market Launch Plan**

**Launch Timeline and Milestone Management**:
```markdown
# Launch Strategy & Timeline

## Launch Phases Overview
### Pre-Launch Phase (Months -3 to 0)
**Objectives**: {preparation-and-setup-goals}
**Key Activities**:
- Product finalization and quality assurance
- Go-to-market team hiring and training
- Marketing content and collateral development
- Sales process and tools setup
- Partner recruitment and enablement
- Beta customer program execution

### Soft Launch Phase (Months 1-3)
**Objectives**: {limited-market-testing-goals}
**Key Activities**:
- Limited customer acquisition (target: {number} customers)
- Product-market fit validation
- Feedback collection and product iteration
- Sales process optimization
- Marketing message testing
- Customer success process development

### Market Launch Phase (Months 4-6)
**Objectives**: {full-market-entry-goals}
**Key Activities**:
- Full marketing campaign activation
- Sales team scaling and territory expansion
- Partner channel activation
- Customer acquisition scaling
- PR and industry event participation
- Competitive response management

### Scale Phase (Months 7-12)
**Objectives**: {growth-acceleration-goals}
**Key Activities**:
- Customer acquisition optimization
- Market expansion (new segments/regions)
- Product enhancement and new features
- Team scaling across all functions
- Customer success and retention focus
- Funding preparation for next stage

## Detailed Launch Timeline
### Month -3: Foundation
| Week | Key Activities | Owner | Success Criteria |
|------|---------------|--------|------------------|
| 1 | {activity-list} | {responsible-team} | {success-metrics} |
| 2 | {activity-list} | {responsible-team} | {success-metrics} |
| 3 | {activity-list} | {responsible-team} | {success-metrics} |
| 4 | {activity-list} | {responsible-team} | {success-metrics} |

### Month 0: Launch Preparation
| Week | Key Activities | Owner | Success Criteria |
|------|---------------|--------|------------------|
| 1 | {activity-list} | {responsible-team} | {success-metrics} |
| 2 | {activity-list} | {responsible-team} | {success-metrics} |
| 3 | {activity-list} | {responsible-team} | {success-metrics} |
| 4 | {activity-list} | {responsible-team} | {success-metrics} |

### Month 1: Soft Launch
| Week | Key Activities | Owner | Success Criteria |
|------|---------------|--------|------------------|
| 1 | {activity-list} | {responsible-team} | {success-metrics} |
| 2 | {activity-list} | {responsible-team} | {success-metrics} |
| 3 | {activity-list} | {responsible-team} | {success-metrics} |
| 4 | {activity-list} | {responsible-team} | {success-metrics} |

## Launch Success Criteria
### Phase Gate Metrics
**Pre-Launch Completion**:
- [ ] Product ready for market (quality scorecard: >{percentage}%)
- [ ] Go-to-market team hired and trained ({count} people)
- [ ] Sales tools and processes operational
- [ ] Marketing campaigns ready for activation
- [ ] Beta customers providing positive feedback (NPS > {score})

**Soft Launch Success**:
- [ ] {number} paying customers acquired
- [ ] Product-market fit indicators positive (retention > {percentage}%)
- [ ] Sales process converting at >{percentage}%
- [ ] Customer satisfaction score > {rating}
- [ ] Marketing qualified leads > {monthly-target}

**Market Launch Success**:
- [ ] {number} customers acquired in first {months} months
- [ ] Monthly recurring revenue > ${amount}
- [ ] Customer acquisition cost < ${target-cac}
- [ ] Partner channel contributing >{percentage}% of pipeline
- [ ] Market awareness targets achieved

## Risk Mitigation Plan
### Launch Risks and Contingencies
| Risk | Probability | Impact | Mitigation Strategy | Contingency Plan |
|------|-------------|--------|-------------------|-----------------|
| Product delays | {high/med/low} | {high/med/low} | {prevention-plan} | {response-plan} |
| Market rejection | {high/med/low} | {high/med/low} | {prevention-plan} | {response-plan} |
| Competitive response | {high/med/low} | {high/med/low} | {prevention-plan} | {response-plan} |
| Team execution | {high/med/low} | {high/med/low} | {prevention-plan} | {response-plan} |
| Funding shortfall | {high/med/low} | {high/med/low} | {prevention-plan} | {response-plan} |
````

````

### 7. **Success Metrics and KPIs**

**Performance Measurement Framework**:
```markdown
**Step 7.1: Success Metrics and Performance Tracking**

**KPI Framework and Success Measurement**:
```markdown
# Success Metrics & KPIs

## Go-to-Market KPI Dashboard
### Customer Acquisition Metrics
| Metric | Target | Month 3 | Month 6 | Month 12 | Tracking |
|--------|---------|---------|---------|----------|-----------|
| **New Customers** | {target} | {actual} | {actual} | {actual} | {on-track-status} |
| **Customer Acquisition Cost** | ${target} | ${actual} | ${actual} | ${actual} | {trend} |
| **Customer Lifetime Value** | ${target} | ${actual} | ${actual} | ${actual} | {trend} |
| **LTV:CAC Ratio** | {target}:1 | {actual}:1 | {actual}:1 | {actual}:1 | {health} |
| **Payback Period** | {target} months | {actual} months | {actual} months | {actual} months | {trend} |

### Revenue Metrics
| Metric | Target | Month 3 | Month 6 | Month 12 | Status |
|--------|---------|---------|---------|----------|---------|
| **Monthly Recurring Revenue** | ${target} | ${actual} | ${actual} | ${actual} | {status} |
| **Annual Recurring Revenue** | ${target} | ${actual} | ${actual} | ${actual} | {status} |
| **Revenue Growth Rate** | {target}% | {actual}% | {actual}% | {actual}% | {trend} |
| **Average Revenue Per User** | ${target} | ${actual} | ${actual} | ${actual} | {trend} |
| **Revenue per Channel** | - | {breakdown} | {breakdown} | {breakdown} | {analysis} |

### Market Penetration Metrics
| Metric | Target | Month 3 | Month 6 | Month 12 | Analysis |
|--------|---------|---------|---------|----------|----------|
| **Market Share** | {target}% | {actual}% | {actual}% | {actual}% | {competitive-position} |
| **Brand Awareness** | {target}% | {actual}% | {actual}% | {actual}% | {survey-results} |
| **Pipeline Coverage** | {target}x | {actual}x | {actual}x | {actual}x | {pipeline-health} |
| **Win Rate** | {target}% | {actual}% | {actual}% | {actual}% | {sales-effectiveness} |

## Channel Performance Analysis
### Marketing Channel ROI
| Channel | Investment | Customers | CAC | ROAS | LTV:CAC | Performance |
|---------|------------|-----------|-----|------|---------|-------------|
| **Content/SEO** | ${amount} | {count} | ${amount} | {ratio}:1 | {ratio}:1 | {rating} |
| **Paid Advertising** | ${amount} | {count} | ${amount} | {ratio}:1 | {ratio}:1 | {rating} |
| **Sales Team** | ${amount} | {count} | ${amount} | {ratio}:1 | {ratio}:1 | {rating} |
| **Partner Channel** | ${amount} | {count} | ${amount} | {ratio}:1 | {ratio}:1 | {rating} |
| **Referrals** | ${amount} | {count} | ${amount} | {ratio}:1 | {ratio}:1 | {rating} |

### Sales Performance Metrics
| Metric | Target | Q1 | Q2 | Q3 | Q4 |
|--------|---------|-----|-----|-----|-----|
| **Sales Qualified Leads** | {target} | {actual} | {actual} | {actual} | {actual} |
| **Opportunity Creation** | {target} | {actual} | {actual} | {actual} | {actual} |
| **Pipeline Value** | ${target} | ${actual} | ${actual} | ${actual} | ${actual} |
| **Closed Won Revenue** | ${target} | ${actual} | ${actual} | ${actual} | ${actual} |
| **Sales Cycle Length** | {target} days | {actual} days | {actual} days | {actual} days | {actual} days |

## Customer Success Metrics
### Retention and Expansion
| Metric | Target | Month 6 | Month 12 | Month 18 | Trend |
|--------|---------|---------|----------|----------|--------|
| **Customer Retention Rate** | {target}% | {actual}% | {actual}% | {actual}% | {trend} |
| **Net Revenue Retention** | {target}% | {actual}% | {actual}% | {actual}% | {trend} |
| **Upsell/Cross-sell Rate** | {target}% | {actual}% | {actual}% | {actual}% | {trend} |
| **Customer Satisfaction (NPS)** | {target} | {actual} | {actual} | {actual} | {trend} |
| **Product Adoption Rate** | {target}% | {actual}% | {actual}% | {actual}% | {trend} |

## Success Milestone Framework
### 6-Month Milestones
- **Revenue Target**: ${amount} in MRR
- **Customer Target**: {count} paying customers
- **Market Position**: {competitive-position-goal}
- **Team Scale**: {team-size} employees
- **Product Milestones**: {key-product-achievements}

### 12-Month Milestones
- **Revenue Target**: ${amount} in ARR
- **Market Expansion**: {new-segments-regions}
- **Channel Maturity**: {channel-contribution-goals}
- **Operational Excellence**: {efficiency-targets}
- **Next Funding Round**: {funding-preparation}

### Success Review Process
- **Weekly Reviews**: Channel performance, pipeline health
- **Monthly Reviews**: Customer acquisition, revenue metrics
- **Quarterly Reviews**: Market position, strategic pivots
- **Annual Reviews**: Go-to-market strategy evolution
````

```

## Examples

### Example 1: SaaS Platform Go-to-Market

**Input**:
```

go-to-market

````

**Expected Output**:
```markdown
🚀 Building comprehensive go-to-market strategy...

📊 Market Analysis Complete:
✅ Primary Target: Mid-market companies (500-2000 employees)
✅ Market Size: $2.3B TAM, $450M SAM
✅ Customer Persona: IT Directors & Operations Managers

🎯 GTM Strategy Framework:
- Customer Acquisition: Multi-channel approach (content + direct sales)
- Pricing Model: Freemium → $99/month → $499/month → Enterprise
- Launch Timeline: 6-month phased rollout
- Success Metrics: 500 customers, $50K MRR by Month 6

📈 Channel Strategy:
- Inbound Marketing (40% of leads): SEO, content, webinars
- Direct Sales (35% of leads): Inside sales team + field sales
- Partner Channel (25% of leads): Systems integrators

💰 Revenue Model:
- Target ARPU: $299/month
- Customer LTV: $18K
- Acquisition Cost: $1,200 (LTV:CAC = 15:1)
- Break-even: Month 4 per customer

📄 Complete 42-page go-to-market strategy saved to:
{{folders.plan}}/business/go-to-market.md

🎯 Ready for team alignment and execution launch!
````

### Example 2: Hardware Product Launch

**Input**:

```
go-to-market
```

**Expected Output**:

```markdown
🔧 Building hardware product go-to-market strategy...

📋 Product Launch Context:

- Product: IoT sensor for industrial monitoring
- Target: Manufacturing facilities and warehouses
- Price Point: $2,999 per unit + $199/month service

🏭 Market Entry Strategy:

- Phase 1: Direct sales to early adopters (Months 1-6)
- Phase 2: Channel partner program (Months 7-12)
- Phase 3: Geographic expansion (Months 13-18)

🤝 Partner Strategy:

- Systems Integrators: 15 tier-1 partners identified
- Distributors: Regional distribution network
- Technology Partners: Integration with 5 major platforms

📊 Launch Metrics:

- Target: 200 units sold in Year 1
- Revenue Goal: $1.2M ARR by Month 12
- Market Penetration: 2% of addressable facilities

✅ Comprehensive GTM strategy with detailed launch timeline,
competitive positioning, and channel enablement plan completed
```

## Notes

- **Requirements integration** ensures GTM strategy aligns with project specifications
- **Customer-centric approach** focuses on target segments and buyer personas
- **Multi-channel strategy** provides diversified customer acquisition approach
- **Data-driven metrics** enable performance tracking and optimization
- **Phased launch plan** reduces risk and enables iterative improvement
- **Competitive positioning** addresses market dynamics and differentiation
- **Revenue optimization** includes pricing strategy and unit economics
- **Success measurement** provides clear KPIs and milestone tracking
