output "backend_repo_url" {
  description = "ECR URL for Flask app"
  value       = aws_ecr_repository.backend-repo.repository_url
}

output "frontend_repo_url" {
  description = "ECR URL for Express app"
  value       = aws_ecr_repository.frontend-repo.repository_url
}
