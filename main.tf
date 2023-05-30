data "aws_caller_identity" "default" {}

locals {
  aws_account_id = data.aws_caller_identity.default.account_id
  aws_root_account_arn = format("%s:root", data.aws_caller_identity.default.arn)

  names = [
    for index in module.codebuild:
      index.role_name
  ]
}
data "aws_secretsmanager_secret" "by-arn" {
  arn = "arn:aws:secretsmanager:ap-southeast-1:925016504071:secret:chatbot_github_token-pBcvSV"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.by-arn.id
}

resource "aws_codestarconnections_connection" "_" {
  name          = var.codestar_connection_name
  provider_type = var.git_provider_type
}

