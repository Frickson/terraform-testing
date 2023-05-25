module "dev_chatbot" {
  source = "github.com/nec-msbu-devops/aws-chatbot-module"
  environment = var.environment
  git_branch = var.git_branch
}