# Secure Cloud-Native DevOps Platform

[![DevOps](https://img.shields.io/badge/DevOps-Complete-brightgreen)](https://github.com/hassan461-hub/CI-CD-Pipeline-using-Jenkins-GitHub-webhook-ubuntu-AWS-EC2-docker-)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)
[![Node.js](https://img.shields.io/badge/Node.js-18%2B-green)](https://nodejs.org/)

A complete, production-ready 3-tier web application with full DevOps, DevSecOps, and Cloud infrastructure automation. Perfect for final year DevOps lab projects.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Quick Start](#quick-start)
- [Folder Structure](#folder-structure)
- [Local Setup](#local-setup)
- [EC2 Deployment](#ec2-deployment)
- [Jenkins Setup](#jenkins-setup)
- [Monitoring](#monitoring)
- [Security Scanning](#security-scanning)
- [Kubernetes](#kubernetes)
- [Terraform](#terraform)
- [Ansible](#ansible)
- [Docker Commands](#docker-commands)
- [Troubleshooting](#troubleshooting)
- [Final Deliverables](#final-deliverables)

---

## 🎯 Overview

**Secure Cloud-Native DevOps Platform** is a comprehensive demonstration of modern DevOps practices including:

- ✅ **3-Tier Architecture** - Frontend, Backend, Database
- ✅ **Containerization** - Docker & Docker Compose
- ✅ **CI/CD Pipeline** - Jenkins automation
- ✅ **Infrastructure as Code** - Terraform for AWS
- ✅ **Configuration Management** - Ansible automation
- ✅ **Monitoring & Observability** - Prometheus & Grafana
- ✅ **Security Scanning** - npm audit & Trivy
- ✅ **Kubernetes Ready** - Complete YAML manifests
- ✅ **Professional UI** - Modern, responsive frontend
- ✅ **Production Patterns** - Best practices throughout

Perfect for:
- Final year university DevOps projects
- Cloud certification preparation
- Portfolio demonstration
- Learning DevOps best practices

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│    FRONTEND (Nginx)                      │
│    Port: 80                              │
│    ✓ Professional UI                    │
│    ✓ Dynamic API Calls                  │
└────────────────┬────────────────────────┘
                 │
┌────────────────▼────────────────────────┐
│    BACKEND (Node.js/Express)             │
│    Port: 3000                            │
│    ✓ REST API                           │
│    ✓ Connection Pool                    │
│    ✓ Retry Logic                        │
└────────────────┬────────────────────────┘
                 │
┌────────────────▼────────────────────────┐
│    DATABASE (MySQL)                      │
│    Port: 3306 (mapped to 3307)          │
│    ✓ Persistent Volumes                 │
│    ✓ Auto Init                          │
└──────────────────────────────────────────┘

MONITORING STACK
├── Prometheus (9090) - Metrics collection
├── Grafana (4000) - Visualization
├── cAdvisor (8081) - Container metrics
└── Node Exporter (9100) - Host metrics
```

---

## ✨ Features

### Frontend Application
- **Professional Design** - Modern UI with Material Design
- **Responsive Layout** - Works on all devices
- **6 Feature Cards**:
  - CI/CD Pipeline
  - Docker Containerization
  - Security Scanning
  - Monitoring Dashboard
  - Kubernetes Ready
  - Infrastructure as Code
- **System Status** - Real-time backend and database status
- **API Testing** - Built-in backend API tester button
- **Dynamic API Calls** - `localhost:3000` address resolution

### Backend API
- **REST Endpoints**:
  - `GET /` - Server status
  - `GET /api/health` - Health check with DB status
  - `GET /api/message` - Application message
  - `GET /api/db-test` - Database connectivity test
- **Connection Pooling** - Efficient database connections
- **Retry Logic** - Graceful handling of slow database startup
- **Error Handling** - Comprehensive error responses
- **Graceful Shutdown** - Proper connection cleanup

### Database
- **MySQL 8.0** - Reliable open-source database
- **3 Tables**:
  - `messages` - Application messages
  - `users` - User information (extensible)
  - `audit_logs` - Action tracking
- **Auto Initialization** - SQL scripts run on startup
- **Persistent Storage** - Data survives container restarts

### DevOps Tools
- **Docker Compose** - 7 integrated services
- **Prometheus** - Metrics collection & storage
- **Grafana** - Beautiful dashboards
- **Jenkins** - CI/CD automation
- **Terraform** - AWS infrastructure automation
- **Ansible** - Server configuration management
- **cAdvisor** - Container monitoring
- **Node Exporter** - Host metrics

---

## 🚀 Quick Start

### Prerequisites
```bash
# Check your system
docker --version      # Docker must be installed
docker compose version  # Docker Compose plugin
git --version         # Git for version control
```

### Run Application (1 Command)
```bash
# Clone repository
git clone <repository-url>
cd secure-cloud-native-devops-platform

# Start everything
docker compose up -d --build

# Wait for services to start (30-60 seconds)
sleep 30

# Verify
docker compose ps
```

### Access Services
| Service | URL | Credentials |
|---------|-----|-------------|
| **Frontend** | http://localhost | N/A |
| **Backend API** | http://localhost:3000 | N/A |
| **Grafana** | http://localhost:4000 | admin/admin123 |
| **Prometheus** | http://localhost:9090 | N/A |
| **cAdvisor** | http://localhost:8081 | N/A |
| **MySQL** | localhost:3307 | root/root |

### Stop Services
```bash
docker compose down

# Remove all data
docker compose down -v
```

---

## 📁 Folder Structure

```
secure-cloud-native-devops-platform/
│
├── frontend/                          # Nginx + HTML/CSS/JS
│   ├── index.html                    # Main page
│   ├── style.css                     # Styling
│   ├── script.js                     # Frontend logic
│   └── Dockerfile                    # Nginx container
│
├── backend/                          # Node.js/Express API
│   ├── server.js                     # Main server file
│   ├── package.json                  # Dependencies
│   └── Dockerfile                    # Node container
│
├── db/                               # MySQL Database
│   └── init.sql                      # Database initialization
│
├── monitoring/                       # Prometheus config
│   └── prometheus.yml                # Prometheus targets
│
├── kubernetes/                       # Kubernetes manifests
│   ├── frontend-deployment.yml       # Frontend K8s deployment
│   ├── backend-deployment.yml        # Backend K8s deployment
│   ├── mysql-deployment.yml          # MySQL K8s StatefulSet
│   ├── frontend-service.yml          # Frontend service
│   ├── backend-service.yml           # Backend service
│   └── mysql-service.yml             # MySQL service
│
├── terraform/                        # AWS infrastructure
│   ├── main.tf                       # EC2, Security Group, EIP
│   ├── variables.tf                  # Input variables
│   ├── outputs.tf                    # Output values
│   └── user_data.sh                  # EC2 initialization
│
├── ansible/                          # Server automation
│   ├── inventory.ini                 # Host inventory
│   └── install-tools.yml             # Installation playbook
│
├── security/                         # Security tools
│   └── security-scan-notes.md        # Scanning guide
│
├── docs/                             # Documentation
│   ├── setup-guide.md                # Local setup steps
│   ├── architecture.md               # System design
│   ├── screenshots-checklist.md      # Screenshot guide
│   └── final-report-outline.md       # Report template
│
├── docker-compose.yml                # Docker Compose config (7 services)
├── Jenkinsfile                       # Jenkins pipeline
├── .gitignore                        # Git ignore rules
└── README.md                         # This file
```

---

## 🖥️ Local Setup Steps

### Step 1: Install Prerequisites
```bash
# Ubuntu/Debian
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io docker-compose-plugin git curl

# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Verify installations
docker --version
docker compose version
```

### Step 2: Clone Repository
```bash
git clone <your-repository-url>
cd secure-cloud-native-devops-platform
```

### Step 3: Start Services
```bash
# Build and start all services
docker compose up -d --build

# Monitor startup progress
docker compose logs -f

# Wait for services to be ready
sleep 30
```

### Step 4: Verify Deployment
```bash
# Check all services running
docker compose ps

# Test each component
curl http://localhost                    # Frontend
curl http://localhost:3000               # Backend root
curl http://localhost:3000/api/health    # Backend health
curl http://localhost:3000/api/message   # Backend message
curl http://localhost:3000/api/db-test   # Database connection
```

### Step 5: Open in Browser
- **Frontend**: http://localhost
- **Grafana**: http://localhost:4000 (admin/admin123)
- **Prometheus**: http://localhost:9090

---

## ☁️ EC2 Deployment Steps

### Step 1: Prepare AWS
```bash
# 1. Create EC2 key pair
aws ec2 create-key-pair --key-name devops-key --region us-east-1 \
    --query 'KeyMaterial' --output text > devops-key.pem
chmod 400 devops-key.pem

# 2. Get your IP for SSH access
curl http://checkip.amazonaws.com  # Your public IP
```

### Step 2: Update Terraform Variables
```bash
cd terraform/

# Edit variables.tf
nano variables.tf

# Key changes needed:
# - aws_region: Your AWS region
# - ami_id: Ubuntu 22.04 AMI for your region
# - instance_type: t3.medium (default)
# - key_pair_name: devops-key (created above)
# - allowed_ssh_cidr: Your IP/32 (e.g., 203.0.113.10/32)
```

### Step 3: Deploy Infrastructure
```bash
cd terraform/

# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Deploy to AWS
terraform apply

# Wait for deployment (2-3 minutes)
# Note the Elastic IP address from output
```

### Step 4: Access EC2 Instance
```bash
# SSH into instance (replace IP with output)
ssh -i devops-key.pem ubuntu@<ELASTIC-IP>

# Clone repository on EC2
git clone <your-repository-url>
cd secure-cloud-native-devops-platform

# Start services
docker compose up -d --build
```

### Step 5: Access Application on EC2
- **Frontend**: http://<ELASTIC-IP>
- **Grafana**: http://<ELASTIC-IP>:4000
- **Prometheus**: http://<ELASTIC-IP>:9090

---

## 🔄 Jenkins CI/CD Setup

### Step 1: Install Jenkins
```bash
# On Ubuntu server
sudo apt update
sudo apt install -y openjdk-11-jdk

# Install Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt update
sudo apt install -y jenkins

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Get initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### Step 2: Configure Jenkins
1. Open http://localhost:8080
2. Paste initial admin password
3. Install suggested plugins
4. Create first admin user
5. Configure Jenkins URL

### Step 3: Create Pipeline Job
1. Click "New Item"
2. Enter job name: "devops-platform-pipeline"
3. Select "Pipeline"
4. In Pipeline section, select "Pipeline script from SCM"
5. Set SCM to Git
6. Enter repository URL
7. Set script path to "Jenkinsfile"
8. Click Save

### Step 4: Run Pipeline
```bash
# Trigger manually or via webhook
# Pipeline will:
# 1. Checkout code
# 2. Install dependencies
# 3. Run security scans
# 4. Build Docker images
# 5. Deploy with docker compose
# 6. Verify deployment
```

### Step 5: View Pipeline Execution
- Open Jenkins job page
- Click "Open Blue Ocean" for visualization
- Watch all stages execute
- View logs for each stage

---

## 📊 Monitoring Setup

### Prometheus
```bash
# Prometheus is running on http://localhost:9090

# Common queries:
# - container_cpu_usage_seconds_total
# - container_memory_usage_bytes
# - node_cpu_seconds_total
# - node_memory_MemAvailable_bytes

# View targets
# Go to: http://localhost:9090/targets
# All targets should show "UP" in green
```

### Grafana Setup
```bash
# 1. Open http://localhost:4000
# 2. Login: admin / admin123
# 3. Add Prometheus data source:
#    - URL: http://prometheus:9090
#    - Access: Server (default)
#    - Click "Save & Test"
# 4. Import dashboards:
#    - Click "+" → Import
#    - Paste dashboard ID from Grafana.com
#    - Select Prometheus as data source
```

### Recommended Dashboards
- ID 1860 - Node Exporter for Prometheus
- ID 893 - Docker and Host Monitoring
- ID 315 - Prometheus

---

## 🔐 Security Scanning

### npm Audit
```bash
cd backend/

# Run security scan
npm audit

# Fix vulnerabilities automatically
npm audit fix

# Output format
# 0 vulnerabilities = Security issue ✓ OK
# Any vulnerabilities = Need remediation
```

### Trivy Container Scanning
```bash
# Install Trivy (if not installed)
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list
sudo apt update && sudo apt install trivy

# Scan filesystem
trivy fs .

# Scan Docker images
trivy image frontend-app:latest
trivy image backend-app:latest

# Scan with specific severity
trivy fs . --severity HIGH,CRITICAL
```

### Security Best Practices
See: [security/security-scan-notes.md](security/security-scan-notes.md)

---

## ☸️ Kubernetes Deployment

### Files Included
- `kubernetes/frontend-deployment.yml` - 2 frontend replicas
- `kubernetes/backend-deployment.yml` - 2 backend replicas
- `kubernetes/mysql-deployment.yml` - MySQL StatefulSet
- `kubernetes/frontend-service.yml` - Frontend LoadBalancer
- `kubernetes/backend-service.yml` - Backend ClusterIP
- `kubernetes/mysql-service.yml` - MySQL Service

### Deploy to Minikube
```bash
# Start Minikube
minikube start

# Build images and push to Minikube
eval $(minikube docker-env)
docker compose build

# Deploy manifests
kubectl apply -f kubernetes/

# Monitor deployment
kubectl get deployments
kubectl get pods
kubectl get services

# Access services
minikube service frontend-service  # Opens browser
```

### Deploy to EKS
```bash
# Update image registry in manifests
# Change: image: frontend-app:latest
# To: image: <account>.dkr.ecr.<region>.amazonaws.com/frontend-app:latest

# Push images to ECR
aws ecr get-login-password --region us-east-1 | \
    docker login --username AWS --password-stdin <account>.dkr.ecr.us-east-1.amazonaws.com

docker tag frontend-app <account>.dkr.ecr.us-east-1.amazonaws.com/frontend-app
docker push <account>.dkr.ecr.us-east-1.amazonaws.com/frontend-app

# Deploy to EKS
kubectl apply -f kubernetes/
```

---

## 🏗️ Terraform AWS Infrastructure

### Files Included
- `terraform/main.tf` - AWS resources (EC2, Security Group, EIP)
- `terraform/variables.tf` - Input variables
- `terraform/outputs.tf` - Output values
- `terraform/user_data.sh` - EC2 initialization script

### Key Resources
- **EC2 Instance** - Ubuntu 22.04 LTS
- **Security Group** - 7 ingress rules (SSH, HTTP, API, Grafana, Prometheus, etc.)
- **Elastic IP** - Static public IP address
- **IAM Roles** - If extended with additional AWS services

### Deployment
```bash
cd terraform/

# Validate configuration
terraform validate

# Preview changes
terraform plan

# Deploy infrastructure
terraform apply

# View outputs
terraform output

# Destroy infrastructure (careful!)
terraform destroy
```

---

## 🤖 Ansible Configuration

### Files Included
- `ansible/inventory.ini` - Host inventory
- `ansible/install-tools.yml` - Installation playbook

### Tasks Automated
- Update system packages
- Install Docker and Docker Compose
- Install Node.js and npm
- Install Git and utilities
- Add user to docker group
- Verify installations

### Execution
```bash
cd ansible/

# Update inventory.ini with your EC2 IP
# Then run:

ansible-playbook -i inventory.ini install-tools.yml

# Or for specific host:
ansible-playbook -i inventory.ini install-tools.yml --limit=devops_server

# Dry run (no changes):
ansible-playbook -i inventory.ini install-tools.yml --check
```

---

## 🐳 Docker Commands

### Common Operations
```bash
# Start services (background)
docker compose up -d

# Start with build
docker compose up -d --build

# Stop services
docker compose down

# Remove all volumes
docker compose down -v

# View logs
docker compose logs -f

# View specific service logs
docker compose logs backend-app

# Execute command in container
docker compose exec backend-app npm version

# Scale service
docker compose up -d --scale backend-app=3

# Restart services
docker compose restart

# Rebuild images
docker compose build
```

### Useful Queries
```bash
# List running containers
docker ps

# List all containers
docker ps -a

# View image sizes
docker images

# View network
docker network inspect devops-network

# View volume
docker volume ls

# Remove unused resources
docker system prune -a --volumes
```

---

## 🔧 Troubleshooting

### Port Already in Use
```bash
# Find process using port
lsof -i :3000

# Kill the process
kill -9 <PID>

# Or change port in docker-compose.yml
```

### MySQL Connection Failed
```bash
# Check MySQL logs
docker compose logs mysql-db

# Restart MySQL
docker compose restart mysql-db

# Wait for startup
sleep 30

# Test connection
curl http://localhost:3000/api/db-test
```

### Services Not Starting
```bash
# Check system resources
free -h  # Memory
df -h    # Disk space

# Full restart
docker compose down
docker compose up -d --build

# Monitor startup
docker compose logs -f
```

### Permission Denied (Docker)
```bash
# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Restart Docker
sudo systemctl restart docker
```

### Slow API Responses
```bash
# Check backend logs
docker compose logs backend-app

# Check database connection
curl http://localhost:3000/api/db-test

# Monitor container metrics
docker stats

# Check resource limits
docker compose top backend-app
```

---

## 📋 Final Deliverables

### Complete Deliverables Checklist
- [x] **Frontend Application** - Professional UI with all features
- [x] **Backend API** - REST endpoints with database integration
- [x] **MySQL Database** - Auto-initialized with sample data
- [x] **Docker Setup** - All services containerized
- [x] **Docker Compose** - 7 services configured
- [x] **Monitoring Stack** - Prometheus, Grafana, cAdvisor, Node Exporter
- [x] **Jenkins Pipeline** - 7 stages of automation
- [x] **Security Scanning** - npm audit and Trivy integration
- [x] **Kubernetes Files** - Production-ready YAML manifests
- [x] **Terraform Code** - AWS infrastructure automation
- [x] **Ansible Playbook** - Server configuration management
- [x] **Documentation** - Comprehensive guides and tutorials
- [x] **Screenshots Guide** - 40-point checklist
- [x] **Report Template** - Complete project report outline

### Repository Structure Verification
```bash
# Verify all required files exist
ls -la secure-cloud-native-devops-platform/

# Expected output shows:
# frontend/          (with Dockerfile, index.html, style.css, script.js)
# backend/           (with Dockerfile, server.js, package.json)
# db/                (with init.sql)
# monitoring/        (with prometheus.yml)
# kubernetes/        (with 6 YAML files)
# terraform/         (with main.tf, variables.tf, outputs.tf, user_data.sh)
# ansible/           (with inventory.ini, install-tools.yml)
# security/          (with security-scan-notes.md)
# docs/              (with 4 markdown files)
# docker-compose.yml (7 services)
# Jenkinsfile        (7 stages)
# .gitignore
# README.md
```

### Getting Started Commands
```bash
# Quick start sequence
git clone <repository-url>
cd secure-cloud-native-devops-platform

# Local testing
docker compose up -d --build
sleep 30
docker compose ps

# Access
# Frontend:   http://localhost
# Grafana:    http://localhost:4000 (admin/admin123)
# Prometheus: http://localhost:9090

# Cleanup
docker compose down -v
```

---

## 📚 Documentation Files

| Document | Purpose |
|----------|---------|
| [docs/setup-guide.md](docs/setup-guide.md) | Step-by-step local setup |
| [docs/architecture.md](docs/architecture.md) | System design and components |
| [docs/screenshots-checklist.md](docs/screenshots-checklist.md) | 40 screenshots for project |
| [docs/final-report-outline.md](docs/final-report-outline.md) | Report template |
| [security/security-scan-notes.md](security/security-scan-notes.md) | Security tools guide |

---

## 🎓 Learning Outcomes

After completing this project, you will understand:

✅ **DevOps Fundamentals**
- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- CI/CD Pipelines (Jenkins)
- Containerization (Docker)

✅ **Cloud Architecture**
- 3-tier application design
- Microservices patterns
- Cloud deployment models
- High availability concepts

✅ **Monitoring & Operations**
- Metrics collection (Prometheus)
- Data visualization (Grafana)
- Application monitoring
- Performance optimization

✅ **Security**
- Vulnerability scanning
- Container security
- Network security groups
- Security best practices

✅ **Tools & Technologies**
- Docker and Docker Compose
- Kubernetes basics
- AWS cloud services
- Jenkins automation

---

## 🤝 Contributing

Suggestions and improvements welcome! Please:

1. Fork the repository
2. Create feature branch
3. Make your improvements
4. Submit pull request

---

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

---

## 🆘 Support & Questions

### For Setup Issues
- Check [docs/setup-guide.md](docs/setup-guide.md)
- Review troubleshooting section above
- Check Docker logs: `docker compose logs`

### For Architecture Questions
- Read [docs/architecture.md](docs/architecture.md)
- Review source code comments
- Check official documentation links

### For Report Help
- Use [docs/final-report-outline.md](docs/final-report-outline.md)
- Follow [docs/screenshots-checklist.md](docs/screenshots-checklist.md)

---

## 📊 Project Statistics

| Metric | Value |
|--------|-------|
| **Total Containers** | 7 |
| **API Endpoints** | 4 |
| **Database Tables** | 3 |
| **CI/CD Stages** | 7 |
| **Kubernetes Objects** | 9 |
| **Terraform Resources** | 6 |
| **Configuration Files** | 10+ |
| **Documentation Pages** | 5 |
| **Total Lines of Code** | 2000+ |

---

## 🎯 Quick Reference

### Essential Commands
```bash
# Start everything
docker compose up -d --build

# Check status
docker compose ps

# View logs
docker compose logs -f backend-app

# Test API
curl http://localhost:3000/api/health | jq

# Stop everything
docker compose down

# Clean everything
docker compose down -v
```

### Service URLs
```
Frontend:    http://localhost
Backend:     http://localhost:3000
Grafana:     http://localhost:4000 (admin/admin123)
Prometheus:  http://localhost:9090
MySQL:       localhost:3307 (root/root)
cAdvisor:    http://localhost:8081
```

### Key Files
```
docker-compose.yml     - Service configuration
Jenkinsfile           - CI/CD pipeline
terraform/main.tf     - AWS infrastructure
ansible/install-tools.yml - Server setup
kubernetes/*.yml      - K8s manifests
```

---

## 🏆 Final Notes

This project demonstrates:
- **Production-ready architecture** - Built with best practices
- **Complete DevOps workflow** - From development to deployment
- **Security-first approach** - Scanning and protection built-in
- **Operational excellence** - Monitoring and observability
- **Infrastructure automation** - Repeatable deployments
- **Documentation** - Comprehensive guides for students

**Perfect for:**
- Final year university projects
- DevOps certification prep
- Portfolio demonstration
- Learning cloud-native development

---

## 📞 Contact

**Project Name**: Secure Cloud-Native DevOps Platform
**Version**: 1.0
**Last Updated**: 2026
**Status**: ✅ Production Ready

---

<div align="center">

**Made with ❤️ for DevOps Engineers**

[⬆ Back to Top](#secure-cloud-native-devops-platform)

</div>
