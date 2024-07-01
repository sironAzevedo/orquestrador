resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name #"main-ecs-cluster"
}

resource "aws_ecr_repository" "repo" {
  name = var.ecr_repository_name #"generic-orchestrator"
}

resource "aws_security_group" "sg" {
  name        = var.security_group_name #"orchestrator-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_task_definition" "task" {
  for_each = { for service in var.service_definitions : service.name => service }
  
  
  family                    = each.value.task_def
  network_mode              = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu       = 256
  memory    = 512
  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn = var.ecs_task_role_arn
  container_definitions = jsonencode([{
    name      = each.value.container
    image     = "${aws_ecr_repository.repo.repository_url}:latest"    
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = each.value.port
      hostPort      = each.value.port
    }]
  }])
}

resource "aws_ecs_service" "service" {
  for_each = { for service in var.service_definitions : service.name => service }
  
  
  name               = each.value.name
  cluster            = aws_ecs_cluster.main.id
  task_definition    = aws_ecs_task_definition.task[each.key].arn
  desired_count      = 2
  launch_type        = "FARGATE"  
  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups = [aws_security_group.sg.id]
  }
  force_new_deployment = true
  load_balancer {
    target_group_arn = var.target_group_arns[each.key]
    container_name   = each.value.container
    container_port   = each.value.port
  }
}