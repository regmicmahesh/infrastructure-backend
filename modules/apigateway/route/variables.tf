variable "invoke_arn" {
  type        = string
  description = "The URI of the Lambda function for a Lambda proxy integration, when integration_type is AWS_PROXY."
}

variable "api_id" {
  type        = string
  description = "The API identifier for the route"
}

variable "route_key" {
  type        = string
  description = "The route key for the route. For HTTP APIs, the route key can be either $default, or a combination of an HTTP method and resource path, for example, GET /pets."
}

variable "execution_arn" {
  type        = string
  description = "The ARN prefix of API Gateway for setting source_arn."
}

variable "function_name" {
  type        = string
  description = "Name of the lambda function."
}
