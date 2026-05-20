# Backend Dockerfile - Node.js Express API
# Multi-stage build for optimized production image

# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Production stage
FROM node:18-alpine

WORKDIR /app

# Install curl for health checks
RUN apk add --no-cache curl

# Copy from builder
COPY --from=builder /app/node_modules ./node_modules

# Copy application files
COPY server.js .
COPY package*.json ./

# Create .env file template (will be overridden by docker-compose)
RUN echo "DB_HOST=mysql-db\nDB_USER=root\nDB_PASSWORD=root\nDB_NAME=devopsdb\nPORT=3000" > .env

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:3000/api/health || exit 1

# Start the application
CMD ["npm", "start"]
