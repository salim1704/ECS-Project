variable "private_subnet" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "public_subnet" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "alb_sg_id" {
  description = "ALB Security Group ID"
  type        = string
}
