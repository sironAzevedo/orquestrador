variable "ecs_cluster_name" {
  description = "ecs cluster name"
  type        = string
}

variable "ecr_repository_name" {
  description = "ecr repository name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "security_group_name" {
  description = "security group name"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "services" {
  description = "List of service names"
  type        = list(string)
}

variable "ecs_task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ECS Task Role ARN"
  type        = string
}

variable "service_definitions" {
  description = "List of service definitions"
  type        = list(object({
    name      = string
    port      = number
    task_def  = string
    container = string
  }))
}

variable "target_group_arns" {
  description = "ARNs of the target groups"
  type        = map(string)
}