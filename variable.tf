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
    }
  }
}

variable "environment" {
  type        = string
  description = "AWS resource environment/prefix"
  default = "dev"
}

variable "region" {
  type        = string
  description = "AWS region"
  default = "ap-southeast-1"
}

variable "resource_tag_name" {
  type        = string
  description = "Resource tag name for cost tracking"
  default = "nothing"
}

variable "git_owner" {
  type        = string
  description = "Github username"
  default = "frickson"
}

variable "git_repo" {
  type        = string
  description = "Github repository name"
  default = "https://github.com/nec-msbu-devops/chatbot.git"
}

variable "git_branch" {
  type        = string
  description = "Github branch name"
  default     = "master"
}

variable "domain_name" {
  type        = string
  default     = "test.com"
}

variable "domain_cache_settings" {
  type        = string
  default     = "true"
}