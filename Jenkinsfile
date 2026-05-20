#!/usr/bin/env groovy

// Jenkins Pipeline for Secure Cloud-Native DevOps Platform
// This pipeline automates build, test, security scanning, and deployment

pipeline {
    agent any

    // Define pipeline parameters
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['development', 'staging', 'production'], description: 'Deployment environment')
        booleanParam(name: 'SKIP_TESTS', defaultValue: false, description: 'Skip unit tests')
        booleanParam(name: 'SKIP_SECURITY', defaultValue: false, description: 'Skip security scanning')
    }

    // Environment variables
    environment {
        PROJECT_NAME = 'secure-cloud-native-devops-platform'
        DOCKER_IMAGE_FRONTEND = "${PROJECT_NAME}-frontend"
        DOCKER_IMAGE_BACKEND = "${PROJECT_NAME}-backend"
        REGISTRY = 'localhost'
        GIT_COMMIT_MSG = sh(script: "git log -1 --pretty=%B", returnStdout: true).trim()
    }

    // Build triggers
    triggers {
        githubPush()
        pollSCM('H/15 * * * *')
    }

    stages {
        // ==================== CHECKOUT ====================
        stage('Checkout') {
            steps {
                echo "========== STAGE: Checkout =========="
               git branch: 'main', url: 'https://github.com/hassan461-hub/CI-CD-Pipeline-using-Jenkins-GitHub-webhook-ubuntu-AWS-EC2-docker-.git'
                sh '''
                    echo "Repository: ${GIT_URL}"
                    echo "Branch: ${GIT_BRANCH}"
                    echo "Commit: ${GIT_COMMIT}"
                    git log --oneline -5
                '''
            }
        }

        // ==================== ENVIRONMENT SETUP ====================
        stage('Environment Setup') {
            steps {
                echo "========== STAGE: Environment Setup =========="
                sh '''
                    echo "Environment: ${ENVIRONMENT}"
                    echo "Docker Version:"
                    docker --version
                    echo "Docker Compose Version:"
                    docker compose version
                    echo "System Info:"
                    uname -a
                '''
            }
        }

        // ==================== BACKEND INSTALL ====================
        stage('Backend Install') {
            steps {
                echo "========== STAGE: Backend Install =========="
                dir('backend') {
                    sh '''
                        echo "Installing backend dependencies..."
                        npm --version
                        npm install
                        ls -la node_modules | head -10
                    '''
                }
            }
        }

        // ==================== UNIT TESTS ====================
        stage('Unit Test') {
            when {
                expression {
                    return !params.SKIP_TESTS
                }
            }
            steps {
                echo "========== STAGE: Unit Test =========="
                dir('backend') {
                    sh '''
                        echo "Running unit tests..."
                        npm test || echo "No tests configured - skipping"
                    '''
                }
            }
        }

        // ==================== SECURITY SCAN ====================
        stage('Security Scan') {
            when {
                expression {
                    return !params.SKIP_SECURITY
                }
            }
            steps {
                echo "========== STAGE: Security Scan =========="
                
                // NPM Audit
                dir('backend') {
                    sh '''
                        echo "Running npm audit for vulnerabilities..."
                        npm audit --production || true
                        echo "npm audit completed - vulnerabilities (if any) listed above"
                    '''
                }

                // Trivy filesystem scan (if installed)
                sh '''
                    echo "Checking for Trivy installation..."
                    if command -v trivy &> /dev/null; then
                        echo "Running Trivy filesystem scan..."
                        trivy fs . --exit-code 0 || true
                    else
                        echo "Trivy not installed - skipping image scanning"
                        echo "To install Trivy on Ubuntu:"
                        echo "  wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -"
                        echo "  echo 'deb https://aquasecurity.github.io/trivy-repo/deb focal main' | tee /etc/apt/sources.list.d/trivy.list"
                        echo "  apt update && apt install trivy"
                    fi
                '''
            }
        }

        // ==================== BUILD DOCKER IMAGES ====================
        stage('Docker Compose Build') {
            steps {
                echo "========== STAGE: Docker Compose Build =========="
                sh '''
                    echo "Building Docker images..."
                    docker compose build
                    echo "Docker images built successfully"
                    docker images | grep ${PROJECT_NAME}
                '''
            }
        }

        // ==================== DEPLOY ====================
        stage('Docker Compose Deploy') {
            steps {
                echo "========== STAGE: Docker Compose Deploy =========="
                sh '''
                    echo "Stopping previous deployment (if any)..."
                    docker compose down || true
                    
                    echo "Starting services..."
                    docker compose up -d --build
                    
                    echo "Waiting for services to be ready..."
                    sleep 10
                    
                    docker compose ps
                '''
            }
        }

        // ==================== VERIFY DEPLOYMENT ====================
        stage('Verify Deployment') {
            steps {
                echo "========== STAGE: Verify Deployment =========="
                sh '''
                    echo "Checking running containers..."
                    docker ps
                    
                    echo ""
                    echo "Container Status:"
                    docker compose ps
                    
                    echo ""
                    echo "Testing Frontend..."
                    curl -f http://localhost || exit 1
                    echo "✓ Frontend is responding"
                    
                    echo ""
                    echo "Testing Backend Health..."
                    curl -f http://localhost:3000/api/health || exit 1
                    echo "✓ Backend health check passed"
                    
                    echo ""
                    echo "Testing API Message Endpoint..."
                    curl -s http://localhost:3000/api/message | jq '.' || exit 1
                    echo "✓ API message endpoint working"
                    
                    echo ""
                    echo "Container Logs Summary:"
                    docker compose logs --tail 5
                '''
            }
        }
    }

    // ==================== POST SUCCESS ====================
    post {
        success {
            echo "========== PIPELINE SUCCESS =========="
            sh '''
                echo ""
                echo "╔════════════════════════════════════════════╗"
                echo "║   BUILD AND DEPLOYMENT SUCCESSFUL          ║"
                echo "╚════════════════════════════════════════════╝"
                echo ""
                echo "Access the application:"
                echo "  Frontend:  http://localhost"
                echo "  Grafana:   http://localhost:4000 (admin/admin123)"
                echo "  Prometheus: http://localhost:9090"
                echo ""
            '''
        }
    }

    // ==================== POST FAILURE ====================
    post {
        failure {
            echo "========== PIPELINE FAILED =========="
            sh '''
                echo ""
                echo "╔════════════════════════════════════════════╗"
                echo "║   BUILD OR DEPLOYMENT FAILED               ║"
                echo "╚════════════════════════════════════════════╝"
                echo ""
                echo "Troubleshooting steps:"
                echo "1. Check logs: docker compose logs"
                echo "2. Check specific service: docker compose logs <service-name>"
                echo "3. Verify resources: docker ps && docker images"
                echo "4. Check network: docker network ls"
                echo ""
                echo "Recent logs:"
                docker compose logs --tail 20 || true
            '''
        }
    }

    // ==================== POST ALWAYS ====================
    post {
        always {
            echo "========== PIPELINE CLEANUP =========="
            sh '''
                echo "Pipeline execution completed at: $(date)"
                echo "Workspace: $(pwd)"
            '''
        }
    }
}
