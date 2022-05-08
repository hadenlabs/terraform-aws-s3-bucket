output "instance" {
  description = "show instance module"
  value       = module.main.instance
}

output "bucket_domain_name" {
  value       = module.main.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_regional_domain_name" {
  value       = module.main.bucket_regional_domain_name
  description = "The bucket region-specific domain name"
}

output "bucket_id" {
  value       = module.main.bucket_id
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = module.main.bucket_arn
  description = "Bucket ARN"
}

output "bucket_region" {
  value       = module.main.bucket_region
  description = "Bucket region"
}

output "tags" {
  value       = module.main.tags
  description = "tags generated"
}