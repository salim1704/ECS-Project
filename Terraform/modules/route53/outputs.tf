output "app_url" {
  description = "HTTPS URL of the app"
  value       = "https://${aws_route53_record.this.fqdn}"
}