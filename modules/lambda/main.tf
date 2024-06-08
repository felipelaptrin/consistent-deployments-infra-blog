locals {
  account_ids = {
    dev    = "937168356724"
    prod   = "654654203090"
    assets = "730335516527"
  }
  base_name = "consistent-deployments"
}

###############
### Lambda
###############
data "aws_iam_policy_document" "this" {
  count = var.deploy ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.deploy ? 1 : 0

  name               = local.base_name
  assume_role_policy = data.aws_iam_policy_document.this[0].json
}

resource "aws_iam_role_policy" "this" {
  count = var.deploy ? 1 : 0

  name = "lambda-policy"
  role = aws_iam_role.this[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:ecr:${var.aws_region}:${local.account_ids.assets}:repository/${local.base_name}"
        ]
      }
    ]
  })
}

resource "aws_lambda_function" "this" {
  count = var.deploy ? 1 : 0

  function_name = "${var.environment}-${local.base_name}"
  role          = aws_iam_role.this[0].arn
  image_uri     = "${var.ecr_repo_url}:${var.app_version}"
  package_type  = "Image"
}
