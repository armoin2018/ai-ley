# API Keys for LLM providers
export OPENAI_API_KEY="your-openai-api-key"
export ANTHROPIC_API_KEY="your-anthropic-api-key"
export HUGGINGFACE_API_TOKEN="your-hf-token"
export COHERE_API_KEY="your-cohere-api-key"

# Langflow configuration
export LANGFLOW_HOST="0.0.0.0"
export LANGFLOW_PORT="7860"
export LANGFLOW_LOG_LEVEL="INFO"
export LANGFLOW_CACHE_TYPE="memory"  # or "redis"

# Database configuration
export LANGFLOW_DATABASE_URL="sqlite:///./langflow.db"
export LANGFLOW_REDIS_URL="redis://localhost:6379"

# Security settings
export LANGFLOW_SECRET_KEY="your-secret-key"
export LANGFLOW_AUTH_TYPE="password"  # or "oauth"