data "aws_iam_policy_document" "assume_role_eks" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::925016504071:role/development-describe-cluster-cross-account"]
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