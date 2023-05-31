variable "codebuild" {
  type = map(object({
    name                  = string
    source_type           = string
    source_location       = string
    buildspec             = string
    privileged_mode       = bool
    cache_type            = string
    local_cache_modes     = list(string)
    environment_variables = map(string)
  }))
  default = {
    "snyk_container_scanning" = {
      name          = "build1"
      source_type   = "GITHUB"
      source_location = "https://github.com/nec-msbu-devops/chatbot.git"
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
      source_type   = "GITHUB"
      source_location = "https://github.com/nec-msbu-devops/chatbot.git"
      buildspec     = "chatbot/buildspecs/buildspec-ecr.yml"
      privileged_mode = false
      cache_type    = "NO_CACHE"
      local_cache_modes = []
      environment_variables = {}
    },
    "deploy_to_staging" = {
      name          = "build3"
      source_type   = "GITHUB"
      source_location = "https://github.com/nec-msbu-devops/chatbot.git"
      buildspec     = "chatbot/buildspecs/buildspec-stag.yml"
      privileged_mode = false
      cache_type    = "NO_CACHE"
      local_cache_modes = []
      environment_variables = {}
    },
    "git-credentials-check" = {
      name          = "build4"
      source_type   = "NO_SOURCE"
      source_location = ""
      buildspec     = "https://github.com/nec-msbu-devops/chatbot.git"
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
      environment_variables = {}
    },
    "deploy_to_stag" = {
      name          = "build5"
      source_type   = "GITHUB"
      source_location = "https://github.com/nec-msbu-devops/chatbot.git"
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

variable "parameters" {
  default = [
    {
      name  = "foo"
      type  = "String"
      value = "bar"
    },
    {
      name  = "another_parameter"
      type  = "String"
      value = "example"
    },
    # Add more parameters as needed
  ]
}

variable "parameters-1" {
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = [
    {
      name  = "foo1"
      type  = "String"
      value = "bar"
    },
    {
      name  = "another_parameter1"
      type  = "String"
      value = "example"
    }
    # Add more parameters as needed
  ]
}

#variable to add
# COMMIT_ID, ROLE_ARN?, NAMESPACE/ENVIRONMENT
# SECRET MANAGER
# GITHUB_TOKEN X2, ask from boss 
variable "parameters-2" {
  type = map(object({
    name  = string
    type  = string
    value = string
  }))
  default = {
    "test1" = {
      name  = "foo2"
      type  = "String"
      value = "bar"
    },
    "test2" = {
      name  = "another_parameter2"
      type  = "String"
      value = "example"
    }
    # Add more parameters as needed
  }
}

variable "lambda" {
  type = map(object({
    filename  = string
    handler = string
    runtime = string
    enable_function_url = bool
    function_url_auth_type = string
  }))
  default = {
    "function-1" = {
      filename  = "lambda_source/ImpToSecurityHubEKS.zip"
      handler = "lambda_function.lambda_handler"
      runtime = "python3.9"
      enable_function_url = false
      function_url_auth_type = ""
    },
    "function-2" = {
      filename  = "lambda_source/trigger.zip"
      handler = "lambda_function.lambda_handler"
      runtime = "python3.9"
      enable_function_url = true
      function_url_auth_type = "NONE"
    }
  }
}

