#!/usr/bin/env python3
"""
SWOT Analysis Generator Script

This script helps create structured SWOT analyses by:
1. Generating analysis templates (full, quick, strategy matrix)
2. Collecting and scoring factors across four quadrants
3. Developing strategic initiatives (SO, WO, ST, WT)
4. Creating action plans and tracking frameworks
5. Importing external factors from PESTEL analysis

Usage:
    python generate-swot-analysis.py --interactive
    python generate-swot-analysis.py --company "CompanyName" --industry "Industry" --output swot.md
    python generate-swot-analysis.py --template quick --output quick-swot.md
    python generate-swot-analysis.py --import-pestel ../pestel/analysis.md --output swot.md
"""

import argparse
import os
import re
from datetime import datetime
from pathlib import Path


class SWOTFactor:
    """Represents a single SWOT factor"""
    
    def __init__(self, name, quadrant, description=""):
        self.name = name
        self.quadrant = quadrant  # S, W, O, T
        self.description = description
        self.dimension1 = 0  # Importance or Attractiveness/Severity
        self.dimension2 = 0  # Performance or Probability
        self.trend = "→"  # ⬆️ ➡️ ⬇️
        self.evidence = []
        self.impact = []
        
    @property
    def priority_score(self):
        return self.dimension1 * self.dimension2
    
    @property
    def dimension1_label(self):
        if self.quadrant in ['S', 'W']:
            return "Importance"
        else:
            return "Attractiveness" if self.quadrant == 'O' else "Severity"
    
    @property
    def dimension2_label(self):
        if self.quadrant in ['S', 'W']:
            return "Performance"
        else:
            return "Probability"
    
    def to_markdown_detailed(self):
        """Generate detailed markdown representation"""
        md = f"### Factor: {self.name}\n\n"
        md += f"**Description:** {self.description}\n\n"
        
        if self.evidence:
            md += "**Evidence/Metrics:**\n"
            for ev in self.evidence:
                md += f"- {ev}\n"
            md += "\n"
        
        md += "**Assessment:**\n"
        md += f"- **{self.dimension1_label}:** {self.dimension1}\n"
        md += f"- **{self.dimension2_label}:** {self.dimension2}\n"
        md += f"- **Priority Score:** {self.priority_score}\n"
        md += f"- **Trend:** {self.trend}\n\n"
        
        if self.impact:
            quadrant_label = {
                'S': "Strategic Value:",
                'W': "Business Impact:",
                'O': "Potential Value:",
                'T': "Potential Impact:"
            }
            md += f"**{quadrant_label.get(self.quadrant, 'Impact:')}**\n"
            for imp in self.impact:
                md += f"- {imp}\n"
            md += "\n"
        
        return md
    
    def to_table_row(self):
        """Generate table row for quick format"""
        return f"| {self.name[:40]} | {self.dimension1} | {self.dimension2} | {self.priority_score} | {self.trend} |"


class Strategy:
    """Represents a SWOT strategy (SO, WO, ST, WT)"""
    
    def __init__(self, name, strategy_type, strength_or_weakness="", opportunity_or_threat=""):
        self.name = name
        self.type = strategy_type  # SO, WO, ST, WT
        self.sw_factor = strength_or_weakness
        self.ot_factor = opportunity_or_threat
        self.objective = ""
        self.actions = []
        self.resources = ""
        self.timeline = ""
        self.metrics = []
        self.priority = "Medium"
    
    def to_markdown(self):
        """Generate markdown representation"""
        type_labels = {
            'SO': ('Strength Leveraged', 'Opportunity Pursued'),
            'WO': ('Weakness Addressed', 'Opportunity Enabled'),
            'ST': ('Strength Deployed', 'Threat Mitigated'),
            'WT': ('Weakness Minimized', 'Threat Avoided')
        }
        
        label1, label2 = type_labels.get(self.type, ('Factor 1', 'Factor 2'))
        
        md = f"### Strategy: {self.name}\n\n"
        md += f"**{label1}:** {self.sw_factor}\n"
        md += f"**{label2}:** {self.ot_factor}\n\n"
        
        if self.objective:
            md += f"**Objective:** {self.objective}\n\n"
        
        if self.actions:
            md += "**Key Actions:**\n"
            for action in self.actions:
                md += f"- {action}\n"
            md += "\n"
        
        if self.resources:
            md += f"**Resources Required:** {self.resources}\n\n"
        
        if self.timeline:
            md += f"**Timeline:** {self.timeline}\n\n"
        
        if self.metrics:
            md += "**Success Metrics:**\n"
            for metric in self.metrics:
                md += f"- {metric}\n"
            md += "\n"
        
        md += f"**Priority:** {self.priority}\n\n"
        
        return md


class SWOTAnalysis:
    """Main SWOT analysis container"""
    
    QUADRANTS = {
        'S': 'Strengths',
        'W': 'Weaknesses',
        'O': 'Opportunities',
        'T': 'Threats'
    }
    
    def __init__(self, company, industry, scope="", analyst=""):
        self.company = company
        self.industry = industry
        self.scope = scope
        self.analyst = analyst
        self.date = datetime.now().strftime("%Y-%m-%d")
        self.factors = {q: [] for q in self.QUADRANTS.keys()}
        self.strategies = []
    
    def add_factor(self, factor):
        """Add a factor to the appropriate quadrant"""
        if factor.quadrant in self.QUADRANTS:
            self.factors[factor.quadrant].append(factor)
        else:
            raise ValueError(f"Invalid quadrant: {factor.quadrant}")
    
    def add_strategy(self, strategy):
        """Add a strategic initiative"""
        self.strategies.append(strategy)
    
    def get_top_factors(self, quadrant, n=5):
        """Get top N factors from a quadrant by priority score"""
        return sorted(self.factors[quadrant], key=lambda f: f.priority_score, reverse=True)[:n]
    
    def get_all_sorted(self, quadrant):
        """Get all factors from a quadrant sorted by priority"""
        return sorted(self.factors[quadrant], key=lambda f: f.priority_score, reverse=True)
    
    def generate_full_report(self):
        """Generate comprehensive SWOT report"""
        md = f"# SWOT Analysis: {self.company}\n\n"
        md += f"**Organization:** {self.company}\n"
        md += f"**Industry:** {self.industry}\n"
        md += f"**Analysis Scope:** {self.scope}\n"
        md += f"**Analysis Date:** {self.date}\n"
        md += f"**Prepared By:** {self.analyst}\n"
        md += f"**Review Date:** [To be scheduled]\n\n"
        md += "---\n\n"
        
        # Executive Summary
        md += "## Executive Summary\n\n"
        md += f"**Purpose:** {self.scope}\n\n"
        
        md += "**Key Findings:**\n\n"
        for quadrant, label in self.QUADRANTS.items():
            md += f"**Top {label}:**\n"
            for i, factor in enumerate(self.get_top_factors(quadrant, 3), 1):
                md += f"{i}. {factor.name} (Score: {factor.priority_score})\n"
            md += "\n"
        
        md += "---\n\n"
        
        # Each Quadrant
        for quadrant, label in self.QUADRANTS.items():
            md += f"## {label.upper()} ({'Internal Positive' if quadrant == 'S' else 'Internal Negative' if quadrant == 'W' else 'External Positive' if quadrant == 'O' else 'External Negative'})\n\n"
            
            factors = self.get_all_sorted(quadrant)
            if factors:
                for factor in factors:
                    md += factor.to_markdown_detailed()
                    md += "---\n\n"
                
                # Quadrant summary
                avg_score = sum(f.priority_score for f in factors) / len(factors)
                critical = len([f for f in factors if f.priority_score >= 20])
                
                md += f"**{label} Summary:**\n"
                md += f"- Total {label} Identified: {len(factors)}\n"
                md += f"- Average Priority Score: {avg_score:.1f}\n"
                md += f"- Critical {label} (Score 20-25): {critical}\n\n"
            else:
                md += f"*No {label.lower()} identified.*\n\n"
            
            md += "---\n\n"
        
        # SWOT Strategy Matrix
        md += "## SWOT Strategy Matrix\n\n"
        
        strategy_types = {
            'SO': 'Strength-Opportunity (Aggressive Growth)',
            'WO': 'Weakness-Opportunity (Developmental)',
            'ST': 'Strength-Threat (Defensive)',
            'WT': 'Weakness-Threat (Damage Control)'
        }
        
        for stype, label in strategy_types.items():
            md += f"### {label}\n\n"
            type_strategies = [s for s in self.strategies if s.type == stype]
            
            if type_strategies:
                for strategy in type_strategies:
                    md += strategy.to_markdown()
                    md += "---\n\n"
            else:
                md += "*No strategies developed for this quadrant.*\n\n"
        
        # Footer
        md += "---\n\n"
        md += f"**Document Version:** 1.0\n"
        md += f"**Last Updated:** {self.date}\n"
        md += f"**Next Review:** [To be scheduled]\n"
        md += f"**Document Owner:** {self.analyst}\n"
        
        return md
    
    def generate_quick_report(self):
        """Generate simplified one-page report"""
        md = f"# SWOT Quick Assessment: {self.company}\n\n"
        md += f"**Industry:** {self.industry} | **Date:** {self.date} | **Analyst:** {self.analyst}\n\n"
        md += f"**Purpose:** {self.scope}\n\n"
        md += "---\n\n"
        
        # Each quadrant as table
        for quadrant, label in self.QUADRANTS.items():
            dim1_label = "Importance" if quadrant in ['S', 'W'] else "Attractiveness/Severity"
            dim2_label = "Performance" if quadrant in ['S', 'W'] else "Probability"
            
            md += f"## {label.upper()} ({'Internal +' if quadrant == 'S' else 'Internal -' if quadrant == 'W' else 'External +' if quadrant == 'O' else 'External -'})\n\n"
            md += f"| Factor | {dim1_label} (1-5) | {dim2_label} (1-5) | Score | Trend |\n"
            md += "|--------|-------------------|------------------|-------|-------|\n"
            
            factors = self.get_all_sorted(quadrant)
            if factors:
                for factor in factors:
                    md += factor.to_table_row() + "\n"
            else:
                md += "| - | - | - | - | - |\n"
            
            md += "\n"
            
            # Top 3
            top3 = self.get_top_factors(quadrant, 3)
            if top3:
                md += f"**Top 3 {label}:**\n"
                for i, factor in enumerate(top3, 1):
                    md += f"{i}. **{factor.name}** (Score: {factor.priority_score})\n"
                md += "\n"
            
            md += "---\n\n"
        
        # Summary
        md += "## Summary\n\n"
        
        s_total = sum(f.priority_score for f in self.factors['S'])
        w_total = sum(f.priority_score for f in self.factors['W'])
        o_total = sum(f.priority_score for f in self.factors['O'])
        t_total = sum(f.priority_score for f in self.factors['T'])
        
        md += f"**Internal Position:** Strengths {s_total} vs Weaknesses {w_total} (Net: {s_total - w_total:+d})\n\n"
        md += f"**External Position:** Opportunities {o_total} vs Threats {t_total} (Net: {o_total - t_total:+d})\n\n"
        
        # Strategic posture
        md += "**Strategic Posture:**\n"
        if s_total > w_total and o_total > t_total:
            md += "- [X] **Aggressive Growth** (Strong internal + favorable external)\n"
        elif s_total < w_total and o_total > t_total:
            md += "- [X] **Turnaround Required** (Weak internal + favorable external)\n"
        elif s_total > w_total and o_total < t_total:
            md += "- [X] **Defensive Strategy** (Strong internal + challenging external)\n"
        else:
            md += "- [X] **Survival Mode** (Weak internal + challenging external)\n"
        
        md += "\n---\n\n"
        md += f"**Next Review:** [Date]\n"
        
        return md
    
    def generate_strategy_matrix(self):
        """Generate strategy-focused matrix template"""
        md = f"# SWOT Strategy Matrix: {self.company}\n\n"
        md += f"**Strategic Context:** {self.scope}\n"
        md += f"**Date:** {self.date}\n\n"
        md += "---\n\n"
        
        md += "## Strategy Development Framework\n\n"
        md += "```\n"
        md += "                OPPORTUNITIES              THREATS\n"
        md += "STRENGTHS   |   SO Strategies      |   ST Strategies      |\n"
        md += "            |   (Aggressive)       |   (Defensive)        |\n"
        md += "            |                      |                      |\n"
        md += "WEAKNESSES  |   WO Strategies      |   WT Strategies      |\n"
        md += "            |   (Developmental)    |   (Damage Control)   |\n"
        md += "```\n\n"
        md += "---\n\n"
        
        # Strategy templates for each quadrant
        strategy_types = {
            'SO': ('Strength-Opportunity', 'Use strengths to capitalize on opportunities'),
            'WO': ('Weakness-Opportunity', 'Overcome weaknesses to pursue opportunities'),
            'ST': ('Strength-Threat', 'Use strengths to mitigate or avoid threats'),
            'WT': ('Weakness-Threat', 'Minimize weaknesses and avoid threats')
        }
        
        for stype, (label, desc) in strategy_types.items():
            md += f"## {label} Strategies\n\n"
            md += f"**Objective:** {desc}\n\n"
            
            type_strategies = [s for s in self.strategies if s.type == stype]
            if type_strategies:
                for strategy in type_strategies:
                    md += strategy.to_markdown()
            else:
                md += "### Strategy Template\n\n"
                md += "**Factor 1:** [Strength or Weakness]\n"
                md += "**Factor 2:** [Opportunity or Threat]\n"
                md += "**Objective:** [Specific goal]\n"
                md += "**Key Actions:**\n"
                md += "- [Action 1]\n"
                md += "- [Action 2]\n"
                md += "- [Action 3]\n\n"
            
            md += "---\n\n"
        
        return md


def import_from_pestel(pestel_file):
    """Import opportunities and threats from PESTEL analysis"""
    opportunities = []
    threats = []
    
    try:
        with open(pestel_file, 'r') as f:
            content = f.read()
        
        # Simple regex to find factors marked as opportunities (⭐) or threats (⚠️)
        # This is a basic implementation - could be enhanced
        
        factor_pattern = r'### Factor: (.+?)\n.+?Type:\*\* (.+?)[\n⭐⚠️]'
        matches = re.findall(factor_pattern, content, re.DOTALL)
        
        for name, factor_type in matches:
            if '⭐' in factor_type or 'Opportunity' in factor_type:
                opportunities.append(name.strip())
            elif '⚠️' in factor_type or 'Threat' in factor_type:
                threats.append(name.strip())
        
        print(f"Imported from PESTEL: {len(opportunities)} opportunities, {len(threats)} threats")
        return opportunities, threats
        
    except Exception as e:
        print(f"Warning: Could not import from PESTEL file: {e}")
        return [], []


def interactive_mode(import_pestel_file=None):
    """Interactive mode for creating SWOT analysis"""
    print("=" * 60)
    print("SWOT Analysis Generator - Interactive Mode")
    print("=" * 60)
    print()
    
    # Collect basic info
    company = input("Company/Organization name: ").strip()
    industry = input("Industry: ").strip()
    scope = input("Analysis scope (e.g., '2026 Strategic Plan'): ").strip()
    analyst = input("Analyst name: ").strip()
    
    analysis = SWOTAnalysis(company, industry, scope, analyst)
    
    # Import from PESTEL if provided
    imported_opps = []
    imported_threats = []
    if import_pestel_file:
        imported_opps, imported_threats = import_from_pestel(import_pestel_file)
    
    print("\n" + "=" * 60)
    print("Now let's add factors to each quadrant.")
    print("For each factor, press Enter with no name to move to next quadrant.")
    print("=" * 60)
    
    for quadrant, label in SWOTAnalysis.QUADRANTS.items():
        print(f"\n--- {label.upper()} ---")
        
        # Pre-populate from PESTEL
        if quadrant == 'O' and imported_opps:
            print(f"\nImported {len(imported_opps)} opportunities from PESTEL:")
            for opp in imported_opps:
                print(f"  - {opp}")
            use_imports = input("\nInclude these in analysis? (y/n): ").lower() == 'y'
            if use_imports:
                for opp in imported_opps:
                    factor = SWOTFactor(opp, quadrant)
                    factor.description = "Imported from PESTEL analysis"
                    factor.dimension1 = 3  # Default moderate scores
                    factor.dimension2 = 3
                    analysis.add_factor(factor)
        
        if quadrant == 'T' and imported_threats:
            print(f"\nImported {len(imported_threats)} threats from PESTEL:")
            for threat in imported_threats:
                print(f"  - {threat}")
            use_imports = input("\nInclude these in analysis? (y/n): ").lower() == 'y'
            if use_imports:
                for threat in imported_threats:
                    factor = SWOTFactor(threat, quadrant)
                    factor.description = "Imported from PESTEL analysis"
                    factor.dimension1 = 3
                    factor.dimension2 = 3
                    analysis.add_factor(factor)
        
        # Add custom factors
        while True:
            name = input(f"\nFactor name (or Enter to skip to next quadrant): ").strip()
            if not name:
                break
            
            factor = SWOTFactor(name, quadrant)
            factor.description = input("Description: ").strip()
            
            # Dimension 1
            dim1_label = factor.dimension1_label
            while True:
                try:
                    factor.dimension1 = int(input(f"{dim1_label} (1-5): "))
                    if 1 <= factor.dimension1 <= 5:
                        break
                    print("Please enter a number between 1 and 5")
                except ValueError:
                    print("Please enter a valid number")
            
            # Dimension 2
            dim2_label = factor.dimension2_label
            while True:
                try:
                    factor.dimension2 = int(input(f"{dim2_label} (1-5): "))
                    if 1 <= factor.dimension2 <= 5:
                        break
                    print("Please enter a number between 1 and 5")
                except ValueError:
                    print("Please enter a valid number")
            
            print(f"\n✓ Added: {name} (Priority Score: {factor.priority_score})")
            analysis.add_factor(factor)
    
    # Generate report
    print("\n" + "=" * 60)
    print("Generating report...")
    print("=" * 60)
    
    template = input("\nTemplate type (full/quick/matrix) [full]: ").strip().lower() or "full"
    output_file = input("Output filename [swot-analysis.md]: ").strip() or "swot-analysis.md"
    
    if template == "quick":
        report = analysis.generate_quick_report()
    elif template == "matrix":
        report = analysis.generate_strategy_matrix()
    else:
        report = analysis.generate_full_report()
    
    with open(output_file, 'w') as f:
        f.write(report)
    
    # Summary
    total_factors = sum(len(analysis.factors[q]) for q in analysis.QUADRANTS.keys())
    print(f"\n✅ SWOT Analysis generated: {output_file}")
    print(f"   Total factors: {total_factors}")
    for quadrant, label in analysis.QUADRANTS.items():
        print(f"   {label}: {len(analysis.factors[quadrant])}")
    print()


def template_mode(company, industry, scope, template_type, output):
    """Generate a blank template"""
    analysis = SWOTAnalysis(
        company=company or "[Company Name]",
        industry=industry or "[Industry]",
        scope=scope or "[Analysis Scope]",
        analyst="[Analyst Name]"
    )
    
    # Add placeholder factors
    placeholders = {
        'S': "Strong [capability/resource]",
        'W': "[Gap/limitation] needs improvement",
        'O': "[Market/trend] opportunity",
        'T': "[Competitive/market] threat"
    }
    
    for quadrant, template in placeholders.items():
        for i in range(1, 4):
            factor = SWOTFactor(f"{template} {i}", quadrant)
            factor.description = "[Describe this factor]"
            factor.dimension1 = 3
            factor.dimension2 = 3
            analysis.add_factor(factor)
    
    if template_type == "quick":
        report = analysis.generate_quick_report()
    elif template_type == "matrix":
        report = analysis.generate_strategy_matrix()
    else:
        report = analysis.generate_full_report()
    
    with open(output, 'w') as f:
        f.write(report)
    
    print(f"✅ Template generated: {output}")


def main():
    parser = argparse.ArgumentParser(
        description="Generate SWOT analysis reports",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Interactive mode
  python generate-swot-analysis.py --interactive
  
  # Generate blank template
  python generate-swot-analysis.py --company "TechCorp" --industry "SaaS" --output swot.md
  
  # Generate quick assessment
  python generate-swot-analysis.py --template quick --output quick-swot.md
  
  # Import from PESTEL
  python generate-swot-analysis.py --import-pestel ../pestel/analysis.md --interactive
        """
    )
    
    parser.add_argument('--interactive', '-i', action='store_true',
                        help='Interactive mode for building analysis')
    parser.add_argument('--company', '-c', help='Company/organization name')
    parser.add_argument('--industry', help='Industry sector')
    parser.add_argument('--scope', help='Analysis scope/context')
    parser.add_argument('--template', choices=['full', 'quick', 'matrix'], default='full',
                        help='Template type (default: full)')
    parser.add_argument('--import-pestel', help='Path to PESTEL analysis to import O/T factors')
    parser.add_argument('--output', '-o', default='swot-analysis.md',
                        help='Output filename (default: swot-analysis.md)')
    
    args = parser.parse_args()
    
    if args.interactive:
        interactive_mode(args.import_pestel)
    else:
        template_mode(args.company, args.industry, args.scope, args.template, args.output)


if __name__ == '__main__':
    main()
