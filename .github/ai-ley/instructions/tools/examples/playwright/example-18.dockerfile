# Dockerfile for Playwright
FROM mcr.microsoft.com/playwright:v1.41.0-focal

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Run tests
CMD ["npx", "playwright", "test"]