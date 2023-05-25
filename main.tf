data "aws_caller_identity" "default" {}

locals {
  aws_account_id = data.aws_caller_identity.default.account_id
  aws_root_account_arn = format("data.aws_caller_identity.default.arn%s", ":root")
}
data "aws_secretsmanager_secret" "by-arn" {
  arn = "arn:aws:secretsmanager:ap-southeast-1:925016504071:secret:chatbot_github_token-pBcvSV"
}

data "aws_secretsmanager_secret_version" "secret-version" {
  secret_id = data.aws_secretsmanager_secret.by-arn.id
}

resource "aws_codestarconnections_connection" "_" {
  name          = var.codestar_connection_name
  provider_type = var.git_provider_type
}



module "build" {
  for_each = var.codebuild
  source = "github.com/nec-msbu-devops/chatbot-aws-codebuild"
  name                = each.value.name
  private_repository  = true
  source_credential_token = jsondecode(data.aws_secretsmanager_secret_version.secret-version.secret_string)["chatbot_github_token"]
  source_type         = "GITHUB"
  source_location     = "https://github.com/nec-msbu-devops/chatbot.git"
  privileged_mode     = each.value.privileged_mode
  buildspec           = each.value.buildspec
  artifact_type       = "NO_ARTIFACTS"
  cache_type          = each.value.cache_type
  local_cache_modes   = each.value.local_cache_modes
  extra_permissions   = length(var.extra_permissions) != 0 ? var.extra_permissions : []
  #environment_variables = each.value.environment_variables 
}


/* resource "aws_iam_role" "default" {
  name                  = "EKS_assume_role_created_from_terraform_by_kx"
  assume_role_policy    = data.aws_iam_policy_document.role.json
  force_detach_policies = true
  path                  = var.iam_role_path
  permissions_boundary  = var.iam_permissions_boundary

}

data "aws_iam_policy_document" "role" {
  statement {
    sid = ""
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = [local.aws_root_account_arn]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect    = "Allow"
    actions   = ["eks:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.default.name
  policy_arn = aws_iam_policy.policy.arn
} */
