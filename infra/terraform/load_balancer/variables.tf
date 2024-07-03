variable "nlb_name" {
  description = "NLB Name"
  type        = string
}

variable "alb_name" {
  description = "ALB Name"
  type        = string
}

# variable "nlb_target_group_name" {
#   description = "nlb target group name"
#   type        = string
# }

# variable "alb_target_group_name" {
#   description = "alb target group name"
#   type        = string
# }

# variable "nlb_target_group_port" {
#   description = "nlb target group port"
#   type        = number
# }

# variable "alb_target_group_port" {
#   description = "alb target group port"
#   type        = number
# }

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
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