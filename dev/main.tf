module "dev_chatbot" {
  source = "github.com/nec-msbu-devops/aws-chatbot-module?ref=v1.0"
  environment = var.environment
}