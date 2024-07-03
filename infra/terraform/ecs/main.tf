resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name #"main-ecs-cluster"
}

resource "aws_ecr_repository" "repo" {
  name = var.ecr_repository_name #"generic-orchestrator"
}

resource "aws_ecs_task_definition" "task" {
  count    = length(var.services)
  
  family                    = var.services[count.index].nome
  network_mode              = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu       = 256
  memory    = 512
  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn = var.ecs_task_role_arn
  tags = merge(
    var.default_tags,
    {
      serviceName = var.services[count.index].nome
    }
  )
  container_definitions = jsonencode([{
    name      = var.services[count.index].nome
    image     = "${aws_ecr_repository.repo.repository_url}:latest"    
    cpu       = 256
    memory    = 512
    essential = true
    portMappings = [{
      containerPort = var.services[count.index].porta
      hostPort      = var.services[count.index].porta
    }]
  }])
}

resource "aws_ecs_service" "service" {
  count              = length(var.services)
  
  name               = var.services[count.index].nome
  cluster            = aws_ecs_cluster.main.id
  task_definition    = aws_ecs_task_definition.task[count.index].arn
  desired_count      = var.services[count.index].auto_scaling_min
  launch_type        = "FARGATE"
  tags = merge(
    var.default_tags,
    {
      serviceName = var.services[count.index].nome
    }
  )
  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups = [aws_security_group.sg.id]
  }
  force_new_deployment = true
  load_balancer {
    target_group_arn = var.target_group_arns[count.index]
    container_name   = var.services[count.index].nome
    container_port   = var.services[count.index].porta
  }
}