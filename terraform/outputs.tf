# Terraform Outputs
# Display important information after deployment

output "instance_details" {
  description = "EC2 instance details"
  value = {
    instance_id     = aws_instance.devops_server.id
    instance_type   = aws_instance.devops_server.instance_type
    private_ip      = aws_instance.devops_server.private_ip_address
    public_ip       = aws_eip.devops_eip.public_ip
    availability_zone = aws_instance.devops_server.availability_zone
  }
}

output "security_group_details" {
  description = "Security group details"
  value = {
    security_group_id   = aws_security_group.devops_sg.id
    security_group_name = aws_security_group.devops_sg.name
  }
}

output "access_information" {
  description = "Connection information for the deployed instance"
  value = {
    ssh_command = "ssh -i /path/to/${var.key_pair_name}.pem ubuntu@${aws_eip.devops_eip.public_ip}"
    http_url    = "http://${aws_eip.devops_eip.public_ip}"
    grafana_url = "http://${aws_eip.devops_eip.public_ip}:4000"
    prometheus_url = "http://${aws_eip.devops_eip.public_ip}:9090"
  }
}

output "deployment_summary" {
  description = "Deployment summary for documentation"
  value = {
    region          = var.aws_region
    environment     = var.environment
    instance_type   = var.instance_type
    public_ip       = aws_eip.devops_eip.public_ip
    next_steps = [
      "1. SSH into the instance using the ssh_command",
      "2. Clone the repository: git clone <repo-url>",
      "3. Navigate to project: cd secure-cloud-native-devops-platform",
      "4. Run docker compose: docker compose up -d --build",
      "5. Access frontend: http://${aws_eip.devops_eip.public_ip}",
      "6. Configure monitoring dashboards in Grafana"
    ]
  }
}
