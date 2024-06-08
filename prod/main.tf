data "terraform_remote_state" "assets" {
  backend = "s3"
  config = {
    bucket = "terraform-states-730335516527"
    key    = "consistent-deployments.tfstate"
    region = "us-east-1"
  }
}

module "this" {
  source       = "../modules/lambda"
  aws_region   = "us-east-1"
  environment  = "dev"
  ecr_repo_url = data.terraform_remote_state.assets.outputs.ecr_repo_url
  deploy       = true
  app_version  = "cc5bfc828b239b10be4bcdf8a9e84cfc75da1212" # var.app_version
}
