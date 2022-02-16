module "label" {
  source = "../label"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.function_name}-iam"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "ses-policy-doc" {
  statement {
    actions   = ["ses:*"]
    resources = ["*"]
  }

}

resource "aws_iam_role_policy" "lambda-ses-role-policy" {
  count  = var.ses_enabled ? 1 : 0
  name   = "${var.function_name}-ses-role-policy"
  role   = aws_iam_role.iam_for_lambda.id
  policy = data.aws_iam_policy_document.ses-policy-doc.json
}





resource "aws_lambda_function" "test_lambda" {
  function_name = var.function_name
  role          = aws_iam_role.iam_for_lambda.arn
  image_uri     = var.image_uri
  memory_size   = var.memory_size
  package_type  = "Image"

  timeout = var.timeout

  environment {

    variables = var.environment_variables
  }

  lifecycle {
    ignore_changes = [image_uri, environment]
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.lambda-sg.id]
  }

  tags = module.label.tags

}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_security_group" "lambda-sg" {
  name   = join("-", [var.function_name, "sg"])
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "egress-internet" {
  count             = var.internet_enabled ? 1 : 0
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lambda-sg.id
  type              = "egress"
}

resource "aws_security_group_rule" "egress-rds" {
  count                    = var.db_access_enabled ? 1 : 0
  description              = "Send traffic to Aurora Serverless."
  from_port                = 0
  to_port                  = 5432
  source_security_group_id = var.rds_sg_id
  protocol                 = "-1"
  security_group_id        = aws_security_group.lambda-sg.id
  type                     = "egress"
}
