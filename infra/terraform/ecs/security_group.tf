resource "aws_security_group" "sg" {
  name        = var.security_group_name #"orchestrator-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.services
    content {
      description = "Allow traffic for app ${ingress.value.nome} on port ${ingress.value.porta}"
      from_port = ingress.value.porta
      to_port = ingress.value.porta
      protocol    = "tcp"
      cidr_blocks = var.allowed_ips
    }
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}