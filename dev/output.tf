output "repo" {
  value = module.dev_chatbot.test
  sensitive = true
}

output "repo11" {
  value = module.dev_chatbot.name
}
