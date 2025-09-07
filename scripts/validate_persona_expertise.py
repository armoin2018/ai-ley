#!/usr/bin/env python3
"""
Persona Expertise Validation Script

Validates persona industry expertise against 2025 standards including:
- Current technology versions and best practices
- Modern framework adoption and usage patterns
- Industry-specific knowledge depth and accuracy
- Professional certification and skill alignment
- Regulatory compliance and standard adherence
"""

import os
import json
import re
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Tuple

class PersonaExpertiseValidator:
    """Validates persona expertise against current industry standards"""
    
    def __init__(self, personas_dir: str):
        self.personas_dir = Path(personas_dir)
        self.validation_results = {}
        self.industry_standards_2025 = self.load_industry_standards()
    
    def load_industry_standards(self) -> Dict:
        """Load current industry standards and best practices for 2025"""
        return {
            "developer": {
                "technologies": {
                    "javascript": ["Node.js 20+", "React 18+", "TypeScript 5+", "Next.js 14+"],
                    "python": ["Python 3.11+", "FastAPI", "Pydantic 2.0+", "SQLAlchemy 2.0+"],
                    "go": ["Go 1.23+", "Generics", "Fuzzing", "PGO support"],
                    "cloud": ["Kubernetes 1.28+", "Docker", "AWS/GCP/Azure", "Terraform"],
                },
                "practices": ["CI/CD", "DevOps", "Microservices", "Clean Architecture", "TDD"],
                "certifications": ["AWS Certified", "Kubernetes CKA/CKAD", "Azure Certified"]
            },
            "ai": {
                "technologies": {
                    "frameworks": ["PyTorch 2.0+", "TensorFlow 2.14+", "Transformers 4.35+"],
                    "models": ["GPT-4", "LLaMA 2", "Claude", "Gemini", "Mistral"],
                    "tools": ["Weights & Biases", "MLflow", "Kubeflow", "Ray", "DVC"],
                },
                "practices": ["MLOps", "Model Governance", "Ethical AI", "RAG", "Fine-tuning"],
                "regulations": ["AI Act", "GDPR", "CCPA", "Algorithmic Accountability"]
            },
            "security": {
                "frameworks": ["NIST CSF 2.0", "ISO 27001:2022", "OWASP Top 10 2023"],
                "threats": ["Supply Chain", "AI/ML Security", "Cloud Native", "Zero Trust"],
                "tools": ["SIEM", "SOAR", "EDR/XDR", "Cloud Security Posture Management"],
                "certifications": ["CISSP", "CISM", "OSCP", "GCIH", "Cloud Security"]
            },
            "finance": {
                "regulations": ["Basel III", "MiFID II", "GDPR", "PCI DSS"],
                "technologies": ["Blockchain", "DeFi", "CBDCs", "RegTech", "Open Banking"],
                "standards": ["ISO 20022", "FIX Protocol", "SWIFT", "Real-time payments"],
                "practices": ["ESG", "Sustainable Finance", "Digital Assets", "AI/ML Risk"]
            }
        }
    
    def extract_persona_content(self, filepath: Path) -> Dict:
        """Extract structured content from persona markdown file"""
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Extract metadata from frontmatter
        metadata = {}
        if content.startswith('---'):
            parts = content.split('---', 2)
            if len(parts) >= 3:
                frontmatter = parts[1].strip()
                for line in frontmatter.split('\n'):
                    if ':' in line:
                        key, value = line.split(':', 1)
                        metadata[key.strip()] = value.strip().strip('"\'')
        
        # Extract sections
        sections = {}
        current_section = None
        current_content = []
        
        for line in content.split('\n'):
            if line.startswith('## '):
                if current_section:
                    sections[current_section] = '\n'.join(current_content)
                current_section = line[3:].strip()
                current_content = []
            else:
                current_content.append(line)
        
        if current_section:
            sections[current_section] = '\n'.join(current_content)
        
        return {
            'metadata': metadata,
            'sections': sections,
            'filepath': str(filepath)
        }
    
    def validate_technology_currency(self, persona: Dict, category: str) -> Dict:
        """Validate that persona uses current technology versions"""
        tools_section = persona['sections'].get('3. Tools & Capabilities', '')
        validation_results = {
            'current_technologies': [],
            'outdated_technologies': [],
            'missing_technologies': [],
            'score': 0.0
        }
        
        if category in self.industry_standards_2025:
            standards = self.industry_standards_2025[category]['technologies']
            
            for tech_category, current_versions in standards.items():
                for version in current_versions:
                    if version.lower() in tools_section.lower():
                        validation_results['current_technologies'].append(version)
                    else:
                        validation_results['missing_technologies'].append(version)
            
            # Calculate score based on current vs missing technologies
            total = len(validation_results['current_technologies']) + len(validation_results['missing_technologies'])
            if total > 0:
                validation_results['score'] = len(validation_results['current_technologies']) / total * 5.0
        
        return validation_results
    
    def validate_industry_practices(self, persona: Dict, category: str) -> Dict:
        """Validate adherence to current industry best practices"""
        content = ' '.join(persona['sections'].values()).lower()
        validation_results = {
            'implemented_practices': [],
            'missing_practices': [],
            'score': 0.0
        }
        
        if category in self.industry_standards_2025:
            practices = self.industry_standards_2025[category].get('practices', [])
            
            for practice in practices:
                if practice.lower() in content:
                    validation_results['implemented_practices'].append(practice)
                else:
                    validation_results['missing_practices'].append(practice)
            
            # Calculate score
            total = len(practices)
            if total > 0:
                validation_results['score'] = len(validation_results['implemented_practices']) / total * 5.0
        
        return validation_results
    
    def validate_expertise_depth(self, persona: Dict) -> Dict:
        """Validate depth and authenticity of expertise"""
        knowledge_section = persona['sections'].get('4. Knowledge Scope', '')
        capabilities_section = persona['sections'].get('3. Tools & Capabilities', '')
        
        # Count technical terms, specific methodologies, and detailed explanations
        technical_terms = len(re.findall(r'\b[A-Z]{2,}\b', knowledge_section))  # Acronyms
        specific_tools = len(re.findall(r'[a-zA-Z]+\s*\d+[\.\+]', capabilities_section))  # Versioned tools
        detailed_explanations = len(re.findall(r':\s*[^,\n]{50,}', knowledge_section))  # Detailed descriptions
        
        depth_score = min(5.0, (technical_terms + specific_tools + detailed_explanations) / 10 * 5.0)
        
        return {
            'technical_terms': technical_terms,
            'specific_tools': specific_tools,
            'detailed_explanations': detailed_explanations,
            'depth_score': depth_score
        }
    
    def validate_persona(self, filepath: Path) -> Dict:
        """Validate a single persona against industry standards"""
        persona = self.extract_persona_content(filepath)
        
        # Determine category from file path
        category_map = {
            'developer': 'developer',
            'ai': 'ai',
            'security': 'security',
            'finance': 'finance'
        }
        
        category = None
        for cat_name, cat_key in category_map.items():
            if cat_name in str(filepath):
                category = cat_key
                break
        
        if not category:
            category = 'general'
        
        # Perform validations
        tech_validation = self.validate_technology_currency(persona, category)
        practice_validation = self.validate_industry_practices(persona, category)
        depth_validation = self.validate_expertise_depth(persona)
        
        # Calculate overall expertise score
        overall_score = (tech_validation['score'] + practice_validation['score'] + depth_validation['depth_score']) / 3
        
        return {
            'filepath': str(filepath),
            'category': category,
            'persona_name': persona['metadata'].get('title', 'Unknown'),
            'current_score': float(persona['metadata'].get('summaryScore', 0)),
            'technology_validation': tech_validation,
            'practice_validation': practice_validation,
            'depth_validation': depth_validation,
            'overall_expertise_score': overall_score,
            'last_updated': persona['metadata'].get('lastUpdated', 'Unknown'),
            'needs_update': overall_score < 4.0
        }
    
    def validate_all_personas(self) -> Dict:
        """Validate all personas in the directory"""
        results = {
            'validation_date': datetime.now().isoformat(),
            'personas': [],
            'summary': {
                'total_personas': 0,
                'high_quality': 0,  # Score >= 4.0
                'needs_improvement': 0,  # Score < 4.0
                'average_score': 0.0,
                'categories': {}
            }
        }
        
        # Find all persona files
        persona_files = list(self.personas_dir.rglob('*.md'))
        persona_files = [f for f in persona_files if 'psychological-consistency-framework' not in f.name]
        
        for filepath in persona_files:
            try:
                validation_result = self.validate_persona(filepath)
                results['personas'].append(validation_result)
                
                # Update summary statistics
                results['summary']['total_personas'] += 1
                score = validation_result['overall_expertise_score']
                
                if score >= 4.0:
                    results['summary']['high_quality'] += 1
                else:
                    results['summary']['needs_improvement'] += 1
                
                category = validation_result['category']
                if category not in results['summary']['categories']:
                    results['summary']['categories'][category] = {
                        'count': 0,
                        'average_score': 0.0,
                        'high_quality': 0
                    }
                
                cat_stats = results['summary']['categories'][category]
                cat_stats['count'] += 1
                cat_stats['average_score'] = ((cat_stats['average_score'] * (cat_stats['count'] - 1)) + score) / cat_stats['count']
                if score >= 4.0:
                    cat_stats['high_quality'] += 1
                    
            except Exception as e:
                print(f"Error validating {filepath}: {e}")
        
        # Calculate overall average score
        if results['personas']:
            total_score = sum(p['overall_expertise_score'] for p in results['personas'])
            results['summary']['average_score'] = total_score / len(results['personas'])
        
        return results
    
    def generate_report(self, results: Dict) -> str:
        """Generate a comprehensive validation report"""
        report = []
        report.append("# Persona Expertise Validation Report")
        report.append(f"Generated: {results['validation_date']}")
        report.append("")
        
        # Summary statistics
        summary = results['summary']
        report.append("## Executive Summary")
        report.append(f"- **Total Personas**: {summary['total_personas']}")
        report.append(f"- **Average Expertise Score**: {summary['average_score']:.2f}/5.0")
        report.append(f"- **High Quality Personas (≥4.0)**: {summary['high_quality']} ({summary['high_quality']/summary['total_personas']*100:.1f}%)")
        report.append(f"- **Personas Needing Improvement**: {summary['needs_improvement']} ({summary['needs_improvement']/summary['total_personas']*100:.1f}%)")
        report.append("")
        
        # Category breakdown
        report.append("## Category Analysis")
        for category, stats in summary['categories'].items():
            report.append(f"### {category.title()} Category")
            report.append(f"- Count: {stats['count']}")
            report.append(f"- Average Score: {stats['average_score']:.2f}/5.0")
            report.append(f"- High Quality: {stats['high_quality']}/{stats['count']} ({stats['high_quality']/stats['count']*100:.1f}%)")
            report.append("")
        
        # Top performers
        report.append("## Top Performing Personas")
        top_personas = sorted(results['personas'], key=lambda x: x['overall_expertise_score'], reverse=True)[:10]
        for persona in top_personas:
            report.append(f"- **{persona['persona_name']}** ({persona['category']}): {persona['overall_expertise_score']:.2f}/5.0")
        report.append("")
        
        # Personas needing improvement
        report.append("## Personas Requiring Updates")
        low_scoring = [p for p in results['personas'] if p['overall_expertise_score'] < 4.0]
        low_scoring.sort(key=lambda x: x['overall_expertise_score'])
        
        for persona in low_scoring:
            report.append(f"### {persona['persona_name']} ({persona['category']}) - {persona['overall_expertise_score']:.2f}/5.0")
            
            # Technology issues
            if persona['technology_validation']['missing_technologies']:
                report.append("**Missing Current Technologies:**")
                for tech in persona['technology_validation']['missing_technologies'][:5]:
                    report.append(f"- {tech}")
            
            # Practice issues
            if persona['practice_validation']['missing_practices']:
                report.append("**Missing Industry Practices:**")
                for practice in persona['practice_validation']['missing_practices'][:3]:
                    report.append(f"- {practice}")
            
            report.append("")
        
        return "\n".join(report)

def main():
    """Run the persona expertise validation"""
    script_dir = Path(__file__).parent
    personas_dir = script_dir.parent / '.ai-ley' / 'shared' / 'personas'
    
    if not personas_dir.exists():
        print(f"Error: Personas directory not found at {personas_dir}")
        return
    
    print("Starting persona expertise validation...")
    validator = PersonaExpertiseValidator(str(personas_dir))
    
    # Run validation
    results = validator.validate_all_personas()
    
    # Generate report
    report = validator.generate_report(results)
    
    # Save results
    output_dir = script_dir.parent / '.project'
    output_dir.mkdir(exist_ok=True)
    
    # Save JSON results
    json_output = output_dir / 'persona_validation_results.json'
    with open(json_output, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2)
    
    # Save markdown report
    report_output = output_dir / 'PERSONA_VALIDATION_REPORT.md'
    with open(report_output, 'w', encoding='utf-8') as f:
        f.write(report)
    
    print(f"\nValidation complete!")
    print(f"- Results saved to: {json_output}")
    print(f"- Report saved to: {report_output}")
    print(f"- Average expertise score: {results['summary']['average_score']:.2f}/5.0")
    print(f"- Personas needing improvement: {results['summary']['needs_improvement']}")

if __name__ == "__main__":
    main()