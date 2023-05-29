output "test" {
    value = local.aws_root_account_arn
}

output "example" {
    value = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["chatbot_github_token"]
    sensitive = true
}

output "role_arn" {
  description = "IAM Role ARN"
  value = [for index in module.codebuild:{
    arn = index.role_arn
  }]
}


output "project_id" {
  /* description = "IAM Role ARN" */
  value = [for index in module.codebuild:{
    arn = index.project_id
  }]
}

output "testabc" {
  value = length(local.test)!=0 ? [for x in local.test: x.project_id if x.name == "build3"][0] : "shit"
}
