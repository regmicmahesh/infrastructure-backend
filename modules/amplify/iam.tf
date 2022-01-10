data "aws_iam_policy_document" "amplify-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["amplify.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "amplify-role-policy" {
  statement {
    actions   = ["amplify:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "amplify-role" {
  name               = "${var.prefix}-${var.app_name}-Role"
  assume_role_policy = data.aws_iam_policy_document.amplify-assume-role-policy.json

  tags = module.label.tags
}

resource "aws_iam_role_policy" "amplify-policy" {
  name = "${var.prefix}-${var.app_name}-Policy"
  role = aws_iam_role.amplify-role.name
  policy = data.aws_iam_policy_document.amplify-role-policy.json
  
}


