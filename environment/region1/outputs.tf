output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.compute.alb_dns_name
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = module.compute.alb_arn
}