
output "cloudfront_url" {
  description = "The CloudFront distribution URL for this project"
  value       = module.cloudfront.cloudfront_domain_name
}
