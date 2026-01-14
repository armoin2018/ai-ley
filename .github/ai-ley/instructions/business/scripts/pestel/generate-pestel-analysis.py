#!/usr/bin/env python3
"""
PESTEL Analysis Generator Script

This script helps create structured PESTEL analyses by:
1. Generating analysis templates with proper structure
2. Collecting data from various sources
3. Calculating priority scores
4. Creating summary reports

Usage:
    python generate-pestel-analysis.py --company "Company Name" --industry "Industry" --output analysis.md
    python generate-pestel-analysis.py --interactive
    python generate-pestel-analysis.py --template quick
"""

import argparse
import os
from datetime import datetime
from pathlib import Path


class PESTELFactor:
    """Represents a single PESTEL factor"""
    
    def __init__(self, name, category, description=""):
        self.name = name
        self.category = category
        self.description = description
        self.likelihood = 0
        self.impact = 0
        self.trend = "→"  # ⬆️ ➡️ ⬇️
        self.factor_type = "⭐"  # ⭐ Opportunity | ⚠️ Threat
        self.timeframe = "Short-term"
        self.sources = []
        self.implications = []
        self.responses = []
    
    @property
    def priority_score(self):
        return self.likelihood * self.impact
    
    def to_markdown(self):
        """Generate markdown representation"""
        md = f"### Factor: {self.name}\n\n"
        md += f"**Description:** {self.description}\n\n"
        md += f"**Trend Direction:** {self.trend}\n\n"
        
        if self.sources:
            md += "**Evidence/Sources:**\n"
            for source in self.sources:
                md += f"- {source}\n"
            md += "\n"
        
        md += "**Impact Assessment:**\n"
        md += f"- **Likelihood:** {self.likelihood} - {self._likelihood_label()}\n"
        md += f"- **Impact:** {self.impact} - {self._impact_label()}\n"
        md += f"- **Priority Score:** {self.priority_score}\n"
        md += f"- **Type:** {self.factor_type}\n\n"
        
        md += "**Business Implications:**\n"
        if self.implications:
            for impl in self.implications:
                md += f"- {impl}\n"
        else:
            md += "- [To be determined]\n"
        md += f"- Timeframe: {self.timeframe}\n\n"
        
        md += "**Recommended Response:**\n"
        if self.responses:
            for resp in self.responses:
                md += f"- {resp}\n"
        else:
            md += "- [To be determined]\n"
        md += "\n"
        
        return md
    
    def _likelihood_label(self):
        labels = {1: "Very Unlikely", 2: "Unlikely", 3: "Possible", 4: "Likely", 5: "Very Likely"}
        return labels.get(self.likelihood, "Unknown")
    
    def _impact_label(self):
        labels = {1: "Negligible", 2: "Minor", 3: "Moderate", 4: "Major", 5: "Critical"}
        return labels.get(self.impact, "Unknown")


class PESTELAnalysis:
    """Main PESTEL analysis container"""
    
    CATEGORIES = ["Political", "Economic", "Social", "Technological", "Environmental", "Legal"]
    
    def __init__(self, company, industry, markets="", analyst="", purpose=""):
        self.company = company
        self.industry = industry
        self.markets = markets
        self.analyst = analyst
        self.purpose = purpose
        self.date = datetime.now().strftime("%Y-%m-%d")
        self.factors = {cat: [] for cat in self.CATEGORIES}
    
    def add_factor(self, factor):
        """Add a factor to the appropriate category"""
        if factor.category in self.CATEGORIES:
            self.factors[factor.category].append(factor)
        else:
            raise ValueError(f"Invalid category: {factor.category}")
    
    def get_all_factors(self):
        """Get all factors sorted by priority"""
        all_factors = []
        for category in self.CATEGORIES:
            all_factors.extend(self.factors[category])
        return sorted(all_factors, key=lambda f: f.priority_score, reverse=True)
    
    def get_opportunities(self):
        """Get all opportunity factors"""
        return [f for f in self.get_all_factors() if f.factor_type == "⭐"]
    
    def get_threats(self):
        """Get all threat factors"""
        return [f for f in self.get_all_factors() if f.factor_type == "⚠️"]
    
    def generate_report(self, template="full"):
        """Generate full markdown report"""
        if template == "quick":
            return self._generate_quick_report()
        else:
            return self._generate_full_report()
    
    def _generate_full_report(self):
        """Generate comprehensive PESTEL report"""
        md = f"# PESTEL Analysis: {self.company}\n\n"
        md += f"**Organization:** {self.company}\n"
        md += f"**Industry:** {self.industry}\n"
        md += f"**Geographic Focus:** {self.markets}\n"
        md += f"**Analysis Date:** {self.date}\n"
        md += f"**Prepared By:** {self.analyst}\n"
        md += f"**Review Date:** [To be scheduled]\n\n"
        md += "---\n\n"
        
        # Executive Summary
        md += "## Executive Summary\n\n"
        md += f"**Purpose:** {self.purpose}\n\n"
        
        top_factors = self.get_all_factors()[:5]
        md += "**Key Findings:**\n"
        for factor in top_factors:
            md += f"- {factor.factor_type} **{factor.name}** (Score: {factor.priority_score})\n"
        md += "\n"
        
        md += "**Critical Priorities:** [Top 3 factors requiring immediate attention]\n\n"
        md += "---\n\n"
        
        # Analysis by Category
        for category in self.CATEGORIES:
            md += f"## {category} Factors\n\n"
            
            category_factors = self.factors[category]
            if category_factors:
                for factor in sorted(category_factors, key=lambda f: f.priority_score, reverse=True):
                    md += factor.to_markdown()
                
                # Category summary
                opportunities = len([f for f in category_factors if f.factor_type == "⭐"])
                threats = len([f for f in category_factors if f.factor_type == "⚠️"])
                top_factor = max(category_factors, key=lambda f: f.priority_score)
                
                md += f"**{category} Factors Summary:**\n"
                md += f"- Total Opportunities: {opportunities}\n"
                md += f"- Total Threats: {threats}\n"
                md += f"- Highest Priority: {top_factor.name} (Score: {top_factor.priority_score})\n\n"
            else:
                md += "*No factors identified in this category.*\n\n"
            
            md += "---\n\n"
        
        # Consolidated Analysis
        md += "## Consolidated Analysis\n\n"
        md += self._generate_priority_matrix()
        md += self._generate_summary_stats()
        
        # Strategic Implications
        md += "## Strategic Implications\n\n"
        md += "### Key Opportunities\n\n"
        for i, opp in enumerate(self.get_opportunities()[:3], 1):
            md += f"{i}. **{opp.name}** (Priority Score: {opp.priority_score})\n"
            md += f"   - Strategic response: [To be determined]\n"
            md += f"   - Resources needed: [To be determined]\n"
            md += f"   - Expected benefit: [To be determined]\n"
            md += f"   - Timeline: {opp.timeframe}\n\n"
        
        md += "### Critical Threats\n\n"
        for i, threat in enumerate(self.get_threats()[:3], 1):
            md += f"{i}. **{threat.name}** (Priority Score: {threat.priority_score})\n"
            md += f"   - Mitigation strategy: [To be determined]\n"
            md += f"   - Resources needed: [To be determined]\n"
            md += f"   - Risk if unaddressed: [To be determined]\n"
            md += f"   - Timeline: {threat.timeframe}\n\n"
        
        # Recommendations
        md += "---\n\n"
        md += "## Recommendations\n\n"
        md += "### Immediate Actions (0-3 months)\n\n"
        md += "1. [Action item with owner and deadline]\n"
        md += "2. [Action item with owner and deadline]\n"
        md += "3. [Action item with deadline]\n\n"
        
        md += "### Short-Term Initiatives (3-12 months)\n\n"
        md += "1. [Strategic initiative with timeline]\n"
        md += "2. [Strategic initiative with timeline]\n"
        md += "3. [Strategic initiative with timeline]\n\n"
        
        md += "### Long-Term Strategic Priorities (1-3 years)\n\n"
        md += "1. [Strategic direction with milestones]\n"
        md += "2. [Strategic direction with milestones]\n"
        md += "3. [Strategic direction with milestones]\n\n"
        
        # Footer
        md += "---\n\n"
        md += f"**Document Version:** 1.0\n"
        md += f"**Last Updated:** {self.date}\n"
        md += f"**Next Review:** [To be scheduled]\n"
        md += f"**Document Owner:** {self.analyst}\n"
        
        return md
    
    def _generate_quick_report(self):
        """Generate simplified one-page report"""
        md = f"# PESTEL Quick Assessment: {self.company}\n\n"
        md += f"**Industry:** {self.industry} | **Date:** {self.date} | **Analyst:** {self.analyst}\n\n"
        md += "---\n\n"
        
        for category in self.CATEGORIES:
            md += f"## {category[0]} - {category}\n\n"
            md += "| Factor | Impact | Likelihood | Score | Type |\n"
            md += "|--------|--------|------------|-------|------|\n"
            
            if self.factors[category]:
                for factor in sorted(self.factors[category], key=lambda f: f.priority_score, reverse=True):
                    md += f"| {factor.name[:40]} | {factor.impact} | {factor.likelihood} | {factor.priority_score} | {factor.factor_type} |\n"
            else:
                md += "| - | - | - | - | - |\n"
            
            md += "\n"
        
        # Summary
        md += "## Summary\n\n"
        all_factors = self.get_all_factors()
        md += f"**Total Opportunities:** {len(self.get_opportunities())} "
        md += f"**Total Threats:** {len(self.get_threats())}\n\n"
        
        md += "**Top 5 Priorities:**\n\n"
        for i, factor in enumerate(all_factors[:5], 1):
            md += f"{i}. {factor.name} ({factor.category}, Score: {factor.priority_score}) {factor.factor_type}\n"
        
        return md
    
    def _generate_priority_matrix(self):
        """Generate priority matrix table"""
        md = "### Priority Matrix\n\n"
        md += "| Priority | Factor | Category | Score | Type | Timeframe |\n"
        md += "|----------|--------|----------|-------|------|-----------|\\n"
        
        all_factors = self.get_all_factors()[:10]
        for i, factor in enumerate(all_factors, 1):
            cat_abbrev = factor.category[0]  # First letter
            timeframe_abbrev = factor.timeframe[0]  # First letter
            md += f"| {i} | {factor.name[:30]} | {cat_abbrev} | {factor.priority_score} | {factor.factor_type} | {timeframe_abbrev} |\n"
        
        md += "\n**Legend:** P=Political, E=Economic, S=Social, T=Technological, En=Environmental, L=Legal\n\n"
        return md
    
    def _generate_summary_stats(self):
        """Generate summary statistics"""
        md = "### Opportunities vs. Threats Summary\n\n"
        
        opportunities = self.get_opportunities()
        threats = self.get_threats()
        
        opp_score = sum(f.priority_score for f in opportunities)
        threat_score = sum(f.priority_score for f in threats)
        
        md += f"**Total Opportunities:** {len(opportunities)} (Total Score: {opp_score})\n"
        md += f"**Total Threats:** {len(threats)} (Total Score: {threat_score})\n\n"
        
        md += "**By Category:**\n"
        for category in self.CATEGORIES:
            cat_factors = self.factors[category]
            cat_opps = len([f for f in cat_factors if f.factor_type == "⭐"])
            cat_threats = len([f for f in cat_factors if f.factor_type == "⚠️"])
            md += f"- {category}: {cat_opps} opportunities / {cat_threats} threats\n"
        
        md += "\n---\n\n"
        return md


def interactive_mode():
    """Interactive mode for creating PESTEL analysis"""
    print("=" * 60)
    print("PESTEL Analysis Generator - Interactive Mode")
    print("=" * 60)
    print()
    
    # Collect basic info
    company = input("Company/Organization name: ").strip()
    industry = input("Industry: ").strip()
    markets = input("Geographic markets (optional): ").strip()
    analyst = input("Analyst name: ").strip()
    purpose = input("Purpose of this analysis: ").strip()
    
    analysis = PESTELAnalysis(company, industry, markets, analyst, purpose)
    
    print("\n" + "=" * 60)
    print("Now let's add factors. Press Enter with no name to finish a category.")
    print("=" * 60)
    
    for category in PESTELAnalysis.CATEGORIES:
        print(f"\n--- {category.upper()} FACTORS ---")
        
        while True:
            name = input(f"\nFactor name (or Enter to skip to next category): ").strip()
            if not name:
                break
            
            factor = PESTELFactor(name, category)
            
            factor.description = input("Description: ").strip()
            
            while True:
                try:
                    factor.likelihood = int(input("Likelihood (1-5): "))
                    if 1 <= factor.likelihood <= 5:
                        break
                    print("Please enter a number between 1 and 5")
                except ValueError:
                    print("Please enter a valid number")
            
            while True:
                try:
                    factor.impact = int(input("Impact (1-5): "))
                    if 1 <= factor.impact <= 5:
                        break
                    print("Please enter a number between 1 and 5")
                except ValueError:
                    print("Please enter a valid number")
            
            factor_type = input("Type (o=opportunity, t=threat): ").lower().strip()
            factor.factor_type = "⭐" if factor_type == "o" else "⚠️"
            
            trend = input("Trend (u=up, s=stable, d=down): ").lower().strip()
            factor.trend = {"u": "⬆️", "s": "➡️", "d": "⬇️"}.get(trend, "➡️")
            
            factor.timeframe = input("Timeframe (Immediate/Short-term/Long-term): ").strip() or "Short-term"
            
            print(f"\n✓ Added: {name} (Priority Score: {factor.priority_score})")
            
            analysis.add_factor(factor)
    
    # Generate report
    print("\n" + "=" * 60)
    print("Generating report...")
    print("=" * 60)
    
    template = input("\nTemplate type (full/quick) [full]: ").strip().lower() or "full"
    output_file = input("Output filename [pestel-analysis.md]: ").strip() or "pestel-analysis.md"
    
    report = analysis.generate_report(template)
    
    with open(output_file, 'w') as f:
        f.write(report)
    
    print(f"\n✅ Report generated: {output_file}")
    print(f"   Total factors: {len(analysis.get_all_factors())}")
    print(f"   Opportunities: {len(analysis.get_opportunities())}")
    print(f"   Threats: {len(analysis.get_threats())}")
    print()


def template_mode(company, industry, template_type, output):
    """Generate a blank template"""
    analysis = PESTELAnalysis(
        company=company or "[Company Name]",
        industry=industry or "[Industry]",
        markets="[Markets]",
        analyst="[Analyst Name]",
        purpose="[Purpose of Analysis]"
    )
    
    # Add placeholder factors
    for category in PESTELAnalysis.CATEGORIES:
        for i in range(1, 3):
            factor = PESTELFactor(f"[{category} Factor {i}]", category)
            factor.description = "[Description of this factor]"
            factor.likelihood = 3
            factor.impact = 3
            factor.factor_type = "⭐"
            analysis.add_factor(factor)
    
    report = analysis.generate_report(template_type)
    
    with open(output, 'w') as f:
        f.write(report)
    
    print(f"✅ Template generated: {output}")


def main():
    parser = argparse.ArgumentParser(
        description="Generate PESTEL analysis reports",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Interactive mode
  python generate-pestel-analysis.py --interactive
  
  # Generate blank template
  python generate-pestel-analysis.py --company "TechCorp" --industry "SaaS" --output analysis.md
  
  # Generate quick assessment template
  python generate-pestel-analysis.py --template quick --output quick-pestel.md
        """
    )
    
    parser.add_argument('--interactive', '-i', action='store_true',
                        help='Interactive mode for building analysis')
    parser.add_argument('--company', '-c', help='Company/organization name')
    parser.add_argument('--industry', help='Industry sector')
    parser.add_argument('--template', choices=['full', 'quick'], default='full',
                        help='Template type (default: full)')
    parser.add_argument('--output', '-o', default='pestel-analysis.md',
                        help='Output filename (default: pestel-analysis.md)')
    
    args = parser.parse_args()
    
    if args.interactive:
        interactive_mode()
    else:
        template_mode(args.company, args.industry, args.template, args.output)


if __name__ == '__main__':
    main()
