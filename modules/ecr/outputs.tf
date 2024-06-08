output "ecr_repo_url" {
  description = "URL of ECR repository"
  value       = aws_ecr_repository.this.repository_url
}