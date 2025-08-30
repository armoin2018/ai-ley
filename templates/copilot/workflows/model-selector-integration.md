# Model Selector Integration Workflow

This workflow demonstrates how to integrate the dynamic model selector with existing Copilot workflows for enhanced task execution.

## Workflow Integration Points

### 1. PRD Creation Workflow Integration

`````markdown
# Enhanced PRD Creation with Model Selection

When creating PRDs, the model selector can:

- Route complex analysis tasks to GPT-4 for thorough requirements analysis
- Use Claude-3-Sonnet for creative user story generation
- Apply GPT-3.5-Turbo for simple requirement formatting

Integration Example:

```python
from agents.model_selector.agent_executor import AgentExecutor

executor = AgentExecutor()

# Complex requirements analysis
analysis_result = executor.execute_task(
    "Analyze stakeholder requirements and identify potential conflicts",
    user_preferences={'complexity_preference': 'high'}
)

# Creative user story generation
stories_result = executor.execute_task(
    "Generate user stories for the authentication feature",
    user_preferences={'style_preference': 'creative'}
)
```

### 2. Build Plan Workflow Integration

`````markdown
# Smart Build Planning with Model Selection

For build planning tasks:

- Technical architecture decisions → GPT-4
- Creative naming and documentation → Claude-3-Sonnet
- Simple task breakdowns → GPT-3.5-Turbo

Integration Example:

```python
# Architecture planning
arch_result = executor.execute_task(
    "Design microservice architecture for user management system",
    user_preferences={'style': 'technical', 'complexity': 'expert'}
)

# Task breakdown
tasks_result = executor.execute_task(
    "Break down authentication feature into development tasks",
    user_preferences={'complexity': 'moderate'}
)
```

### 3. Code Review and Analysis

````markdown
# Intelligent Code Review

Route code review tasks based on complexity:

- Simple linting and formatting → GPT-3.5-Turbo
- Complex architectural review → GPT-4
- Creative refactoring suggestions → Claude-3-Sonnet

Integration Example:

```python
# Complex code review
review_result = executor.execute_task(
    f"Review this complex authentication middleware: {code_content}",
    user_preferences={'style': 'technical', 'complexity': 'high'}
)
```

## Workflow Configuration Examples

### 1. Development Team Workflow

```json
{
  "workflow_name": "development_team",
  "default_preferences": {
    "cost_constraints": {
      "daily_budget_limit": 50.0,
      "per_task_limit": 2.0
    },
    "preferred_provider": "openai"
  },
  "task_routing": {
    "code_review": {
      "complexity": "high",
      "style": "technical",
      "preferred_model": "gpt-4"
    },
    "documentation": {
      "complexity": "moderate",
      "style": "creative",
      "preferred_model": "claude-3-sonnet"
    },
    "testing": {
      "complexity": "moderate",
      "style": "technical",
      "preferred_model": "gpt-3.5-turbo"
    }
  }
}
```

### 2. Product Management Workflow

```json
{
  "workflow_name": "product_management",
  "default_preferences": {
    "cost_constraints": {
      "daily_budget_limit": 100.0,
      "per_task_limit": 5.0
    }
  },
  "task_routing": {
    "requirements_analysis": {
      "complexity": "expert",
      "style": "analytical",
      "preferred_model": "claude-3-opus"
    },
    "user_story_creation": {
      "complexity": "high",
      "style": "creative",
      "preferred_model": "claude-3-sonnet"
    },
    "market_research": {
      "complexity": "high",
      "style": "analytical",
      "preferred_model": "gpt-4"
    }
  }
}
```

### 3. Creative Team Workflow

```json
{
  "workflow_name": "creative_team",
  "default_preferences": {
    "preferred_provider": "anthropic",
    "cost_constraints": {
      "daily_budget_limit": 75.0
    }
  },
  "task_routing": {
    "content_creation": {
      "complexity": "high",
      "style": "creative",
      "preferred_model": "claude-3-sonnet"
    },
    "copy_editing": {
      "complexity": "moderate",
      "style": "creative",
      "preferred_model": "claude-3-sonnet"
    },
    "brainstorming": {
      "complexity": "high",
      "style": "creative",
      "preferred_model": "claude-3-opus"
    }
  }
}
```

## Integration Scripts

### Workflow Execution Script

```python
#!/usr/bin/env python3
"""
Workflow-aware task execution with model selection
"""

import json
from pathlib import Path
from agents.model_selector.agent_executor import AgentExecutor

class WorkflowIntegrator:
    def __init__(self, workflow_config_path: str):
        self.executor = AgentExecutor()
        self.workflow_config = self._load_workflow_config(workflow_config_path)

    def _load_workflow_config(self, config_path: str):
        with open(config_path, 'r') as f:
            return json.load(f)

    def execute_workflow_task(self, task_type: str, task_description: str):
        """Execute task with workflow-specific preferences"""

        # Get workflow-specific preferences
        task_config = self.workflow_config.get('task_routing', {}).get(task_type, {})
        default_prefs = self.workflow_config.get('default_preferences', {})

        # Merge preferences
        user_preferences = {**default_prefs, **task_config}

        # Execute with workflow context
        return self.executor.execute_task(
            task_description,
            user_preferences=user_preferences,
            execution_options={
                'workflow_context': {
                    'workflow_name': self.workflow_config.get('workflow_name'),
                    'task_type': task_type
                }
            }
        )

# Usage example
integrator = WorkflowIntegrator('./workflows/development_team.json')
result = integrator.execute_workflow_task(
    'code_review',
    'Review this authentication implementation for security issues'
)
```

### Batch Workflow Processor

```python
#!/usr/bin/env python3
"""
Process multiple workflow tasks efficiently
"""

class BatchWorkflowProcessor:
    def __init__(self, workflow_configs: dict):
        self.executor = AgentExecutor()
        self.workflows = workflow_configs

    async def process_workflow_batch(self, workflow_tasks: list):
        """Process multiple workflow tasks asynchronously"""

        enhanced_tasks = []
        for task in workflow_tasks:
            workflow_name = task.get('workflow')
            task_type = task.get('task_type')

            if workflow_name in self.workflows:
                workflow_config = self.workflows[workflow_name]
                task_config = workflow_config.get('task_routing', {}).get(task_type, {})
                default_prefs = workflow_config.get('default_preferences', {})

                # Enhance task with workflow preferences
                enhanced_task = {
                    **task,
                    'user_preferences': {**default_prefs, **task_config}
                }
                enhanced_tasks.append(enhanced_task)
            else:
                enhanced_tasks.append(task)

        return await self.executor.execute_batch_tasks_async(enhanced_tasks)
```

## Monitoring and Analytics

### Workflow Performance Tracking

```python
class WorkflowAnalytics:
    def __init__(self):
        self.executor = AgentExecutor()

    def analyze_workflow_performance(self, workflow_name: str):
        """Analyze performance for specific workflow"""

        history = self.executor.get_execution_history()
        workflow_tasks = [
            record for record in history
            if record.get('workflow_context', {}).get('workflow_name') == workflow_name
        ]

        # Calculate workflow-specific metrics
        total_tasks = len(workflow_tasks)
        successful_tasks = sum(1 for task in workflow_tasks if task.get('success'))
        total_cost = sum(task.get('cost', 0) for task in workflow_tasks)

        # Model usage by task type
        task_type_models = {}
        for task in workflow_tasks:
            task_type = task.get('workflow_context', {}).get('task_type', 'unknown')
            model = task.get('model_used')

            if task_type not in task_type_models:
                task_type_models[task_type] = {}

            task_type_models[task_type][model] = task_type_models[task_type].get(model, 0) + 1

        return {
            'workflow_name': workflow_name,
            'total_tasks': total_tasks,
            'success_rate': successful_tasks / total_tasks if total_tasks > 0 else 0,
            'total_cost': total_cost,
            'average_cost_per_task': total_cost / total_tasks if total_tasks > 0 else 0,
            'model_usage_by_task_type': task_type_models
        }
```

## Best Practices for Workflow Integration

### 1. Configuration Management

- Keep workflow configurations in version control
- Use environment-specific configurations (dev, staging, prod)
- Regular review and optimization of routing rules
- Document workflow-specific preferences and rationale

### 2. Cost Management

- Set appropriate budget limits for different workflows
- Monitor cost trends by workflow and task type
- Implement cost alerts and automatic scaling
- Regular cost optimization reviews

### 3. Quality Assurance

- Track success rates by workflow and task type
- Implement feedback loops for model selection optimization
- Regular performance reviews and adjustments
- User satisfaction monitoring

### 4. Team Adoption

- Provide clear documentation and examples
- Training sessions for team members
- Gradual rollout with pilot projects
- Regular feedback collection and iteration

This integration framework allows teams to leverage the dynamic model selector while maintaining their existing workflows and adding intelligent model routing capabilities.
````
`````
`````
