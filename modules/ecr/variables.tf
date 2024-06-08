variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
}

variable "environment" {
  description = "Name of the environment to deploy"
  type        = string
  validation {
    condition     = contains(["assets"], var.environment)
    error_message = "Variable 'environment' only allows values: 'assets'."
  }
}
