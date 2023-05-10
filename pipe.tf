module "codepipeline" {
  source         = "JamesWoolfenden/codepipeline/aws"
  version        = "0.4.21"
  artifact_store = var.artifact_store
  common_tags    = var.common_tags
  description    = var.description
  name           = var.name
  stages         = var.stages
}