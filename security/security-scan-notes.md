# Security Scanning Guide for DevOps Platform

## Overview
This document explains security scanning practices for the Secure Cloud-Native DevOps Platform, including dependency vulnerability detection and container image scanning.

## Tools Used

### 1. NPM Audit
**Purpose:** Scans npm dependencies for known security vulnerabilities

**Installation:**
- NPM Audit is included with Node.js/npm

**Commands:**

```bash
# Scan for vulnerabilities
npm audit

# Audit only production dependencies
npm audit --production

# Get detailed JSON output
npm audit --json

# Fix vulnerabilities automatically
npm audit fix

# Fix vulnerabilities (including major version changes)
npm audit fix --force
```

**What it checks:**
- Known vulnerabilities in dependencies
- Severity levels: low, moderate, high, critical

**Jenkins Integration:**
- Automatically runs in the "Security Scan" stage of Jenkinsfile
- Fails on critical vulnerabilities (can be configured)

---

### 2. Trivy - Container & Filesystem Security Scanner
**Purpose:** Scans container images, filesystems, and Git repositories for vulnerabilities

**Website:** https://github.com/aquasecurity/trivy

**Installation on Ubuntu:**

```bash
# Add Trivy repository
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list

# Update and install
sudo apt update
sudo apt install trivy -y

# Verify installation
trivy --version
```

**Commands:**

```bash
# Scan filesystem (current directory)
trivy fs .

# Scan specific directory
trivy fs ./backend

# Scan Docker image
trivy image backend-app:latest

# Scan image from registry
trivy image ubuntu:latest

# JSON output for processing
trivy fs . --format json > scan_results.json

# High severity only
trivy fs . --severity HIGH,CRITICAL

# Exit with error on findings
trivy fs . --exit-code 1
```

**What it checks:**
- OS package vulnerabilities
- Application dependency vulnerabilities
- Misconfigurations
- Secrets in code

---

### 3. Additional Security Best Practices

#### Docker Security
```bash
# Use minimal base images (alpine variants)
FROM node:18-alpine

# Don't run as root
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs

# Scan built images
docker scan <image-name>
```

#### Code Scanning
```bash
# Scan for secrets/credentials
git log -p | grep -i "password\|api_key\|secret"

# Use dedicated tools like git-secrets
git secrets --install
git secrets --scan
```

#### Dependency Management
```bash
# Keep dependencies updated
npm update

# Check for outdated packages
npm outdated

# Regular security audits
npm audit --audit-level=moderate
```

---

## Jenkins Pipeline Security Scanning

The Jenkinsfile includes a dedicated **"Security Scan"** stage that:

1. Runs `npm audit` on backend dependencies
2. Runs Trivy filesystem scan (if installed)
3. Can scan Docker images after build

**Example output from security scan:**

```
npm audit report
┌─────────────────────────────────────────┐
│ High    │ Expression Injection            │
├─────────────────────────────────────────┤
│ Package │ express                         │
├─────────────────────────────────────────┤
│ Patched │ >=4.18.2                        │
└─────────────────────────────────────────┘
```

---

## Security Scanning in CI/CD

### Automated Scanning Steps
1. **Build Stage:** Vulnerabilities in dependencies detected
2. **Deploy Stage:** Container images scanned
3. **Runtime:** Monitoring for unusual behavior

### Handling Vulnerabilities

**Low/Moderate Risk:**
- Update dependencies
- Plan for regular updates

**High/Critical Risk:**
- Patch immediately
- Block deployment until fixed
- Document if patch unavailable

---

## Manual Security Audit Checklist

Before deploying to production:

- [ ] Run `npm audit` on all services
- [ ] Scan all container images with Trivy
- [ ] Check for hardcoded secrets
- [ ] Verify database password strength
- [ ] Review network security groups
- [ ] Validate HTTPS configuration
- [ ] Check API authentication/authorization
- [ ] Audit file permissions
- [ ] Review logs for anomalies

---

## Vulnerability Database Updates

Trivy automatically updates its vulnerability database, but you can manually update:

```bash
# Update Trivy DB
trivy image --download-db-only

# Scan with latest DB
trivy fs . --skip-update false
```

---

## Reporting and Documentation

### Generate Security Reports

```bash
# Create detailed report
npm audit --json > npm_audit_$(date +%Y%m%d).json

# Create Trivy report
trivy fs . --format table > trivy_scan_$(date +%Y%m%d).txt

# CSV format for spreadsheets
trivy fs . --format csv > trivy_results.csv
```

### Store Reports
- Keep copies in version control (sanitized)
- Archive scan results for compliance
- Track remediation progress

---

## References

- [npm Audit Documentation](https://docs.npmjs.com/cli/audit)
- [Trivy GitHub Repository](https://github.com/aquasecurity/trivy)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

---

**Last Updated:** 2026
**DevOps Team**
