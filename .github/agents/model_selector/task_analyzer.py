"""
Task Analyzer - Analyzes task complexity and characteristics for model selection
"""

import json
import re
from enum import Enum
from typing import Any, Dict, List, Optional


class TaskComplexity(Enum):
    """Task complexity levels for model selection"""
    SIMPLE = "simple"
    MODERATE = "moderate"  
    HIGH = "high"
    EXPERT = "expert"


class TaskStyle(Enum):
    """Task style categories"""
    ANALYTICAL = "analytical"
    CREATIVE = "creative"
    TECHNICAL = "technical"
    DEFAULT = "default"


class TaskAnalyzer:
    """Analyzes task characteristics to determine optimal model selection"""
    
    def __init__(self):
        self.complexity_patterns = {
            TaskComplexity.EXPERT: [
                r'advanced|complex|sophisticated|comprehensive',
                r'multi-step|multi-phase|multi-stage',
                r'analyze.*compare.*evaluate',
                r'architectural|system design|enterprise',
                r'optimization|performance|scalability',
                r'security.*compliance.*governance'
            ],
            TaskComplexity.HIGH: [
                r'analyze|reasoning|logic|step-by-step',
                r'compare|contrast|evaluate|assess',
                r'detailed|thorough|comprehensive',
                r'integration|implementation|deployment',
                r'troubleshoot|debug|diagnose'
            ],
            TaskComplexity.MODERATE: [
                r'review|examine|check|validate',
                r'explain|describe|summarize',
                r'modify|update|enhance|improve',
                r'configure|setup|install'
            ],
            TaskComplexity.SIMPLE: [
                r'list|show|display|get',
                r'simple|basic|quick|easy',
                r'format|convert|transform',
                r'copy|move|rename|delete'
            ]
        }
        
        self.style_patterns = {
            TaskStyle.ANALYTICAL: [
                r'analyze|analysis|examine|investigate',
                r'data|metrics|statistics|report',
                r'research|study|evaluate|assess',
                r'calculate|compute|measure|quantify',
                r'compare|benchmark|performance'
            ],
            TaskStyle.CREATIVE: [
                r'create|generate|design|build',
                r'creative|innovative|brainstorm',
                r'story|narrative|content|writing',
                r'marketing|branding|messaging',
                r'user experience|ui|ux|interface'
            ],
            TaskStyle.TECHNICAL: [
                r'code|programming|development|implement',
                r'technical|engineering|architecture',
                r'deploy|configure|setup|install',
                r'debug|troubleshoot|fix|resolve',
                r'api|database|infrastructure|system'
            ]
        }
    
    def analyze_complexity(self, task_description: str) -> TaskComplexity:
        """
        Analyze task complexity based on keywords and patterns
        
        Args:
            task_description: The task description to analyze
            
        Returns:
            TaskComplexity enum value
        """
        task_lower = task_description.lower()
        
        # Check for explicit complexity indicators
        for complexity, patterns in self.complexity_patterns.items():
            for pattern in patterns:
                if re.search(pattern, task_lower):
                    return complexity
        
        # Fallback: analyze by length and structure
        word_count = len(task_description.split())
        if word_count > 100:
            return TaskComplexity.HIGH
        elif word_count > 50:
            return TaskComplexity.MODERATE
        else:
            return TaskComplexity.SIMPLE
    
    def analyze_style(self, task_description: str) -> TaskStyle:
        """
        Analyze task style based on keywords and patterns
        
        Args:
            task_description: The task description to analyze
            
        Returns:
            TaskStyle enum value
        """
        task_lower = task_description.lower()
        
        style_scores = {}
        
        # Score each style based on pattern matches
        for style, patterns in self.style_patterns.items():
            score = 0
            for pattern in patterns:
                matches = len(re.findall(pattern, task_lower))
                score += matches
            style_scores[style] = score
        
        # Return style with highest score, default if tie or no matches
        if max(style_scores.values()) == 0:
            return TaskStyle.DEFAULT
        
        return max(style_scores, key=style_scores.get)
    
    def extract_model_preference(self, task_description: str) -> Optional[str]:
        """
        Extract explicit model preference from task description
        
        Args:
            task_description: The task description to analyze
            
        Returns:
            Model name if explicitly specified, None otherwise
        """
        model_patterns = {
            r'gpt-4|gpt4|openai.*4': 'gpt-4',
            r'gpt-3\.5|gpt3\.5|openai.*3': 'gpt-3.5-turbo',
            r'claude.*3.*sonnet|claude-3-sonnet': 'claude-3-sonnet',
            r'claude.*3.*haiku|claude-3-haiku': 'claude-3-haiku',
            r'claude.*3.*opus|claude-3-opus': 'claude-3-opus',
            r'gemini.*pro|google.*gemini': 'gemini-pro'
        }
        
        task_lower = task_description.lower()
        
        for pattern, model in model_patterns.items():
            if re.search(pattern, task_lower):
                return model
        
        return None
    
    def analyze_task(self, 
                    task_description: str, 
                    task_metadata: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """
        Comprehensive task analysis for model selection
        
        Args:
            task_description: The task description to analyze
            task_metadata: Optional metadata about the task
            
        Returns:
            Dictionary containing analysis results
        """
        complexity = self.analyze_complexity(task_description)
        style = self.analyze_style(task_description)
        explicit_model = self.extract_model_preference(task_description)
        
        # Additional analysis
        word_count = len(task_description.split())
        has_code_blocks = bool(re.search(r'```|`.*`', task_description))
        has_urls = bool(re.search(r'https?://', task_description))
        has_file_references = bool(re.search(r'\.[a-z]{2,4}(?:\s|$)', task_description))
        
        analysis = {
            'complexity': complexity.value,
            'style': style.value,
            'explicit_model': explicit_model,
            'characteristics': {
                'word_count': word_count,
                'has_code_blocks': has_code_blocks,
                'has_urls': has_urls,
                'has_file_references': has_file_references
            },
            'metadata': task_metadata or {}
        }
        
        return analysis
    
    def get_priority_score(self, analysis: Dict[str, Any]) -> int:
        """
        Calculate priority score for task routing
        
        Args:
            analysis: Task analysis results
            
        Returns:
            Priority score (higher = more important)
        """
        score = 0
        
        # Complexity scoring
        complexity_scores = {
            'simple': 1,
            'moderate': 3,
            'high': 7,
            'expert': 10
        }
        score += complexity_scores.get(analysis['complexity'], 1)
        
        # Style scoring
        style_scores = {
            'analytical': 5,
            'technical': 7,
            'creative': 4,
            'default': 2
        }
        score += style_scores.get(analysis['style'], 2)
        
        # Characteristic bonuses
        chars = analysis['characteristics']
        if chars['has_code_blocks']:
            score += 3
        if chars['has_file_references']:
            score += 2
        if chars['word_count'] > 100:
            score += 2
        
        return score
