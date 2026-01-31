output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
value = aws_subnet.public[*].id
}

output "private_subnet_id" {
  value = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

output "public_route_table_id" {
  description = "Public route table ID"
  value       = aws_route_table.public_rt.id
}

output "private_route_table_ids" {
  description = "List of private route table IDs"
  value       = aws_route_table.private_rt[*].id
}