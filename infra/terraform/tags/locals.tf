locals {
  local_default_tags = {
    serviceName = var.serviceName
    REPO_ID     = var.github_repo_id
    REPO_NAME   = var.github_repo_name
  }
}