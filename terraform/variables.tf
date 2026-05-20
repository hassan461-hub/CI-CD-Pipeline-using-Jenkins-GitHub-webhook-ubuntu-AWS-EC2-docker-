# Terraform Variables
# Define all variable inputs for AWS infrastructure

variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "us-east-1"  # EDIT: Change to your desired region (e.g., us-west-2, eu-west-1)
}

variable "environment" {
  description = "Environment name (development, staging, production)"
  type        = string
  default     = "development"
  
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
  default     = "secure-devops-platform"
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
  default     = "vpc-default"  # EDIT: Set to your VPC ID (use 'aws ec2 describe-vpcs')
}

variable "instance_type" {
  description = "EC2 instance type (t2.micro, t3.small, t3.medium, etc.)"
  type        = string
  default     = "t3.medium"  # Suitable for this application
  
  validation {
    condition     = can(regex("^[a-z][0-9][a-z]\\.[a-z]+$", var.instance_type))
    error_message = "Instance type must be a valid AWS instance type."
  }
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI ID (EDIT: Set for your region)"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # EDIT: Replace with AMI ID for your region
  
  # Common AMI IDs (Ubuntu 22.04 LTS, check for latest):
  # us-east-1: ami-0c55b159cbfafe1f0
  # us-west-2: ami-0a8e758f5e873d1c1
  # eu-west-1: ami-0d3206c5c5b4c3733
  # ap-southeast-1: ami-0a9fafb9e1ce2b0b3
}

variable "key_pair_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
  default     = "my-devops-key"  # EDIT: Set your EC2 key pair name
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access (restrict for security)"
  type        = string
  default     = "0.0.0.0/0"  # EDIT: Change to your IP (e.g., "203.0.113.0/32") for production
  
  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "Must be a valid CIDR block."
  }
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
  
  validation {
    condition     = var.root_volume_size >= 20
    error_message = "Root volume size must be at least 20 GB."
  }
}

variable "enable_monitoring" {
  description = "Enable CloudWatch detailed monitoring"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default = {
    Team        = "DevOps"
    Department  = "Infrastructure"
    CostCenter  = "Engineering"
  }
}
