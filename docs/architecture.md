# Architecture Diagram and Explanation

## System Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         INTERNET / USERS                          │
└────────────────────────────┬────────────────────────────────────┘
                             │ (HTTP:80 / HTTPS)
                             │
        ┌────────────────────▼──────────────────────┐
        │    FRONTEND APPLICATION (Nginx)            │
        │    ✓ React/HTML/CSS/JavaScript            │
        │    ✓ Responsive Design                     │
        │    ✓ Dynamic API Calls                     │
        │    Port: 80                                │
        │    Container: frontend-app                 │
        └────────────────────┬──────────────────────┘
                             │ (HTTP:3000)
        ┌────────────────────▼──────────────────────┐
        │    BACKEND APPLICATION (Node.js/Express)  │
        │    ✓ REST API Endpoints                    │
        │    ✓ Connection Pool                       │
        │    ✓ Error Handling                        │
        │    ✓ Health Checks                         │
        │    Port: 3000                              │
        │    Container: backend-app                  │
        └────────┬──────────────────────┬────────┬──┘
                 │ (TCP:3306)           │        │
                 │                      │        └──────────┐
    ┌────────────▼──────────────────┐  │                   │
    │  DATABASE LAYER (MySQL)        │  │    ┌─────────────▼─────────┐
    │  ✓ Database: devopsdb          │  │    │  MONITORING LAYER      │
    │  ✓ Tables: messages, users     │  │    ├────────────────────────┤
    │  ✓ Persistent Volumes          │  │    │ Prometheus (9090)      │
    │  ✓ Init Script                 │  │    │ - Scrapes Metrics      │
    │  Port: 3307 (host)             │  │    │ - Stores Time Series   │
    │  Container: mysql-db           │  │    │                        │
    └────────────────────────────────┘  │    │ Grafana (4000)         │
                                        │    │ - Visualizations       │
                                        │    │ - Dashboards           │
                                        │    │ - Alerts               │
                                        │    │                        │
                                        ├───▶│ cAdvisor (8081)        │
                                        │    │ - Container Metrics    │
                                        │    │                        │
                                        │    │ Node Exporter (9100)   │
                                        │    │ - Host Metrics         │
                                        │    │                        │
                                        │    └────────────────────────┘
                                        │
                         ┌──────────────▼────────┐
                         │  DOCKER NETWORK       │
                         │  devops-network       │
                         │  (Bridge Network)     │
                         └───────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│                    CI/CD PIPELINE (Jenkins)                       │
├────────────────────────────────────────────────────────────────┤
│  1. Checkout Code         → 4. Security Scan (npm audit)        │
│  2. Install Dependencies  → 5. Docker Build                     │
│  3. Unit Tests            → 6. Docker Deploy                    │
│                             7. Health Verification              │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│              KUBERNETES DEPLOYMENT (Optional)                     │
├────────────────────────────────────────────────────────────────┤
│  Frontend Deployment (2 Replicas)                                │
│  Backend Deployment (2 Replicas)                                 │
│  MySQL StatefulSet (Persistent Storage)                          │
│  Services: LoadBalancer, ClusterIP                               │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│              INFRASTRUCTURE AS CODE (Terraform)                   │
├────────────────────────────────────────────────────────────────┤
│  AWS EC2 Instance (Ubuntu 22.04)                                 │
│  Security Group (Ports: 22, 80, 3000, 4000, 8080, 9090, 9100)  │
│  Elastic IP (Static Public IP)                                   │
│  IAM Roles and Policies                                          │
└────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────┐
│         CONFIGURATION MANAGEMENT (Ansible Playbook)              │
├────────────────────────────────────────────────────────────────┤
│  1. Install Docker & Docker Compose                              │
│  2. Install Node.js & npm                                        │
│  3. Install Git & Development Tools                              │
│  4. Configure Docker Group Permissions                           │
│  5. System Optimization                                          │
└────────────────────────────────────────────────────────────────┘
```

---

## Component Details

### 1. Frontend Layer
- **Framework**: HTML5 / CSS3 / JavaScript
- **Server**: Nginx (Reverse Proxy)
- **Port**: 80 (HTTP)
- **Features**:
  - Professional UI with Material Design
  - Real-time system status display
  - Dynamic API calls to backend
  - Responsive design for all devices
  - Error handling and retry logic

### 2. Application Layer (Backend)
- **Framework**: Node.js with Express.js
- **Port**: 3000
- **Database**: MySQL Connection Pool
- **Features**:
  - RESTful API with JSON responses
  - Connection pooling for efficiency
  - Retry logic for database connections
  - Health check endpoints
  - CORS enabled for frontend access
  - Graceful shutdown handling
  - Error handling middleware

### 3. Data Layer (Database)
- **Engine**: MySQL 8.0
- **Port**: 3306 (mapped to 3307 on host)
- **Database**: devopsdb
- **Tables**:
  - `messages` - Application messages
  - `users` - User information (extensible)
  - `audit_logs` - Action tracking
- **Features**:
  - Persistent volume storage
  - Automatic initialization
  - Sample data insertion
  - Timezone support

### 4. Monitoring Stack

#### Prometheus (Port 9090)
- Time-series database for metrics
- Scrapes metrics every 15 seconds
- 30-day retention
- Metrics sources:
  - Prometheus itself
  - cAdvisor (container metrics)
  - Node Exporter (host metrics)
  - Backend application (optional)

#### Grafana (Port 4000)
- Visualization platform
- Pre-configured Prometheus data source
- Dashboard creation
- Alert management
- Default credentials: admin / admin123

#### cAdvisor (Port 8081)
- Container monitoring
- Real-time metrics
- Performance analysis
- Historical data

#### Node Exporter (Port 9100)
- Host system metrics
- CPU, memory, disk usage
- Network statistics
- System uptime

---

## Data Flow

### Request Flow (Frontend to Backend)
```
User Request
    ↓
Nginx (Port 80)
    ↓
Backend API (Port 3000)
    ↓
MySQL Connection Pool
    ↓
Database (Port 3306)
    ↓
Response → JSON
    ↓
Backend → Frontend
    ↓
Browser → User Display
```

### Monitoring Data Flow
```
Applications/Services
    ↓
Prometheus (Scrapes every 15s)
    ↓
Time-Series Database
    ↓
Grafana (Queries Data)
    ↓
Dashboards & Alerts
```

---

## Networking

### Docker Network
- **Type**: Bridge Network
- **Name**: devops-network
- **Communication**: Internal container-to-container via service names
- **Isolation**: Containers isolated from host network

### Port Mapping
| Container | Internal Port | Host Port | Protocol |
|-----------|---------------|-----------|----------|
| frontend-app | 80 | 80 | TCP |
| backend-app | 3000 | 3000 | TCP |
| mysql-db | 3306 | 3307 | TCP |
| prometheus | 9090 | 9090 | TCP |
| grafana | 3000 | 4000 | TCP |
| cadvisor | 8080 | 8081 | TCP |
| node-exporter | 9100 | 9100 | TCP |

---

## Deployment Scenarios

### Local Development
- Docker Compose on single machine
- Suitable for development and testing
- All services on localhost

### Single Server (Ubuntu EC2)
- Terraform provisions AWS EC2
- Docker Compose runs on instance
- Elastic IP for consistent access
- Security groups control traffic

### Kubernetes Cluster
- Deploy to Minikube (local) or EKS (AWS)
- Manifests provided for:
  - Frontend Deployment (2 replicas)
  - Backend Deployment (2 replicas)
  - MySQL StatefulSet
  - Services for networking
- Auto-scaling and self-healing

---

## Security Considerations

### Network Security
- Security Groups restrict ports
- Only necessary ports exposed
- Private Docker network for inter-container communication

### Database Security
- MySQL root password (changeable)
- Database-level access control
- Prepared statements for query safety

### Application Security
- npm audit for dependency vulnerabilities
- Trivy for image scanning
- CORS configuration
- Error message sanitization

### Infrastructure Security
- EC2 instances in VPC
- SSH key-based authentication
- IAM roles and policies
- Automated security group management

---

## Scalability

### Horizontal Scaling
- Multiple replicas in Kubernetes
- Load balancer distributes traffic
- Database connection pooling

### Vertical Scaling
- Increase container resource limits
- Larger EC2 instance types
- MySQL buffer pool configuration

### Performance Optimization
- Nginx caching
- Database query optimization
- Connection pooling
- Monitoring and alerting

---

## Disaster Recovery

### Backup Strategy
- MySQL persistent volumes
- Automated backups (configurable)
- Data retention policies

### Failover Mechanism
- Kubernetes automated pod restart
- Container health checks
- Service discovery

### Monitoring & Alerts
- Prometheus alerting rules
- Grafana notifications
- Custom alert thresholds

---

## Technology Stack Summary

| Layer | Technology | Version |
|-------|-----------|---------|
| Frontend | Nginx | Latest |
| Backend | Node.js | 18 LTS |
| Backend Framework | Express.js | 4.18+ |
| Database | MySQL | 8.0 |
| Container Runtime | Docker | Latest |
| Container Orchestration | Docker Compose | Latest / Kubernetes |
| Monitoring | Prometheus | Latest |
| Visualization | Grafana | Latest |
| IaC | Terraform | 1.0+ |
| Configuration Mgmt | Ansible | Latest |
| CI/CD | Jenkins | LTS |

---

## API Endpoints

### Frontend
- `GET /` - Main application page

### Backend
- `GET /` - Server status
- `GET /api/health` - Health check
- `GET /api/message` - Application message
- `GET /api/db-test` - Database connectivity test

### Monitoring
- `GET /metrics` - Prometheus metrics (services)
- Grafana Dashboard UI on port 4000
- cAdvisor UI on port 8081
- Prometheus UI on port 9090

---

**Last Updated**: 2026
**Version**: 1.0
