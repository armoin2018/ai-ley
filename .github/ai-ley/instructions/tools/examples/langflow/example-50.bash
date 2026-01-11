# Monitor memory usage
docker stats langflow-container

# Check for memory leaks in flows
htop -p $(pgrep -f langflow)

# Optimize memory settings
export LANGFLOW_MAX_WORKERS=2
export LANGFLOW_WORKER_MEMORY_LIMIT=1024