# Dockerfile for SQLite-based application
FROM node:18-alpine

# Install SQLite3 and build tools
RUN apk add --no-cache sqlite sqlite-dev python3 make g++

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci --only=production

# Copy application code
COPY . .

# Create data directory with proper permissions
RUN mkdir -p /app/data && \
    chown -R node:node /app/data

# Switch to non-root user
USER node

# Expose application port
EXPOSE 3000

# Health check for SQLite database
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD sqlite3 /app/data/app.db "SELECT 1;" || exit 1

# Start application
CMD ["npm", "start"]