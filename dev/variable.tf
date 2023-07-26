variable "environment" {
  type = string
  default = "development"
  description = "👾🕹️"
}

variable "git_branch" {
  type = string
  default = "main"
  description = "👾🕹️"
}

variable "eks_role" {
  type = string
  /* default = "arn:aws:iam::925016504071:role/development-describe-cluster-cross-account" */
  default  = "arn:aws:iam::448658572737:role/EksCodeBuildKubectlRole"
  description = "EKS roles from chatbot development account"
}

locals {
  arn_by_env = {
    development = "arn:aws:iam::448658572737:role/DEV"
    staging = "arn:aws:iam::448658572737:role/STAG"
    production = "arn:aws:iam::448658572737:role/PROD"
  }
  development = {
    arn_by_env = "arn:aws:iam::448658572737:role/DEV"
    tag = {
      env = "developnment"
    }
  }
  arn = local.arn_by_env[var.environment]
}