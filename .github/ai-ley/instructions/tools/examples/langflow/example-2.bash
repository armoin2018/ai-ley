# Pull official Docker image
docker pull langflowai/langflow:latest

# Run Langflow container
docker run -it -p 7860:7860 langflowai/langflow:latest

# Run with volume for persistence
docker run -it -p 7860:7860 -v langflow_data:/app/data langflowai/langflow:latest