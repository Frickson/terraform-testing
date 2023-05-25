data "aws_caller_identity" "default" {}

locals {
  aws_account_id = data.aws_caller_identity.default.account_id
  aws_root_account_arn = format("%s:root", data.aws_caller_identity.default.arn)
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


module "codebuild" {
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


resource "aws_iam_role" "default" {
  name                  = "EKS_assume_role_created_from_terraform_by_kx"
  assume_role_policy    = data.aws_iam_policy_document.role.json
}

data "aws_iam_policy_document" "role" {
  statement {
    sid = ""
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.aws_account_id}:root"]
    }
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
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
}

data "aws_iam_policy_document" "assume_role_eks" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::925016504071:role/EKS_assume_role_created_from_terraform_by_kx"]
  }
}

resource "aws_iam_policy" "assume_role_eks_policy" {
  name        = "sts_assume_eks_deploy_role"
  description = "A policy to assume role given by specific account to deploy resouces on their account"
  policy      = data.aws_iam_policy_document.assume_role_eks.json
}

resource "aws_iam_role_policy_attachment" "assume_role_eks_attach" {
  count = length(module.codebuild)
  policy_arn = aws_iam_policy.assume_role_eks_policy.arn
  role = index(module.codebuild[count.index].role_arn)
}

