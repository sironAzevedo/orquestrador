variable "log_group_name" {
  description = "log group name"
  type        = string
}

variable "sns_topic_name" {
  description = "sns topic name"
  type        = string
}

variable "log_group_qtd_retention" {
  description = "log group qtd retention"
  type        = number
}

variable "cluster_name" {
  description = "cluster name"
  type        = string
}