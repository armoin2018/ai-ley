# SWOT Analysis Generation Scripts

This directory contains automation scripts for creating and managing SWOT (Strengths, Weaknesses, Opportunities, Threats) analyses.

## Available Scripts

### `generate-swot-analysis.py`

Python script for creating structured SWOT analysis documents and strategy matrices.

**Features:**
- Interactive mode for guided SWOT creation
- Template generation (full, quick, strategy matrix)
- Automatic priority scoring
- Strategy matrix generation (SO/WO/ST/WT)
- Import from PESTEL analysis
- Markdown output for documentation

**Requirements:**
- Python 3.7 or higher
- No external dependencies (uses standard library only)

**Usage Examples:**

**Interactive Mode (Recommended):**
```bash
python generate-swot-analysis.py --interactive
```

This guides you through:
1. Organization and strategic context
2. Adding factors to each quadrant (S/W/O/T)
3. Scoring factors on two dimensions
4. Generating strategic initiatives
5. Creating action plans

**Generate Blank Template:**
```bash
python generate-swot-analysis.py --company "CompanyName" --industry "Industry" --output swot.md
```

**Generate Quick Assessment:**
```bash
python generate-swot-analysis.py --template quick --company "CompanyName" --output quick-swot.md
```

**Generate Strategy Matrix:**
```bash
python generate-swot-analysis.py --template matrix --output swot-matrix.md
```

**Import from PESTEL Analysis:**
```bash
python generate-swot-analysis.py --import-pestel ../pestel/my-pestel.md --output swot.md
```

This imports external factors (opportunities/threats) from a PESTEL analysis.

**Command-Line Options:**

- `--interactive`, `-i`: Launch interactive mode
- `--company`, `-c`: Company/organization name
- `--industry`: Industry sector
- `--scope`: Analysis scope (e.g., "Product launch", "Market expansion")
- `--template {full|quick|matrix}`: Template type (default: full)
- `--import-pestel`: Path to PESTEL analysis file to import O/T factors
- `--output`, `-o`: Output filename (default: swot-analysis.md)

## Report Formats

### Full SWOT Analysis

Comprehensive analysis including:
- Executive summary with top priorities
- Detailed factor analysis for all 4 quadrants
- Scoring methodology (dual-dimension: Importance×Performance or Attractiveness×Probability)
- SWOT strategy matrix (SO, WO, ST, WT)
- Strategic action plan with timelines
- Success metrics and KPIs
- Review schedule

**Best for:** Strategic planning, fundraising, business plans, board presentations

### Quick SWOT Assessment

Condensed table-based format:
- Factor lists with basic scores
- Top 3-5 items per quadrant
- Strategic posture identification
- Immediate action items
- Quick metrics dashboard

**Best for:** Team workshops, rapid assessments, project planning, quarterly reviews

### Strategy Matrix

Focus on strategic option development:
- 2x2 matrix for SO/WO/ST/WT strategies
- Detailed strategy templates for each quadrant
- Resource allocation summaries
- Implementation roadmap
- Governance framework

**Best for:** Strategy workshops, leadership planning sessions, OKR development

## Scoring Methodology

### Internal Factors (Strengths & Weaknesses)

**Dimension 1 - Importance (1-5):**
- 1: Minor relevance to success
- 2: Somewhat relevant
- 3: Moderately important
- 4: Very important
- 5: Critical to competitive success

**Dimension 2 - Performance (1-5):**
- For Strengths: 1=Slight advantage, 5=Dominant advantage
- For Weaknesses: 1=Slight disadvantage, 5=Critical disadvantage

**Priority Score = Importance × Performance = 1 to 25**

### External Factors (Opportunities & Threats)

**Dimension 1 - Attractiveness/Severity (1-5):**
- 1: Minimal impact on business
- 2: Small impact
- 3: Moderate impact
- 4: Large impact
- 5: Transformative opportunity / Critical threat

**Dimension 2 - Probability (1-5):**
- 1: Very unlikely (<20%)
- 2: Unlikely (20-40%)
- 3: Possible (40-60%)
- 4: Likely (60-80%)
- 5: Very likely (>80%)

**Priority Score = Attractiveness/Severity × Probability = 1 to 25**

### Priority Interpretation

- **20-25:** Critical priority requiring immediate strategic attention
- **15-19:** High priority for planning and resource allocation
- **10-14:** Moderate priority to monitor and address as resources allow
- **5-9:** Low priority but track developments
- **1-4:** Minimal priority, periodic review only

## SWOT Strategy Matrix Framework

### SO Strategies (Aggressive Growth)
- Use internal strengths to capitalize on external opportunities
- Growth-oriented, market expansion focus
- Example: "Leverage strong R&D to enter AI automation market"

### WO Strategies (Developmental)
- Overcome internal weaknesses to pursue external opportunities
- Capability-building, improvement focus
- Example: "Hire enterprise sales team to capture Fortune 500 opportunity"

### ST Strategies (Defensive)
- Use internal strengths to mitigate or avoid external threats
- Protective, competitive defense focus
- Example: "Use brand loyalty to defend against new low-cost entrants"

### WT Strategies (Damage Control/Repositioning)
- Minimize internal weaknesses and avoid external threats
- Risk mitigation, strategic repositioning focus
- Example: "Divest underperforming units to reduce exposure to market decline"

## Workflow Examples

### Example 1: Strategic Planning Session

```bash
# Step 1: Generate full template
python generate-swot-analysis.py \
  --company "TechCorp" \
  --industry "SaaS" \
  --scope "2026 Strategic Plan" \
  --output strategic-swot.md

# Step 2: Conduct PESTEL first (optional but recommended)
cd ../pestel
python generate-pestel-analysis.py --interactive
cd ../swot

# Step 3: Import PESTEL results and add internal factors
python generate-swot-analysis.py \
  --import-pestel ../pestel/techcorp-pestel.md \
  --interactive \
  --output strategic-swot-complete.md

# Step 4: Generate strategy matrix for workshop
python generate-swot-analysis.py \
  --template matrix \
  --output strategy-workshop.md
```

### Example 2: Product Launch Decision

```bash
# Quick assessment for go/no-go decision
python generate-swot-analysis.py \
  --template quick \
  --company "NewProduct" \
  --scope "Product Launch Decision" \
  --output product-launch-swot.md

# Fill in factors, review with team
# Make decision based on S/W/O/T balance
```

### Example 3: Quarterly Business Review

```bash
# Update existing SWOT
python generate-swot-analysis.py \
  --company "MyCompany" \
  --template quick \
  --output q1-2026-swot.md

# Compare with previous quarter
diff q4-2025-swot.md q1-2026-swot.md

# Track changes in scores and priorities
```

## Integration with Other Frameworks

### PESTEL → SWOT Integration

PESTEL analysis identifies external factors; SWOT adds internal perspective:

```bash
# 1. Conduct PESTEL analysis
python ../pestel/generate-pestel-analysis.py --interactive

# 2. Import PESTEL to SWOT (auto-maps O/T)
python generate-swot-analysis.py \
  --import-pestel ../pestel/analysis.md \
  --output swot-from-pestel.md

# PESTEL positive factors → SWOT Opportunities
# PESTEL negative factors → SWOT Threats
# Add internal S/W factors manually
```

### SWOT → OKRs

Translate SWOT strategies into objectives:

```python
# SO/WO Strategies → Growth Objectives
# ST/WT Strategies → Risk Mitigation Objectives
# Each strategy becomes an Objective with Key Results
```

### SWOT → Balanced Scorecard

Map strategies to four perspectives:
- Financial: Revenue/cost strategies
- Customer: Market and satisfaction strategies
- Internal Processes: Operational improvement strategies
- Learning & Growth: Capability development strategies

## Tips for Effective SWOT Analysis

**Preparation:**
1. Gather data first (financials, market research, competitive intel)
2. Involve cross-functional stakeholders
3. Review previous SWOT if available
4. Set clear scope and timeframe

**Execution:**
5. Be specific and evidence-based (avoid vague statements)
6. Ensure factors are correctly categorized (internal vs. external)
7. Focus on root causes, not symptoms
8. Prioritize ruthlessly (not everything is critical)
9. Link directly to strategy (every factor should inform decisions)

**Follow-Through:**
10. Develop concrete action plans
11. Assign owners and resources
12. Set review cadence (quarterly minimum)
13. Track progress on strategic initiatives
14. Update SWOT as conditions change

## Common Pitfalls to Avoid

1. **Confusing Internal/External:** Markets are external, capabilities are internal
2. **Being Too Vague:** "Good product" vs. "NPS 68, 98% retention, 4.8/5 rating"
3. **Listing Too Many Factors:** Focus on 5-10 per quadrant, not 30
4. **Ignoring Weaknesses:** Honesty is critical for good strategy
5. **No Prioritization:** Everything can't be top priority
6. **Analysis Paralysis:** Spend 2-4 weeks max, then act
7. **No Action Plan:** SWOT without strategy is academic exercise
8. **One-and-Done:** SWOT should be living document, reviewed quarterly

## Troubleshooting

**Script Issues:**
- Ensure Python 3.7+: `python --version`
- Try `python3` instead of `python`
- Check file permissions for output directory

**Content Issues:**
- **Can't distinguish S from O:** Strengths are internal (you control), Opportunities are external
- **Can't distinguish W from T:** Weaknesses are your gaps, Threats are external forces
- **Too many factors:** Use scoring to identify top priorities, focus on those
- **Duplicate factors:** Consolidate related items into comprehensive statements

**Strategic Issues:**
- **No clear strategies:** Force matching exercise (each S with each O, etc.)
- **Strategies too vague:** Add specific actions, owners, timelines, metrics
- **Can't prioritize strategies:** Score on Impact × Feasibility × Urgency

## Additional Resources

- **SWOT Instructions:** `../swot.instructions.md`
- **Full Template:** `../examples/swot/template-swot-analysis.md`
- **Quick Template:** `../examples/swot/template-quick-swot.md`
- **Strategy Matrix Template:** `../examples/swot/template-swot-matrix.md`
- **SaaS Example:** `../examples/swot/example-saas-company.md`
- **Retail Example:** `../examples/swot/example-retail-expansion.md`
- **Manufacturing Example:** `../examples/swot/example-manufacturing.md`

## Related Frameworks

- **PESTEL Analysis:** External environment analysis (feeds into SWOT O/T)
- **Porter's Five Forces:** Competitive analysis (informs SWOT)
- **Business Model Canvas:** Business model design (uses SWOT insights)
- **Balanced Scorecard:** Strategy execution (implements SWOT strategies)
- **OKRs:** Goal setting (translates SWOT strategies to objectives)

## Support

For questions or issues:
1. Review SWOT instructions documentation
2. Check example files for reference patterns
3. Consult AI-ley agents for analysis assistance:
   - @ailey-entrepreneur for market opportunities
   - @ailey-orchestrator for facilitation guidance
   - @ailey-planner for strategic action planning

---

**Version:** 1.0  
**Last Updated:** 2026-01-12  
**Maintained By:** AI-ley Framework Team
