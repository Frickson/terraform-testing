variable "domain_name" {
  default = "chatbot"
  type = string
}

variable "codepipeline" {
  type = map(object({
    resource_tag_name  = string
    create_codestar_conn = bool
    codepipeline_module_enabled = bool
  }))
  default = {
    "pipe1" = {
      resource_tag_name    = "dev-pipe1"
      create_codestar_conn = true
      codepipeline_module_enabled = true
    },
    "pipe2" = {
      resource_tag_name    = "dev-pipe2"
      create_codestar_conn = false
      codepipeline_module_enabled = true
    }
  }
}

variable "git_owner" {
  type = string
  default = "Frickson"
}

variable "git_repo" {
  type = string
  default = "chatbot"
}

variable "environment" {
  type = string
  default = "development"
}

variable "git_branch" {
    type = string
    default = "main"
}