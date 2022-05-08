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

output "use_fullname" {
  value       = module.main.use_fullname
  description = "return if enabled generated name"
}

# data user

output "user_enabled" {
  value       = module.main.user_enabled
  description = "Is user creation enabled"
}

output "user_name" {
  value       = module.main.user_name
  description = "Normalized IAM user name"
}

output "user_arn" {
  value       = module.main.user_arn
  description = "The ARN assigned by AWS for the user"
}

output "user_unique_id" {
  value       = module.main.user_unique_id
  description = "The user unique ID assigned by AWS"
}

output "access_key_id" {
  sensitive   = true
  value       = module.main.access_key_id
  description = "The access key ID"
}

output "secret_access_key" {
  sensitive   = true
  value       = module.main.secret_access_key
  description = "The secret access key. This will be written to the state file in plain-text"
}
