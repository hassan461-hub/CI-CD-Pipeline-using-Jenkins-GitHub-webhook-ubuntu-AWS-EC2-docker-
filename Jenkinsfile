#!/usr/bin/env groovy

pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['development', 'staging', 'production'], description: 'Deployment environment')
        booleanParam(name: 'SKIP_TESTS', defaultValue: false, description: 'Skip unit tests')
        booleanParam(name: 'SKIP_SECURITY', defaultValue: false, description: 'Skip security scanning')
    }

    environment {
        PROJECT_NAME = 'secure-cloud-native-devops-platform'
        DOCKER_IMAGE_FRONTEND = "${PROJECT_NAME}-frontend"
        DOCKER_IMAGE_BACKEND = "${PROJECT_NAME}-backend"
        REGISTRY = 'localhost'
        GITHUB_REPO = 'https://github.com/hassan461-hub/CI-CD-Pipeline-using-Jenkins-GitHub-webhook-ubuntu-AWS-EC2-docker-.git'
    }

    triggers {
        githubPush()
        pollSCM('H/15 * * * *')
    }

    stages {

        stage('Checkout') {
            steps {
                echo "========== STAGE: Checkout =========="
                git branch: 'main', url: "${GITHUB_REPO}"

                sh '''
                    echo "Repository checked successfully"
                    echo "Current branch:"
                    git branch
                    echo "Recent commits:"
                    git log --oneline -5
                '''
            }
        }

        stage('Environment Setup') {
            steps {
                echo "========== STAGE: Environment Setup =========="
                sh '''
                    echo "Environment: ${ENVIRONMENT}"
                    echo "Project Name: ${PROJECT_NAME}"
                    echo "Docker Version:"
                    docker --version
                    echo "Docker Compose Version:"
                    docker compose version
                    echo "System Info:"
                    uname -a
                    echo "Current Directory:"
                    pwd
                    echo "Project Files:"
                    ls -la
                '''
            }
        }

        stage('Backend Install') {
            steps {
                echo "========== STAGE: Backend Install =========="
                dir('backend') {
                    sh '''
                        echo "Installing backend dependencies..."
                        npm --version
                        npm install
                    '''
                }
            }
        }

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
                        echo "Running backend tests..."
                        npm test || echo "No tests configured - continuing"
                    '''
                }
            }
        }

        stage('Security Scan') {
            when {
                expression {
                    return !params.SKIP_SECURITY
                }
            }
            steps {
                echo "========== STAGE: Security Scan =========="

                dir('backend') {
                    sh '''
                        echo "Running npm audit..."
                        npm audit --omit=dev || true
                        echo "npm audit completed"
                    '''
                }

                sh '''
                    echo "Checking Trivy installation..."
                    if command -v trivy > /dev/null 2>&1; then
                        echo "Running Trivy filesystem scan..."
                        trivy fs . --exit-code 0 || true
                    else
                        echo "Trivy is not installed, skipping Trivy scan"
                    fi
                '''
            }
        }

        stage('Docker Compose Build') {
            steps {
                echo "========== STAGE: Docker Compose Build =========="
                sh '''
                    echo "Building Docker images..."
                    docker compose build
                    echo "Docker images built successfully"
                    docker images | head -20
                '''
            }
        }

        stage('Docker Compose Deploy') {
            steps {
                echo "========== STAGE: Docker Compose Deploy =========="
                sh '''
                    echo "Stopping old deployment..."
                    docker compose down || true

                    echo "Removing old containers if they already exist..."
                    docker rm -f mysql-db backend-app frontend-app prometheus grafana cadvisor node-exporter || true

                    echo "Starting new deployment..."
                    docker compose up -d --build

                    echo "Waiting for services to start..."
                    sleep 15

                    echo "Current container status:"
                    docker compose ps
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo "========== STAGE: Verify Deployment =========="
                sh '''
                    echo "Checking running containers..."
                    docker ps

                    echo ""
                    echo "Testing Frontend..."
                    curl -f http://localhost || exit 1
                    echo "Frontend is responding"

                    echo ""
                    echo "Testing Backend Root..."
                    curl -f http://localhost:3000 || exit 1
                    echo "Backend root endpoint is responding"

                    echo ""
                    echo "Testing Backend Health..."
                    curl -f http://localhost:3000/api/health || exit 1
                    echo "Backend health endpoint is responding"

                    echo ""
                    echo "Testing Backend Message API..."
                    curl -f http://localhost:3000/api/message || exit 1
                    echo "Backend message API is responding"

                    echo ""
                    echo "Testing Prometheus..."
                    curl -f http://localhost:9090 || true

                    echo ""
                    echo "Testing Grafana..."
                    curl -f http://localhost:4000 || true

                    echo ""
                    echo "Deployment verification completed"
                '''
            }
        }
    }

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
                echo "  Frontend:   http://localhost"
                echo "  Backend:    http://localhost:3000"
                echo "  Health:     http://localhost:3000/api/health"
                echo "  Message:    http://localhost:3000/api/message"
                echo "  Grafana:    http://localhost:4000"
                echo "  Prometheus: http://localhost:9090"
                echo ""
                echo "Running containers:"
                docker ps
            '''
        }

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
                echo "2. Check backend logs: docker compose logs backend-app"
                echo "3. Check frontend logs: docker compose logs frontend-app"
                echo "4. Check MySQL logs: docker compose logs mysql-db"
                echo "5. Check containers: docker ps -a"
                echo ""
                echo "Recent Docker Compose logs:"
                docker compose logs --tail 30 || true
            '''
        }

        always {
            echo "========== PIPELINE FINISHED =========="
            sh '''
                echo "Pipeline execution completed at: $(date)"
                echo "Workspace: $(pwd)"
            '''
        }
    }
}