output "vpc_endpoint_sg_id" {
  description = "VPC Endpoint Security Group ID"
  value       = aws_security_group.endpoint_sg.id
}

output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.alb_sg.id
}

output "ecs_task_sg_id" {
  description = "ECS Task Security Group ID"
  value       = aws_security_group.ecs_task_sg.id
}