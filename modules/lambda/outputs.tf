output "invoke_arn" {
  value = aws_lambda_function.test_lambda.invoke_arn
}

output "function_name" {
  value = aws_lambda_function.test_lambda.function_name
}

output "lambda_sg_id" {
  value = aws_security_group.lambda-sg.id
}
