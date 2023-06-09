locals {
  codebuild = {
    "build-image" = {
      name          = "build-image"
      source_type   = "GITHUB"
      source_location = var.source_location_url
      buildspec     = "chatbot/buildspecs/buildspec-build-image.yml"
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
      environment_variables = []
      vpc_config = {}
    },
    "snyk_container_scanning" = {
      name          = "build1"
      source_type   = "GITHUB"
      source_location = var.source_location_url
      buildspec     = "chatbot/buildspecs/buildspec-snyk.yml"
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
      environment_variables = []
      vpc_config = {}
    },
    "ECR_image_scanning" = {
      name          = "build2"
      source_type   = "GITHUB"
      source_location = var.source_location_url
      buildspec     = "chatbot/buildspecs/buildspec-ecr.yml"
      privileged_mode = false
      cache_type    = "NO_CACHE"
      local_cache_modes = []
      environment_variables = []
      vpc_config = {}
    },
    "git-credentials-check" = {
      name          = "build4"
      source_type   = "NO_SOURCE"
      source_location = ""
      # using file becuz codepipeline required minimum 2 stages to create
      # maybe can move to repo, repo with only this yaml fil
      buildspec     = file("${path.module}/buildspec/git-secret-check.yaml")
      privileged_mode = false
      cache_type    = "NO_CACHE"
      local_cache_modes = []
      environment_variables = [
        {
          name  = "JENKINS_URL"
          value = "https://jenkins.example.com"
          type  = "PLAINTEXT"
        },
        {
          name  = "COMPANY_NAME"
          value = "Amazon"
          type  = "PLAINTEXT"
        }
      ]
      vpc_config = {}
    },
    "deploy_to_stag" = {
      name          = "build5"
      source_type   = "GITHUB"
      source_location = var.source_location_url
      buildspec     = "chatbot/buildspecs/buildspec-stag.yml"
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
      environment_variables = []
      vpc_config = {
        vpc_id = "vpc-082b9db10b172efca"
        subnets = [
          "subnet-017543a237f6844da",
          "subnet-042e439c1960131c3",
        ]

        security_group_ids = [
          "sg-057743b6da4cfecbf"
        ]
     }
    }
    "terraform_scan_by_kx" = {
      name          = "build6"
      source_type   = "NO_SOURCE"
      source_location = ""
      buildspec     = file("${path.module}/buildspec/terraform-scan.yaml")
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE"]
      environment_variables = []
      vpc_config = {}
    }
  }
}


variable "source_location_url" {
  type = string
  default = "https://github.com/nec-msbu-devops/chatbot.git"
  description = "buildspec source repository url"
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

/* variable "parameters" {
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
} */

variable "parameters-1" {
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = [
    {
      name  = "CLUSTER_NAME"
      type  = "String"
      value = "chatbot"
    },
    {
      name  = "COMMIT_ID"
      type  = "String"
      value = "default"
    }
    # Add more parameters as needed
  ]
}

#variable to add
# COMMIT_ID, ROLE_ARN?, NAMESPACE/ENVIRONMENT
# SECRET MANAGER
# GITHUB_TOKEN X2, ask from boss
# synk api-key

/* 
variable "parameters-2" {
  type = map(object({
    name  = string
    type  = string
    value = string
  }))
  default = {
    "CLUSTER_NAME" = {
      name  = "CLUSTER_NAME"
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
} */

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

