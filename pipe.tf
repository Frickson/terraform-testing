locals {
  s3_deployment_bucket_arn = "arn:aws:s3:::${var.domain_name}"
}

module "codepipeline" {
  source = "github.com/nec-msbu-devops/chatbot-aws-codepipeline"
  for_each = var.codepipeline
  resource_tag_name = each.value.resource_tag_name
  environment       = each.value.environment
  region            = each.value.region

  codepipeline_module_enabled = each.value.codepipeline_module_enabled

  git_owner        = each.value.git_owner
  git_repo         = each.value.git_repo
  git_branch       = each.value.git_branch

  s3_deploy_bucket_arn = local.s3_deployment_bucket_arn

}