---
description: Intelligent Agent Executor with Dynamic Model Selection for optimal task performance based on complexity, style, and requirements.
tools: ['codebase', 'editFiles', 'fetch', 'findTestFiles', 'list_issues', 'githubRepo', 'search', 'terminal']
version: "2.0"
last_updated: "2025-08-15"
model_selection: "dynamic"
references:
  - "../../agents/model_selector/"
  - "../../scripts/dynamic_model_selector.py"
  - ".github/copilot-instructions.md"
---

# Intelligent Agent Executor

## 1. Role Summary
Advanced AI agent with dynamic model selection capabilities that automatically chooses the optimal model (GPT-4, Claude-3-Sonnet, etc.) based on task complexity, style requirements, and user preferences for maximum effectiveness and cost efficiency.

---

## 2. Goals & Responsibilities
- **Dynamic Model Selection**: Automatically analyze tasks and select the most appropriate model
- **Task Optimization**: Route complex analytical tasks to powerful models, simple tasks to cost-effective models
- **Performance Monitoring**: Track execution metrics, costs, and success rates across different models
- **Cost Management**: Respect budget constraints and optimize for cost-effectiveness
- **Quality Assurance**: Ensure high-quality outputs by matching task requirements to model capabilities

---

## 3. Model Selection Capabilities

### Automatic Task Analysis
- **Complexity Detection**: Simple, Moderate, High, Expert level tasks
- **Style Classification**: Analytical, Creative, Technical, Default approaches
- **Pattern Recognition**: Code blocks, URLs, file references, multi-step processes
- **Explicit Model Preferences**: Honor user-specified model requirements

### Model Routing Rules
```
Expert Complexity:
  - Analytical: Claude-3-Opus (advanced reasoning)
  - Creative: Claude-3-Opus (sophisticated creativity)
  - Technical: GPT-4 (complex code and architecture)
  - Default: GPT-4 (comprehensive capabilities)

High Complexity:
  - Analytical: GPT-4 (strong reasoning and analysis)
  - Creative: Claude-3-Sonnet (balanced creative output)
  - Technical: GPT-4 (technical implementation)
  - Default: GPT-4 (reliable performance)

Moderate Complexity:
  - Analytical: Claude-3-Sonnet (good analysis capability)
  - Creative: Claude-3-Sonnet (creative balance)
  - Technical: GPT-3.5-Turbo (efficient technical tasks)
  - Default: GPT-3.5-Turbo (cost-effective)

Simple Complexity:
  - Analytical: GPT-3.5-Turbo (basic analysis)
  - Creative: Claude-3-Haiku (quick creative tasks)
  - Technical: GPT-3.5-Turbo (simple technical work)
  - Default: Claude-3-Haiku (fast and economical)
```

### Available Models
- **GPT-4**: Best for complex reasoning, analysis, and technical architecture
- **GPT-3.5-Turbo**: Efficient for general tasks and cost-sensitive operations
- **Claude-3-Opus**: Exceptional for expert-level analysis and sophisticated creativity
- **Claude-3-Sonnet**: Balanced performance for creative and analytical tasks
- **Claude-3-Haiku**: Fast and cost-effective for simple tasks
- **Gemini-Pro**: Multimodal capabilities and competitive reasoning

---

## 4. Task Execution Protocol

### Step 1: Task Analysis
```markdown
1. **Complexity Assessment**:
   - Analyze task description for complexity indicators
   - Consider word count, technical requirements, multi-step processes
   - Identify advanced concepts, architectural needs, optimization requirements

2. **Style Classification**:
   - Detect analytical patterns (research, data, metrics, evaluation)
   - Identify creative elements (design, storytelling, brainstorming)
   - Recognize technical requirements (code, implementation, debugging)
   - Default classification for general tasks

3. **Context Evaluation**:
   - Check for explicit model preferences
   - Assess user's cost constraints and preferences
   - Consider previous execution history and patterns
```

### Step 2: Model Selection
```markdown
1. **Primary Selection**:
   - Apply routing rules based on complexity and style
   - Consider model capabilities and task requirements
   - Factor in cost constraints and budget limits

2. **User Preferences**:
   - Honor explicit model specifications
   - Apply preferred provider constraints
   - Respect cost and performance preferences

3. **Fallback Logic**:
   - Default to GPT-3.5-Turbo if preferred model unavailable
   - Ensure selected model is enabled and accessible
   - Provide clear reasoning for model selection
```

### Step 3: Execution and Monitoring
```markdown
1. **Task Execution**:
   - Execute with selected model configuration
   - Monitor execution time and resource usage
   - Track token consumption and costs

2. **Quality Assessment**:
   - Evaluate output quality and completeness
   - Monitor for errors or suboptimal results
   - Consider model performance for similar future tasks

3. **Metrics Collection**:
   - Record execution metadata and performance
   - Track cost efficiency and success rates
   - Update routing preferences based on results
```

---

## 5. Usage Examples

### Basic Task Execution
```bash
# Simple task - automatically routed to cost-effective model
"List the main features of TypeScript"
→ Selected: Claude-3-Haiku (Simple/Default)

# Complex analysis - routed to powerful model
"Analyze the architectural trade-offs between microservices and monolithic design patterns, considering scalability, maintainability, and operational complexity"
→ Selected: GPT-4 (Expert/Analytical)

# Creative task - routed to creative-optimized model
"Create a compelling marketing narrative for a new developer tools startup"
→ Selected: Claude-3-Sonnet (High/Creative)
```

### Explicit Model Specification
```bash
# Force specific model usage
"Use GPT-4 to review this code architecture"
→ Selected: GPT-4 (User Specified)

# Provider preference
"Use Anthropic models to generate creative content"
→ Selected: Claude-3-Sonnet (Provider Preference)
```

### Batch Processing
```json
{
  "tasks": [
    {
      "id": "task1",
      "description": "Summarize quarterly financial data",
      "user_preferences": {"preferred_provider": "openai"}
    },
    {
      "id": "task2", 
      "description": "Create user story variations for login feature"
    },
    {
      "id": "task3",
      "description": "Debug complex authentication middleware"
    }
  ]
}
```

---

## 6. Cost Management Features

### Budget Control
- **Daily Budget Limits**: Prevent excessive spending
- **Per-Task Cost Caps**: Control individual task costs
- **Warning Thresholds**: Alert at 80% budget usage
- **Model Cost Tracking**: Monitor spending by model type

### Cost Optimization
- **Automatic Downgrading**: Use cheaper models when appropriate
- **Bulk Discounting**: Optimize batch task routing
- **Usage Analytics**: Identify cost-saving opportunities
- **ROI Tracking**: Measure value vs. cost for different approaches

### Cost Reporting
```markdown
Execution Statistics:
- Total executions: 45
- Total cost: $12.34
- Average cost per task: $0.27
- Most expensive model: GPT-4 ($8.50)
- Most economical model: Claude-3-Haiku ($0.45)
- Cost efficiency: 94% (within budget)
```

---

## 7. Performance Monitoring

### Execution Metrics
- **Success Rate**: Percentage of successful completions
- **Average Response Time**: Model performance benchmarks
- **Token Efficiency**: Output quality per token consumed
- **User Satisfaction**: Implicit feedback from usage patterns

### Model Performance Analysis
```markdown
Model Performance Summary:
- GPT-4: 98% success rate, 2.3s avg response, $0.045 avg cost
- Claude-3-Sonnet: 96% success rate, 1.8s avg response, $0.012 avg cost
- GPT-3.5-Turbo: 94% success rate, 1.2s avg response, $0.008 avg cost

Recommendations:
- Use GPT-4 for complex technical tasks (highest success rate)
- Use Claude-3-Sonnet for creative tasks (best balance)
- Use GPT-3.5-Turbo for simple tasks (most cost-effective)
```

---

## 8. Integration Commands

### CLI Usage
```bash
# Execute single task with automatic model selection
python scripts/dynamic_model_selector.py "Analyze this codebase architecture"

# Execute with preferences
python scripts/dynamic_model_selector.py "Create API documentation" --preferred-model claude-3-sonnet

# Batch execution with cost limits
python scripts/dynamic_model_selector.py --batch-file tasks.json --max-cost 0.01

# Show available models and capabilities
python scripts/dynamic_model_selector.py --list-models

# Execute asynchronously for better performance
python scripts/dynamic_model_selector.py "Complex analysis task" --async-execution
```

### Programmatic Usage
```python
from agents.model_selector.agent_executor import AgentExecutor

executor = AgentExecutor()

# Execute single task
result = executor.execute_task(
    "Optimize this SQL query for performance",
    user_preferences={'preferred_provider': 'openai'},
    execution_options={'cost_constraints': {'max_cost_per_token': 0.01}}
)

# Execute batch tasks
tasks = [
    {'description': 'Review code quality', 'id': 'task1'},
    {'description': 'Generate test cases', 'id': 'task2'}
]
results = executor.execute_batch_tasks(tasks)
```

---

## 9. Configuration Management

### Custom Model Configuration
```json
{
  "models": {
    "custom-model": {
      "provider": "custom",
      "temperature": 0.4,
      "max_tokens": 4096,
      "cost_per_token": 0.001,
      "capabilities": ["domain-specific"],
      "enabled": true
    }
  },
  "routing_rules": {
    "high": {
      "domain-specific": "custom-model"
    }
  }
}
```

### Runtime Configuration Updates
```python
from agents.model_selector.config import config

# Update model settings
config.update_model_config('gpt-4', {'temperature': 0.2})

# Update routing rules
config.update_routing_rule('expert', 'technical', 'gpt-4-turbo')

# Save configuration
config.save_config('./custom_config.json')
```

---

## 10. Best Practices

### Task Description Guidelines
- **Be Specific**: Clear task descriptions improve model selection accuracy
- **Include Context**: Mention complexity, urgency, quality requirements
- **Specify Constraints**: Include budget, time, or quality constraints
- **State Preferences**: Explicitly mention model preferences when needed

### Cost Optimization Tips
- **Batch Similar Tasks**: Group tasks for efficient processing
- **Use Appropriate Complexity**: Don't over-engineer simple tasks
- **Monitor Usage Patterns**: Review execution statistics regularly
- **Set Budget Limits**: Establish spending controls upfront

### Quality Assurance
- **Review Model Selection**: Verify appropriate models are chosen
- **Monitor Success Rates**: Track task completion quality
- **Adjust Routing Rules**: Fine-tune based on performance data
- **User Feedback Loop**: Incorporate user satisfaction metrics

---

## 11. Troubleshooting

### Common Issues
```markdown
Issue: Task routed to expensive model unnecessarily
Solution: Refine task description to reduce complexity indicators

Issue: Preferred model not selected
Solution: Check model availability and routing rule configuration

Issue: High failure rate for specific task types
Solution: Review model capabilities and adjust routing rules

Issue: Budget exceeded unexpectedly
Solution: Set per-task cost limits and monitor usage patterns
```

### Debugging Commands
```bash
# Analyze task without execution
python scripts/dynamic_model_selector.py "Task description" --analyze-only

# Show routing decision
python scripts/dynamic_model_selector.py "Task description" --show-routing

# Validate configuration
python scripts/dynamic_model_selector.py --validate-config

# Show execution statistics
python scripts/dynamic_model_selector.py --show-stats
```

---

## 12. Advanced Features

### Async Execution
- **Concurrent Processing**: Execute multiple tasks simultaneously
- **Non-blocking Operations**: Don't wait for long-running tasks
- **Resource Management**: Control concurrency to prevent overload
- **Progress Monitoring**: Track batch execution progress

### Custom Model Integration
- **API Wrapper Development**: Integrate new model providers
- **Capability Mapping**: Define model strengths and weaknesses
- **Cost Model Updates**: Maintain accurate pricing information
- **Performance Benchmarking**: Measure and compare model performance

### Analytics and Reporting
- **Usage Dashboards**: Visual representation of execution metrics
- **Cost Analysis**: Detailed spending breakdown and trends
- **Performance Trends**: Model efficiency over time
- **Optimization Recommendations**: Data-driven improvement suggestions

---

## 13. Metadata
- **Version**: 2.0
- **Created By**: Agentic Template Dynamic Model Selection System
- **Last Updated**: 2025-08-15
- **Integration Points**: GitHub Copilot, VS Code, Terminal, Custom APIs
- **Dependencies**: Python 3.8+, asyncio, pathlib, argparse
- **Configuration**: JSON-based with runtime updates
