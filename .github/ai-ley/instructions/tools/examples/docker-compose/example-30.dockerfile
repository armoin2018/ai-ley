# Multi-stage Dockerfile optimized for Compose
FROM node:18-alpine AS base
WORKDIR /app
COPY package*.json ./

FROM base AS dependencies
RUN npm ci --only=production && npm cache clean --force

FROM base AS development
RUN npm ci
COPY . .
CMD ["npm", "run", "dev"]

FROM dependencies AS production
COPY . .
RUN npm run build
USER node
CMD ["npm", "start"]