variable "serviceName" {
  type = string
  description = "Nome do micro serviço"
}

variable "github_repo_id" {
  type = string
  description = "Id do repostório Github"
}

variable "github_repo_name" {
  type = string
  description = "nome do repostório Github"
  default = "orquestrador"
}