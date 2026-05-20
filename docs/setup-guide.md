# Secure Cloud-Native DevOps Platform - Project Setup Guide

Welcome to the DevOps Platform Setup Guide! This document will help you set up the complete 3-tier application locally.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Local Development Setup](#local-development-setup)
3. [Verification Steps](#verification-steps)
4. [Troubleshooting](#troubleshooting)
5. [Next Steps](#next-steps)

---

## Prerequisites

### System Requirements
- **OS**: Ubuntu 22.04 LTS or Windows 10/11 with WSL2
- **RAM**: Minimum 4GB (8GB recommended)
- **Disk Space**: At least 20GB free

### Required Software
- **Docker**: Latest version
- **Docker Compose**: Latest version
- **Git**: For version control
- **Terminal/Shell**: Bash or compatible shell

### Installation Commands

#### Linux (Ubuntu/Debian)
```bash
# Update packages
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install -y docker.io docker-compose-plugin

# Add current user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Install Git
sudo apt install -y git

# Verify installations
docker --version
docker compose version
git --version
```

#### macOS
```bash
# Install using Homebrew
brew install docker docker-compose git

# Start Docker Desktop (if using Docker Desktop)
# Then verify:
docker --version
docker compose version
```

#### Windows
- Download and install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
- Enable WSL2 backend
- Download and install [Git for Windows](https://git-scm.com/download/win)

---

## Local Development Setup

### Step 1: Clone Repository
```bash
# Clone the repository
git clone <your-repository-url>

# Navigate to project directory
cd secure-cloud-native-devops-platform
```

### Step 2: Verify Project Structure
```bash
# Check the folder structure
ls -la

# Should display:
# frontend/
# backend/
# db/
# monitoring/
# kubernetes/
# terraform/
# ansible/
# security/
# docs/
# docker-compose.yml
# Jenkinsfile
# .gitignore
# README.md
```

### Step 3: Build and Run with Docker Compose
```bash
# Build all images and start services
docker compose up -d --build

# This command will:
# 1. Build frontend image (Nginx)
# 2. Build backend image (Node.js/Express)
# 3. Create MySQL database with init script
# 4. Start Prometheus for metrics collection
# 5. Start Grafana for visualization
# 6. Start cAdvisor for container metrics
# 7. Start Node Exporter for host metrics

# Wait for services to be ready (about 30-60 seconds)
sleep 30

# Check status of all services
docker compose ps
```

### Step 4: Verify Services are Running
```bash
# List running containers
docker ps

# Should show:
# - frontend-app (port 80)
# - backend-app (port 3000)
# - mysql-db (port 3307)
# - prometheus (port 9090)
# - grafana (port 4000)
# - cadvisor (port 8081)
# - node-exporter (port 9100)
```

### Step 5: Test the Application

#### Test Frontend
```bash
# Access frontend in your browser
# Open: http://localhost

# Or test with curl
curl -s http://localhost | head -20
```

#### Test Backend
```bash
# Test health endpoint
curl -s http://localhost:3000/api/health | jq

# Test message endpoint
curl -s http://localhost:3000/api/message | jq

# Test database connection
curl -s http://localhost:3000/api/db-test | jq
```

---

## Verification Steps

### Health Checks
```bash
# Check all containers are healthy
docker compose ps

# Expected output: All services should have "Up" status
# For example:
# frontend-app   Up (healthy)
# backend-app    Up (healthy)
# mysql-db       Up (healthy)
# prometheus     Up
# grafana        Up
```

### Container Logs
```bash
# View logs from all services
docker compose logs

# View logs from specific service
docker compose logs backend-app

# View real-time logs
docker compose logs -f frontend-app

# View last 50 lines
docker compose logs --tail=50
```

### Database Verification
```bash
# Connect to MySQL
docker compose exec mysql-db mysql -uroot -proot -e "use devopsdb; SELECT * FROM messages;"

# Expected output should show sample messages:
# DevOps Final Project Database Connected Successfully
# Welcome to Secure Cloud-Native DevOps Platform
# MySQL Database is Running and Operational
```

---

## Service Access Information

| Service | URL | Credentials |
|---------|-----|-------------|
| Frontend | http://localhost | N/A |
| Backend API | http://localhost:3000 | N/A |
| MySQL Database | localhost:3307 | root / root |
| Grafana | http://localhost:4000 | admin / admin123 |
| Prometheus | http://localhost:9090 | N/A |
| cAdvisor | http://localhost:8081 | N/A |
| Node Exporter | http://localhost:9100 | N/A |

---

## Troubleshooting

### Issue: Docker Compose Command Not Found
```bash
# Make sure you have docker-compose-plugin installed
sudo apt install -y docker-compose-plugin

# Or use the full path
/usr/libexec/docker/cli-plugins/docker-compose up -d
```

### Issue: Port Already in Use
```bash
# Find process using port
sudo lsof -i :3000

# Kill the process
kill -9 <PID>

# Or modify docker-compose.yml to use different ports
```

### Issue: MySQL Connection Failed
```bash
# Check MySQL logs
docker compose logs mysql-db

# Restart MySQL service
docker compose restart mysql-db

# Wait for MySQL to be ready (important!)
sleep 30

# Test connection from backend
curl -s http://localhost:3000/api/db-test | jq
```

### Issue: Services Not Starting
```bash
# Check system resources
free -h  # Memory
df -h    # Disk space

# Restart all services
docker compose down
docker compose up -d --build

# Watch logs during startup
docker compose logs -f
```

### Issue: Permission Denied Errors
```bash
# Ensure user is in docker group
sudo usermod -aG docker $USER
newgrp docker

# Restart Docker service
sudo systemctl restart docker
```

---

## Common Commands

```bash
# Start services
docker compose up -d

# Stop all services
docker compose down

# Rebuild images and start
docker compose up -d --build

# View logs
docker compose logs -f

# Execute command in container
docker compose exec backend-app npm version

# Scale a service
docker compose up -d --scale backend-app=3

# Remove volumes (CAUTION: deletes data)
docker compose down -v
```

---

## Next Steps

1. **Frontend Testing**
   - Open http://localhost in your browser
   - Click "Test Backend API" button
   - Verify system status indicators

2. **Monitoring Setup**
   - Access Grafana: http://localhost:4000
   - Login: admin / admin123
   - Add Prometheus data source: http://prometheus:9090
   - Create dashboards

3. **Database Exploration**
   - Connect to MySQL on port 3307
   - Explore the devopsdb database
   - Review created tables

4. **Jenkins Integration** (see main README)
   - Configure Jenkins server
   - Set up webhook with GitHub
   - Run CI/CD pipeline

5. **Production Deployment**
   - Review Terraform configuration
   - Update AWS variables
   - Deploy to EC2 instance

---

## Performance Optimization

### For Development
```bash
# Use .env file for custom environment variables
# Create .env.development file:
BACKEND_REPLICAS=1
FRONTEND_REPLICAS=1
```

### For Production
```bash
# Update docker-compose.yml
# Increase replicas
# Add resource limits
# Configure proper logging
```

---

## Cleaning Up

```bash
# Stop all services
docker compose down

# Remove all images
docker compose down --rmi all

# Remove volumes (delete data)
docker compose down -v

# Complete cleanup
docker system prune -a --volumes
```

---

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)
- [Node.js Express Guide](https://expressjs.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Grafana Dashboards](https://grafana.com/grafana/dashboards/)

---

**Questions or Issues?** Check the main README.md for more information or create an issue in the repository.
