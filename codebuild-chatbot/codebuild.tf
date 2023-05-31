locals {
  token = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["chatbot_github_token"]
}

data "aws_secretsmanager_secret" "by-arn" {
  arn = "arn:aws:secretsmanager:ap-southeast-1:925016504071:secret:chatbot_github_token-pBcvSV"
}

module "codebuild" {
  for_each = local.codebuild
  source = "github.com/nec-msbu-devops/chatbot-aws-codebuild"
  name                = each.value.name
  private_repository  = each.value.source_type == "GITHUB" ? true : false
  source_credential_token = each.value.source_type == "GITHUB" ? local.token : ""
  source_type         = each.value.source_type
  source_location     = each.value.source_location
  privileged_mode     = each.value.privileged_mode
  buildspec           = each.value.buildspec
  artifact_type       = "NO_ARTIFACTS"
  cache_type          = each.value.cache_type
  local_cache_modes   = each.value.local_cache_modes
  extra_permissions   = length(var.extra_permissions) != 0 ? var.extra_permissions : []
}
