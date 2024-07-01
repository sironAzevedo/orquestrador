output "cluster_id" {
  value = aws_ecs_cluster.main.id
}

output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.repo.repository_url
}