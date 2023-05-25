output "test" {
    value = local.aws_root_account_arn
}

output "example" {
    value = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["chatbot_github_token"]
    sensitive = true
}

output "project_name" {
  description = "Project name"
  value       = module.codebuild.project_name
}

output "project_id" {
  description = "Project ID"
  value       = module.codebuild.project_id
}

output "role_id" {
  description = "IAM Role ID"
  value       = module.codebuild.role_id
}

output "role_arn" {
  description = "IAM Role ARN"
  value       = module.codebuild.role_arn
}

output "cache_bucket_name" {
  description = "Cache S3 bucket name"
  value       = module.codebuild.cache_bucket_name
}

output "cache_bucket_arn" {
  description = "Cache S3 bucket ARN"
  value       = module.codebuild.cache_bucket_arn
}

output "badge_url" {
  description = "The URL of the build badge when badge_enabled is enabled"
  value       = module.codebuild.badge_url
}