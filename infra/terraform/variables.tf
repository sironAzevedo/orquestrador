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
  description = "List of services to create"
  type        = list(string)
  default     = ["orchestrator-cartao", "orchestrator-conta"]
}

variable "service_ports" {
  description = "List of ports for the services"
  type        = list(number)
  default     = [8080, 8081]
}

variable "application_name" {
  description = "Application name"
  type        = string
  default     = "orchestrator"
}