output "repo_urls" {
  value = module.dev_chatbot.repo_urls
  sensitive = true
}

output "project_names" {
  value = module.dev_chatbot.project_names
}
