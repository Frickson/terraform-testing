variable "chatbot_codebuild" {
  codebuild = {
    "snyk_container_scanning" = {
      name          = "build1"
      buildspec     = "chatbot/buildspecs/buildspec-snyk.yml"
      privileged_mode = true
      cache_type    = "LOCAL"
      local_cache_modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
    },
    "ECR_image_scanning" = {
      name          = "build2"
      buildspec     = "chatbot/buildspecs/buildspec-ecr.yml"
      privileged_mode = false
      cache_type    = "NO_CACHE"
      local_cache_modes = []
      environment_variables = []
    },
    "deploy_to_staging" = {
      name          = "build3"
      buildspec     = "chatbot/buildspecs/buildspec-stag.yml"
      privileged_mode = false
      cache_type    = "NO_CACHE"
      local_cache_modes = []
      environment_variables = []
    }
  }
}
