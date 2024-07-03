variable "ecs_cluster_name" {
  description = "ecs cluster name"
  type        = string
}

variable "aws_ecs_cluster_id" {
  description = "ecs cluster id"
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

variable "alb_listener_arn" {
  description = "alb listener arn"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ECS Task Role ARN"
  type        = string
}

variable "services" {
  description = "List of service configurations"
  type = list(object({
    nome             = string
    porta            = number
    auto_scaling_max = number
    auto_scaling_min = number
  }))
}

variable "target_group_arns" {
  description = "ARNs of the target groups"
  type        = map(string)
}

variable "default_tags" {
  type = map(any)
}