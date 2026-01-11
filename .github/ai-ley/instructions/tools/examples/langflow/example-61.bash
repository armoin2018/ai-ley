# Solution: Adjust memory limits
docker run -m 4g langflow/langflow

# Or use environment variables
export LANGFLOW_WORKER_MEMORY_LIMIT=2048
export LANGFLOW_MAX_WORKERS=2