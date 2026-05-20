#!/bin/bash
# User data script for EC2 instance initialization
# This script runs automatically when the instance starts

set -e  # Exit on error

echo "====================================="
echo "Starting EC2 Instance Setup"
echo "====================================="

# Update system packages
echo "Updating system packages..."
apt-get update
apt-get upgrade -y

# Install essential tools
echo "Installing essential tools..."
apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    htop \
    vim \
    net-tools

# Install Docker
echo "Installing Docker..."
apt-get install -y docker.io
systemctl start docker
systemctl enable docker

# Install Docker Compose Plugin
echo "Installing Docker Compose..."
apt-get install -y docker-compose-plugin

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Install Node.js (optional, for local development)
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# Install Jenkins (optional)
echo "Installing Java (required for Jenkins)..."
apt-get install -y openjdk-11-jdk

# Optional: Install Jenkins
# curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list
# apt-get update
# apt-get install -y jenkins
# systemctl start jenkins
# systemctl enable jenkins

echo "====================================="
echo "EC2 Instance Setup Complete!"
echo "====================================="
echo ""
echo "Installed components:"
echo "- Docker $(docker --version)"
echo "- Docker Compose $(docker compose version)"
echo "- Node.js $(node --version)"
echo "- npm $(npm --version)"
echo "- Java $(java -version 2>&1 | head -1)"
echo ""
echo "Next steps:"
echo "1. Clone your repository"
echo "2. Navigate to secure-cloud-native-devops-platform directory"
echo "3. Run: docker compose up -d --build"
