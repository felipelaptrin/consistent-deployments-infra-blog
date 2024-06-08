terraform {
  backend "s3" {
    bucket = "terraform-states-937168356724"
    key    = "consistent-deployments.tfstate"
    region = "us-east-1"
  }
}
