variable "basic_authentication" {}
variable "parameter" {}

output "lambda_arn" {
  value = aws_lambda_function.this.qualified_arn
}

output "result" {
  value = <<RESULT
${path.module} = {
  lambda = ${aws_lambda_function.this.function_name}
}
RESULT
}
