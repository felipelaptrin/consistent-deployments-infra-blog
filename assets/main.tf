module "this" {
  source      = "../modules/ecr"
  aws_region  = "us-east-1"
  environment = "assets"
}
