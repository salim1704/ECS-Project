output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
value = aws_subnet.public[*].id
}

output "private_subnet_id" {
  value = aws_subnet.private[*].id
}

output "private_route_table_ids" {
  description = "List of private route table IDs"
  value       = aws_route_table.private_rt[*].id
}