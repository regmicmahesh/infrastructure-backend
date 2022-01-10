module "label" {
  source = "../label"

  enabled    = var.enabled
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_amplify_app" "default" {
  count       = var.enabled ? 1 : 0
  name        = var.app_name
  description = "${var.stage}-${var.app_name} "
  repository  = var.git_repository
  oauth_token = var.oauth_token

  iam_service_role_arn = aws_iam_role.amplify-role.arn

  // This is the official build spec for react.
  build_spec = <<-EOT
    version: 0.1
    frontend:
      phases:
        preBuild:
          commands:
            - yarn install
        build:
          commands:
            - yarn run build
      artifacts:
        baseDirectory: build
        files:
          - '**/*'
      cache:
        paths:
          - node_modules/**/*
  EOT

  custom_rule {
    source = "/<*>"
    status = "404-200"
    target = "/index.html"
  }

  environment_variables = var.environment_variables

  tags = module.label.tags
}

resource "aws_amplify_branch" "amplify-branch" {
  count             = var.enabled ? 1 : 0
  branch_name       = var.github_branch
  app_id            = aws_amplify_app.default[0].id
  description       = "Branch-${var.github_branch}"
  enable_auto_build = var.auto_build

  tags = {
    Name       = var.app_name
    DomainName = var.domain_name
    Branch     = var.github_branch
  }
}

resource "aws_amplify_domain_association" "amplify-domain" {
  count       = var.enabled ? 1 : 0
  domain_name = var.domain_name
  app_id      = aws_amplify_app.default[0].id

  sub_domain {
    prefix      = var.prefix
    branch_name = aws_amplify_branch.amplify-branch[0].branch_name
  }

}
