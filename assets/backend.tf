terraform {
  backend "s3" {
    bucket = "terraform-states-730335516527"
    key    = "consistent-deployments.tfstate"
    region = "us-east-1"
  }
}
