module "label" {
  source = "../label"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  attributes = var.attributes
  tags       = var.tags
}

resource "aws_apigatewayv2_api" "lambda" {
  name          = "${var.api_name}-gw"
  protocol_type = "HTTP"
  tags          = module.label.tags
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id      = aws_apigatewayv2_api.lambda.id
  name        = "${var.api_name}-stage"
  auto_deploy = true
}

resource "aws_apigatewayv2_domain_name" "default" {
  domain_name = var.domain_name

  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api_mapping" "api" {
  api_id      = aws_apigatewayv2_api.lambda.id
  domain_name = aws_apigatewayv2_domain_name.default.id
  stage       = aws_apigatewayv2_stage.lambda.id
}

module "api-gw-record" {
  source                = "../route53/record"
  record_name           = var.domain_name
  zone_id               = var.zone_id
  target_domain_name    = aws_apigatewayv2_domain_name.default.domain_name_configuration[0].target_domain_name
  target_hosted_zone_id = aws_apigatewayv2_domain_name.default.domain_name_configuration[0].hosted_zone_id
}
