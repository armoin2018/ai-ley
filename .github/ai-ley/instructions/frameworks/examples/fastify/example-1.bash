# Create new project
npm init -y
npm install fastify

# TypeScript support
npm install -D typescript @types/node ts-node
npm install fastify @fastify/type-provider-typebox

# Additional plugins
npm install @fastify/cors @fastify/helmet @fastify/rate-limit @fastify/jwt