# Create new Electron app with Forge
npm create electron-app@latest my-app
cd my-app

# Or with specific template
npm create electron-app@latest my-app -- --template=typescript
npm create electron-app@latest my-app -- --template=typescript-webpack
npm create electron-app@latest my-app -- --template=vite-typescript

# Development
npm start

# Build for distribution
npm run make