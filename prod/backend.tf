terraform {
  backend "s3" {
    bucket = "terraform-states-654654203090"
    key    = "consistent-deployments.tfstate"
    region = "us-east-1"
  }
}
