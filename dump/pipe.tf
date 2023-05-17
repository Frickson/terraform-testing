locals {
  bucket_name = "${var.environment}-${var.git_repo}-${random_string.postfix.result}"
}

resource "random_string" "postfix" {
  count = var.codepipeline_module_enabled ? 1 : 0

  length  = 6
  numeric = false
  upper   = false
  special = false
  lower   = true
}
# -----------------------------------------------------------------------------
# Resources: CodePipeline
# -----------------------------------------------------------------------------
resource "aws_s3_bucket" "artifact_store" {
  count = var.codepipeline_module_enabled ? 1 : 0

  bucket        = local.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_lifecycle_configuration" "_" {
  count = var.codepipeline_module_enabled ? 1 : 0

  bucket = try(one(aws_s3_bucket.artifact_store.*.id), "")

  rule {
    id     = "lifecycle_rule_codepipeline_expiration"
    status = "Enabled"
    expiration {
      days = 5
    }
  }
}
module "codepipeline" {
  source = "github.com/nec-msbu-devops/chatbot-aws-codepipeline"
  for_each = var.codepipeline
  resource_tag_name = each.value.resource_tag_name
  environment       = each.value.environment
  create_codestar_conn = each.value.create_codestar_conn
  codepipeline_module_enabled = each.value.codepipeline_module_enabled

  git_owner        = each.value.git_owner
  git_repo         = each.value.git_repo
  git_branch       = each.value.git_branch

  s3_deploy_bucket_arn = local.s3_deployment_bucket_arn

}