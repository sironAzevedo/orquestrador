variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "subnet_cidrs" {
  description = "The CIDR blocks for the subnets"
  type        = list(string)
  default     = ["172.31.0.0/20", "172.31.48.0/20"]
}

variable "services" {
  description = "List of service configurations"
  type = list(object({
    nome             = string
    porta            = number
    auto_scaling_max = number
    auto_scaling_min = number
  }))
  default = [
    { nome = "orchestrator-cartao", porta = 8080, auto_scaling_max = 2, auto_scaling_min = 1 },
    { nome = "orchestrator-conta", porta = 8081, auto_scaling_max = 2, auto_scaling_min = 1 }
  ]
}

variable "application_name" {
  description = "Application name"
  type        = string
  default     = "orchestrator"
}

variable "github_repo_id" {
  type = string
  description = "Id do repostório Github"
  default = "821738371"
}

variable "github_repo_name" {
  type = string
  description = "nome do repostório Github"
  default = "orquestrador"
}