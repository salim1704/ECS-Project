variable "domain_name" {
  description = "Base domain name (existing hosted zone)"
  type        = string
}

variable "dns_name" {
  description = "DNS name for the Route 53 record"
  type        = string
}

