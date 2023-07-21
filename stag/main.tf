module "stag_chatbot" {
  source = "github.com/nec-msbu-devops/aws-chatbot-module"
  environment = var.environment
  git_branch = var.git_branch
  eks_role = var.eks_role
}