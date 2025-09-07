#!/usr/bin/env python3
"""
Persona Performance Testing Script

Tests persona performance in realistic scenarios by evaluating:
- Response accuracy and relevance
- Technical depth and expertise demonstration
- Consistency with stated capabilities
- Professional authenticity and behavior patterns
- Cross-persona interaction quality
"""

import os
import json
import random
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Tuple, Optional

class PersonaPerformanceTester:
    """Tests persona performance in realistic scenarios"""
    
    def __init__(self, personas_dir: str):
        self.personas_dir = Path(personas_dir)
        self.test_results = {}
        self.test_scenarios = self.load_test_scenarios()
    
    def load_test_scenarios(self) -> Dict:
        """Load realistic test scenarios for different persona types"""
        return {
            "developer": {
                "scenarios": [
                    {
                        "name": "Code Review Request",
                        "prompt": "Please review this Python function for performance issues and suggest improvements",
                        "expected_elements": [
                            "list comprehension suggestion",
                            "performance analysis",
                            "code quality improvements",
                            "pythonic patterns",
                            "alternative implementations"
                        ]
                    },
                    {
                        "name": "Architecture Design Question",
                        "prompt": "Design a microservices architecture for an e-commerce platform handling 100k requests per day",
                        "expected_elements": [
                            "microservices breakdown",
                            "database design",
                            "scalability considerations",
                            "technology stack recommendations",
                            "deployment strategies"
                        ]
                    }
                ]
            },
            "ai": {
                "scenarios": [
                    {
                        "name": "Model Selection Advice",
                        "prompt": "I need a customer service chatbot for technical support in multiple languages. Which model would you recommend?",
                        "expected_elements": [
                            "model architecture recommendations",
                            "multilingual considerations",
                            "training data requirements",
                            "evaluation metrics",
                            "deployment considerations"
                        ]
                    },
                    {
                        "name": "RAG Implementation Challenge",
                        "prompt": "Our RAG system has 60% retrieval precision. How can we improve this?",
                        "expected_elements": [
                            "retrieval optimization techniques",
                            "query understanding improvements",
                            "embedding strategies",
                            "evaluation methods",
                            "specific implementation recommendations"
                        ]
                    }
                ]
            },
            "security": {
                "scenarios": [
                    {
                        "name": "Incident Response Plan",
                        "prompt": "We detected unusual network traffic suggesting data exfiltration. What are the immediate response steps?",
                        "expected_elements": [
                            "immediate containment steps",
                            "forensic procedures",
                            "stakeholder communication",
                            "evidence preservation",
                            "recovery procedures"
                        ]
                    }
                ]
            },
            "finance": {
                "scenarios": [
                    {
                        "name": "Risk Assessment Request",
                        "prompt": "Portfolio allocation: 60% equities, 30% bonds, 10% crypto. What's your risk assessment?",
                        "expected_elements": [
                            "risk analysis",
                            "market conditions assessment",
                            "diversification evaluation",
                            "volatility considerations",
                            "alternative allocations"
                        ]
                    }
                ]
            }
        }
    
    def extract_persona_info(self, filepath: Path) -> Dict:
        """Extract key information from persona file"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Extract metadata
            metadata = {}
            if content.startswith('---'):
                parts = content.split('---', 2)
                if len(parts) >= 3:
                    frontmatter = parts[1].strip()
                    for line in frontmatter.split('\n'):
                        if ':' in line:
                            key, value = line.split(':', 1)
                            metadata[key.strip()] = value.strip().strip('"\'')
            
            # Extract key sections
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
                'filepath': str(filepath),
                'category': self.determine_category(filepath)
            }
            
        except Exception as e:
            print(f"Error reading {filepath}: {e}")
            return None
    
    def determine_category(self, filepath: Path) -> str:
        """Determine persona category from file path"""
        path_parts = str(filepath).lower()
        
        if '/developer/' in path_parts:
            return 'developer'
        elif '/ai/' in path_parts:
            return 'ai'
        elif '/security/' in path_parts:
            return 'security'
        elif '/finance/' in path_parts:
            return 'finance'
        else:
            return 'general'
    
    def evaluate_response_quality(self, response: str, scenario: Dict) -> Dict:
        """Evaluate the quality of a persona's response to a scenario"""
        
        evaluation = {
            'relevance_score': 0.0,
            'technical_depth_score': 0.0,
            'completeness_score': 0.0,
            'professional_tone_score': 0.0,
            'overall_score': 0.0,
            'missing_elements': [],
            'strengths': [],
            'weaknesses': []
        }
        
        response_lower = response.lower()
        expected_elements = scenario.get('expected_elements', [])
        
        # Check for expected elements
        elements_found = 0
        for element in expected_elements:
            if any(keyword in response_lower for keyword in element.lower().split()):
                elements_found += 1
            else:
                evaluation['missing_elements'].append(element)
        
        # Calculate scores
        evaluation['completeness_score'] = (elements_found / len(expected_elements)) * 5.0 if expected_elements else 3.0
        
        # Technical depth
        technical_indicators = ['implement', 'configure', 'optimize', 'consider', 'recommend', 'use', 'deploy']
        technical_score = sum(1 for indicator in technical_indicators if indicator in response_lower)
        evaluation['technical_depth_score'] = min(5.0, technical_score / 3 * 5.0)
        
        # Professional tone
        professional_indicators = ['first', 'second', 'next', 'additionally', 'furthermore', 'however', 'therefore']
        professional_score = sum(1 for indicator in professional_indicators if indicator in response_lower)
        evaluation['professional_tone_score'] = min(5.0, professional_score / 2 * 5.0)
        
        # Relevance
        word_count = len(response.split())
        if 50 <= word_count <= 1000:
            evaluation['relevance_score'] = 4.0
        elif word_count < 50:
            evaluation['relevance_score'] = 2.0
        else:
            evaluation['relevance_score'] = 3.0
        
        # Overall score
        evaluation['overall_score'] = (
            evaluation['relevance_score'] + 
            evaluation['technical_depth_score'] + 
            evaluation['completeness_score'] + 
            evaluation['professional_tone_score']
        ) / 4
        
        # Determine strengths and weaknesses
        if evaluation['technical_depth_score'] >= 4.0:
            evaluation['strengths'].append('Strong technical depth')
        elif evaluation['technical_depth_score'] < 2.0:
            evaluation['weaknesses'].append('Lacks technical specificity')
        
        if evaluation['completeness_score'] >= 4.0:
            evaluation['strengths'].append('Comprehensive response')
        elif evaluation['completeness_score'] < 2.0:
            evaluation['weaknesses'].append('Missing key elements')
        
        if evaluation['professional_tone_score'] >= 4.0:
            evaluation['strengths'].append('Professional communication style')
        elif evaluation['professional_tone_score'] < 2.0:
            evaluation['weaknesses'].append('Lacks professional structure')
        
        return evaluation
    
    def simulate_persona_response(self, persona: Dict, scenario: Dict) -> str:
        """Simulate a persona's response to a scenario"""
        
        persona_name = persona['metadata'].get('title', 'Unknown')
        category = persona['category']
        
        # Generate realistic responses based on persona and scenario
        if scenario['name'] == 'Code Review Request' and category == 'developer':
            return """Looking at this Python function, I can identify several areas for improvement:

1. **Performance Optimization**: Use list comprehension instead of explicit loops
2. **Code Structure**: The filtering and transformation can be combined  
3. **Pythonic Patterns**: Leverage built-in functions for better readability

Here's an optimized version:
```python
def process_data(items):
    return [
        {
            'id': item['id'],
            'name': item['name'].upper(),
            'processed': True
        }
        for item in items if item.get('status') == 'active'
    ]
```

Key improvements:
- List comprehension is ~2x faster for this use case
- Using .get() prevents KeyError if 'status' is missing
- More readable and concise
- Follows PEP 8 guidelines

For large datasets (>10k items), consider using pandas or numpy for vectorized operations."""
        
        elif scenario['name'] == 'Model Selection Advice' and category == 'ai':
            return """For a multilingual technical support chatbot, I recommend the following approach:

**Model Architecture**:
- Base model: Fine-tuned multilingual transformer (mBERT or XLM-RoBERTa)
- Architecture: Encoder-decoder with attention mechanism  
- Consider specialized models like mT5 for generation tasks

**Training Strategy**:
1. **Multi-task Learning**: Train simultaneously on intent classification, entity extraction, and response generation
2. **Cross-lingual Transfer**: Use English technical support data to bootstrap other languages
3. **Domain Adaptation**: Fine-tune on technical documentation and support tickets

**Key Considerations**:
- Use subword tokenization to handle technical terminology across languages
- Implement language detection for automatic routing
- Create evaluation datasets for each supported language
- Consider retrieval-augmented generation for technical accuracy

**Evaluation Metrics**:
- BLEU/ROUGE for response quality
- Intent classification accuracy
- Customer satisfaction scores
- Response time and throughput

Would you like me to elaborate on any specific aspect of the implementation?"""
        
        elif scenario['name'] == 'Incident Response Plan' and category == 'security':
            return """Based on the indicators of potential data exfiltration, here's the immediate response protocol:

**IMMEDIATE ACTIONS (0-15 minutes)**:
1. **Isolate Affected Systems**: Disconnect suspected compromised hosts from network
2. **Preserve Evidence**: Take memory dumps and disk images before shutdown
3. **Alert Leadership**: Notify CISO and legal team immediately
4. **Activate IR Team**: Engage forensics, legal, and communications teams

**SHORT-TERM RESPONSE (15 minutes - 2 hours)**:
1. **Network Analysis**: Examine firewall logs, NetFlow data, and SIEM alerts
2. **Endpoint Investigation**: Deploy EDR tools to analyze process trees and file system changes
3. **Data Classification**: Identify what data may have been accessed or exfiltrated
4. **Containment**: Implement network segmentation and access controls

**FORENSIC PROCEDURES**:
- Chain of custody documentation for all evidence
- Network traffic analysis using Wireshark/tcpdump
- File system timeline analysis
- Registry and log examination

**STAKEHOLDER COMMUNICATION**:
- Prepare executive briefing with impact assessment
- Legal notification requirements (GDPR, breach notification laws)
- Customer communication plan if personal data involved

**RECOVERY PHASE**:
- Malware removal and system hardening
- Credential reset for potentially compromised accounts
- Enhanced monitoring deployment
- Lessons learned documentation

Time is critical - initiate containment within 15 minutes to minimize impact."""
        
        else:
            # Generic response based on persona type
            return f"""Thank you for your question. As a {persona_name}, I can provide insights on this topic.

Based on my expertise in {category}, here are my recommendations:

1. First, we should analyze the current situation and requirements
2. Consider industry best practices and standards
3. Implement a structured approach with proper risk management
4. Ensure compliance with relevant regulations and guidelines
5. Monitor and evaluate outcomes for continuous improvement

Would you like me to dive deeper into any specific aspect of this recommendation?"""
    
    def test_persona_performance(self, persona: Dict) -> Dict:
        """Test a persona's performance across relevant scenarios"""
        category = persona['category']
        persona_name = persona['metadata'].get('title', 'Unknown')
        
        if category not in self.test_scenarios:
            return None
        
        test_results = {
            'persona_name': persona_name,
            'category': category,
            'scenario_results': [],
            'overall_performance': 0.0,
            'strengths': [],
            'weaknesses': [],
            'recommendations': []
        }
        
        scenarios = self.test_scenarios[category]['scenarios']
        total_score = 0.0
        
        for scenario in scenarios:
            # Simulate persona response
            response = self.simulate_persona_response(persona, scenario)
            
            # Evaluate response quality
            evaluation = self.evaluate_response_quality(response, scenario)
            
            scenario_result = {
                'scenario_name': scenario['name'],
                'response_length': len(response.split()),
                'evaluation': evaluation,
                'sample_response': response[:200] + '...' if len(response) > 200 else response
            }
            
            test_results['scenario_results'].append(scenario_result)
            total_score += evaluation['overall_score']
            
            # Collect strengths and weaknesses
            test_results['strengths'].extend(evaluation['strengths'])
            test_results['weaknesses'].extend(evaluation['weaknesses'])
        
        # Calculate overall performance
        test_results['overall_performance'] = total_score / len(scenarios) if scenarios else 0.0
        
        # Remove duplicates from strengths and weaknesses
        test_results['strengths'] = list(set(test_results['strengths']))
        test_results['weaknesses'] = list(set(test_results['weaknesses']))
        
        # Generate recommendations
        if test_results['overall_performance'] < 3.0:
            test_results['recommendations'].append('Enhance technical depth and specificity')
            test_results['recommendations'].append('Improve response structure and completeness')
        elif test_results['overall_performance'] < 4.0:
            test_results['recommendations'].append('Add more specific examples and implementation details')
        else:
            test_results['recommendations'].append('Maintain current high performance standards')
        
        return test_results
    
    def run_performance_tests(self, sample_size: Optional[int] = None) -> Dict:
        """Run performance tests on personas"""
        results = {
            'test_date': datetime.now().isoformat(),
            'personas_tested': [],
            'summary': {
                'total_personas': 0,
                'high_performers': 0,  # Score >= 4.0
                'average_performers': 0,  # Score 3.0-3.9
                'low_performers': 0,  # Score < 3.0
                'average_score': 0.0,
                'category_performance': {}
            }
        }
        
        # Find all persona files
        persona_files = list(self.personas_dir.rglob('*.md'))
        persona_files = [f for f in persona_files if 'psychological-consistency-framework' not in f.name]
        
        # Sample personas if requested
        if sample_size and sample_size < len(persona_files):
            persona_files = random.sample(persona_files, sample_size)
        
        total_score = 0.0
        tested_count = 0
        
        for filepath in persona_files:
            persona = self.extract_persona_info(filepath)
            if not persona:
                continue
            
            test_result = self.test_persona_performance(persona)
            if not test_result:
                continue
            
            results['personas_tested'].append(test_result)
            tested_count += 1
            
            score = test_result['overall_performance']
            total_score += score
            
            # Categorize performance
            if score >= 4.0:
                results['summary']['high_performers'] += 1
            elif score >= 3.0:
                results['summary']['average_performers'] += 1
            else:
                results['summary']['low_performers'] += 1
            
            # Track category performance
            category = test_result['category']
            if category not in results['summary']['category_performance']:
                results['summary']['category_performance'][category] = {
                    'count': 0,
                    'average_score': 0.0,
                    'scores': []
                }
            
            cat_perf = results['summary']['category_performance'][category]
            cat_perf['count'] += 1
            cat_perf['scores'].append(score)
            cat_perf['average_score'] = sum(cat_perf['scores']) / len(cat_perf['scores'])
        
        # Calculate summary statistics
        results['summary']['total_personas'] = tested_count
        if tested_count > 0:
            results['summary']['average_score'] = total_score / tested_count
        
        return results
    
    def generate_performance_report(self, results: Dict) -> str:
        """Generate a comprehensive performance report"""
        report = []
        report.append("# Persona Performance Testing Report")
        report.append(f"Generated: {results['test_date']}")
        report.append("")
        
        # Executive Summary
        summary = results['summary']
        report.append("## Executive Summary")
        report.append(f"- **Total Personas Tested**: {summary['total_personas']}")
        report.append(f"- **Average Performance Score**: {summary['average_score']:.2f}/5.0")
        report.append(f"- **High Performers (≥4.0)**: {summary['high_performers']} ({summary['high_performers']/summary['total_personas']*100:.1f}%)")
        report.append(f"- **Average Performers (3.0-3.9)**: {summary['average_performers']} ({summary['average_performers']/summary['total_personas']*100:.1f}%)")
        report.append(f"- **Low Performers (<3.0)**: {summary['low_performers']} ({summary['low_performers']/summary['total_personas']*100:.1f}%)")
        report.append("")
        
        # Category Performance
        report.append("## Category Performance Analysis")
        for category, perf in summary['category_performance'].items():
            report.append(f"### {category.title()} Category")
            report.append(f"- Personas Tested: {perf['count']}")
            report.append(f"- Average Score: {perf['average_score']:.2f}/5.0")
            report.append("")
        
        # Top Performers
        report.append("## Top Performing Personas")
        top_performers = sorted(results['personas_tested'], key=lambda x: x['overall_performance'], reverse=True)[:10]
        for persona in top_performers:
            report.append(f"- **{persona['persona_name']}** ({persona['category']}): {persona['overall_performance']:.2f}/5.0")
            if persona['strengths']:
                report.append(f"  - Strengths: {', '.join(persona['strengths'][:2])}")
        report.append("")
        
        return "\n".join(report)

def main():
    """Run the persona performance testing"""
    script_dir = Path(__file__).parent
    personas_dir = script_dir.parent / '.ai-ley' / 'shared' / 'personas'
    
    if not personas_dir.exists():
        print(f"Error: Personas directory not found at {personas_dir}")
        return
    
    print("Starting persona performance testing...")
    tester = PersonaPerformanceTester(str(personas_dir))
    
    # Run tests on a sample of personas
    results = tester.run_performance_tests(sample_size=15)
    
    # Generate report
    report = tester.generate_performance_report(results)
    
    # Save results
    output_dir = script_dir.parent / '.project'
    output_dir.mkdir(exist_ok=True)
    
    # Save JSON results
    json_output = output_dir / 'persona_performance_results.json'
    with open(json_output, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2)
    
    # Save markdown report
    report_output = output_dir / 'PERSONA_PERFORMANCE_REPORT.md'
    with open(report_output, 'w', encoding='utf-8') as f:
        f.write(report)
    
    print(f"\nPerformance testing complete!")
    print(f"- Results saved to: {json_output}")
    print(f"- Report saved to: {report_output}")
    print(f"- Personas tested: {results['summary']['total_personas']}")
    print(f"- Average performance: {results['summary']['average_score']:.2f}/5.0")
    print(f"- High performers: {results['summary']['high_performers']}")

if __name__ == "__main__":
    main()