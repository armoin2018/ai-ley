"""
Model Router - Routes tasks to appropriate models based on analysis
"""

import json
import os
from typing import Any, Dict, List, Optional, Tuple

from .task_analyzer import TaskAnalyzer, TaskComplexity, TaskStyle


class ModelConfig:
    """Configuration for a specific model"""
    
    def __init__(self, 
                 name: str,
                 provider: str,
                 temperature: float = 0.5,
                 max_tokens: Optional[int] = None,
                 cost_per_token: float = 0.0,
                 capabilities: List[str] = None):
        self.name = name
        self.provider = provider
        self.temperature = temperature
        self.max_tokens = max_tokens
        self.cost_per_token = cost_per_token
        self.capabilities = capabilities or []
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary format"""
        return {
            'name': self.name,
            'provider': self.provider,
            'temperature': self.temperature,
            'max_tokens': self.max_tokens,
            'cost_per_token': self.cost_per_token,
            'capabilities': self.capabilities
        }


class ModelRouter:
    """Routes tasks to appropriate models based on analysis"""
    
    def __init__(self):
        self.analyzer = TaskAnalyzer()
        self.models = self._initialize_models()
        self.routing_rules = self._initialize_routing_rules()
    
    def _initialize_models(self) -> Dict[str, ModelConfig]:
        """Initialize available models and their configurations"""
        # Load from external JSON file if available
        return self._load_models_from_file()

    def _load_models_from_file(self) -> Dict[str, ModelConfig]:
        """Load model configurations from models.json in the same directory.

        Falls back to an empty dict if file not found or invalid.
        """
        models_path = os.path.join(os.path.dirname(__file__), 'models.json')
        models: Dict[str, ModelConfig] = {}
        try:
            with open(models_path, 'r', encoding='utf-8') as fh:
                raw = json.load(fh)
            for name, cfg in raw.items():
                models[name] = ModelConfig(
                    name=cfg.get('name', name),
                    provider=cfg.get('provider', 'unknown'),
                    temperature=cfg.get('temperature', 0.5),
                    max_tokens=cfg.get('max_tokens'),
                    cost_per_token=cfg.get('cost_per_token', 0.0),
                    capabilities=cfg.get('capabilities', [])
                )
        except Exception:
            # If loading fails, return empty dict and the rest of the system will
            # gracefully fallback to defaults where appropriate.
            models = {}
        return models
        
    
    def _initialize_routing_rules(self) -> Dict[str, Dict[str, str]]:
        """Initialize routing rules based on complexity and style"""
        # Load routing rules from external JSON
        return self._load_routing_from_file()

    def _load_routing_from_file(self) -> Dict[str, Dict[str, str]]:
        """Load routing rules from routing_rules.json in the same directory.

        Falls back to an empty mapping if the file is missing or invalid.
        """
        rules_path = os.path.join(os.path.dirname(__file__), 'routing_rules.json')
        try:
            with open(rules_path, 'r', encoding='utf-8') as fh:
                raw = json.load(fh)
            # Ensure keys are strings and values are dicts
            cleaned: Dict[str, Dict[str, str]] = {}
            for complexity, mapping in raw.items():
                cleaned[complexity] = {k: v for k, v in mapping.items()}
            return cleaned
        except Exception:
            return {}
    
    def route_task(self, 
                   task_description: str,
                   user_preferences: Optional[Dict[str, Any]] = None,
                   cost_constraints: Optional[Dict[str, float]] = None) -> Dict[str, Any]:
        """
        Route task to appropriate model
        
        Args:
            task_description: Description of the task
            user_preferences: Optional user preferences for model selection
            cost_constraints: Optional cost constraints (max_cost_per_token, budget_limit)
            
        Returns:
            Dictionary containing routing decision and metadata
        """
        # Analyze the task
        analysis = self.analyzer.analyze_task(task_description)
        
        # Check for explicit model preference
        if analysis['explicit_model']:
            selected_model = analysis['explicit_model']
            selection_reason = "Explicit model specified in task"
        else:
            # Apply routing rules
            selected_model = self._apply_routing_rules(analysis, user_preferences, cost_constraints)
            selection_reason = f"Selected based on complexity: {analysis['complexity']}, style: {analysis['style']}"
        
        # Get model configuration
        model_config = self.models.get(selected_model)
        if not model_config:
            # Fallback to default model
            selected_model = 'gpt-3.5-turbo'
            model_config = self.models[selected_model]
            selection_reason += " (fallback to default)"
        
        # Calculate priority and estimated cost
        priority = self.analyzer.get_priority_score(analysis)
        estimated_tokens = self._estimate_tokens(task_description)
        estimated_cost = estimated_tokens * model_config.cost_per_token
        
        return {
            'selected_model': selected_model,
            'model_config': model_config.to_dict(),
            'selection_reason': selection_reason,
            'task_analysis': analysis,
            'priority': priority,
            'estimated_cost': estimated_cost,
            'estimated_tokens': estimated_tokens,
            'routing_metadata': {
                'user_preferences': user_preferences,
                'cost_constraints': cost_constraints,
                'timestamp': self._get_timestamp()
            }
        }
    
    def _apply_routing_rules(self, 
                           analysis: Dict[str, Any],
                           user_preferences: Optional[Dict[str, Any]] = None,
                           cost_constraints: Optional[Dict[str, float]] = None) -> str:
        """Apply routing rules to select model"""
        
        complexity = analysis['complexity']
        style = analysis['style']
        
        # Get base recommendation from routing rules
        base_model = self.routing_rules.get(complexity, {}).get(style, 'gpt-3.5-turbo')
        
        # Apply user preferences
        if user_preferences:
            preferred_model = user_preferences.get('preferred_model')
            if preferred_model and preferred_model in self.models:
                return preferred_model
            
            preferred_provider = user_preferences.get('preferred_provider')
            if preferred_provider:
                provider_models = [name for name, config in self.models.items() 
                                 if config.provider == preferred_provider]
                if provider_models:
                    # Find best match within preferred provider
                    for model in provider_models:
                        if model in self.routing_rules.get(complexity, {}).values():
                            base_model = model
                            break
        
        # Apply cost constraints
        if cost_constraints:
            max_cost = cost_constraints.get('max_cost_per_token')
            if max_cost:
                model_config = self.models[base_model]
                if model_config.cost_per_token > max_cost:
                    # Find cheaper alternative
                    cheaper_models = [name for name, config in self.models.items()
                                    if config.cost_per_token <= max_cost]
                    if cheaper_models:
                        # Select cheapest model that still meets requirements
                        base_model = min(cheaper_models, 
                                       key=lambda x: self.models[x].cost_per_token)
        
        return base_model
    
    def _estimate_tokens(self, text: str) -> int:
        """Estimate token count for text (rough approximation)"""
        # Rough estimation: ~4 characters per token
        return max(len(text) // 4, 10)
    
    def _get_timestamp(self) -> str:
        """Get current timestamp"""
        from datetime import datetime
        return datetime.now().isoformat()
    
    def get_available_models(self) -> Dict[str, Dict[str, Any]]:
        """Get list of available models and their capabilities"""
        return {name: config.to_dict() for name, config in self.models.items()}
    
    def add_custom_model(self, model_config: ModelConfig):
        """Add a custom model configuration"""
        self.models[model_config.name] = model_config
    
    def update_routing_rules(self, complexity: str, style: str, model: str):
        """Update routing rules for specific complexity/style combination"""
        if complexity not in self.routing_rules:
            self.routing_rules[complexity] = {}
        self.routing_rules[complexity][style] = model
    
    def batch_route_tasks(self, tasks: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """
        Route multiple tasks efficiently
        
        Args:
            tasks: List of task dictionaries with 'description' and optional metadata
            
        Returns:
            List of routing results
        """
        results = []
        
        for task in tasks:
            description = task.get('description', '')
            user_prefs = task.get('user_preferences')
            cost_constraints = task.get('cost_constraints')
            
            routing_result = self.route_task(description, user_prefs, cost_constraints)
            routing_result['task_id'] = task.get('id', len(results))
            results.append(routing_result)
        
        return results
