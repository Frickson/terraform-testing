variable "environment" {
  type = string
  default = "staging"
  description = "👾🕹️"
}

variable "git_branch" {
  type = string
  default = "main"
  description = "👾🕹️"
}

variable "eks_role" {
  type = string
  default = "arn:aws:iam::925016504071:role/development-describe-cluster-cross-account"
  description = "EKS roles from chatbot development account"
}