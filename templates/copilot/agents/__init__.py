"""
Agentic Template - Agent System
Dynamic model selection and task routing for GitHub Copilot agents
"""

from .model_selector.agent_executor import AgentExecutor
from .model_selector.model_router import ModelRouter
from .model_selector.task_analyzer import TaskAnalyzer

__version__ = "1.0.0"
__all__ = ["TaskAnalyzer", "ModelRouter", "AgentExecutor"]
