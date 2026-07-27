output "frontend_url" {
  description = "Public URL for the deployed frontend"
  value       = "http://${aws_lb.main.dns_name}"
}

output "backend_api_url" {
  description = "Public URL for the deployed backend API"
  value       = "http://${aws_lb.main.dns_name}/api"
}

output "frontend_ecr_repository_url" {
  description = "ECR repository URL for the frontend image"
  value       = aws_ecr_repository.frontend.repository_url
}

output "backend_ecr_repository_url" {
  description = "ECR repository URL for the backend image"
  value       = aws_ecr_repository.backend.repository_url
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "frontend_service_name" {
  description = "Name of the frontend ECS service"
  value       = aws_ecs_service.frontend.name
}

output "backend_service_name" {
  description = "Name of the backend ECS service"
  value       = aws_ecs_service.backend.name
}