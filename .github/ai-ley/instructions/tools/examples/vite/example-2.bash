# Initialize new Vite project
npm create vite@latest my-project
cd my-project
npm install
npm run dev

# Add Vite to existing project
npm install --save-dev vite
# Create vite.config.js
touch vite.config.js

# Basic package.json scripts
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  }
}