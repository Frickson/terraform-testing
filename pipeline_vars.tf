variable "codepipeline" {
  type = map(object({
    environment        = string
    resource_tag_name  = string
    git_owner          = string
    git_repo           = string
    git_branch         = string
    domain_name        = string
    codepipeline_module_enabled = bool
  }))
  default = {
    "pipe1" = {
      environment          = "dev"
      resource_tag_name    = "dev-pipe1"
      git_owner            = "Frickson"
      git_repo             = "test"
      git_branch           = "main"
      domain_name          = "chatbot"
      codepipeline_module_enabled = true
    },
    "pipe2" = {
      environment          = "dev"
      resource_tag_name    = "dev-pipe2"
      git_owner            = "Frickson"
      git_repo             = "webserver"
      git_branch           = "main"
      domain_name          = "chatbot"
      codepipeline_module_enabled = true
    }
  }
}

