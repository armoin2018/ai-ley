# Install Neutralino CLI
npm install -g @neutralinojs/neu

# Verify installation
neu --version

# Create new application with template
neu create myapp --template vanilla
# or with specific frontend framework
neu create myapp --template react
neu create myapp --template vue
neu create myapp --template svelte

cd myapp

# Install dependencies
npm install

# Start development server
neu run

# Alternative: Create from scratch
mkdir neutralino-app && cd neutralino-app
neu init

# Install frontend dependencies (if using a framework)
npm install react react-dom  # for React
npm install vue@next         # for Vue 3
npm install svelte           # for Svelte