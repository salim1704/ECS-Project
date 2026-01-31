variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}


variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "private_subnet" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "public_subnet" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}