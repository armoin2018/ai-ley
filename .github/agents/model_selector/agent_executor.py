"""
Agent Executor - Executes tasks with selected models
"""

import asyncio
from typing import Any, Callable, Dict, List, Optional

from .model_router import ModelRouter
from .task_analyzer import TaskAnalyzer


class AgentExecutor:
    """Executes agent tasks with dynamically selected models"""
    
    def __init__(self):
        self.analyzer = TaskAnalyzer()
        self.router = ModelRouter()
        self.execution_history = []
        self.active_sessions = {}
    
    def execute_task(self,
                    task_description: str,
                    context: Optional[Dict[str, Any]] = None,
                    user_preferences: Optional[Dict[str, Any]] = None,
                    execution_options: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """
        Execute a single task with optimal model selection
        
        Args:
            task_description: Description of the task to execute
            context: Optional context information
            user_preferences: User preferences for model selection
            execution_options: Options for task execution
            
        Returns:
            Execution result with metadata
        """
        # Route task to appropriate model
        routing_result = self.router.route_task(
            task_description, 
            user_preferences,
            execution_options.get('cost_constraints') if execution_options else None
        )
        
        # Prepare execution context
        execution_context = {
            'task_description': task_description,
            'selected_model': routing_result['selected_model'],
            'model_config': routing_result['model_config'],
            'context': context or {},
            'options': execution_options or {},
            'routing_metadata': routing_result
        }
        
        # Execute with selected model
        try:
            result = self._execute_with_model(execution_context)
            
            # Record execution
            execution_record = {
                'task_description': task_description,
                'model_used': routing_result['selected_model'],
                'success': True,
                'result': result,
                'execution_time': result.get('execution_time'),
                'cost': result.get('cost'),
                'timestamp': self.router._get_timestamp()
            }
            self.execution_history.append(execution_record)
            
            return {
                'success': True,
                'result': result,
                'model_info': {
                    'selected_model': routing_result['selected_model'],
                    'selection_reason': routing_result['selection_reason'],
                    'estimated_cost': routing_result['estimated_cost']
                },
                'execution_metadata': execution_record
            }
            
        except Exception as e:
            # Handle execution failure
            error_record = {
                'task_description': task_description,
                'model_used': routing_result['selected_model'],
                'success': False,
                'error': str(e),
                'timestamp': self.router._get_timestamp()
            }
            self.execution_history.append(error_record)
            
            return {
                'success': False,
                'error': str(e),
                'model_info': {
                    'selected_model': routing_result['selected_model'],
                    'selection_reason': routing_result['selection_reason']
                },
                'execution_metadata': error_record
            }
    
    def _execute_with_model(self, execution_context: Dict[str, Any]) -> Dict[str, Any]:
        """
        Execute task with the specified model
        
        Args:
            execution_context: Complete execution context
            
        Returns:
            Execution result
        """
        import time
        start_time = time.time()
        
        model_config = execution_context['model_config']
        task_description = execution_context['task_description']
        
        # Simulate model execution (replace with actual model API calls)
        result = self._simulate_model_execution(task_description, model_config)
        
        execution_time = time.time() - start_time
        estimated_tokens = len(result.get('response', '')) // 4
        actual_cost = estimated_tokens * model_config['cost_per_token']
        
        return {
            'response': result['response'],
            'execution_time': execution_time,
            'tokens_used': estimated_tokens,
            'cost': actual_cost,
            'model_metadata': result.get('metadata', {})
        }
    
    def _simulate_model_execution(self, task: str, model_config: Dict[str, Any]) -> Dict[str, Any]:
        """
        Simulate model execution (replace with actual API calls)
        
        Args:
            task: Task description
            model_config: Model configuration
            
        Returns:
            Simulated response
        """
        model_name = model_config['name']
        
        # Simulate different model behaviors
        if 'gpt-4' in model_name:
            response = f"[GPT-4 Response] Detailed analysis of: {task[:100]}..."
        elif 'claude' in model_name:
            response = f"[Claude Response] Thoughtful consideration of: {task[:100]}..."
        elif 'gemini' in model_name:
            response = f"[Gemini Response] Comprehensive approach to: {task[:100]}..."
        else:
            response = f"[Default Response] Processing: {task[:100]}..."
        
        return {
            'response': response,
            'metadata': {
                'model': model_name,
                'temperature': model_config['temperature'],
                'provider': model_config['provider']
            }
        }
    
    async def execute_task_async(self,
                                task_description: str,
                                context: Optional[Dict[str, Any]] = None,
                                user_preferences: Optional[Dict[str, Any]] = None,
                                execution_options: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """
        Execute task asynchronously
        
        Args:
            task_description: Description of the task to execute
            context: Optional context information
            user_preferences: User preferences for model selection
            execution_options: Options for task execution
            
        Returns:
            Execution result with metadata
        """
        loop = asyncio.get_event_loop()
        return await loop.run_in_executor(
            None, 
            self.execute_task,
            task_description,
            context,
            user_preferences,
            execution_options
        )
    
    def execute_batch_tasks(self,
                           tasks: List[Dict[str, Any]],
                           batch_options: Optional[Dict[str, Any]] = None) -> List[Dict[str, Any]]:
        """
        Execute multiple tasks in batch
        
        Args:
            tasks: List of task dictionaries
            batch_options: Options for batch execution
            
        Returns:
            List of execution results
        """
        results = []
        
        # Route all tasks first
        routing_results = self.router.batch_route_tasks(tasks)
        
        for i, (task, routing) in enumerate(zip(tasks, routing_results)):
            try:
                execution_result = self.execute_task(
                    task['description'],
                    task.get('context'),
                    task.get('user_preferences'),
                    task.get('execution_options')
                )
                execution_result['task_id'] = task.get('id', i)
                execution_result['batch_index'] = i
                results.append(execution_result)
                
            except Exception as e:
                error_result = {
                    'task_id': task.get('id', i),
                    'batch_index': i,
                    'success': False,
                    'error': str(e),
                    'model_info': {
                        'selected_model': routing['selected_model'],
                        'selection_reason': routing['selection_reason']
                    }
                }
                results.append(error_result)
        
        return results
    
    async def execute_batch_tasks_async(self,
                                       tasks: List[Dict[str, Any]],
                                       max_concurrent: int = 5) -> List[Dict[str, Any]]:
        """
        Execute multiple tasks asynchronously with concurrency control
        
        Args:
            tasks: List of task dictionaries
            max_concurrent: Maximum number of concurrent executions
            
        Returns:
            List of execution results
        """
        semaphore = asyncio.Semaphore(max_concurrent)
        
        async def execute_single_task(task_data: Dict[str, Any], index: int):
            async with semaphore:
                result = await self.execute_task_async(
                    task_data['description'],
                    task_data.get('context'),
                    task_data.get('user_preferences'),
                    task_data.get('execution_options')
                )
                result['task_id'] = task_data.get('id', index)
                result['batch_index'] = index
                return result
        
        # Create tasks for async execution
        async_tasks = [
            execute_single_task(task, i) 
            for i, task in enumerate(tasks)
        ]
        
        # Execute all tasks concurrently
        results = await asyncio.gather(*async_tasks, return_exceptions=True)
        
        # Handle any exceptions
        processed_results = []
        for i, result in enumerate(results):
            if isinstance(result, Exception):
                error_result = {
                    'task_id': tasks[i].get('id', i),
                    'batch_index': i,
                    'success': False,
                    'error': str(result)
                }
                processed_results.append(error_result)
            else:
                processed_results.append(result)
        
        return processed_results
    
    def get_execution_history(self, limit: Optional[int] = None) -> List[Dict[str, Any]]:
        """
        Get execution history
        
        Args:
            limit: Optional limit on number of records to return
            
        Returns:
            List of execution records
        """
        if limit:
            return self.execution_history[-limit:]
        return self.execution_history.copy()
    
    def get_execution_stats(self) -> Dict[str, Any]:
        """
        Get execution statistics
        
        Returns:
            Dictionary with execution statistics
        """
        total_executions = len(self.execution_history)
        successful_executions = sum(1 for record in self.execution_history if record['success'])
        failed_executions = total_executions - successful_executions
        
        # Model usage statistics
        model_usage = {}
        total_cost = 0
        total_time = 0
        
        for record in self.execution_history:
            model = record['model_used']
            model_usage[model] = model_usage.get(model, 0) + 1
            
            if record['success']:
                total_cost += record.get('cost', 0)
                total_time += record.get('execution_time', 0)
        
        return {
            'total_executions': total_executions,
            'successful_executions': successful_executions,
            'failed_executions': failed_executions,
            'success_rate': successful_executions / total_executions if total_executions > 0 else 0,
            'model_usage': model_usage,
            'total_cost': total_cost,
            'average_execution_time': total_time / successful_executions if successful_executions > 0 else 0,
            'most_used_model': max(model_usage, key=model_usage.get) if model_usage else None
        }
    
    def clear_history(self):
        """Clear execution history"""
        self.execution_history.clear()
    
    def register_custom_execution_handler(self, 
                                        model_name: str, 
                                        handler: Callable[[str, Dict[str, Any]], Dict[str, Any]]):
        """
        Register a custom execution handler for a specific model
        
        Args:
            model_name: Name of the model
            handler: Custom execution handler function
        """
        # This would be used to register actual API handlers for different models
        # For now, this is a placeholder for extensibility
        pass
