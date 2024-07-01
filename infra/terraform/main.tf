module "vpc" {
  source        = "./vpc"
  vpc_cidr      = var.vpc_cidr
  subnet_cidrs  = var.subnet_cidrs
}

module "load_balancers" {
  source                  = "./load_balancer"
  nlb_name                = "orchestrator-nlb"
  alb_name                = "orchestrator-alb"
  nlb_target_group_name   = "nlb-target-group"
  alb_target_group_name   = "alb-target-group"
  alb_target_group_port   = 80
  nlb_target_group_port   = 80
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.subnet_ids
  service_definitions     = local.service_definitions
}

module "ecs" {
  source                      = "./ecs"
  ecs_cluster_name            = var.application_name
  ecr_repository_name         = var.application_name
  services                    = var.services
  security_group_name         = "orchestrator-sg"
  vpc_id                      = module.vpc.vpc_id
  subnet_ids                  = module.vpc.subnet_ids
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn 
  service_definitions         = local.service_definitions
  target_group_arns           = module.load_balancers.target_group_arns
}

module "iam" {
  source = "./iam"
}

module "cloudwatch" {
  source = "./cloudwatch"
  log_group_name          = "/ecs/orchestrator"
  sns_topic_name          = "orchestrator-sns-topic"
  log_group_qtd_retention = 7
  cluster_name            = module.ecs.cluster_name
}

locals {
  service_definitions = [
    for idx, service_name in var.services :
    {
      name       = service_name
      port       = 8080 + idx
      task_def   = "${service_name}-task"
      container  = "${service_name}-container"
    }
  ]
}