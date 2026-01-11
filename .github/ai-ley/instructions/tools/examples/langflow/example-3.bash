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