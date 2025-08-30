#!/usr/bin/env python3
"""
Dynamic Model Selector - Main execution script
Execute agents with dynamic model selection based on task characteristics
"""

import argparse
import json
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

# Add the agents directory to the Python path
sys.path.insert(0, str(Path(__file__).parent.parent))

from agents.model_selector.agent_executor import AgentExecutor
from agents.model_selector.config import config
from agents.model_selector.model_router import ModelRouter
from agents.model_selector.task_analyzer import TaskAnalyzer


def main():
    """Main entry point for the dynamic model selector"""
    parser = argparse.ArgumentParser(
        description="Execute tasks with dynamic model selection",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Execute a simple task
  python dynamic_model_selector.py "Summarize this document"
  
  # Execute with specific preferences
  python dynamic_model_selector.py "Create a story" --preferred-model claude-3-sonnet
  
  # Execute with cost constraints
  python dynamic_model_selector.py "Analyze data" --max-cost 0.01
  
  # Execute batch tasks from file
  python dynamic_model_selector.py --batch-file tasks.json
  
  # Show available models
  python dynamic_model_selector.py --list-models
        """
    )
    
    # Task specification
    parser.add_argument(
        'task',
        nargs='?',
        help='Task description to execute'
    )
    
    parser.add_argument(
        '--batch-file',
        type=str,
        help='JSON file containing batch of tasks to execute'
    )
    
    # Model preferences
    parser.add_argument(
        '--preferred-model',
        type=str,
        help='Preferred model to use (overrides automatic selection)'
    )
    
    parser.add_argument(
        '--preferred-provider',
        type=str,
        choices=['openai', 'anthropic', 'google'],
        help='Preferred model provider'
    )
    
    # Cost constraints
    parser.add_argument(
        '--max-cost',
        type=float,
        help='Maximum cost per token allowed'
    )
    
    parser.add_argument(
        '--budget-limit',
        type=float,
        help='Total budget limit for execution'
    )
    
    # Execution options
    parser.add_argument(
        '--async-execution',
        action='store_true',
        help='Execute tasks asynchronously'
    )
    
    parser.add_argument(
        '--max-concurrent',
        type=int,
        default=5,
        help='Maximum number of concurrent tasks (for async execution)'
    )
    
    parser.add_argument(
        '--timeout',
        type=int,
        default=60,
        help='Timeout in seconds for task execution'
    )
    
    # Output options
    parser.add_argument(
        '--output-format',
        choices=['json', 'text', 'detailed'],
        default='text',
        help='Output format'
    )
    
    parser.add_argument(
        '--output-file',
        type=str,
        help='File to save output to'
    )
    
    parser.add_argument(
        '--include-metadata',
        action='store_true',
        help='Include execution metadata in output'
    )
    
    # Information commands
    parser.add_argument(
        '--list-models',
        action='store_true',
        help='List available models and their capabilities'
    )
    
    parser.add_argument(
        '--analyze-only',
        action='store_true',
        help='Only analyze the task without executing'
    )
    
    parser.add_argument(
        '--show-routing',
        action='store_true',
        help='Show routing decision without executing'
    )
    
    parser.add_argument(
        '--show-stats',
        action='store_true',
        help='Show execution statistics'
    )
    
    # Configuration
    parser.add_argument(
        '--config-file',
        type=str,
        help='Custom configuration file'
    )
    
    parser.add_argument(
        '--validate-config',
        action='store_true',
        help='Validate configuration and exit'
    )
    
    # Verbose output
    parser.add_argument(
        '--verbose', '-v',
        action='store_true',
        help='Verbose output'
    )
    
    args = parser.parse_args()
    
    # Load custom configuration if specified
    if args.config_file:
        config._load_from_file(args.config_file)
    
    # Validate configuration if requested
    if args.validate_config:
        return validate_configuration()
    
    # Show available models if requested
    if args.list_models:
        return show_available_models(args.output_format)
    
    # Initialize components
    executor = AgentExecutor()
    router = ModelRouter()
    analyzer = TaskAnalyzer()
    
    # Show execution statistics if requested
    if args.show_stats:
        return show_execution_stats(executor, args.output_format)
    
    # Determine execution mode
    if args.batch_file:
        return execute_batch_tasks(executor, args)
    elif args.task:
        return execute_single_task(executor, analyzer, router, args)
    else:
        print("Error: Either provide a task description or use --batch-file")
        return 1


def validate_configuration() -> int:
    """Validate configuration and report issues"""
    issues = config.validate_config()
    
    if not issues:
        print("✓ Configuration is valid")
        return 0
    else:
        print("✗ Configuration has issues:")
        for issue in issues:
            print(f"  - {issue}")
        return 1


def show_available_models(output_format: str) -> int:
    """Show available models and their capabilities"""
    router = ModelRouter()
    models = router.get_available_models()
    
    if output_format == 'json':
        print(json.dumps(models, indent=2))
    else:
        print("Available Models:")
        print("=" * 50)
        
        for name, model_config in models.items():
            enabled = config.is_model_enabled(name)
            status = "✓" if enabled else "✗"
            
            print(f"\n{status} {name}")
            print(f"  Provider: {model_config['provider']}")
            print(f"  Cost/token: ${model_config['cost_per_token']:.6f}")
            print(f"  Max tokens: {model_config['max_tokens']}")
            print(f"  Capabilities: {', '.join(model_config['capabilities'])}")
            if not enabled:
                print("  Status: DISABLED")
    
    return 0


def show_execution_stats(executor: AgentExecutor, output_format: str) -> int:
    """Show execution statistics"""
    stats = executor.get_execution_stats()
    
    if output_format == 'json':
        print(json.dumps(stats, indent=2))
    else:
        print("Execution Statistics:")
        print("=" * 50)
        print(f"Total executions: {stats['total_executions']}")
        print(f"Successful: {stats['successful_executions']}")
        print(f"Failed: {stats['failed_executions']}")
        print(f"Success rate: {stats['success_rate']:.1%}")
        print(f"Total cost: ${stats['total_cost']:.4f}")
        print(f"Average execution time: {stats['average_execution_time']:.2f}s")
        
        if stats['model_usage']:
            print("\nModel Usage:")
            for model, count in stats['model_usage'].items():
                print(f"  {model}: {count} times")
        
        if stats['most_used_model']:
            print(f"\nMost used model: {stats['most_used_model']}")
    
    return 0


def execute_single_task(executor: AgentExecutor, 
                       analyzer: TaskAnalyzer,
                       router: ModelRouter,
                       args) -> int:
    """Execute a single task"""
    try:
        # Prepare user preferences
        user_preferences = {}
        if args.preferred_model:
            user_preferences['preferred_model'] = args.preferred_model
        if args.preferred_provider:
            user_preferences['preferred_provider'] = args.preferred_provider
        
        # Prepare cost constraints
        cost_constraints = {}
        if args.max_cost:
            cost_constraints['max_cost_per_token'] = args.max_cost
        if args.budget_limit:
            cost_constraints['budget_limit'] = args.budget_limit
        
        # Prepare execution options
        execution_options = {
            'timeout': args.timeout,
            'cost_constraints': cost_constraints
        }
        
        # Analyze only if requested
        if args.analyze_only:
            analysis = analyzer.analyze_task(args.task)
            output_result(analysis, args, "Task Analysis")
            return 0
        
        # Show routing only if requested
        if args.show_routing:
            routing = router.route_task(args.task, user_preferences, cost_constraints)
            output_result(routing, args, "Routing Decision")
            return 0
        
        # Execute the task
        if args.verbose:
            print(f"Executing task: {args.task[:100]}...")
        
        if args.async_execution:
            import asyncio
            result = asyncio.run(executor.execute_task_async(
                args.task,
                user_preferences=user_preferences,
                execution_options=execution_options
            ))
        else:
            result = executor.execute_task(
                args.task,
                user_preferences=user_preferences,
                execution_options=execution_options
            )
        
        # Output result
        output_result(result, args, "Execution Result")
        
        return 0 if result.get('success', False) else 1
        
    except Exception as e:
        print(f"Error executing task: {e}")
        return 1


def execute_batch_tasks(executor: AgentExecutor, args) -> int:
    """Execute batch of tasks from file"""
    try:
        # Load tasks from file
        with open(args.batch_file, 'r', encoding='utf-8') as f:
            tasks_data = json.load(f)
        
        tasks = tasks_data if isinstance(tasks_data, list) else tasks_data.get('tasks', [])
        
        if not tasks:
            print("No tasks found in batch file")
            return 1
        
        if args.verbose:
            print(f"Executing {len(tasks)} tasks from {args.batch_file}")
        
        # Execute tasks
        if args.async_execution:
            import asyncio
            results = asyncio.run(executor.execute_batch_tasks_async(
                tasks, 
                max_concurrent=args.max_concurrent
            ))
        else:
            results = executor.execute_batch_tasks(tasks)
        
        # Output results
        output_result(results, args, "Batch Execution Results")
        
        # Check if all tasks succeeded
        all_success = all(result.get('success', False) for result in results)
        return 0 if all_success else 1
        
    except Exception as e:
        print(f"Error executing batch tasks: {e}")
        return 1


def output_result(result: Any, args, title: str = "Result"):
    """Output result in specified format"""
    if args.output_format == 'json':
        output_data = result
    elif args.output_format == 'detailed':
        output_data = result
    else:  # text format
        if isinstance(result, dict):
            if 'result' in result and 'response' in result['result']:
                output_data = result['result']['response']
            elif 'selected_model' in result:
                output_data = f"Model: {result['selected_model']}\nReason: {result.get('selection_reason', 'N/A')}"
            else:
                output_data = str(result)
        else:
            output_data = str(result)
    
    # Format output
    if args.output_format == 'json':
        formatted_output = json.dumps(output_data, indent=2)
    elif args.output_format == 'detailed':
        formatted_output = f"{title}:\n{'=' * len(title)}\n{json.dumps(output_data, indent=2)}"
    else:
        formatted_output = str(output_data)
    
    # Include metadata if requested
    if args.include_metadata and isinstance(result, dict):
        if args.output_format != 'json':
            formatted_output += f"\n\nMetadata:\n{json.dumps(result.get('execution_metadata', {}), indent=2)}"
    
    # Output to file or console
    if args.output_file:
        with open(args.output_file, 'w', encoding='utf-8') as f:
            f.write(formatted_output)
        if args.verbose:
            print(f"Output saved to {args.output_file}")
    else:
        print(formatted_output)


if __name__ == '__main__':
    sys.exit(main())
