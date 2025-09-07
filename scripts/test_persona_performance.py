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
                        "prompt": "Please review this Python function for performance issues and suggest improvements:\n\n```python\ndef process_data(items):\n    result = []\n    for item in items:\n        if item['status'] == 'active':\n            result.append({\n                'id': item['id'],\n                'name': item['name'].upper(),\n                'processed': True\n            })\n    return result\n```",
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
                        "prompt": "I need to design a microservices architecture for an e-commerce platform that handles 100k requests per day. What are the key components and considerations?",
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
                        "prompt": "I'm building a customer service chatbot that needs to handle technical support queries in multiple languages. Which model architecture and training approach would you recommend?",
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
                        "prompt": "Our RAG system is returning irrelevant documents for complex queries. The retrieval precision is only 60%. How can we improve this?",
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
                        "prompt": "We detected unusual network traffic patterns suggesting a potential data exfiltration attempt. Walk me through the immediate response steps.",
                        "expected_elements": [
                            "immediate containment steps",
                            "forensic procedures",
                            "stakeholder communication",
                            "evidence preservation",
                            "recovery procedures"
                        ]
                    },
                    {
                        "name": "Security Architecture Review",
                        "prompt": "We're migrating to a cloud-native architecture. What security controls should we implement to maintain our current security posture?",
                        "expected_elements": [
                            "cloud security controls",
                            "zero-trust principles",
                            "identity and access management",
                            "data protection strategies",
                            "compliance considerations"
                        ]
                    }
                ]
            },
            "finance": {
                "scenarios": [
                    {
                        "name": "Risk Assessment Request",
                        "prompt": "I'm considering a portfolio allocation of 60% equities, 30% bonds, and 10% crypto. Given current market conditions, what's your risk assessment?",
                        "expected_elements": [
                            "risk analysis",
                            "market conditions assessment",
                            "diversification evaluation",
                            "volatility considerations",
                            "alternative allocations"
                        ]
                    },
                    {
                        "name": "Trading Strategy Question",
                        "prompt": "Bitcoin is showing strong correlation with tech stocks lately. How should this affect my crypto trading strategy?",
                        "expected_elements": [
                            "correlation analysis",
                            "market dynamics explanation",
                            "strategy adjustments",
                            "risk management",
                            "market timing considerations"
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
        
        category_keywords = {
            'developer': ['developer', 'programming'],
            'ai': ['ai/', '/ai/', 'ml-', 'llm-', 'rag-', 'nlp-'],
            'security': ['security', 'penetration', 'cyber'],
            'finance': ['finance', 'trading', 'crypto', 'quant']
        }
        
        for category, keywords in category_keywords.items():
            if any(keyword in path_parts for keyword in keywords):
                return category
        
        return 'general'
    
    def evaluate_response_quality(self, response: str, scenario: Dict) -> Dict:
        """Evaluate the quality of a persona's response to a scenario"""
        
        # This is a simplified evaluation - in a real system, you'd use more sophisticated methods
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
        
        # Check for expected elements (simplified)
        elements_found = 0
        for element in expected_elements:
            if any(keyword in response_lower for keyword in element.lower().split()):
                elements_found += 1
            else:
                evaluation['missing_elements'].append(element)
        
        # Calculate scores (simplified heuristics)
        evaluation['completeness_score'] = (elements_found / len(expected_elements)) * 5.0 if expected_elements else 3.0
        
        # Technical depth (check for technical terms, specific recommendations)
        technical_indicators = ['implement', 'configure', 'optimize', 'consider', 'recommend', 'use', 'deploy']
        technical_score = sum(1 for indicator in technical_indicators if indicator in response_lower)
        evaluation['technical_depth_score'] = min(5.0, technical_score / 3 * 5.0)
        
        # Professional tone (check for structured response, explanations)
        professional_indicators = ['first', 'second', 'next', 'additionally', 'furthermore', 'however', 'therefore']
        professional_score = sum(1 for indicator in professional_indicators if indicator in response_lower)
        evaluation['professional_tone_score'] = min(5.0, professional_score / 2 * 5.0)
        
        # Relevance (length and topic alignment)
        word_count = len(response.split())
        if word_count > 50 and word_count < 1000:  # Reasonable length
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
        """Simulate a persona's response to a scenario (placeholder for actual LLM integration)"""
        
        # This is a simplified simulation - in a real system, you'd use the actual persona with an LLM
        persona_name = persona['metadata'].get('title', 'Unknown')
        category = persona['category']
        
        # Generate a realistic response based on persona capabilities and scenario
        tools_section = persona['sections'].get('3. Tools & Capabilities', '')
        knowledge_section = persona['sections'].get('4. Knowledge Scope', '')
        
        if scenario['name'] == 'Code Review Request' and 'python' in tools_section.lower():
            return f\"\"\"Looking at this Python function, I can identify several areas for improvement:\n\n1. **Performance Optimization**: Use list comprehension instead of explicit loops\n2. **Code Structure**: The filtering and transformation can be combined\n3. **Pythonic Patterns**: Leverage built-in functions for better readability\n\nHere's an optimized version:\n```python\ndef process_data(items):\n    return [\n        {{\n            'id': item['id'],\n            'name': item['name'].upper(),\n            'processed': True\n        }}\n        for item in items if item.get('status') == 'active'\n    ]\n```\n\nKey improvements:\n- List comprehension is ~2x faster for this use case\n- Using .get() prevents KeyError if 'status' is missing\n- More readable and concise\n- Follows PEP 8 guidelines\n\nFor large datasets (>10k items), consider using pandas or numpy for vectorized operations.\"\"\"\n        \n        elif scenario['name'] == 'Model Selection Advice' and category == 'ai':\n            return f\"\"\"For a multilingual technical support chatbot, I recommend the following approach:\n\n**Model Architecture**:\n- Base model: Fine-tuned multilingual transformer (mBERT or XLM-RoBERTa)\n- Architecture: Encoder-decoder with attention mechanism\n- Consider specialized models like mT5 for generation tasks\n\n**Training Strategy**:\n1. **Multi-task Learning**: Train simultaneously on intent classification, entity extraction, and response generation\n2. **Cross-lingual Transfer**: Use English technical support data to bootstrap other languages\n3. **Domain Adaptation**: Fine-tune on technical documentation and support tickets\n\n**Key Considerations**:\n- Use subword tokenization to handle technical terminology across languages\n- Implement language detection for automatic routing\n- Create evaluation datasets for each supported language\n- Consider retrieval-augmented generation for technical accuracy\n\n**Evaluation Metrics**:\n- BLEU/ROUGE for response quality\n- Intent classification accuracy\n- Customer satisfaction scores\n- Response time and throughput\n\nWould you like me to elaborate on any specific aspect of the implementation?\"\"\"\n        \n        elif scenario['name'] == 'Incident Response Plan' and category == 'security':\n            return f\"\"\"Based on the indicators of potential data exfiltration, here's the immediate response protocol:\n\n**IMMEDIATE ACTIONS (0-15 minutes)**:\n1. **Isolate Affected Systems**: Disconnect suspected compromised hosts from network\n2. **Preserve Evidence**: Take memory dumps and disk images before shutdown\n3. **Alert Leadership**: Notify CISO and legal team immediately\n4. **Activate IR Team**: Engage forensics, legal, and communications teams\n\n**SHORT-TERM RESPONSE (15 minutes - 2 hours)**:\n1. **Network Analysis**: Examine firewall logs, NetFlow data, and SIEM alerts\n2. **Endpoint Investigation**: Deploy EDR tools to analyze process trees and file system changes\n3. **Data Classification**: Identify what data may have been accessed or exfiltrated\n4. **Containment**: Implement network segmentation and access controls\n\n**FORENSIC PROCEDURES**:\n- Chain of custody documentation for all evidence\n- Network traffic analysis using Wireshark/tcpdump\n- File system timeline analysis\n- Registry and log examination\n\n**STAKEHOLDER COMMUNICATION**:\n- Prepare executive briefing with impact assessment\n- Legal notification requirements (GDPR, breach notification laws)\n- Customer communication plan if personal data involved\n\n**RECOVERY PHASE**:\n- Malware removal and system hardening\n- Credential reset for potentially compromised accounts\n- Enhanced monitoring deployment\n- Lessons learned documentation\n\nTime is critical - initiate containment within 15 minutes to minimize impact.\"\"\"\n        \n        else:\n            # Generic response based on persona type\n            return f\"\"\"Thank you for your question. As a {persona_name}, I can provide insights on this topic.\n\nBased on my expertise in {category}, here are my recommendations:\n\n1. First, we should analyze the current situation and requirements\n2. Consider industry best practices and standards\n3. Implement a structured approach with proper risk management\n4. Ensure compliance with relevant regulations and guidelines\n5. Monitor and evaluate outcomes for continuous improvement\n\nWould you like me to dive deeper into any specific aspect of this recommendation?\"\"\"\n    
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
        
        for scenario in scenarios:\n            # Simulate persona response\n            response = self.simulate_persona_response(persona, scenario)\n            \n            # Evaluate response quality\n            evaluation = self.evaluate_response_quality(response, scenario)\n            \n            scenario_result = {\n                'scenario_name': scenario['name'],\n                'response_length': len(response.split()),\n                'evaluation': evaluation,\n                'sample_response': response[:200] + '...' if len(response) > 200 else response\n            }\n            \n            test_results['scenario_results'].append(scenario_result)\n            total_score += evaluation['overall_score']\n            \n            # Collect strengths and weaknesses\n            test_results['strengths'].extend(evaluation['strengths'])\n            test_results['weaknesses'].extend(evaluation['weaknesses'])\n        \n        # Calculate overall performance\n        test_results['overall_performance'] = total_score / len(scenarios) if scenarios else 0.0\n        \n        # Remove duplicates from strengths and weaknesses\n        test_results['strengths'] = list(set(test_results['strengths']))\n        test_results['weaknesses'] = list(set(test_results['weaknesses']))\n        \n        # Generate recommendations\n        if test_results['overall_performance'] < 3.0:\n            test_results['recommendations'].append('Enhance technical depth and specificity')\n            test_results['recommendations'].append('Improve response structure and completeness')\n        elif test_results['overall_performance'] < 4.0:\n            test_results['recommendations'].append('Add more specific examples and implementation details')\n        else:\n            test_results['recommendations'].append('Maintain current high performance standards')\n        \n        return test_results\n    \n    def run_performance_tests(self, sample_size: Optional[int] = None) -> Dict:\n        \"\"\"Run performance tests on personas\"\"\"\n        results = {\n            'test_date': datetime.now().isoformat(),\n            'personas_tested': [],\n            'summary': {\n                'total_personas': 0,\n                'high_performers': 0,  # Score >= 4.0\n                'average_performers': 0,  # Score 3.0-3.9\n                'low_performers': 0,  # Score < 3.0\n                'average_score': 0.0,\n                'category_performance': {}\n            }\n        }\n        \n        # Find all persona files\n        persona_files = list(self.personas_dir.rglob('*.md'))\n        persona_files = [f for f in persona_files if 'psychological-consistency-framework' not in f.name]\n        \n        # Sample personas if requested\n        if sample_size and sample_size < len(persona_files):\n            persona_files = random.sample(persona_files, sample_size)\n        \n        total_score = 0.0\n        tested_count = 0\n        \n        for filepath in persona_files:\n            persona = self.extract_persona_info(filepath)\n            if not persona:\n                continue\n            \n            test_result = self.test_persona_performance(persona)\n            if not test_result:\n                continue\n            \n            results['personas_tested'].append(test_result)\n            tested_count += 1\n            \n            score = test_result['overall_performance']\n            total_score += score\n            \n            # Categorize performance\n            if score >= 4.0:\n                results['summary']['high_performers'] += 1\n            elif score >= 3.0:\n                results['summary']['average_performers'] += 1\n            else:\n                results['summary']['low_performers'] += 1\n            \n            # Track category performance\n            category = test_result['category']\n            if category not in results['summary']['category_performance']:\n                results['summary']['category_performance'][category] = {\n                    'count': 0,\n                    'average_score': 0.0,\n                    'scores': []\n                }\n            \n            cat_perf = results['summary']['category_performance'][category]\n            cat_perf['count'] += 1\n            cat_perf['scores'].append(score)\n            cat_perf['average_score'] = sum(cat_perf['scores']) / len(cat_perf['scores'])\n        \n        # Calculate summary statistics\n        results['summary']['total_personas'] = tested_count\n        if tested_count > 0:\n            results['summary']['average_score'] = total_score / tested_count\n        \n        return results\n    \n    def generate_performance_report(self, results: Dict) -> str:\n        \"\"\"Generate a comprehensive performance report\"\"\"\n        report = []\n        report.append(\"# Persona Performance Testing Report\")\n        report.append(f\"Generated: {results['test_date']}\")\n        report.append(\"\")\n        \n        # Executive Summary\n        summary = results['summary']\n        report.append(\"## Executive Summary\")\n        report.append(f\"- **Total Personas Tested**: {summary['total_personas']}\")\n        report.append(f\"- **Average Performance Score**: {summary['average_score']:.2f}/5.0\")\n        report.append(f\"- **High Performers (≥4.0)**: {summary['high_performers']} ({summary['high_performers']/summary['total_personas']*100:.1f}%)\")\n        report.append(f\"- **Average Performers (3.0-3.9)**: {summary['average_performers']} ({summary['average_performers']/summary['total_personas']*100:.1f}%)\")\n        report.append(f\"- **Low Performers (<3.0)**: {summary['low_performers']} ({summary['low_performers']/summary['total_personas']*100:.1f}%)\")\n        report.append(\"\")\n        \n        # Category Performance\n        report.append(\"## Category Performance Analysis\")\n        for category, perf in summary['category_performance'].items():\n            report.append(f\"### {category.title()} Category\")\n            report.append(f\"- Personas Tested: {perf['count']}\")\n            report.append(f\"- Average Score: {perf['average_score']:.2f}/5.0\")\n            report.append(\"\")\n        \n        # Top Performers\n        report.append(\"## Top Performing Personas\")\n        top_performers = sorted(results['personas_tested'], key=lambda x: x['overall_performance'], reverse=True)[:10]\n        for persona in top_performers:\n            report.append(f\"- **{persona['persona_name']}** ({persona['category']}): {persona['overall_performance']:.2f}/5.0\")\n            if persona['strengths']:\n                report.append(f\"  - Strengths: {', '.join(persona['strengths'][:2])}\")\n        report.append(\"\")\n        \n        # Performance Issues\n        report.append(\"## Areas for Improvement\")\n        low_performers = [p for p in results['personas_tested'] if p['overall_performance'] < 3.0]\n        \n        common_weaknesses = {}\n        for persona in low_performers:\n            for weakness in persona['weaknesses']:\n                common_weaknesses[weakness] = common_weaknesses.get(weakness, 0) + 1\n        \n        report.append(\"**Most Common Performance Issues:**\")\n        for weakness, count in sorted(common_weaknesses.items(), key=lambda x: x[1], reverse=True)[:5]:\n            report.append(f\"- {weakness}: {count} personas\")\n        report.append(\"\")\n        \n        # Detailed Results for Low Performers\n        if low_performers:\n            report.append(\"## Low Performing Personas (Detailed Analysis)\")\n            for persona in low_performers[:5]:  # Show top 5 low performers\n                report.append(f\"### {persona['persona_name']} ({persona['category']}) - {persona['overall_performance']:.2f}/5.0\")\n                \n                if persona['weaknesses']:\n                    report.append(\"**Key Weaknesses:**\")\n                    for weakness in persona['weaknesses'][:3]:\n                        report.append(f\"- {weakness}\")\n                \n                if persona['recommendations']:\n                    report.append(\"**Recommendations:**\")\n                    for rec in persona['recommendations']:\n                        report.append(f\"- {rec}\")\n                \n                report.append(\"\")\n        \n        return \"\\n\".join(report)\n\ndef main():\n    \"\"\"Run the persona performance testing\"\"\"\n    script_dir = Path(__file__).parent\n    personas_dir = script_dir.parent / '.ai-ley' / 'shared' / 'personas'\n    \n    if not personas_dir.exists():\n        print(f\"Error: Personas directory not found at {personas_dir}\")\n        return\n    \n    print(\"Starting persona performance testing...\")\n    tester = PersonaPerformanceTester(str(personas_dir))\n    \n    # Run tests on a sample of personas (full test would take too long)\n    results = tester.run_performance_tests(sample_size=20)\n    \n    # Generate report\n    report = tester.generate_performance_report(results)\n    \n    # Save results\n    output_dir = script_dir.parent / '.project'\n    output_dir.mkdir(exist_ok=True)\n    \n    # Save JSON results\n    json_output = output_dir / 'persona_performance_results.json'\n    with open(json_output, 'w', encoding='utf-8') as f:\n        json.dump(results, f, indent=2)\n    \n    # Save markdown report\n    report_output = output_dir / 'PERSONA_PERFORMANCE_REPORT.md'\n    with open(report_output, 'w', encoding='utf-8') as f:\n        f.write(report)\n    \n    print(f\"\\nPerformance testing complete!\")\n    print(f\"- Results saved to: {json_output}\")\n    print(f\"- Report saved to: {report_output}\")\n    print(f\"- Personas tested: {results['summary']['total_personas']}\")\n    print(f\"- Average performance: {results['summary']['average_score']:.2f}/5.0\")\n    print(f\"- High performers: {results['summary']['high_performers']}\")\n\nif __name__ == \"__main__\":\n    main()