# Terraform Main Configuration
# Provisions AWS EC2 infrastructure for DevOps Platform

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "DevOps-Platform"
      Environment = var.environment
      ManagedBy   = "Terraform"
      CreatedAt   = timestamp()
    }
  }
}

# ==================== SECURITY GROUP ====================
resource "aws_security_group" "devops_sg" {
  name        = "${var.project_name}-security-group"
  description = "Security group for DevOps Platform applications and monitoring"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-sg"
  }
}

# Allow SSH (port 22)
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  description       = "Allow SSH access"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allowed_ssh_cidr  # EDIT: Change to your IP (e.g., "1.2.3.4/32")
  security_group_id = aws_security_group.devops_sg.id

  tags = {
    Name = "allow-ssh"
  }
}

# Allow HTTP (port 80) - Frontend
resource "aws_vpc_security_group_ingress_rule" "http" {
  description       = "Allow HTTP for frontend"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.devops_sg.id

  tags = {
    Name = "allow-http"
  }
}

# Allow Backend API (port 3000)
resource "aws_vpc_security_group_ingress_rule" "backend" {
  description       = "Allow backend API access"
  from_port         = 3000
  to_port           = 3000
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.devops_sg.id

  tags = {
    Name = "allow-backend"
  }
}

# Allow Grafana (port 4000)
resource "aws_vpc_security_group_ingress_rule" "grafana" {
  description       = "Allow Grafana dashboard access"
  from_port         = 4000
  to_port           = 4000
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.devops_sg.id

  tags = {
    Name = "allow-grafana"
  }
}

# Allow Prometheus (port 9090)
resource "aws_vpc_security_group_ingress_rule" "prometheus" {
  description       = "Allow Prometheus access"
  from_port         = 9090
  to_port           = 9090
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.devops_sg.id

  tags = {
    Name = "allow-prometheus"
  }
}

# Allow cAdvisor (port 8081)
resource "aws_vpc_security_group_ingress_rule" "cadvisor" {
  description       = "Allow cAdvisor metrics access"
  from_port         = 8081
  to_port           = 8081
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.devops_sg.id

  tags = {
    Name = "allow-cadvisor"
  }
}

# Allow Node Exporter (port 9100)
resource "aws_vpc_security_group_ingress_rule" "node_exporter" {
  description       = "Allow Node Exporter metrics"
  from_port         = 9100
  to_port           = 9100
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.devops_sg.id

  tags = {
    Name = "allow-node-exporter"
  }
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  description       = "Allow all outbound traffic"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.devops_sg.id

  tags = {
    Name = "allow-all-outbound"
  }
}

# ==================== EC2 INSTANCE ====================
resource "aws_instance" "devops_server" {
  # EDIT: Replace AMI ID with correct Ubuntu AMI for your region
  # To find Ubuntu 22.04 LTS AMI in your region:
  #   aws ec2 describe-images --owners 099720109477 --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" --query 'Images | sort_by(@, &CreationDate) | [-1].[ImageId]' --output text
  ami           = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name               = var.key_pair_name  # EDIT: Set your EC2 key pair name

  # Root volume configuration
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
  }

  # User data for initial setup
  user_data = base64encode(file("${path.module}/user_data.sh"))

  tags = {
    Name = "${var.project_name}-server"
  }

  depends_on = [aws_security_group.devops_sg]
}

# ==================== ELASTIC IP ====================
resource "aws_eip" "devops_eip" {
  instance = aws_instance.devops_server.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }

  depends_on = [aws_instance.devops_server]
}

# ==================== OUTPUTS ====================
output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.devops_server.id
}

output "public_ip" {
  description = "Elastic IP address for the instance"
  value       = aws_eip.devops_eip.public_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = aws_security_group.devops_sg.id
}

output "ssh_command" {
  description = "SSH command to connect to the server"
  value       = "ssh -i /path/to/key.pem ubuntu@${aws_eip.devops_eip.public_ip}"
}
