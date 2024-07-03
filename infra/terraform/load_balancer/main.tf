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
  count       = length(var.services)

  load_balancer_arn = aws_lb.nlb.arn
  port              = var.services[count.index].porta
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group[count.index].arn
  }
}

resource "aws_lb_listener" "alb_listener" {
  count       = length(var.services)

  load_balancer_arn = aws_lb.alb.arn
  port              = var.services[count.index].porta
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group[count.index].arn
  }
}

resource "aws_lb_target_group" "nlb_target_group" {
  count       = length(var.services)

  name     = "nlb-tg-${var.services[count.index].nome}"
  port     = var.services[count.index].porta
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
  count       = length(var.services)

  name     = "alb-tg-${var.services[count.index].nome}"
  port     = var.services[count.index].porta
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