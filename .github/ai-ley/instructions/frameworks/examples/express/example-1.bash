# Initialize project
npm init -y

# Install Express with TypeScript support
npm install express
npm install -D @types/express typescript @types/node

# Install essential middleware
npm install cors helmet morgan compression dotenv
npm install -D @types/cors @types/morgan

# Development tools
npm install -D nodemon ts-node concurrently

# Create TypeScript config
npx tsc --init