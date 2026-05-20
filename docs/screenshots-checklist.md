# Screenshots Checklist for Final DevOps Lab Project

Use this checklist to capture all required screenshots for your lab report. Each screenshot should be labeled with the service/endpoint being tested.

## Frontend Screenshots

### 1. Frontend Home Page
- **URL**: http://localhost
- **What to show**:
  - Professional page title: "Secure Cloud-Native DevOps Platform"
  - All 6 feature cards visible
  - Status section showing system health
  - Button "Test Backend API" visible
- **Filename**: `01-frontend-homepage.png`
- **Notes**: Show the complete page, capture at 1920x1080 if possible

### 2. Frontend "Test Backend API" - Success
- **What to do**: Click the "Test Backend API" button
- **What to show**:
  - Button response box showing JSON message
  - Backend health status: "✓ Healthy"
  - Database status: "✓ Connected"
- **Filename**: `02-frontend-api-test-success.png`
- **Notes**: Wait 2-3 seconds for API to respond

### 3. Frontend Status Indicators
- **What to show**:
  - Backend Health indicator (green checkmark)
  - Database Connection indicator (green checkmark)
  - All system status information
- **Filename**: `03-frontend-status-indicators.png`
- **Notes**: These auto-update every 30 seconds

---

## Backend Application Screenshots

### 4. Backend Health Endpoint
- **URL**: http://localhost:3000/api/health
- **Command**: 
  ```bash
  curl -s http://localhost:3000/api/health | jq '.'
  ```
- **What to show**:
  - JSON response with status, database connection status
  - Response code 200 (OK) or 503 (Unhealthy)
- **Filename**: `04-backend-health-endpoint.png`
- **Notes**: Use `curl` in terminal for clean output

### 5. Backend API Message Endpoint
- **URL**: http://localhost:3000/api/message
- **Command**:
  ```bash
  curl -s http://localhost:3000/api/message | jq '.'
  ```
- **What to show**:
  - Message content
  - Environment information
  - Service version and timestamp
- **Filename**: `05-backend-api-message.png`

### 6. Backend Database Test Endpoint
- **URL**: http://localhost:3000/api/db-test
- **Command**:
  ```bash
  curl -s http://localhost:3000/api/db-test | jq '.'
  ```
- **What to show**:
  - Database connection success
  - Sample message from database
  - Connection status
- **Filename**: `06-backend-db-test.png`

---

## Docker Screenshots

### 7. Docker Compose Status
- **Command**: 
  ```bash
  docker compose ps
  ```
- **What to show**:
  - All 7 services running and healthy
  - Container names, status, ports
- **Filename**: `07-docker-compose-ps.png`
- **Notes**: Show full output with all columns

### 8. Docker Container Logs - Backend
- **Command**:
  ```bash
  docker compose logs backend-app --tail=20
  ```
- **What to show**:
  - Backend startup messages
  - Database connection attempts
  - Success message
- **Filename**: `08-docker-backend-logs.png`

### 9. Docker Container Logs - Database
- **Command**:
  ```bash
  docker compose logs mysql-db --tail=20
  ```
- **What to show**:
  - MySQL startup messages
  - Database initialization
  - Ready for connections
- **Filename**: `09-docker-mysql-logs.png`

### 10. Docker Network Information
- **Command**:
  ```bash
  docker network inspect devops-network
  ```
- **What to show**:
  - Network name and driver (bridge)
  - Connected containers and their IPs
- **Filename**: `10-docker-network.png`

---

## Database Screenshots

### 11. MySQL Messages Table
- **Command**:
  ```bash
  docker compose exec mysql-db mysql -uroot -proot -e "use devopsdb; SELECT * FROM messages;"
  ```
- **What to show**:
  - Messages table with sample data
  - Three messages inserted successfully
  - Timestamp information
- **Filename**: `11-mysql-messages-table.png`

### 12. MySQL Database Verification
- **Command**:
  ```bash
  docker compose exec mysql-db mysql -uroot -proot -e "SHOW DATABASES; USE devopsdb; SHOW TABLES;"
  ```
- **What to show**:
  - devopsdb database listed
  - All tables in database
- **Filename**: `12-mysql-databases-tables.png`

---

## Monitoring - Prometheus Screenshots

### 13. Prometheus Home Page
- **URL**: http://localhost:9090
- **What to show**:
  - Prometheus home page loaded
  - Version information visible
- **Filename**: `13-prometheus-home.png`
- **Notes**: Click on "Graph" tab to show metrics

### 14. Prometheus Targets
- **URL**: http://localhost:9090/targets
- **What to show**:
  - All monitoring targets (UP state in green)
  - prometheus:9090 ✓ UP
  - cadvisor:8080 ✓ UP
  - node-exporter:9100 ✓ UP
- **Filename**: `14-prometheus-targets.png`

### 15. Prometheus Metrics Query
- **URL**: http://localhost:9090
- **Action**: Query "container_cpu_usage_seconds_total"
- **What to show**:
  - Query results displayed in graph
  - Time series data
  - Query successful response
- **Filename**: `15-prometheus-metrics-query.png`

---

## Monitoring - Grafana Screenshots

### 16. Grafana Login Page
- **URL**: http://localhost:4000
- **What to show**:
  - Grafana login interface
  - Ready to login with admin/admin123
- **Filename**: `16-grafana-login.png`
- **Notes**: Take before logging in

### 17. Grafana Dashboard Home
- **URL**: http://localhost:4000/d/home
- **What to show**:
  - Grafana home dashboard (after login)
  - Welcome message
  - Available dashboards
- **Filename**: `17-grafana-home.png`

### 18. Grafana Data Source Configuration
- **URL**: http://localhost:4000/datasources
- **What to show**:
  - Prometheus data source configured
  - Connection status: green checkmark
  - URL: http://prometheus:9090
- **Filename**: `18-grafana-datasource.png`
- **Steps**:
  1. Click "Configuration" → "Data Sources"
  2. Click "Prometheus"
  3. Show the configuration

### 19. Grafana Custom Dashboard
- **What to show**:
  - Create or view a dashboard with metrics
  - Example: Container CPU usage, Memory usage
- **Filename**: `19-grafana-dashboard.png`
- **Steps**:
  1. Click "+" → "Dashboard"
  2. Add a panel
  3. Select Prometheus as data source
  4. Query a metric

---

## Monitoring - cAdvisor Screenshots

### 20. cAdvisor Home Page
- **URL**: http://localhost:8081
- **What to show**:
  - cAdvisor interface loaded
  - Container list visible
  - Shows all running containers with metrics
- **Filename**: `20-cadvisor-containers.png`

### 21. cAdvisor Container Metrics
- **URL**: http://localhost:8081
- **What to show**:
  - Click on any container (e.g., backend-app)
  - CPU usage, memory usage graphs
  - Network statistics
- **Filename**: `21-cadvisor-container-details.png`

---

## Monitoring - Node Exporter Screenshots

### 22. Node Exporter Metrics
- **URL**: http://localhost:9100/metrics
- **What to show**:
  - Raw metrics page
  - System metrics in Prometheus format
  - Node info, CPU stats, memory info
- **Filename**: `22-node-exporter-metrics.png`
- **Notes**: First 50 lines should be visible

---

## Jenkins CI/CD Screenshots

### 23. Jenkins Dashboard
- **URL**: http://localhost:8080 (if installed)
- **What to show**:
  - Jenkins home page
  - Job created for DevOps project
- **Filename**: `23-jenkins-dashboard.png`

### 24. Jenkinsfile Content
- **File**: Jenkinsfile (in repository root)
- **What to show**:
  - Display Jenkinsfile content in editor
  - Show all pipeline stages
- **Filename**: `24-jenkinsfile-content.png`
- **Command**:
  ```bash
  cat Jenkinsfile
  ```

### 25. Pipeline Execution Log
- **URL**: Jenkins job page
- **What to show**:
  - Pipeline stages: Checkout → Backend Install → Unit Test → Security Scan → Build → Deploy → Verify
  - All stages passed (green checkmarks)
- **Filename**: `25-jenkins-pipeline-success.png`

---

## Security Scanning Screenshots

### 26. npm Audit Results
- **Command**:
  ```bash
  cd backend && npm audit
  ```
- **What to show**:
  - npm audit report
  - Vulnerability count (even if 0)
  - Any findings listed
- **Filename**: `26-npm-audit-results.png`

### 27. Security Scan Documentation
- **File**: security/security-scan-notes.md
- **What to show**:
  - Display content in editor or terminal
  - Show security best practices
- **Filename**: `27-security-documentation.png`

---

## Kubernetes Screenshots (if deployed)

### 28. Kubernetes Deployment Files
- **Command**:
  ```bash
  ls -la kubernetes/
  ```
- **What to show**:
  - All K8s manifests listed
  - frontend-deployment.yml
  - backend-deployment.yml
  - mysql-deployment.yml
  - Services YAML files
- **Filename**: `28-kubernetes-files.png`

### 29. Kubernetes Deployment (if running on Minikube)
- **Command**:
  ```bash
  kubectl get deployments
  kubectl get services
  ```
- **What to show**:
  - Deployments running
  - Services configured
  - Pod replicas ready
- **Filename**: `29-kubernetes-deployments.png`

---

## Terraform Screenshots

### 30. Terraform Configuration Files
- **Command**:
  ```bash
  ls -la terraform/
  cat terraform/variables.tf | head -30
  ```
- **What to show**:
  - Terraform files listed
  - variables.tf content
  - AWS resource definitions
- **Filename**: `30-terraform-files.png`

### 31. Terraform Plan (if executed)
- **Command**:
  ```bash
  cd terraform && terraform init
  terraform plan
  ```
- **What to show**:
  - Terraform plan output
  - Resources to be created
- **Filename**: `31-terraform-plan.png`

---

## Ansible Screenshots

### 32. Ansible Inventory
- **File**: ansible/inventory.ini
- **What to show**:
  - Display inventory configuration
  - Host groups defined
  - Variables shown
- **Filename**: `32-ansible-inventory.png`

### 33. Ansible Playbook
- **File**: ansible/install-tools.yml
- **What to show**:
  - Display playbook content
  - Tasks listed
- **Filename**: `33-ansible-playbook.png`

### 34. Ansible Execution (if run)
- **Command**:
  ```bash
  ansible-playbook -i inventory.ini install-tools.yml
  ```
- **What to show**:
  - Playbook execution output
  - Tasks completed
  - Installation summary
- **Filename**: `34-ansible-execution.png`

---

## Documentation Screenshots

### 35. README.md Overview
- **File**: README.md
- **What to show**:
  - Display in editor or markdown viewer
  - Project title and description
  - First sections visible
- **Filename**: `35-readme-overview.png`

### 36. Project Structure
- **Command**:
  ```bash
  tree -L 2 -a
  ```
  (or `ls -laR` if tree not available)
- **What to show**:
  - Complete folder structure
  - All files and directories
- **Filename**: `36-project-structure.png`

---

## System Information Screenshots

### 37. Host System Information
- **Command**:
  ```bash
  uname -a
  docker --version
  docker compose version
  git --version
  ```
- **What to show**:
  - Ubuntu version
  - Docker versions
  - System specifications
- **Filename**: `37-system-info.png`

### 38. Docker Images
- **Command**:
  ```bash
  docker images
  ```
- **What to show**:
  - Built images for frontend and backend
  - Image IDs and sizes
  - Creation dates
- **Filename**: `38-docker-images.png`

---

## Final Screenshots

### 39. Application Full Stack Running
- **Command**:
  ```bash
  docker compose ps && echo "---" && curl -s http://localhost:3000/api/health | jq '.'
  ```
- **What to show**:
  - All services running
  - Health check passing
- **Filename**: `39-full-stack-running.png`

### 40. Summary Screenshot (Optional)
- **What to show**:
  - Browser with frontend page visible
  - Terminal showing active services
  - Composite view of working application
- **Filename**: `40-application-summary.png`

---

## Screenshots Organization

Create a folder structure:
```
screenshots/
├── 01-frontend-homepage.png
├── 02-frontend-api-test-success.png
├── 03-frontend-status-indicators.png
├── 04-backend-health-endpoint.png
├── 05-backend-api-message.png
├── 06-backend-db-test.png
├── 07-docker-compose-ps.png
├── 08-docker-backend-logs.png
├── 09-docker-mysql-logs.png
├── 10-docker-network.png
├── ... (continue for all 40)
├── 39-full-stack-running.png
├── 40-application-summary.png
└── README-SCREENSHOTS.md
```

---

## Screenshot Capture Tips

1. **Resolution**: Capture at 1920x1080 or higher
2. **Format**: PNG for lossless quality
3. **Timing**: Ensure services are fully started
4. **Labels**: Add text labels in images if needed
5. **Clarity**: Make sure text is readable
6. **Context**: Include URL bar or command prompt
7. **Browser**: Use Chrome or Firefox for web services
8. **Terminal**: Use clear terminal with readable font
9. **Order**: Follow this checklist order for consistency
10. **Backup**: Keep originals and edited versions

---

## Screenshot Submission Checklist

- [ ] All 40 screenshots captured (or 30 minimum)
- [ ] Screenshots organized in screenshots/ folder
- [ ] All images are PNG format
- [ ] Images have descriptive filenames
- [ ] Images are readable at 100% zoom
- [ ] Screenshots are in order (numbered)
- [ ] Summary document created (README-SCREENSHOTS.md)
- [ ] Git status shows all screenshots committed
- [ ] No corrupted or broken images

---

**Total Screenshots**: 40 (minimum 30 required)
**Time Estimate**: 1-2 hours to capture all
**Alternative**: Take fewer screenshots (20-30) and focus on critical ones

---

Last Updated: 2026
