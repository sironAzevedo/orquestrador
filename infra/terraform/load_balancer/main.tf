resource "aws_lb" "nlb" {
  name               = var.nlb_name #"orchestrator-nlb"
  # internal           = false
  load_balancer_type = "network"
  subnets            = var.subnet_ids

  tags = {
    Name = "main-nlb"
  }
}

resource "aws_lb" "alb" {
  name               = var.alb_name #"orchestrator-alb"
  # internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids

  tags = {
    Name = "main-alb"
  }
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

resource "aws_lb_target_group" "nlb_target_group" {
  name     = var.nlb_target_group_name
  port     = var.nlb_target_group_port #80
  protocol = "TCP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = var.alb_target_group_name
  port     = var.alb_target_group_port #80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }
}

resource "aws_lb_target_group" "tg" {
  for_each = { for service in var.service_definitions : service.name => service }

  name     = each.value.name
  port     = each.value.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    protocol            = "HTTP"
  }
}

# resource "aws_lb_listener_rule" "nlb_listener_rule" {
#   for_each = { for service in var.service_definitions : service.name => service }

#   listener_arn = aws_lb_listener.nlb_listener.arn
#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg[each.key].arn
#   }
#   condition {
#     path_pattern {
#       values = ["/*"]
#     }
#   }
# }

resource "aws_lb_listener_rule" "alb_listener_rule" {
  for_each = { for service in var.service_definitions : service.name => service }

  listener_arn = aws_lb_listener.alb_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[each.key].arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}