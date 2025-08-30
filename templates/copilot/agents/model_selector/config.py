"""
Model Selector Configuration
Centralized configuration for model selection system
"""

import os
from typing import Any, Dict, List


class ModelSelectorConfig:
    """Configuration management for model selector"""
    
    def __init__(self, config_file: str = None):
        self.config_file = config_file
        self.config = self._load_default_config()
        if config_file and os.path.exists(config_file):
            self._load_from_file(config_file)
    
    def _load_default_config(self) -> Dict[str, Any]:
        """Load default configuration"""
        return {
            'models': {
                'gpt-4': {
                    'provider': 'openai',
                    'temperature': 0.3,
                    'max_tokens': 8192,
                    'cost_per_token': 0.03,
                    'capabilities': ['reasoning', 'analysis', 'code', 'complex_tasks'],
                    'api_endpoint': 'https://api.openai.com/v1/chat/completions',
                    'enabled': True
                },
                'gpt-3.5-turbo': {
                    'provider': 'openai',
                    'temperature': 0.5,
                    'max_tokens': 4096,
                    'cost_per_token': 0.002,
                    'capabilities': ['general', 'fast', 'cost_effective'],
                    'api_endpoint': 'https://api.openai.com/v1/chat/completions',
                    'enabled': True
                },
                'claude-3-opus': {
                    'provider': 'anthropic',
                    'temperature': 0.3,
                    'max_tokens': 4096,
                    'cost_per_token': 0.015,
                    'capabilities': ['reasoning', 'analysis', 'creative', 'expert'],
                    'api_endpoint': 'https://api.anthropic.com/v1/messages',
                    'enabled': True
                },
                'claude-3-sonnet': {
                    'provider': 'anthropic',
                    'temperature': 0.7,
                    'max_tokens': 4096,
                    'cost_per_token': 0.003,
                    'capabilities': ['creative', 'balanced', 'reasoning'],
                    'api_endpoint': 'https://api.anthropic.com/v1/messages',
                    'enabled': True
                },
                'claude-3-haiku': {
                    'provider': 'anthropic',
                    'temperature': 0.5,
                    'max_tokens': 4096,
                    'cost_per_token': 0.00025,
                    'capabilities': ['fast', 'cost_effective', 'simple_tasks'],
                    'api_endpoint': 'https://api.anthropic.com/v1/messages',
                    'enabled': True
                },
                'gemini-pro': {
                    'provider': 'google',
                    'temperature': 0.4,
                    'max_tokens': 4096,
                    'cost_per_token': 0.001,
                    'capabilities': ['multimodal', 'reasoning', 'analysis'],
                    'api_endpoint': 'https://generativelanguage.googleapis.com/v1/models',
                    'enabled': True
                }
            },
            'routing_rules': {
                'expert': {
                    'analytical': 'claude-3-opus',
                    'creative': 'claude-3-opus',
                    'technical': 'gpt-4',
                    'default': 'gpt-4'
                },
                'high': {
                    'analytical': 'gpt-4',
                    'creative': 'claude-3-sonnet',
                    'technical': 'gpt-4',
                    'default': 'gpt-4'
                },
                'moderate': {
                    'analytical': 'claude-3-sonnet',
                    'creative': 'claude-3-sonnet',
                    'technical': 'gpt-3.5-turbo',
                    'default': 'gpt-3.5-turbo'
                },
                'simple': {
                    'analytical': 'gpt-3.5-turbo',
                    'creative': 'claude-3-haiku',
                    'technical': 'gpt-3.5-turbo',
                    'default': 'claude-3-haiku'
                }
            },
            'analysis_patterns': {
                'complexity': {
                    'expert': [
                        'advanced', 'complex', 'sophisticated', 'comprehensive',
                        'multi-step', 'multi-phase', 'multi-stage',
                        'analyze.*compare.*evaluate',
                        'architectural', 'system design', 'enterprise',
                        'optimization', 'performance', 'scalability',
                        'security.*compliance.*governance'
                    ],
                    'high': [
                        'analyze', 'reasoning', 'logic', 'step-by-step',
                        'compare', 'contrast', 'evaluate', 'assess',
                        'detailed', 'thorough', 'comprehensive',
                        'integration', 'implementation', 'deployment',
                        'troubleshoot', 'debug', 'diagnose'
                    ],
                    'moderate': [
                        'review', 'examine', 'check', 'validate',
                        'explain', 'describe', 'summarize',
                        'modify', 'update', 'enhance', 'improve',
                        'configure', 'setup', 'install'
                    ],
                    'simple': [
                        'list', 'show', 'display', 'get',
                        'simple', 'basic', 'quick', 'easy',
                        'format', 'convert', 'transform',
                        'copy', 'move', 'rename', 'delete'
                    ]
                },
                'style': {
                    'analytical': [
                        'analyze', 'analysis', 'examine', 'investigate',
                        'data', 'metrics', 'statistics', 'report',
                        'research', 'study', 'evaluate', 'assess',
                        'calculate', 'compute', 'measure', 'quantify',
                        'compare', 'benchmark', 'performance'
                    ],
                    'creative': [
                        'create', 'generate', 'design', 'build',
                        'creative', 'innovative', 'brainstorm',
                        'story', 'narrative', 'content', 'writing',
                        'marketing', 'branding', 'messaging',
                        'user experience', 'ui', 'ux', 'interface'
                    ],
                    'technical': [
                        'code', 'programming', 'development', 'implement',
                        'technical', 'engineering', 'architecture',
                        'deploy', 'configure', 'setup', 'install',
                        'debug', 'troubleshoot', 'fix', 'resolve',
                        'api', 'database', 'infrastructure', 'system'
                    ]
                },
                'model_preferences': {
                    'gpt-4': ['gpt-4', 'gpt4', 'openai.*4'],
                    'gpt-3.5-turbo': ['gpt-3.5', 'gpt3.5', 'openai.*3'],
                    'claude-3-sonnet': ['claude.*3.*sonnet', 'claude-3-sonnet'],
                    'claude-3-haiku': ['claude.*3.*haiku', 'claude-3-haiku'],
                    'claude-3-opus': ['claude.*3.*opus', 'claude-3-opus'],
                    'gemini-pro': ['gemini.*pro', 'google.*gemini']
                }
            },
            'execution_settings': {
                'default_timeout': 60,
                'max_retries': 3,
                'retry_delay': 1.0,
                'max_concurrent_tasks': 5,
                'cost_tracking_enabled': True,
                'history_retention_days': 30
            },
            'cost_constraints': {
                'daily_budget_limit': 100.0,
                'per_task_limit': 5.0,
                'warning_threshold': 0.8
            },
            'logging': {
                'enabled': True,
                'level': 'INFO',
                'file_path': './logs/model_selector.log',
                'include_task_content': False,
                'include_model_responses': False
            }
        }
    
    def _load_from_file(self, config_file: str):
        """Load configuration from file"""
        import json
        try:
            with open(config_file, 'r') as f:
                file_config = json.load(f)
                self._merge_config(file_config)
        except Exception as e:
            print(f"Warning: Could not load config file {config_file}: {e}")
    
    def _merge_config(self, new_config: Dict[str, Any]):
        """Merge new configuration with existing"""
        def deep_merge(base: dict, update: dict):
            for key, value in update.items():
                if key in base and isinstance(base[key], dict) and isinstance(value, dict):
                    deep_merge(base[key], value)
                else:
                    base[key] = value
        
        deep_merge(self.config, new_config)
    
    def get_model_config(self, model_name: str) -> Dict[str, Any]:
        """Get configuration for specific model"""
        return self.config['models'].get(model_name, {})
    
    def get_routing_rules(self) -> Dict[str, Dict[str, str]]:
        """Get routing rules"""
        return self.config['routing_rules']
    
    def get_analysis_patterns(self) -> Dict[str, Dict[str, List[str]]]:
        """Get analysis patterns"""
        return self.config['analysis_patterns']
    
    def get_execution_settings(self) -> Dict[str, Any]:
        """Get execution settings"""
        return self.config['execution_settings']
    
    def get_cost_constraints(self) -> Dict[str, float]:
        """Get cost constraints"""
        return self.config['cost_constraints']
    
    def get_logging_config(self) -> Dict[str, Any]:
        """Get logging configuration"""
        return self.config['logging']
    
    def is_model_enabled(self, model_name: str) -> bool:
        """Check if model is enabled"""
        model_config = self.get_model_config(model_name)
        return model_config.get('enabled', False)
    
    def get_enabled_models(self) -> List[str]:
        """Get list of enabled models"""
        return [name for name, config in self.config['models'].items() 
                if config.get('enabled', False)]
    
    def update_model_config(self, model_name: str, config_updates: Dict[str, Any]):
        """Update configuration for specific model"""
        if model_name not in self.config['models']:
            self.config['models'][model_name] = {}
        self.config['models'][model_name].update(config_updates)
    
    def update_routing_rule(self, complexity: str, style: str, model: str):
        """Update routing rule"""
        if complexity not in self.config['routing_rules']:
            self.config['routing_rules'][complexity] = {}
        self.config['routing_rules'][complexity][style] = model
    
    def save_config(self, file_path: str = None):
        """Save current configuration to file"""
        import json
        save_path = file_path or self.config_file or './model_selector_config.json'
        
        try:
            with open(save_path, 'w') as f:
                json.dump(self.config, f, indent=2)
            print(f"Configuration saved to {save_path}")
        except Exception as e:
            print(f"Error saving configuration: {e}")
    
    def validate_config(self) -> List[str]:
        """Validate configuration and return list of issues"""
        issues = []
        
        # Check if at least one model is enabled
        enabled_models = self.get_enabled_models()
        if not enabled_models:
            issues.append("No models are enabled")
        
        # Check routing rules reference valid models
        for complexity, styles in self.config['routing_rules'].items():
            for style, model in styles.items():
                if model not in self.config['models']:
                    issues.append(f"Routing rule {complexity}.{style} references unknown model: {model}")
                elif not self.is_model_enabled(model):
                    issues.append(f"Routing rule {complexity}.{style} references disabled model: {model}")
        
        # Check cost constraints are positive
        for constraint, value in self.config['cost_constraints'].items():
            if value < 0:
                issues.append(f"Cost constraint {constraint} must be positive")
        
        return issues
    
    def to_dict(self) -> Dict[str, Any]:
        """Return configuration as dictionary"""
        return self.config.copy()


# Global configuration instance
config = ModelSelectorConfig()
