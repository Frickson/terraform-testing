module "codebuild" {
  for_each = var.codebuild
  source = "github.com/nec-msbu-devops/chatbot-aws-codebuild"
  name                = each.value.name
  private_repository  = true
  source_credential_token = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["chatbot_github_token"]
  source_type         = "GITHUB"
  source_location     = "https://github.com/nec-msbu-devops/chatbot.git"
  privileged_mode     = each.value.privileged_mode
  buildspec           = each.value.buildspec
  artifact_type       = "NO_ARTIFACTS"
  cache_type          = each.value.cache_type
  local_cache_modes   = each.value.local_cache_modes
  extra_permissions   = length(var.extra_permissions) != 0 ? var.extra_permissions : []
}
