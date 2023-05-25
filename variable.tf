variable "codebuild" {
  type = map(object({
    name                  = string
    buildspec             = string
    privileged_mode       = bool
    cache_type            = string
    local_cache_modes     = list(string)
    environment_variables = map(string)
  }))
  default = {
    "snyk_container_scanning" = {
      name          = "build1"
      buildspec     = "chatbot/buildspecs/buildspec-snyk.yml"
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
      environment_variables = {
        "KEY1" = "VALUE1" 
        "KEY2" = "VALUE2"
      }
    },
    "ECR_image_scanning" = {
      name          = "build2"
      buildspec     = "chatbot/buildspecs/buildspec-ecr.yml"
      privileged_mode = false
      cache_type    = "NO_CACHE"
      local_cache_modes = []
      environment_variables = {}
    },
    "deploy_to_staging" = {
      name          = "build3"
      buildspec     = "chatbot/buildspecs/buildspec-stag.yml"
      privileged_mode = false
      cache_type    = "NO_CACHE"
      local_cache_modes = []
      environment_variables = {}
    },
    "git-credentials-check" = {
      name          = "build4"
      buildspec     = "chatbot/buildspecs/buildspec-gitsecrets.yml"
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
      environment_variables = {}
    },
    "deploy_to_stag" = {
      name          = "build5"
      buildspec     = "chatbot/buildspecs/buildspec-stag.yml"
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
      environment_variables = {}
    }
  }
}

variable "codestar_connection_name" {
  type = string
  default = "devops_github_to_chatbot"
}

variable "git_provider_type" {
  description = "Codestar connections support; GitHub, Bitbucket"
  default = "GitHub"
}

variable "extra_permissions" {
  type        = list(any)
  default     = []
  description = "List of action strings which will be added to IAM service account permissions."
}
