output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "nlb_target_group_arn" {
  value = {
    for key, value in aws_lb_target_group.nlb_target_group :
    key => value.arn
  }
}

output "alb_target_group_arn" {
  value = {
    for key, value in aws_lb_target_group.alb_target_group :
    key => value.arn
  }
}

# output "nlb_listener_arn" {
#   value = aws_lb_listener.nlb_listener.arn
# }

# output "alb_listener_arn" {
#   value = aws_lb_listener.alb_listener.arn
# }

# output "target_group_arns" {
#   value = {
#     for key, value in aws_lb_target_group.tg :
#     key => value.arn
#   }
# }