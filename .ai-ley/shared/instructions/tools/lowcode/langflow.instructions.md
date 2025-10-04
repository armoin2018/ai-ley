---
agentMode: general
applyTo: llm-workflows
author: AI-LEY
description: Comprehensive instructions for using Langflow to design, configure, and deploy LLM-powered workflows with visual flow creation, model integration, and deployment strategies.
extensions:
  - .json
  - .py
  - .yaml
guidelines: Follow Langflow best practices and LLM workflow design patterns
instructionType: tools
keywords:
  - langflow
  - llm-workflows
  - visual-programming
  - openai
  - hugging-face
  - langchain
  - flow-design
  - ai-workflows
  - low-code-ai
  - model-chaining
lastUpdated: '2025-09-30T00:00:00.000000'
technicalQualityScore: 5.0
AIUsabilityScore: 5.0
title: Langflow LLM Workflow Design
version: 1.0.0
---

# Langflow LLM Workflow Design Instructions

## Tool Overview

- **Tool Name**: Langflow
- **Version**: 1.0+ (latest stable)
- **Category**: Low-Code AI Development, LLM Workflow Design
- **Purpose**: Visual programming tool for building, configuring, and deploying LLM-powered workflows and AI applications
- **Prerequisites**: Python 3.9+, basic understanding of LLMs and prompt engineering

## Installation & Setup

### Local Installation

```bash
# Install via pip
pip install langflow

# Install with all dependencies
pip install langflow[all]

# Verify installation
langflow --version

# Start Langflow server
langflow run

# Access the UI at http://localhost:7860
```

### Docker Installation

```bash
# Pull official Docker image
docker pull langflowai/langflow:latest

# Run Langflow container
docker run -it -p 7860:7860 langflowai/langflow:latest

# Run with volume for persistence
docker run -it -p 7860:7860 -v langflow_data:/app/data langflowai/langflow:latest
```

### Development Setup

```bash
# Clone from GitHub
git clone https://github.com/logspace-ai/langflow.git
cd langflow

# Install in development mode
pip install -e .

# Install frontend dependencies
cd src/frontend
npm install
npm run build

# Start development server
langflow run --dev
```

## Configuration

### Environment Variables

```bash
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
```

### Configuration File

```yaml
# langflow.yaml
server:
  host: '0.0.0.0'
  port: 7860
  log_level: 'INFO'

database:
  url: 'sqlite:///./langflow.db'

cache:
  type: 'memory'
  redis_url: 'redis://localhost:6379'

auth:
  enabled: true
  type: 'password'
  secret_key: 'your-secret-key'

llm_providers:
  openai:
    api_key: '${OPENAI_API_KEY}'
    default_model: 'gpt-4'
  anthropic:
    api_key: '${ANTHROPIC_API_KEY}'
    default_model: 'claude-3-sonnet'
  huggingface:
    api_token: '${HUGGINGFACE_API_TOKEN}'
```

## Core Features

### Visual Flow Editor

- **Purpose**: Drag-and-drop interface for building LLM workflows
- **Usage**: Connect components with edges to create data flow
- **Components**: Input nodes, LLM nodes, memory nodes, output nodes

### Component Library

- **LLM Models**: OpenAI, Anthropic, HuggingFace, local models
- **Memory Systems**: Conversation buffer, summary memory, vector stores
- **Data Processing**: Text splitters, document loaders, embeddings
- **Chains**: Sequential chains, router chains, conditional logic

### Real-Time Testing

- **Purpose**: Test flows with sample inputs during development
- **Usage**: Input test data and see results propagate through the flow
- **Features**: Debug mode, intermediate outputs, error visualization

## UI-Based Flow Creation

### Getting Started with the Interface

#### Main Canvas

- **Flow Design Area**: Central workspace for building flows
- **Component Palette**: Left sidebar with available components
- **Properties Panel**: Right sidebar for component configuration
- **Toolbar**: Top bar with save, run, export options

#### Creating Your First Flow

```python
# Basic flow structure
1. Start with Input Component
   - Text Input: For user queries
   - File Upload: For document processing
   - Chat Input: For conversational interfaces

2. Add LLM Component
   - Select model provider (OpenAI, Anthropic, etc.)
   - Configure model parameters
   - Set prompt template

3. Connect with Output Component
   - Text Output: For simple responses
   - Chat Output: For conversational flows
   - File Output: For generated content
```

### Component Configuration

#### LLM Component Setup

```json
{
  "component": "OpenAI",
  "configuration": {
    "model": "gpt-4",
    "temperature": 0.7,
    "max_tokens": 1000,
    "system_message": "You are a helpful AI assistant.",
    "prompt_template": "User: {input}\nAssistant:",
    "api_key": "${OPENAI_API_KEY}"
  }
}
```

#### Prompt Template Configuration

```python
# Dynamic prompt with variables
prompt_template = """
You are an expert {expertise_area} assistant.

Context: {context}
User Question: {user_input}

Please provide a detailed response that:
1. Addresses the user's question directly
2. Uses the provided context when relevant
3. Maintains a {tone} tone

Response:
"""

# Template variables from input components
variables = {
    "expertise_area": "software development",
    "context": "{{document_content}}",
    "user_input": "{{user_query}}",
    "tone": "professional"
}
```

### Flow Types and Patterns

#### Simple Q&A Flow

```yaml
flow_pattern: 'linear'
components:
  - type: 'TextInput'
    name: 'user_question'
  - type: 'OpenAI'
    name: 'llm_processor'
    config:
      prompt: 'Answer this question: {user_question}'
  - type: 'TextOutput'
    name: 'answer'
connections:
  - from: 'user_question.text'
    to: 'llm_processor.input'
  - from: 'llm_processor.output'
    to: 'answer.text'
```

#### RAG (Retrieval-Augmented Generation) Flow

```yaml
flow_pattern: 'retrieval_augmented'
components:
  - type: 'TextInput'
    name: 'query'
  - type: 'VectorStore'
    name: 'knowledge_base'
    config:
      embedding_model: 'text-embedding-ada-002'
  - type: 'DocumentRetriever'
    name: 'retriever'
    config:
      top_k: 3
  - type: 'OpenAI'
    name: 'generator'
    config:
      prompt: "Context: {context}\nQuestion: {query}\nAnswer:"
  - type: 'TextOutput'
    name: 'response'
```

## Language Model Integration

### OpenAI Integration

#### Configuration

```python
# OpenAI component configuration
openai_config = {
    "model": "gpt-4",  # or gpt-3.5-turbo, gpt-4-turbo
    "temperature": 0.7,
    "max_tokens": 1000,
    "top_p": 1.0,
    "frequency_penalty": 0.0,
    "presence_penalty": 0.0,
    "api_key": "${OPENAI_API_KEY}",
    "organization": "${OPENAI_ORG_ID}",  # optional
    "api_base": "https://api.openai.com/v1"  # optional
}
```

#### Advanced Features

```python
# Function calling with OpenAI
function_call_config = {
    "functions": [
        {
            "name": "get_weather",
            "description": "Get current weather information",
            "parameters": {
                "type": "object",
                "properties": {
                    "location": {"type": "string"},
                    "unit": {"type": "string", "enum": ["celsius", "fahrenheit"]}
                },
                "required": ["location"]
            }
        }
    ],
    "function_call": "auto"
}
```

### Anthropic Claude Integration

#### Configuration

```python
# Claude component configuration
claude_config = {
    "model": "claude-3-sonnet-20240229",  # or claude-3-opus, claude-3-haiku
    "max_tokens": 1000,
    "temperature": 0.7,
    "top_p": 1.0,
    "api_key": "${ANTHROPIC_API_KEY}",
    "system_message": "You are Claude, an AI assistant created by Anthropic."
}
```

#### Message Structure

```python
# Claude message format
claude_messages = [
    {
        "role": "system",
        "content": "You are a helpful research assistant."
    },
    {
        "role": "user",
        "content": "What are the benefits of renewable energy?"
    }
]
```

### HuggingFace Integration

#### Model Configuration

```python
# HuggingFace component setup
hf_config = {
    "model_name": "microsoft/DialoGPT-large",  # or any HF model
    "api_token": "${HUGGINGFACE_API_TOKEN}",
    "task": "text-generation",
    "max_length": 500,
    "temperature": 0.8,
    "do_sample": True,
    "top_k": 50,
    "top_p": 0.9
}
```

#### Custom Model Loading

```python
# Local model integration
local_model_config = {
    "model_path": "/path/to/local/model",
    "tokenizer_path": "/path/to/tokenizer",
    "device": "cuda",  # or "cpu"
    "torch_dtype": "float16",
    "load_in_8bit": False,
    "trust_remote_code": True
}
```

### Local Model Integration

#### Ollama Integration

```python
# Ollama local models
ollama_config = {
    "base_url": "http://localhost:11434",
    "model": "llama2",  # or any Ollama model
    "temperature": 0.7,
    "num_ctx": 2048,
    "repeat_penalty": 1.1
}
```

#### Custom API Integration

```python
# Custom model API
custom_api_config = {
    "endpoint": "https://your-model-api.com/generate",
    "headers": {
        "Authorization": "Bearer ${CUSTOM_API_KEY}",
        "Content-Type": "application/json"
    },
    "request_format": {
        "prompt": "{input}",
        "max_tokens": 500,
        "temperature": 0.7
    }
}
```

## Memory Management

### Conversation Memory Types

#### Buffer Memory

```python
# Simple conversation buffer
buffer_memory_config = {
    "type": "ConversationBufferMemory",
    "memory_key": "chat_history",
    "return_messages": True,
    "max_token_limit": 2000,
    "human_prefix": "Human",
    "ai_prefix": "Assistant"
}

# Usage in flow
conversation_flow = {
    "memory_component": {
        "type": "ConversationBufferMemory",
        "config": buffer_memory_config
    },
    "llm_component": {
        "prompt": "Previous conversation:\n{chat_history}\n\nHuman: {input}\nAssistant:"
    }
}
```

#### Summary Memory

```python
# Conversation summary memory
summary_memory_config = {
    "type": "ConversationSummaryMemory",
    "llm": "gpt-3.5-turbo",
    "memory_key": "chat_history",
    "return_messages": True,
    "max_token_limit": 1000,
    "summary_prompt": """
    Progressively summarize the lines of conversation provided,
    adding onto the previous summary returning a new summary.

    EXAMPLE
    Current summary: The human asks what the AI thinks of artificial intelligence.
    New lines of conversation:
    Human: Is it sentient?
    AI: I don't have consciousness or sentience.
    New summary: The human asks about AI and sentience. The AI explains it lacks consciousness.

    Current summary: {summary}
    New lines: {new_lines}
    New summary:
    """
}
```

#### Vector Store Memory

```python
# Vector-based memory for semantic search
vector_memory_config = {
    "type": "VectorStoreRetrieverMemory",
    "vector_store": {
        "type": "Chroma",  # or "Pinecone", "Weaviate", "FAISS"
        "embedding_model": "text-embedding-ada-002",
        "collection_name": "conversation_memory",
        "persist_directory": "./chroma_db"
    },
    "retriever_kwargs": {
        "search_type": "similarity",
        "k": 4
    }
}
```

### Memory Implementation Patterns

#### Persistent Memory

```python
# Redis-based persistent memory
redis_memory_config = {
    "type": "RedisChatMemory",
    "redis_url": "redis://localhost:6379",
    "session_key": "user_session_{user_id}",
    "ttl": 3600,  # 1 hour expiration
    "max_messages": 50
}

# Database-backed memory
db_memory_config = {
    "type": "PostgresChatMemory",
    "connection_string": "postgresql://user:pass@localhost/db",
    "table_name": "chat_sessions",
    "session_id_column": "session_id",
    "message_column": "message",
    "timestamp_column": "created_at"
}
```

#### Memory with Context Windows

```python
# Sliding window memory
window_memory_config = {
    "type": "ConversationBufferWindowMemory",
    "memory_key": "chat_history",
    "k": 5,  # Keep last 5 exchanges
    "return_messages": True,
    "input_key": "input",
    "output_key": "output"
}

# Token-based memory management
token_memory_config = {
    "type": "ConversationTokenBufferMemory",
    "llm": "gpt-3.5-turbo",
    "memory_key": "chat_history",
    "max_token_limit": 2000,
    "return_messages": True
}
```

### Memory Flow Integration

```python
# Complete memory-enabled flow
memory_flow = {
    "components": [
        {
            "type": "ChatInput",
            "name": "user_input"
        },
        {
            "type": "ConversationBufferMemory",
            "name": "memory",
            "config": {
                "memory_key": "history",
                "return_messages": True
            }
        },
        {
            "type": "OpenAI",
            "name": "chatbot",
            "config": {
                "model": "gpt-4",
                "temperature": 0.7,
                "prompt_template": """
                You are a helpful assistant. Use the conversation history to provide contextual responses.

                Conversation History:
                {history}

                Current User Input: {input}

                Response:
                """
            }
        },
        {
            "type": "ChatOutput",
            "name": "response"
        }
    ],
    "connections": [
        {"from": "user_input", "to": "memory"},
        {"from": "memory", "to": "chatbot"},
        {"from": "chatbot", "to": "response"},
        {"from": "chatbot", "to": "memory"}  # Store response in memory
    ]
}
```

## Component Chaining and Flow Control

### Sequential Processing Chains

#### Simple Linear Chain

```python
# Basic input -> process -> output chain
linear_chain = {
    "components": [
        {
            "type": "TextInput",
            "name": "user_query",
            "config": {
                "placeholder": "Enter your question..."
            }
        },
        {
            "type": "PromptTemplate",
            "name": "format_prompt",
            "config": {
                "template": "Please answer the following question: {query}",
                "input_variables": ["query"]
            }
        },
        {
            "type": "OpenAI",
            "name": "llm_processor",
            "config": {
                "model": "gpt-4",
                "temperature": 0.3
            }
        },
        {
            "type": "TextOutput",
            "name": "final_response"
        }
    ],
    "connections": [
        {"from": "user_query.text", "to": "format_prompt.query"},
        {"from": "format_prompt.formatted_prompt", "to": "llm_processor.prompt"},
        {"from": "llm_processor.text", "to": "final_response.text"}
    ]
}
```

#### Multi-Step Processing Chain

```python
# Complex processing with validation and formatting
multi_step_chain = {
    "components": [
        {
            "type": "TextInput",
            "name": "raw_input"
        },
        {
            "type": "PythonFunction",
            "name": "input_validator",
            "config": {
                "code": """
def validate_input(text: str) -> dict:
    import re

    # Basic validation
    if len(text.strip()) < 3:
        return {"valid": False, "error": "Input too short"}

    # Check for harmful content
    harmful_patterns = ["hack", "exploit", "malicious"]
    if any(pattern in text.lower() for pattern in harmful_patterns):
        return {"valid": False, "error": "Potentially harmful content"}

    return {"valid": True, "cleaned_text": text.strip()}
                """
            }
        },
        {
            "type": "ConditionalRouter",
            "name": "validation_router",
            "config": {
                "condition": "input.valid == True",
                "true_path": "text_processor",
                "false_path": "error_handler"
            }
        },
        {
            "type": "OpenAI",
            "name": "text_processor",
            "config": {
                "model": "gpt-4",
                "prompt": "Process this text: {cleaned_text}"
            }
        },
        {
            "type": "TextTemplate",
            "name": "error_handler",
            "config": {
                "template": "Error: {error}. Please provide valid input."
            }
        }
    ]
}
```

### Parallel Processing Patterns

#### Multi-Model Comparison

```python
# Compare responses from multiple LLMs
parallel_comparison = {
    "components": [
        {
            "type": "TextInput",
            "name": "question"
        },
        {
            "type": "OpenAI",
            "name": "gpt4_response",
            "config": {
                "model": "gpt-4",
                "temperature": 0.1
            }
        },
        {
            "type": "Anthropic",
            "name": "claude_response",
            "config": {
                "model": "claude-3-sonnet-20240229",
                "temperature": 0.1
            }
        },
        {
            "type": "HuggingFace",
            "name": "llama_response",
            "config": {
                "model": "meta-llama/Llama-2-7b-chat-hf",
                "temperature": 0.1
            }
        },
        {
            "type": "PythonFunction",
            "name": "response_aggregator",
            "config": {
                "code": """
def aggregate_responses(gpt4: str, claude: str, llama: str) -> dict:
    responses = {
        "GPT-4": gpt4,
        "Claude": claude,
        "Llama": llama
    }

    # Simple scoring based on length and completeness
    scores = {}
    for model, response in responses.items():
        score = len(response.split()) / 10  # Simple word count score
        scores[model] = min(score, 10)  # Cap at 10

    best_model = max(scores, key=scores.get)

    return {
        "responses": responses,
        "scores": scores,
        "best_response": responses[best_model],
        "best_model": best_model
    }
                """
            }
        }
    ],
    "connections": [
        {"from": "question.text", "to": "gpt4_response.prompt"},
        {"from": "question.text", "to": "claude_response.prompt"},
        {"from": "question.text", "to": "llama_response.prompt"},
        {"from": "gpt4_response.text", "to": "response_aggregator.gpt4"},
        {"from": "claude_response.text", "to": "response_aggregator.claude"},
        {"from": "llama_response.text", "to": "response_aggregator.llama"}
    ]
}
```

### Conditional Flow Control

#### Dynamic Routing

```python
# Route based on input classification
dynamic_routing = {
    "components": [
        {
            "type": "TextInput",
            "name": "user_input"
        },
        {
            "type": "OpenAI",
            "name": "intent_classifier",
            "config": {
                "model": "gpt-3.5-turbo",
                "prompt": """
Classify the following input into one of these categories:
- question: General questions
- code: Code-related requests
- creative: Creative writing requests
- factual: Factual information requests

Input: {input}
Category:
                """,
                "temperature": 0.1
            }
        },
        {
            "type": "ConditionalRouter",
            "name": "category_router",
            "config": {
                "routes": {
                    "question": "general_qa_chain",
                    "code": "code_assistant_chain",
                    "creative": "creative_writing_chain",
                    "factual": "fact_checker_chain"
                }
            }
        },
        {
            "type": "OpenAI",
            "name": "general_qa_chain",
            "config": {
                "model": "gpt-4",
                "prompt": "Answer this question helpfully: {input}"
            }
        },
        {
            "type": "OpenAI",
            "name": "code_assistant_chain",
            "config": {
                "model": "gpt-4",
                "prompt": "Help with this code request: {input}\nProvide working code with explanations."
            }
        }
    ]
}
```

### Loop and Iteration Patterns

#### Iterative Refinement

```python
# Iteratively improve responses
iterative_refinement = {
    "components": [
        {
            "type": "TextInput",
            "name": "initial_request"
        },
        {
            "type": "Counter",
            "name": "iteration_counter",
            "config": {
                "max_iterations": 3,
                "start_value": 1
            }
        },
        {
            "type": "OpenAI",
            "name": "response_generator",
            "config": {
                "model": "gpt-4",
                "prompt": """
Original request: {request}
Iteration: {iteration}
Previous response: {previous_response}

{iteration_instruction}
                """
            }
        },
        {
            "type": "OpenAI",
            "name": "response_evaluator",
            "config": {
                "model": "gpt-3.5-turbo",
                "prompt": """
Evaluate this response on a scale of 1-10:
Request: {request}
Response: {response}

Score (1-10):
Issues to address:
                """,
                "temperature": 0.1
            }
        },
        {
            "type": "ConditionalLoop",
            "name": "improvement_loop",
            "config": {
                "condition": "score < 8 and iteration < 3",
                "loop_back_to": "response_generator"
            }
        }
    ]
}
```

## Parameter Configuration and Optimization

### Dynamic Parameter Adjustment

#### Temperature Control

```python
# Adaptive temperature based on task type
temperature_config = {
    "task_temperatures": {
        "factual": 0.1,
        "analytical": 0.3,
        "creative": 0.8,
        "brainstorming": 0.9
    },
    "implementation": {
        "type": "PythonFunction",
        "code": """
def get_temperature(task_type: str, user_preference: float = None) -> float:
    base_temps = {
        "factual": 0.1,
        "analytical": 0.3,
        "creative": 0.8,
        "brainstorming": 0.9
    }

    base_temp = base_temps.get(task_type, 0.5)

    if user_preference is not None:
        # Blend user preference with task-appropriate temperature
        return (base_temp + user_preference) / 2

    return base_temp
        """
    }
}
```

#### Token Limit Management

```python
# Dynamic token allocation
token_management = {
    "components": [
        {
            "type": "PythonFunction",
            "name": "token_calculator",
            "config": {
                "code": """
def calculate_tokens(
    prompt: str,
    response_length: str = "medium",
    model: str = "gpt-4"
) -> dict:
    import tiktoken

    # Estimate input tokens
    encoding = tiktoken.encoding_for_model(model)
    input_tokens = len(encoding.encode(prompt))

    # Set max tokens based on desired response length
    length_configs = {
        "short": 150,
        "medium": 500,
        "long": 1500,
        "comprehensive": 3000
    }

    max_response_tokens = length_configs.get(response_length, 500)

    # Model token limits
    model_limits = {
        "gpt-3.5-turbo": 4096,
        "gpt-4": 8192,
        "gpt-4-32k": 32768
    }

    model_limit = model_limits.get(model, 4096)

    # Ensure we don't exceed model limits
    available_tokens = model_limit - input_tokens - 100  # Buffer
    final_max_tokens = min(max_response_tokens, available_tokens)

    return {
        "input_tokens": input_tokens,
        "max_tokens": final_max_tokens,
        "total_estimate": input_tokens + final_max_tokens,
        "model_limit": model_limit
    }
                """
            }
        }
    ]
}
```

### Performance Optimization

#### Response Caching

```python
# Implement response caching for repeated queries
caching_config = {
    "cache_backends": {
        "redis": {
            "type": "RedisCache",
            "host": "localhost",
            "port": 6379,
            "db": 0,
            "ttl": 3600,  # 1 hour
            "key_prefix": "langflow_cache:"
        },
        "memory": {
            "type": "MemoryCache",
            "max_size": 1000,
            "ttl": 1800  # 30 minutes
        }
    },
    "implementation": {
        "type": "PythonFunction",
        "code": """
import hashlib
import json
import redis

def cached_llm_call(
    prompt: str,
    model: str,
    temperature: float,
    cache_backend: str = "redis"
) -> str:
    # Create cache key
    cache_data = {
        "prompt": prompt,
        "model": model,
        "temperature": temperature
    }
    cache_key = hashlib.md5(
        json.dumps(cache_data, sort_keys=True).encode()
    ).hexdigest()

    # Check cache
    if cache_backend == "redis":
        r = redis.Redis(host='localhost', port=6379, db=0)
        cached_response = r.get(f"langflow_cache:{cache_key}")
        if cached_response:
            return cached_response.decode('utf-8')

    # If not cached, make API call (placeholder)
    # response = actual_llm_call(prompt, model, temperature)

    # Cache the response
    # r.setex(f"langflow_cache:{cache_key}", 3600, response)

    return "Generated response"  # Placeholder
        """
    }
}
```

#### Batch Processing

```python
# Process multiple inputs efficiently
batch_processing = {
    "components": [
        {
            "type": "ListInput",
            "name": "input_batch",
            "config": {
                "batch_size": 10
            }
        },
        {
            "type": "PythonFunction",
            "name": "batch_processor",
            "config": {
                "code": """
def process_batch(inputs: list, batch_size: int = 5) -> list:
    import asyncio
    from typing import List

    async def process_single(item: str) -> str:
        # Simulate LLM processing
        # In real implementation, this would be an async LLM call
        await asyncio.sleep(0.1)  # Simulate processing time
        return f"Processed: {item}"

    async def process_batch_async(batch: List[str]) -> List[str]:
        tasks = [process_single(item) for item in batch]
        return await asyncio.gather(*tasks)

    # Process in batches
    results = []
    for i in range(0, len(inputs), batch_size):
        batch = inputs[i:i + batch_size]
        batch_results = asyncio.run(process_batch_async(batch))
        results.extend(batch_results)

    return results
                """
            }
        }
    ]
}
```

## Deployment and Production Setup

### Docker Deployment

#### Basic Docker Setup

```dockerfile
# Dockerfile for Langflow application
FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose port
EXPOSE 7860

# Environment variables
ENV LANGFLOW_HOST=0.0.0.0
ENV LANGFLOW_PORT=7860
ENV LANGFLOW_LOG_LEVEL=INFO

# Run Langflow
CMD ["python", "-m", "langflow", "run", "--host", "0.0.0.0", "--port", "7860"]
```

#### Docker Compose Configuration

```yaml
# docker-compose.yml
version: '3.8'

services:
  langflow:
    build: .
    ports:
      - '7860:7860'
    environment:
      - LANGFLOW_DATABASE_URL=postgresql://langflow:password@postgres:5432/langflow
      - LANGFLOW_CACHE_TYPE=redis
      - LANGFLOW_CACHE_URL=redis://redis:6379/0
    volumes:
      - ./flows:/app/flows
      - ./logs:/app/logs
    depends_on:
      - postgres
      - redis
    restart: unless-stopped

  postgres:
    image: postgres:13
    environment:
      - POSTGRES_DB=langflow
      - POSTGRES_USER=langflow
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - '5432:5432'

  redis:
    image: redis:6-alpine
    ports:
      - '6379:6379'
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:
```

### Cloud Platform Deployment

#### AWS Deployment

```yaml
# AWS ECS Task Definition
{
  'family': 'langflow-task',
  'networkMode': 'awsvpc',
  'requiresCompatibilities': ['FARGATE'],
  'cpu': '1024',
  'memory': '2048',
  'executionRoleArn': 'arn:aws:iam::account:role/ecsTaskExecutionRole',
  'taskRoleArn': 'arn:aws:iam::account:role/ecsTaskRole',
  'containerDefinitions':
    [
      {
        'name': 'langflow',
        'image': 'your-account.dkr.ecr.region.amazonaws.com/langflow:latest',
        'portMappings': [{ 'containerPort': 7860, 'protocol': 'tcp' }],
        'environment':
          [
            { 'name': 'LANGFLOW_HOST', 'value': '0.0.0.0' },
            { 'name': 'LANGFLOW_PORT', 'value': '7860' },
            {
              'name': 'LANGFLOW_DATABASE_URL',
              'value': 'postgresql://user:pass@rds-endpoint:5432/langflow',
            },
          ],
        'secrets':
          [
            {
              'name': 'OPENAI_API_KEY',
              'valueFrom': 'arn:aws:secretsmanager:region:account:secret:openai-api-key',
            },
          ],
        'logConfiguration':
          {
            'logDriver': 'awslogs',
            'options':
              {
                'awslogs-group': '/ecs/langflow',
                'awslogs-region': 'us-west-2',
                'awslogs-stream-prefix': 'ecs',
              },
          },
      },
    ],
}
```

#### Kubernetes Deployment

```yaml
# kubernetes-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: langflow-deployment
  labels:
    app: langflow
spec:
  replicas: 3
  selector:
    matchLabels:
      app: langflow
  template:
    metadata:
      labels:
        app: langflow
    spec:
      containers:
        - name: langflow
          image: langflow/langflow:latest
          ports:
            - containerPort: 7860
          env:
            - name: LANGFLOW_HOST
              value: '0.0.0.0'
            - name: LANGFLOW_PORT
              value: '7860'
            - name: LANGFLOW_DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: langflow-secrets
                  key: database-url
            - name: OPENAI_API_KEY
              valueFrom:
                secretKeyRef:
                  name: langflow-secrets
                  key: openai-api-key
          resources:
            requests:
              memory: '1Gi'
              cpu: '500m'
            limits:
              memory: '2Gi'
              cpu: '1000m'
          livenessProbe:
            httpGet:
              path: /health
              port: 7860
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 7860
            initialDelaySeconds: 5
            periodSeconds: 5

---
apiVersion: v1
kind: Service
metadata:
  name: langflow-service
spec:
  selector:
    app: langflow
  ports:
    - protocol: TCP
      port: 80
      targetPort: 7860
  type: LoadBalancer

---
apiVersion: v1
kind: Secret
metadata:
  name: langflow-secrets
type: Opaque
data:
  database-url: cG9zdGdyZXNxbDovL3VzZXI6cGFzc0Bwb3N0Z3JlczozNTQzMi9sYW5nZmxvdw==
  openai-api-key: c2stWU9VUl9BUElfS0VZX0hFUkU=
```

### Environment Configuration

#### Production Environment Variables

```bash
# .env.production
LANGFLOW_HOST=0.0.0.0
LANGFLOW_PORT=7860
LANGFLOW_LOG_LEVEL=INFO
LANGFLOW_LOG_FILE=/var/log/langflow/app.log

# Database Configuration
LANGFLOW_DATABASE_URL=postgresql://user:pass@localhost:5432/langflow
LANGFLOW_DATABASE_POOL_SIZE=20
LANGFLOW_DATABASE_MAX_OVERFLOW=30

# Cache Configuration
LANGFLOW_CACHE_TYPE=redis
LANGFLOW_CACHE_URL=redis://localhost:6379/0
LANGFLOW_CACHE_DEFAULT_TIMEOUT=3600

# Security
LANGFLOW_SECRET_KEY=your-super-secure-secret-key
LANGFLOW_JWT_SECRET=your-jwt-secret
LANGFLOW_CORS_ORIGINS=["https://yourdomain.com"]

# API Keys (use secrets management in production)
OPENAI_API_KEY=sk-your-openai-key
ANTHROPIC_API_KEY=your-anthropic-key
HUGGINGFACE_API_TOKEN=your-hf-token

# Performance
LANGFLOW_WORKER_TIMEOUT=300
LANGFLOW_MAX_WORKERS=4
LANGFLOW_WORKER_MEMORY_LIMIT=2048

# Feature Flags
LANGFLOW_ENABLE_AUTHENTICATION=true
LANGFLOW_ENABLE_RATE_LIMITING=true
LANGFLOW_ENABLE_MONITORING=true
```

#### Health Checks and Monitoring

```python
# health_check.py
from fastapi import FastAPI
from fastapi.responses import JSONResponse
import asyncio
import aioredis
import asyncpg

async def check_database():
    try:
        conn = await asyncpg.connect("postgresql://user:pass@localhost/langflow")
        await conn.execute("SELECT 1")
        await conn.close()
        return True
    except Exception:
        return False

async def check_redis():
    try:
        redis = aioredis.from_url("redis://localhost:6379")
        await redis.ping()
        await redis.close()
        return True
    except Exception:
        return False

async def check_llm_apis():
    checks = {}

    # Check OpenAI
    try:
        import openai
        openai.api_key = "your-key"
        # Make a simple API call
        checks["openai"] = True
    except Exception:
        checks["openai"] = False

    # Add other API checks

    return checks

app = FastAPI()

@app.get("/health")
async def health_check():
    checks = {
        "database": await check_database(),
        "redis": await check_redis(),
        "llm_apis": await check_llm_apis()
    }

    healthy = all(checks.values())
    status_code = 200 if healthy else 503

    return JSONResponse(
        content={
            "status": "healthy" if healthy else "unhealthy",
            "checks": checks
        },
        status_code=status_code
    )

@app.get("/ready")
async def readiness_check():
    # Check if the application is ready to serve requests
    return {"status": "ready"}
```

### Load Balancing and Scaling

#### NGINX Configuration

```nginx
# nginx.conf
upstream langflow_backend {
    least_conn;
    server langflow-1:7860 max_fails=3 fail_timeout=30s;
    server langflow-2:7860 max_fails=3 fail_timeout=30s;
    server langflow-3:7860 max_fails=3 fail_timeout=30s;
}

server {
    listen 80;
    server_name yourdomain.com;

    # Redirect HTTP to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com;

    ssl_certificate /etc/ssl/certs/yourdomain.com.crt;
    ssl_certificate_key /etc/ssl/private/yourdomain.com.key;

    # SSL Configuration
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512;
    ssl_prefer_server_ciphers off;

    # Security Headers
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";

    # Rate Limiting
    limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;

    location / {
        limit_req zone=api burst=20 nodelay;

        proxy_pass http://langflow_backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # WebSocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";

        # Timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    # Static file serving
    location /static/ {
        alias /var/www/langflow/static/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Health check endpoint
    location /health {
        access_log off;
        proxy_pass http://langflow_backend;
    }
}
```

#### Auto-scaling Configuration

```yaml
# horizontal-pod-autoscaler.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: langflow-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: langflow-deployment
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 10
          periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 60
      policies:
        - type: Percent
          value: 50
          periodSeconds: 60
```

## Practical Use Cases and Examples

### Customer Support Automation

#### Intelligent Ticket Routing

```python
# Multi-tier support system with escalation
support_flow = {
    "components": [
        {
            "type": "TextInput",
            "name": "customer_inquiry",
            "config": {
                "placeholder": "Describe your issue..."
            }
        },
        {
            "type": "OpenAI",
            "name": "intent_classifier",
            "config": {
                "model": "gpt-3.5-turbo",
                "prompt": """
Classify this customer inquiry into one of these categories:
1. TECHNICAL_ISSUE - Technical problems or bugs
2. BILLING - Payment, subscription, or billing questions
3. FEATURE_REQUEST - Requests for new features
4. GENERAL_QUESTION - General product questions
5. URGENT - Critical issues requiring immediate attention

Also rate urgency (1-5) and complexity (1-5).

Inquiry: {inquiry}

Classification:
Category:
Urgency:
Complexity:
Reason:
                """,
                "temperature": 0.1
            }
        },
        {
            "type": "ConditionalRouter",
            "name": "ticket_router",
            "config": {
                "routes": {
                    "URGENT": "escalation_flow",
                    "TECHNICAL_ISSUE": "technical_support_flow",
                    "BILLING": "billing_flow",
                    "FEATURE_REQUEST": "product_team_flow",
                    "GENERAL_QUESTION": "knowledge_base_search"
                }
            }
        },
        {
            "type": "VectorStore",
            "name": "knowledge_base_search",
            "config": {
                "vector_store": "pinecone",
                "index_name": "support_kb",
                "top_k": 3
            }
        },
        {
            "type": "OpenAI",
            "name": "knowledge_response",
            "config": {
                "model": "gpt-4",
                "prompt": """
Based on the knowledge base search results, provide a helpful response to the customer inquiry.

Customer Question: {inquiry}

Relevant Knowledge Base Articles:
{kb_results}

Provide a clear, helpful response. If the knowledge base doesn't contain sufficient information, suggest contacting a human agent.

Response:
                """
            }
        }
    ]
}
```

#### FAQ Generation and Maintenance

```python
# Automated FAQ system
faq_system = {
    "components": [
        {
            "type": "BatchInput",
            "name": "support_tickets",
            "config": {
                "input_type": "csv",
                "columns": ["ticket_id", "question", "resolution", "category"]
            }
        },
        {
            "type": "OpenAI",
            "name": "faq_generator",
            "config": {
                "model": "gpt-4",
                "prompt": """
Analyze these support tickets and generate FAQ entries:

Tickets: {tickets}

For each common issue, create:
1. Clear question
2. Comprehensive answer
3. Related keywords
4. Category

Format as JSON array.
                """,
                "temperature": 0.3
            }
        },
        {
            "type": "VectorStore",
            "name": "faq_updater",
            "config": {
                "operation": "upsert",
                "vector_store": "pinecone",
                "index_name": "faq_index"
            }
        }
    ]
}
```

### Content Generation Workflows

#### Multi-Platform Content Creation

```python
# Content adaptation for different platforms
content_workflow = {
    "components": [
        {
            "type": "TextInput",
            "name": "base_content",
            "config": {
                "placeholder": "Enter your main content..."
            }
        },
        {
            "type": "OpenAI",
            "name": "linkedin_adapter",
            "config": {
                "model": "gpt-4",
                "prompt": """
Adapt this content for LinkedIn (professional, 1300 characters max):

Original: {content}

LinkedIn Post:
                """,
                "temperature": 0.7
            }
        },
        {
            "type": "OpenAI",
            "name": "twitter_adapter",
            "config": {
                "model": "gpt-4",
                "prompt": """
Create a Twitter thread from this content (280 chars per tweet):

Original: {content}

Twitter Thread:
                """,
                "temperature": 0.7
            }
        },
        {
            "type": "OpenAI",
            "name": "blog_adapter",
            "config": {
                "model": "gpt-4",
                "prompt": """
Expand this into a comprehensive blog post with:
- Engaging title
- Introduction
- Main sections with headers
- Conclusion
- SEO-friendly meta description

Original: {content}

Blog Post:
                """,
                "temperature": 0.6
            }
        },
        {
            "type": "ContentFormatter",
            "name": "output_formatter",
            "config": {
                "format": "json",
                "structure": {
                    "linkedin": "linkedin_post",
                    "twitter": "twitter_thread",
                    "blog": "blog_post"
                }
            }
        }
    ]
}
```

#### SEO Content Optimization

```python
# SEO-optimized content generation
seo_workflow = {
    "components": [
        {
            "type": "TextInput",
            "name": "target_keyword"
        },
        {
            "type": "TextInput",
            "name": "content_brief"
        },
        {
            "type": "OpenAI",
            "name": "keyword_research",
            "config": {
                "model": "gpt-4",
                "prompt": """
Generate related keywords and search intent for: {keyword}

Provide:
1. Primary keywords (3-5)
2. Long-tail keywords (5-10)
3. Semantic keywords (5-8)
4. Search intent analysis
5. Competitor analysis suggestions
                """,
                "temperature": 0.3
            }
        },
        {
            "type": "OpenAI",
            "name": "content_generator",
            "config": {
                "model": "gpt-4",
                "prompt": """
Create SEO-optimized content based on:

Target Keyword: {keyword}
Content Brief: {brief}
Keyword Research: {keyword_research}

Requirements:
- 1500-2000 words
- Keyword density 1-2%
- H1, H2, H3 structure
- Meta title (60 chars)
- Meta description (160 chars)
- Internal linking suggestions
                """,
                "temperature": 0.6
            }
        }
    ]
}
```

### Data Analysis and Reporting

#### Business Intelligence Insights

```python
# Automated report generation
bi_reporting = {
    "components": [
        {
            "type": "DataConnector",
            "name": "sales_data",
            "config": {
                "source": "postgresql",
                "query": """
                SELECT
                    DATE_TRUNC('month', order_date) as month,
                    SUM(revenue) as total_revenue,
                    COUNT(*) as order_count,
                    AVG(order_value) as avg_order_value
                FROM sales
                WHERE order_date >= DATE_TRUNC('year', CURRENT_DATE)
                GROUP BY month
                ORDER BY month
                """
            }
        },
        {
            "type": "PythonFunction",
            "name": "data_analyzer",
            "config": {
                "code": """
import pandas as pd
import numpy as np

def analyze_sales_data(data: list) -> dict:
    df = pd.DataFrame(data)

    # Calculate trends
    df['revenue_growth'] = df['total_revenue'].pct_change()
    df['order_growth'] = df['order_count'].pct_change()

    # Key metrics
    total_revenue = df['total_revenue'].sum()
    avg_growth = df['revenue_growth'].mean()
    best_month = df.loc[df['total_revenue'].idxmax()]

    return {
        "total_revenue": total_revenue,
        "average_growth_rate": avg_growth,
        "best_performing_month": best_month.to_dict(),
        "trend_analysis": "positive" if avg_growth > 0 else "negative",
        "monthly_data": df.to_dict('records')
    }
                """
            }
        },
        {
            "type": "OpenAI",
            "name": "insight_generator",
            "config": {
                "model": "gpt-4",
                "prompt": """
Generate business insights from this sales data:

{analysis_results}

Provide:
1. Executive Summary (3-4 sentences)
2. Key Findings (5-7 bullet points)
3. Trends and Patterns
4. Recommendations (3-5 actionable items)
5. Areas of Concern (if any)
6. Growth Opportunities

Format as a professional business report.
                """,
                "temperature": 0.4
            }
        }
    ]
}
```

### Educational and Training Applications

#### Personalized Learning Paths

```python
# Adaptive learning system
learning_system = {
    "components": [
        {
            "type": "StudentProfile",
            "name": "learner_profile",
            "config": {
                "attributes": [
                    "learning_style",
                    "current_level",
                    "goals",
                    "time_availability",
                    "preferred_format"
                ]
            }
        },
        {
            "type": "OpenAI",
            "name": "curriculum_generator",
            "config": {
                "model": "gpt-4",
                "prompt": """
Create a personalized learning path for:

Student Profile: {profile}
Subject: {subject}
Target Outcome: {goals}

Generate:
1. Learning objectives (SMART goals)
2. Module breakdown with timelines
3. Recommended resources for each module
4. Assessment checkpoints
5. Prerequisites and dependencies
6. Difficulty progression
                """,
                "temperature": 0.5
            }
        },
        {
            "type": "ProgressTracker",
            "name": "learning_tracker",
            "config": {
                "metrics": [
                    "completion_rate",
                    "quiz_scores",
                    "time_spent",
                    "difficulty_level"
                ]
            }
        },
        {
            "type": "OpenAI",
            "name": "adaptive_tutor",
            "config": {
                "model": "gpt-4",
                "prompt": """
Based on student progress: {progress}

Provide:
1. Immediate feedback on recent work
2. Areas needing reinforcement
3. Next recommended topics
4. Difficulty adjustment suggestions
5. Motivational message
6. Additional resources if struggling
                """,
                "temperature": 0.6
            }
        }
    ]
}
```

#### Interactive Quiz Generation

```python
# Dynamic quiz creation
quiz_generator = {
    "components": [
        {
            "type": "TextInput",
            "name": "study_material"
        },
        {
            "type": "OpenAI",
            "name": "question_generator",
            "config": {
                "model": "gpt-4",
                "prompt": """
Create a comprehensive quiz from this material: {material}

Generate:
1. Multiple choice questions (5)
2. True/false questions (3)
3. Short answer questions (3)
4. Essay questions (2)

For each question provide:
- Difficulty level (Easy/Medium/Hard)
- Learning objective tested
- Correct answer with explanation
- Common wrong answers and why they're incorrect

Format as structured JSON.
                """,
                "temperature": 0.4
            }
        },
        {
            "type": "QuizValidator",
            "name": "answer_checker",
            "config": {
                "scoring_method": "weighted",
                "partial_credit": True
            }
        }
    ]
}
```

### API Integration and Workflow Automation

#### Multi-API Orchestration

```python
# Complex API integration workflow
api_workflow = {
    "components": [
        {
            "type": "WebhookTrigger",
            "name": "order_webhook",
            "config": {
                "endpoint": "/api/orders/new",
                "method": "POST"
            }
        },
        {
            "type": "HTTPRequest",
            "name": "inventory_check",
            "config": {
                "url": "https://inventory.example.com/api/check",
                "method": "GET",
                "headers": {
                    "Authorization": "Bearer {inventory_token}"
                }
            }
        },
        {
            "type": "ConditionalRouter",
            "name": "stock_router",
            "config": {
                "condition": "inventory.in_stock == true",
                "true_path": "process_order",
                "false_path": "backorder_flow"
            }
        },
        {
            "type": "HTTPRequest",
            "name": "payment_processor",
            "config": {
                "url": "https://payments.example.com/api/charge",
                "method": "POST",
                "body": {
                    "amount": "{order.total}",
                    "currency": "USD",
                    "customer_id": "{order.customer_id}"
                }
            }
        },
        {
            "type": "OpenAI",
            "name": "confirmation_generator",
            "config": {
                "model": "gpt-4",
                "prompt": """
Generate a personalized order confirmation email:

Order Details: {order}
Customer: {customer}
Payment: {payment}

Include:
- Warm greeting with customer name
- Order summary with items and pricing
- Estimated delivery date
- Tracking information
- Customer service contact
- Upsell suggestions (relevant products)
                """,
                "temperature": 0.7
            }
        },
        {
            "type": "EmailSender",
            "name": "notification_sender",
            "config": {
                "smtp_server": "smtp.example.com",
            }
        }
    ]
}
```

## Troubleshooting and Common Issues

### Performance Issues

#### High Memory Usage

```bash
# Monitor memory usage
docker stats langflow-container

# Check for memory leaks in flows
htop -p $(pgrep -f langflow)

# Optimize memory settings
export LANGFLOW_MAX_WORKERS=2
export LANGFLOW_WORKER_MEMORY_LIMIT=1024
```

**Solutions:**

- Reduce batch sizes in processing components
- Implement pagination for large datasets
- Use streaming for file processing
- Clear unused variables in Python functions
- Optimize vector store chunk sizes

#### Slow Response Times

```python
# Performance monitoring component
performance_monitor = {
    "type": "PythonFunction",
    "code": """
import time
import psutil
import logging

def monitor_performance(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        start_memory = psutil.Process().memory_info().rss / 1024 / 1024

        try:
            result = func(*args, **kwargs)
            success = True
        except Exception as e:
            result = str(e)
            success = False

        end_time = time.time()
        end_memory = psutil.Process().memory_info().rss / 1024 / 1024

        metrics = {
            "execution_time": end_time - start_time,
            "memory_used": end_memory - start_memory,
            "success": success,
            "function": func.__name__
        }

        logging.info(f"Performance: {metrics}")
        return result

    return wrapper
    """
}
```

**Optimization strategies:**

- Enable response caching for repeated queries
- Use async/await for concurrent operations
- Implement connection pooling for databases
- Optimize prompt lengths and token usage
- Use CDN for static assets

### API Integration Problems

#### Rate Limiting Issues

```python
# Rate limiting handler
rate_limit_handler = {
    "type": "PythonFunction",
    "code": """
import time
import random
from functools import wraps

def rate_limit_retry(max_retries=3, base_delay=1):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(max_retries):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    if "rate limit" in str(e).lower() and attempt < max_retries - 1:
                        delay = base_delay * (2 ** attempt) + random.uniform(0, 1)
                        print(f"Rate limited. Retrying in {delay:.2f}s...")
                        time.sleep(delay)
                        continue
                    raise
            return None
        return wrapper
    return decorator

@rate_limit_retry(max_retries=5, base_delay=2)
def api_call_with_retry(url, headers, data):
    # Your API call implementation
    pass
    """
}
```

#### Authentication Failures

```python
# Token refresh mechanism
auth_manager = {
    "type": "PythonFunction",
    "code": """
import requests
import time
from datetime import datetime, timedelta

class TokenManager:
    def __init__(self):
        self.tokens = {}

    def get_valid_token(self, service):
        if service not in self.tokens:
            return self.refresh_token(service)

        token_data = self.tokens[service]
        if datetime.now() >= token_data['expires_at']:
            return self.refresh_token(service)

        return token_data['token']

    def refresh_token(self, service):
        if service == "openai":
            # OpenAI uses static API keys
            return os.getenv("OPENAI_API_KEY")
        elif service == "anthropic":
            return os.getenv("ANTHROPIC_API_KEY")
        # Add other services as needed

    def handle_auth_error(self, service, error):
        if "unauthorized" in str(error).lower():
            print(f"Auth failed for {service}. Refreshing token...")
            return self.refresh_token(service)
        raise error
    """
}
```

### Flow Execution Errors

#### Component Connection Issues

```yaml
# Debug connection configuration
debug_connections:
  validation_rules:
    - source_output_exists: true
    - target_input_compatible: true
    - data_type_matching: true
    - circular_dependency_check: true

  common_fixes:
    - check_component_outputs: 'Verify component produces expected output'
    - validate_input_types: 'Ensure input types match component requirements'
    - review_flow_logic: 'Check for logical errors in flow design'
    - test_components_individually: 'Isolate and test each component'
```

#### Data Type Mismatches

```python
# Type conversion utilities
type_converter = {
    "type": "PythonFunction",
    "code": """
def safe_type_conversion(value, target_type):
    try:
        if target_type == "string":
            return str(value)
        elif target_type == "integer":
            return int(float(value))  # Handle decimal strings
        elif target_type == "float":
            return float(value)
        elif target_type == "boolean":
            if isinstance(value, str):
                return value.lower() in ['true', '1', 'yes', 'on']
            return bool(value)
        elif target_type == "list":
            if isinstance(value, str):
                import json
                return json.loads(value)
            return list(value)
        elif target_type == "dict":
            if isinstance(value, str):
                import json
                return json.loads(value)
            return dict(value)
        else:
            return value
    except (ValueError, TypeError, json.JSONDecodeError) as e:
        print(f"Type conversion error: {e}")
        return None
    """
}
```

### Database and Storage Issues

#### Vector Store Connection Problems

```python
# Vector store health check
vector_store_diagnostics = {
    "pinecone": {
        "check_connection": """
import pinecone

try:
    pinecone.init(api_key="your-key", environment="your-env")
    index = pinecone.Index("your-index")
    stats = index.describe_index_stats()
    print(f"Index stats: {stats}")
    return True
except Exception as e:
    print(f"Pinecone connection failed: {e}")
    return False
        """,
        "common_issues": [
            "API key expired or invalid",
            "Environment mismatch",
            "Index not found",
            "Quota exceeded"
        ]
    },
    "chroma": {
        "check_connection": """
import chromadb

try:
    client = chromadb.Client()
    collections = client.list_collections()
    print(f"Available collections: {collections}")
    return True
except Exception as e:
    print(f"Chroma connection failed: {e}")
    return False
        """,
        "common_issues": [
            "Service not running",
            "Port conflicts",
            "Permission issues",
            "Disk space problems"
        ]
    }
}
```

#### Database Migration Issues

```sql
-- Check database schema
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'langflow';

-- Verify indexes
SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'langflow';

-- Check for missing migrations
SELECT version, dirty
FROM schema_migrations
ORDER BY version DESC
LIMIT 5;
```

### Debugging Tools and Techniques

#### Flow Execution Logging

```python
# Enhanced logging configuration
logging_config = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "detailed": {
            "format": "%(asctime)s - %(name)s - %(levelname)s - %(funcName)s:%(lineno)d - %(message)s"
        },
        "simple": {
            "format": "%(levelname)s - %(message)s"
        }
    },
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "level": "INFO",
            "formatter": "simple",
            "stream": "ext://sys.stdout"
        },
        "file": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "DEBUG",
            "formatter": "detailed",
            "filename": "/var/log/langflow/app.log",
            "maxBytes": 10485760,  # 10MB
            "backupCount": 5
        }
    },
    "loggers": {
        "langflow": {
            "level": "DEBUG",
            "handlers": ["console", "file"],
            "propagate": False
        }
    }
}
```

#### Component Testing Framework

```python
# Unit testing for flow components
import unittest
from unittest.mock import Mock, patch

class TestFlowComponents(unittest.TestCase):
    def setUp(self):
        self.mock_openai = Mock()
        self.mock_vector_store = Mock()

    def test_prompt_template_formatting(self):
        from langflow.components import PromptTemplate

        template = PromptTemplate(
            template="Hello {name}, your question: {question}",
            input_variables=["name", "question"]
        )

        result = template.format(name="Alice", question="What is AI?")
        expected = "Hello Alice, your question: What is AI?"

        self.assertEqual(result, expected)

    @patch('openai.ChatCompletion.create')
    def test_openai_component(self, mock_create):
        mock_create.return_value = Mock(
            choices=[Mock(message=Mock(content="Test response"))]
        )

        from langflow.components import OpenAI

        component = OpenAI(model="gpt-3.5-turbo")
        result = component.run("Test prompt")

        self.assertEqual(result, "Test response")
        mock_create.assert_called_once()

    def test_flow_execution(self):
        # Test complete flow execution
        flow_config = {
            "components": [...],
            "connections": [...]
        }

        # Execute flow and verify results
        pass

if __name__ == "__main__":
    unittest.main()
```

### Common Error Messages and Solutions

#### "Component not found" Error

```bash
# Solution: Check component registration
langflow list-components

# Reinstall missing components
pip install langflow[all]

# Update component imports
pip install --upgrade langflow
```

#### "Memory allocation failed" Error

```bash
# Solution: Adjust memory limits
docker run -m 4g langflow/langflow

# Or use environment variables
export LANGFLOW_WORKER_MEMORY_LIMIT=2048
export LANGFLOW_MAX_WORKERS=2
```

#### "API quota exceeded" Error

```python
# Solution: Implement quota management
quota_manager = {
    "daily_limits": {
        "openai": 1000000,  # tokens
        "anthropic": 500000,
        "huggingface": 10000  # requests
    },
    "usage_tracking": {
        "file": "/var/log/langflow/api_usage.json",
        "reset_daily": True
    }
}
```

### Performance Optimization Checklist

1. **Flow Design:**

   - [ ] Minimize API calls in loops
   - [ ] Use batch processing where possible
   - [ ] Implement proper error handling
   - [ ] Cache frequently used data

2. **Resource Management:**

   - [ ] Monitor memory usage
   - [ ] Set appropriate worker limits
   - [ ] Use connection pooling
   - [ ] Implement graceful shutdowns

3. **API Optimization:**

   - [ ] Implement rate limiting
   - [ ] Use appropriate model sizes
   - [ ] Optimize prompt lengths
   - [ ] Handle API failures gracefully

4. **Database Performance:**
   - [ ] Index frequently queried fields
   - [ ] Use appropriate connection limits
   - [ ] Implement query optimization
   - [ ] Monitor slow queries

## AI Assistant Guidelines

### Code Generation Rules

#### Flow Architecture Patterns

1. **Always start with clear input/output definitions**
2. **Use descriptive component names that indicate purpose**
3. **Implement proper error handling at each stage**
4. **Include validation steps for user inputs**
5. **Design for scalability from the beginning**

#### Component Selection Priorities

```python
# Priority order for LLM components
llm_priorities = {
    "high_accuracy": ["gpt-4", "claude-3-opus", "gpt-4-turbo"],
    "cost_effective": ["gpt-3.5-turbo", "claude-3-haiku", "llama-2-7b"],
    "fast_response": ["gpt-3.5-turbo", "claude-3-haiku", "local-models"],
    "specialized_tasks": {
        "code_generation": ["gpt-4", "claude-3-sonnet", "codellama"],
        "creative_writing": ["gpt-4", "claude-3-opus", "gpt-4-turbo"],
        "data_analysis": ["gpt-4", "claude-3-sonnet", "gpt-4-turbo"],
        "translation": ["gpt-4", "claude-3-sonnet", "specialized-models"]
    }
}
```

#### Prompt Engineering Standards

```python
# Standard prompt template structure
prompt_template = """
System Context: {system_role}
Task Description: {task_description}
Input Data: {input_data}
Constraints: {constraints}
Output Format: {output_format}
Examples: {examples}
"""

# Best practices for prompt design
prompt_guidelines = {
    "clarity": "Use clear, specific language and avoid ambiguity",
    "context": "Provide relevant context and background information",
    "examples": "Include 2-3 examples of expected input/output",
    "constraints": "Specify limitations, format requirements, and boundaries",
    "role_definition": "Clearly define the AI's role and expertise",
    "output_structure": "Define expected output format and structure"
}
```

### Flow Design Best Practices

#### Modular Component Strategy

```python
# Create reusable component templates
reusable_components = {
    "input_validator": {
        "type": "PythonFunction",
        "purpose": "Validate and sanitize user inputs",
        "template": """
def validate_input(text: str, min_length: int = 1, max_length: int = 1000) -> dict:
    if not isinstance(text, str):
        return {"valid": False, "error": "Input must be a string"}

    text = text.strip()
    if len(text) < min_length:
        return {"valid": False, "error": f"Input too short (min: {min_length})"}

    if len(text) > max_length:
        return {"valid": False, "error": f"Input too long (max: {max_length})"}

    return {"valid": True, "text": text}
        """
    },
    "response_formatter": {
        "type": "PythonFunction",
        "purpose": "Format AI responses consistently",
        "template": """
def format_response(response: str, format_type: str = "markdown") -> str:
    if format_type == "markdown":
        # Add markdown formatting
        return f"**Response:**\\n\\n{response}\\n\\n---"
    elif format_type == "json":
        return json.dumps({"response": response, "timestamp": datetime.now().isoformat()})
    elif format_type == "html":
        return f"<div class='ai-response'><p>{response}</p></div>"
    else:
        return response
        """
    }
}
```

#### Error Handling Patterns

```python
# Comprehensive error handling framework
error_handling = {
    "api_errors": {
        "retry_logic": "Implement exponential backoff for transient failures",
        "fallback_models": "Use alternative LLM providers when primary fails",
        "graceful_degradation": "Provide simplified responses when full processing fails"
    },
    "validation_errors": {
        "user_feedback": "Provide clear, actionable error messages",
        "suggestion_system": "Offer alternative inputs or corrections",
        "progressive_validation": "Validate inputs at multiple stages"
    },
    "system_errors": {
        "logging": "Comprehensive error logging for debugging",
        "monitoring": "Real-time error rate monitoring",
        "alerting": "Automated alerts for critical failures"
    }
}
```

### Security and Privacy Guidelines

#### Data Protection Measures

```python
# Privacy-preserving processing
privacy_controls = {
    "data_sanitization": {
        "pii_detection": "Detect and mask personally identifiable information",
        "content_filtering": "Remove or flag sensitive content",
        "anonymization": "Replace identifiers with anonymous tokens"
    },
    "secure_storage": {
        "encryption": "Encrypt sensitive data at rest and in transit",
        "access_control": "Implement role-based access controls",
        "audit_logging": "Log all data access and modifications"
    },
    "compliance": {
        "gdpr": "Ensure GDPR compliance for EU users",
        "ccpa": "Implement CCPA requirements for California users",
        "hipaa": "HIPAA compliance for healthcare applications"
    }
}
```

#### Input Sanitization

```python
# Security-focused input validation
security_validator = {
    "type": "PythonFunction",
    "code": """
import re
import html

def secure_input_validation(user_input: str) -> dict:
    # Check for injection attacks
    sql_patterns = ['select', 'drop', 'insert', 'update', 'delete', 'union']
    script_patterns = ['<script', 'javascript:', 'onload=', 'onerror=']

    lower_input = user_input.lower()

    # SQL injection detection
    if any(pattern in lower_input for pattern in sql_patterns):
        return {"safe": False, "reason": "Potential SQL injection detected"}

    # XSS detection
    if any(pattern in lower_input for pattern in script_patterns):
        return {"safe": False, "reason": "Potential XSS attempt detected"}

    # Sanitize HTML
    sanitized = html.escape(user_input)

    # Remove excessive whitespace
    sanitized = re.sub(r'\\s+', ' ', sanitized).strip()

    return {"safe": True, "sanitized_input": sanitized}
    """
}
```

### Performance Optimization Guidelines

#### Efficient Flow Design

```python
# Performance optimization strategies
optimization_strategies = {
    "component_efficiency": {
        "batch_processing": "Process multiple items simultaneously",
        "lazy_evaluation": "Only execute components when needed",
        "caching_strategy": "Cache expensive operations and frequent requests",
        "parallel_execution": "Run independent components in parallel"
    },
    "resource_management": {
        "memory_optimization": "Minimize memory usage in data processing",
        "connection_pooling": "Reuse database and API connections",
        "garbage_collection": "Properly clean up resources after use",
        "streaming_processing": "Use streaming for large data sets"
    },
    "api_optimization": {
        "request_batching": "Batch API requests when possible",
        "response_caching": "Cache API responses for repeated queries",
        "rate_limiting": "Implement proper rate limiting to avoid throttling",
        "model_selection": "Choose appropriate model size for task complexity"
    }
}
```

### Testing and Quality Assurance

#### Flow Testing Framework

```python
# Comprehensive testing approach
testing_framework = {
    "unit_tests": {
        "component_testing": "Test individual components in isolation",
        "input_validation": "Test input validation and edge cases",
        "output_verification": "Verify component outputs match expectations",
        "error_handling": "Test error conditions and recovery"
    },
    "integration_tests": {
        "flow_execution": "Test complete flow execution paths",
        "api_integration": "Test external API integrations",
        "database_operations": "Test database read/write operations",
        "performance_benchmarks": "Measure execution time and resource usage"
    },
    "user_acceptance_tests": {
        "scenario_testing": "Test real-world usage scenarios",
        "usability_testing": "Verify user interface and experience",
        "load_testing": "Test system behavior under high load",
        "stress_testing": "Test system limits and failure modes"
    }
}
```

### Documentation Standards

#### Flow Documentation Requirements

```markdown
# Flow Documentation Template

## Overview

- **Purpose**: Clear description of what the flow accomplishes
- **Use Cases**: Primary scenarios where this flow is applicable
- **Prerequisites**: Required setup, API keys, or dependencies

## Architecture

- **Components**: List and description of each component
- **Data Flow**: Step-by-step data transformation process
- **Decision Points**: Conditional logic and routing rules

## Configuration

- **Environment Variables**: Required configuration settings
- **API Keys**: External service authentication requirements
- **Resource Limits**: Memory, CPU, and storage requirements

## Testing

- **Test Cases**: Defined test scenarios and expected outcomes
- **Performance Metrics**: Baseline performance measurements
- **Known Limitations**: Current constraints and limitations

## Maintenance

- **Update Procedures**: How to modify and update the flow
- **Monitoring**: Key metrics to monitor in production
- **Troubleshooting**: Common issues and their solutions
```

### Deployment and Maintenance Guidelines

#### Production Readiness Checklist

```yaml
production_checklist:
  security:
    - [ ] Input validation implemented
    - [ ] Authentication and authorization configured
    - [ ] Sensitive data encryption enabled
    - [ ] Security headers configured
    - [ ] Rate limiting implemented

  performance:
    - [ ] Load testing completed
    - [ ] Performance benchmarks established
    - [ ] Caching strategy implemented
    - [ ] Resource limits configured
    - [ ] Monitoring and alerting set up

  reliability:
    - [ ] Error handling implemented
    - [ ] Backup and recovery procedures tested
    - [ ] Health checks configured
    - [ ] Graceful shutdown procedures
    - [ ] Rollback procedures documented

  compliance:
    - [ ] Data privacy requirements met
    - [ ] Audit logging implemented
    - [ ] Compliance certifications verified
    - [ ] Data retention policies implemented
```

#### Monitoring and Observability

```python
# Comprehensive monitoring setup
monitoring_config = {
    "metrics": {
        "business_metrics": [
            "flow_execution_count",
            "success_rate",
            "average_response_time",
            "user_satisfaction_score"
        ],
        "technical_metrics": [
            "api_response_time",
            "error_rate",
            "memory_usage",
            "cpu_utilization"
        ],
        "cost_metrics": [
            "api_token_usage",
            "infrastructure_cost",
            "cost_per_execution"
        ]
    },
    "alerting": {
        "critical_alerts": [
            "system_down",
            "high_error_rate",
            "api_quota_exceeded"
        ],
        "warning_alerts": [
            "high_response_time",
            "memory_usage_high",
            "unusual_traffic_pattern"
        ]
    },
    "dashboards": {
        "operational": "Real-time system health and performance",
        "business": "Business metrics and KPIs",
        "cost": "Cost analysis and optimization opportunities"
    }
}
```

These guidelines ensure that AI assistants can effectively help users create robust, secure, and maintainable Langflow applications while following best practices for enterprise deployment and operation.

```

```
