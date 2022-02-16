output "gw_arn" {
  value       = aws_apigatewayv2_api.lambda.arn
  description = "The ARN of the API."
}

output "gw_id" {
  value       = aws_apigatewayv2_api.lambda.id
  description = "The API identifier."
}

output "gw_endpoint" {
  value       = aws_apigatewayv2_api.lambda.api_endpoint
  description = "The URI of the API, of the form https://{api-id}.execute-api.{region}.amazonaws.com for HTTP APIs and wss://{api-id}.execute-api.{region}.amazonaws.com for WebSocket APIs."
}

output "execution_arn" {
  value       = aws_apigatewayv2_api.lambda.execution_arn
  description = " The ARN prefix to be used in an aws_lambda_permission's source_arn attribute or in an aws_iam_policy to authorize access to the @connections API. See the Amazon API Gateway Developer Guide for details."
}

output "gw_target_domain_name" {
  value = aws_apigatewayv2_domain_name.default.domain_name_configuration[0].target_domain_name
}

output "gw_target_hosted_zone_id" {
  value = aws_apigatewayv2_domain_name.default.domain_name_configuration[0].hosted_zone_id
}

output "gw_domain_name" {
  value = var.domain_name
}
