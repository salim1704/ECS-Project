output "vpc_endpoint_sg_id" {
  description = "VPC Endpoint Security Group ID"
  value       = aws_security_group.endpoint_sg.id
}