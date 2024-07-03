module "vpc" {
  source        = "./vpc"
  vpc_cidr      = var.vpc_cidr
  subnet_cidrs  = var.subnet_cidrs
}

module "default_tags" {
  source = "./tags"
  serviceName = var.application_name
  github_repo_id = var.github_repo_id
}

module "load_balancers" {
  source                  = "./load_balancer"
  nlb_name                = "orchestrator-nlb"
  alb_name                = "orchestrator-alb"  
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.subnet_ids
  services                = var.services
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
  target_group_arns           = module.load_balancers.alb_target_group_arn
  default_tags                = module.default_tags.tags
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