output "test" {
  value = one(module.dev_chatbot.*.role_arn)
}