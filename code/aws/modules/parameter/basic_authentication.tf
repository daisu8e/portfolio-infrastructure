data "aws_ssm_parameter" "basic_authentication_username" {
  name = "/${var.parameter.prefix}/basic-authentication/username"
}

data "aws_ssm_parameter" "basic_authentication_password" {
  name = "/${var.parameter.prefix}/basic-authentication/password"
}

output "basic_authentication" {
  value = {
    username = data.aws_ssm_parameter.basic_authentication_username.value
    password = data.aws_ssm_parameter.basic_authentication_password.value
  }
}
