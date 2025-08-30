# Dynamic Model Selector for Agentic Template

The Dynamic Model Selector is an intelligent system that automatically chooses the optimal AI model for each task based on complexity, style, user preferences, and cost constraints. This system enables cost-effective and high-quality task execution by routing different types of work to the most appropriate models.

## 🚀 Features

### Intelligent Task Analysis

- **Complexity Detection**: Automatically categorizes tasks as Simple, Moderate, High, or Expert level
- **Style Classification**: Identifies Analytical, Creative, Technical, or Default task styles
- **Pattern Recognition**: Detects code blocks, URLs, file references, and multi-step processes
- **Explicit Model Support**: Honors user-specified model preferences

### Smart Model Routing

- **Rule-Based Routing**: Configurable routing rules based on task characteristics
- **Cost Optimization**: Automatically selects cost-effective models for appropriate tasks
- **Performance Optimization**: Routes complex tasks to powerful models for better results
- **Provider Flexibility**: Supports OpenAI, Anthropic, Google, and custom model providers

### Comprehensive Monitoring

- **Execution Tracking**: Monitor success rates, costs, and performance metrics
- **Cost Management**: Budget limits, spending alerts, and cost optimization
- **Performance Analytics**: Model efficiency analysis and optimization recommendations
- **Historical Data**: Detailed execution history and trend analysis

## 📦 Installation

1. **Copy the model selector system to your project:**

   ```bash
   cp -r templates/copilot/agents /your-project/
   cp -r templates/copilot/scripts /your-project/
   ```

2. **Install required dependencies:**

   ```bash
   pip install asyncio pathlib argparse
   ```

3. **Configure your models and preferences:**
   ```bash
   cp agents/model_selector/example_config.json ./model_selector_config.json
   # Edit the configuration file to match your needs
   ```

## 🎯 Quick Start

### Basic Usage

```bash
# Execute a task with automatic model selection
python scripts/dynamic_model_selector.py "Analyze the performance implications of this database query"

# Execute with specific model preference
python scripts/dynamic_model_selector.py "Create a user story for login feature" --preferred-model claude-3-sonnet

# Execute with cost constraints
python scripts/dynamic_model_selector.py "Review this code architecture" --max-cost 0.01
```

### Programmatic Usage

```python
from agents.model_selector.agent_executor import AgentExecutor

# Initialize executor
executor = AgentExecutor()

# Execute single task
result = executor.execute_task(
    "Optimize this SQL query for better performance",
    user_preferences={'preferred_provider': 'openai'},
    execution_options={'cost_constraints': {'max_cost_per_token': 0.01}}
)

print(f"Selected Model: {result['model_info']['selected_model']}")
print(f"Response: {result['result']['response']}")
print(f"Cost: ${result['result']['cost']:.4f}")
```

### Batch Processing

```python
# Prepare batch tasks
tasks = [
    {
        'id': 'task1',
        'description': 'Review code quality for authentication module',
        'user_preferences': {'style': 'technical'}
    },
    {
        'id': 'task2',
        'description': 'Generate creative marketing copy for new feature',
        'user_preferences': {'style': 'creative'}
    },
    {
        'id': 'task3',
        'description': 'Analyze user feedback sentiment',
        'user_preferences': {'style': 'analytical'}
    }
]

# Execute batch
results = executor.execute_batch_tasks(tasks)

# Or execute asynchronously for better performance
import asyncio
results = asyncio.run(executor.execute_batch_tasks_async(tasks, max_concurrent=3))
```

## 📊 Model Selection Logic

### Complexity-Based Routing

| Complexity   | Analytical      | Creative        | Technical     | Default        |
| ------------ | --------------- | --------------- | ------------- | -------------- |
| **Expert**   | Claude-3-Opus   | Claude-3-Opus   | GPT-4         | GPT-4          |
| **High**     | GPT-4           | Claude-3-Sonnet | GPT-4         | GPT-4          |
| **Moderate** | Claude-3-Sonnet | Claude-3-Sonnet | GPT-3.5-Turbo | GPT-3.5-Turbo  |
| **Simple**   | GPT-3.5-Turbo   | Claude-3-Haiku  | GPT-3.5-Turbo | Claude-3-Haiku |

### Task Classification Examples

**Expert Complexity:**

- "Design a distributed system architecture for handling millions of concurrent users"
- "Analyze the trade-offs between different machine learning algorithms for this use case"
- "Create a comprehensive security audit framework for enterprise applications"

**High Complexity:**

- "Implement a real-time chat system with WebSocket support"
- "Analyze user behavior patterns from this dataset"
- "Debug this complex authentication middleware issue"

**Moderate Complexity:**

- "Write unit tests for this user service"
- "Create documentation for the API endpoints"
- "Refactor this component for better readability"

**Simple Complexity:**

- "List the main features of React"
- "Format this JSON data"
- "Convert this function to TypeScript"

## ⚙️ Configuration

### Model Configuration

```json
{
  "models": {
    "gpt-4": {
      "provider": "openai",
      "temperature": 0.3,
      "max_tokens": 8192,
      "cost_per_token": 0.03,
      "capabilities": ["reasoning", "analysis", "code", "complex_tasks"],
      "enabled": true
    },
    "claude-3-sonnet": {
      "provider": "anthropic",
      "temperature": 0.7,
      "max_tokens": 4096,
      "cost_per_token": 0.003,
      "capabilities": ["creative", "balanced", "reasoning"],
      "enabled": true
    }
  }
}
```

### Routing Rules

```json
{
  "routing_rules": {
    "expert": {
      "analytical": "claude-3-opus",
      "creative": "claude-3-opus",
      "technical": "gpt-4",
      "default": "gpt-4"
    }
  }
}
```

### Cost Constraints

```json
{
  "cost_constraints": {
    "daily_budget_limit": 100.0,
    "per_task_limit": 5.0,
    "warning_threshold": 0.8
  }
}
```

## 📈 Monitoring and Analytics

### Execution Statistics

```bash
# View execution statistics
python scripts/dynamic_model_selector.py --show-stats

# Output:
# Execution Statistics:
# Total executions: 45
# Successful: 43
# Failed: 2
# Success rate: 95.6%
# Total cost: $12.34
# Average execution time: 2.1s
# Most used model: GPT-4
```

### Cost Analysis

```python
# Get detailed cost breakdown
stats = executor.get_execution_stats()
print(f"Total cost: ${stats['total_cost']:.2f}")
print(f"Average cost per task: ${stats['total_cost'] / stats['total_executions']:.4f}")

# Model-specific costs
for model, usage in stats['model_usage'].items():
    model_cost = sum(record['cost'] for record in executor.execution_history
                    if record['model_used'] == model and record['success'])
    print(f"{model}: {usage} tasks, ${model_cost:.2f} total")
```

### Performance Optimization

```python
# Analyze model performance for optimization
history = executor.get_execution_history()

# Success rate by model
for model in ['gpt-4', 'claude-3-sonnet', 'gpt-3.5-turbo']:
    model_tasks = [r for r in history if r['model_used'] == model]
    success_rate = sum(1 for r in model_tasks if r['success']) / len(model_tasks)
    print(f"{model}: {success_rate:.1%} success rate")
```

## 🔧 Advanced Features

### Custom Model Integration

```python
from agents.model_selector.model_router import ModelConfig

# Add custom model
custom_model = ModelConfig(
    name='custom-llm',
    provider='custom',
    temperature=0.4,
    max_tokens=4096,
    cost_per_token=0.001,
    capabilities=['domain-specific', 'fast']
)

router = ModelRouter()
router.add_custom_model(custom_model)

# Update routing rules for custom model
router.update_routing_rules('moderate', 'domain-specific', 'custom-llm')
```

### Async Batch Processing

```python
import asyncio

async def process_large_batch():
    tasks = load_tasks_from_file('large_batch.json')  # 100+ tasks

    # Process with controlled concurrency
    results = await executor.execute_batch_tasks_async(
        tasks,
        max_concurrent=10  # Prevent overwhelming APIs
    )

    # Process results
    successful = [r for r in results if r.get('success')]
    failed = [r for r in results if not r.get('success')]

    print(f"Completed: {len(successful)}/{len(tasks)} tasks")
    print(f"Total cost: ${sum(r['result']['cost'] for r in successful):.2f}")

# Run async processing
asyncio.run(process_large_batch())
```

### Workflow Integration

```python
# Integration with existing workflows
class WorkflowIntegrator:
    def __init__(self, workflow_config):
        self.executor = AgentExecutor()
        self.config = workflow_config

    def execute_prd_workflow(self, feature_request):
        """Execute PRD creation workflow with optimal model selection"""

        # Step 1: Requirements analysis (complex analytical task)
        requirements = self.executor.execute_task(
            f"Analyze requirements for: {feature_request}",
            user_preferences={'complexity': 'high', 'style': 'analytical'}
        )

        # Step 2: User story creation (creative task)
        user_stories = self.executor.execute_task(
            f"Create user stories based on: {requirements['result']['response']}",
            user_preferences={'complexity': 'moderate', 'style': 'creative'}
        )

        # Step 3: Technical considerations (technical task)
        tech_specs = self.executor.execute_task(
            f"Define technical requirements for: {feature_request}",
            user_preferences={'complexity': 'high', 'style': 'technical'}
        )

        return {
            'requirements': requirements,
            'user_stories': user_stories,
            'technical_specs': tech_specs
        }
```

## 🐛 Troubleshooting

### Common Issues

**Task routed to expensive model unnecessarily:**

```bash
# Debug the routing decision
python scripts/dynamic_model_selector.py "Your task description" --show-routing

# Analyze the task classification
python scripts/dynamic_model_selector.py "Your task description" --analyze-only
```

**Model not available or disabled:**

```bash
# Check available models
python scripts/dynamic_model_selector.py --list-models

# Validate configuration
python scripts/dynamic_model_selector.py --validate-config
```

**High costs or budget exceeded:**

```bash
# Check execution statistics
python scripts/dynamic_model_selector.py --show-stats

# Set cost constraints
python scripts/dynamic_model_selector.py "Task" --max-cost 0.01 --budget-limit 10.0
```

### Configuration Validation

```python
from agents.model_selector.config import config

# Validate current configuration
issues = config.validate_config()
if issues:
    print("Configuration issues found:")
    for issue in issues:
        print(f"- {issue}")
else:
    print("Configuration is valid!")
```

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes**
4. **Add tests** for new functionality
5. **Update documentation** as needed
6. **Submit a pull request**

### Development Setup

```bash
# Clone the repository
git clone https://github.com/your-org/agentic-template.git
cd agentic-template

# Set up development environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements-dev.txt

# Run tests
python -m pytest tests/

# Run linting
flake8 agents/ scripts/
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- OpenAI for GPT models and API
- Anthropic for Claude models and API
- Google for Gemini models and API
- The open-source community for inspiration and feedback

## 📞 Support

- **Documentation**: [Full documentation](docs/)
- **Issues**: [GitHub Issues](https://github.com/your-org/agentic-template/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-org/agentic-template/discussions)
- **Email**: support@your-org.com

---

**Made with ❤️ for intelligent agent automation**
