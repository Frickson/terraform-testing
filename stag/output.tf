output "repo_urls" {
  value = module.stag_chatbot.repo_urls
  sensitive = true
}

output "project_names" {
  value = module.stag_chatbot.project_names
}
