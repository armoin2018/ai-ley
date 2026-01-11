# Optimized Dockerfile template
FROM node:18-alpine AS dependencies

# Install only production dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM node:18-alpine AS runner
WORKDIR /app

# Copy dependencies
COPY --from=dependencies /app/node_modules ./node_modules
# Copy built application
COPY --from=builder /app/dist ./dist
# Copy package.json for start script
COPY package*.json ./

# Create non-root user
RUN addgroup -g 1001 -S nodejs &&
    adduser -S nextjs -u 1001

USER nextjs

EXPOSE 3000
CMD ["npm", "start"]