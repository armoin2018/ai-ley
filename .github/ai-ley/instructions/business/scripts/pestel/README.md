# PESTEL Analysis Scripts

This directory contains automation scripts for generating PESTEL (Political, Economic, Social, Technological, Environmental, Legal) analyses.

## Available Scripts

### `generate-pestel-analysis.py`

Python script for creating structured PESTEL analysis reports.

**Features:**
- Interactive mode for guided analysis creation
- Template generation for quick starts
- Automatic priority scoring (Likelihood × Impact)
- Full and quick report formats
- Markdown output for documentation

**Requirements:**
- Python 3.7 or higher
- No external dependencies (uses standard library only)

**Usage Examples:**

**Interactive Mode (Recommended for first-time users):**
```bash
python generate-pestel-analysis.py --interactive
```

This will guide you through:
1. Entering organization and industry details
2. Adding factors for each PESTEL category
3. Scoring each factor (likelihood and impact)
4. Classifying factors as opportunities or threats
5. Generating a comprehensive report

**Generate Blank Template:**
```bash
python generate-pestel-analysis.py --company "TechCorp" --industry "SaaS" --output my-analysis.md
```

**Generate Quick Assessment Template:**
```bash
python generate-pestel-analysis.py --template quick --output quick-pestel.md
```

**Command-Line Options:**

- `--interactive`, `-i`: Launch interactive mode for building analysis
- `--company`, `-c`: Company/organization name
- `--industry`: Industry sector
- `--template {full|quick}`: Template type (default: full)
- `--output`, `-o`: Output filename (default: pestel-analysis.md)

## Report Formats

### Full Report

Comprehensive analysis including:
- Executive summary with top 5 priorities
- Detailed factor analysis for all 6 categories
- Priority matrix and consolidated statistics
- Strategic implications and recommendations
- Implementation timeline (Immediate/Short-term/Long-term)
- Monitoring and review framework

**Best for:** Strategic planning, detailed decision-making, stakeholder presentations

### Quick Report

Condensed one-page assessment:
- Table-based factor summary by category
- Priority scores for all factors
- Top 5 priorities list
- Opportunities vs. threats count

**Best for:** Initial assessments, rapid reviews, executive briefings

## Factor Scoring Guide

### Likelihood Scale (1-5)

1. **Very Unlikely** - Less than 10% probability
2. **Unlikely** - 10-30% probability
3. **Possible** - 30-50% probability
4. **Likely** - 50-80% probability
5. **Very Likely** - More than 80% probability

### Impact Scale (1-5)

1. **Negligible** - Minimal effect on operations or strategy
2. **Minor** - Small, manageable impact
3. **Moderate** - Noticeable impact requiring attention
4. **Major** - Significant impact affecting key areas
5. **Critical** - Fundamental impact on business viability

### Priority Score

**Calculation:** Likelihood × Impact = Priority Score (1-25)

**Interpretation:**
- **20-25:** Critical priority requiring immediate action
- **15-19:** High priority for short-term planning
- **10-14:** Moderate priority for monitoring
- **5-9:** Low priority but track developments
- **1-4:** Minimal priority, periodic review

## Workflow Examples

### Example 1: New Market Entry Analysis

```bash
# Step 1: Generate template
python generate-pestel-analysis.py \
  --company "GlobalCorp" \
  --industry "Retail" \
  --output market-entry-pestel.md

# Step 2: Fill in the template with research data
# (Edit market-entry-pestel.md manually or use interactive mode)

# Step 3: Use interactive mode to complete analysis
python generate-pestel-analysis.py --interactive
```

### Example 2: Quick Business Environment Scan

```bash
# Generate quick assessment template
python generate-pestel-analysis.py \
  --template quick \
  --company "TechStartup" \
  --industry "AI/ML" \
  --output quarterly-scan.md

# Complete the tables in the generated file
# Review top priorities
```

### Example 3: Quarterly Review Update

```bash
# Use existing analysis as reference
# Run interactive mode to create updated version
python generate-pestel-analysis.py --interactive

# Compare with previous quarter's analysis
# Track changes in factor scores
```

## Integration with Other Tools

### Using with AI-ley Agents

Reference the PESTEL instruction file when using agents:

```
@ailey-entrepreneur Please analyze market entry using:
- .github/ai-ley/instructions/business/pestel.instructions.md
- Examples: ./examples/pestel/example-tech-startup.md
```

### Combining with Other Frameworks

PESTEL analysis integrates well with:
- **SWOT Analysis**: Convert PESTEL factors to SWOT categories
- **Porter's Five Forces**: Use PESTEL insights for industry analysis
- **Scenario Planning**: PESTEL factors drive scenario development
- **Risk Management**: Threat factors inform risk registers

## Tips for Effective PESTEL Analysis

1. **Start Broad, Then Focus:** Identify many factors initially, then prioritize
2. **Use Evidence:** Support each factor with data sources and citations
3. **Think Timeframes:** Consider when factors will impact the business
4. **Involve Stakeholders:** Get input from different functional areas
5. **Regular Updates:** Review and update quarterly or when major changes occur
6. **Connect to Strategy:** Link findings directly to strategic decisions
7. **Quantify When Possible:** Use numbers for impact and likelihood
8. **Consider Interactions:** Note how factors in different categories relate

## Troubleshooting

**Script won't run:**
- Check Python version: `python --version` (need 3.7+)
- Try `python3` instead of `python`

**Output file issues:**
- Ensure you have write permissions in the output directory
- Check that filename doesn't contain invalid characters

**Missing factors:**
- Use interactive mode to add factors step-by-step
- Edit generated markdown files directly to add more factors

## Additional Resources

- **PESTEL Instructions:** `../pestel.instructions.md`
- **Full Template:** `../examples/pestel/template-pestel-analysis.md`
- **Tech Startup Example:** `../examples/pestel/example-tech-startup.md`
- **Retail Example:** `../examples/pestel/example-retail-expansion.md`
- **Quick Template:** `../examples/pestel/template-quick-pestel.md`

## Support

For issues or questions:
1. Review the PESTEL instructions documentation
2. Check example files for reference
3. Consult AI-ley agent documentation for analysis assistance

---

**Version:** 1.0  
**Last Updated:** 2025-01-10  
**Maintained By:** AI-ley Framework Team
