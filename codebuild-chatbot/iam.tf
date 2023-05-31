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
  name        = "eks_describe_from_terraform"
  description = "Allow describe EKS"
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
    resources = [aws_iam_role.default.arn]
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
  role = local.names[count.index]
}