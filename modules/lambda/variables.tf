variable "deploy" {
  description = "Boolean that control if this entire module will be deployed"
  type        = bool
}

variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
}

variable "environment" {
  description = "Name of the environment to deploy"
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Variable 'environment' only allows values: 'dev', 'prod'."
  }
}

variable "app_version" {
  description = "Git hash of the application"
  type        = string
  default     = ""
}

variable "ecr_repo_url" {
  description = "URL of the ECR that contains the application image"
  type        = string
}