variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "private_route_table_ids" {
  description = "List of private route table IDs"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block for security group"
  type        = string
}

variable "vpc_endpoint_sg_id" {
  description = "Security group ID for VPC endpoints"
  type        = string
}