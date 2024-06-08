locals {
  account_ids = {
    dev    = "937168356724"
    prod   = "654654203090"
    assets = "730335516527"
  }
  base_name = "consistent-deployments"
}

###############
### ECR
###############
resource "aws_ecr_repository" "this" {
  name                 = local.base_name
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = values(local.account_ids)
        }
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ],
        Condition = {
          StringLike = {
            "aws:sourceArn": [ for account in values(local.account_ids) : "arn:aws:lambda:${var.aws_region}:${account}:function:*" ]
          }
        }
      }
    ]
  })
}
