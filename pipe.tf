
module "codepipeline" {
  source = "github.com/nec-msbu-devops/chatbot-aws-codepipeline"

  resource_tag_name = var.resource_tag_name
  environment       = var.environment
  region            = var.region

  codepipeline_module_enabled = var.codepipeline_module_enabled

  git_owner        = var.git_owner
  git_repo         = var.git_repo
  git_branch       = var.git_branch


  environment_variable_map = [
    {
      name  = "DOMAIN"
      value = var.domain_name
      type  = "PLAINTEXT"
    },
    {
      name  = "CACHE"
      value = var.domain_cache_settings
      type  = "PLAINTEXT"
    }
  ]
}