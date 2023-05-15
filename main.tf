data "aws_secretsmanager_secret" "by-arn" {
  arn = "arn:aws:secretsmanager:ap-southeast-1:925016504071:secret:chatbot_github_token-pBcvSV"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.by-arn.id
}

module "build" {
  for_each = variable.chatbot_codebuild.codebuild
  source = "github.com/nec-msbu-devops/terraform_module"
  name                = each.value.name
  #build_image         = var.build_image
  #build_compute_type  = var.build_compute_type
  #build_timeout       = var.build_timeout 
  private_repository  = true
  #source_credential_token = "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"
  source_credential_token = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["chatbot_github_token"]
  source_type         = "GITHUB"
  source_location     = "https://github.com/nec-msbu-devops/chatbot.git"
  privileged_mode     = each.value.privileged_mode
  buildspec           = each.value.buildspec
  artifact_type       = "NO_ARTIFACTS"
  cache_type          = each.value.cache_type
  local_cache_modes   = each.value.local_cache_modes
  #environment_variables = each.value.environment_variables
}

output "example" {
  value = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["chatbot_github_token"]
  sensitive = true
}
