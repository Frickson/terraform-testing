output "test" {
    value = local.aws_root_account_arn
}

output "example" {
    value = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["chatbot_github_token"]
    sensitive = true
}

output "role_id" {
  description = "IAM Role ID"
  value       = module.build.role_id
}
