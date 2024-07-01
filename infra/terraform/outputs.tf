output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_dns_name" {
  value = module.load_balancers.alb_dns_name
}

output "ecs_cluster_id" {
  value = module.ecs.cluster_id
}