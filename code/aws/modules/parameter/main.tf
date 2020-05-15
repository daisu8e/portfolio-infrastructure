variable "parameter" {}

output "result" {
  value = <<RESULT
${path.module} = {
  ip_white_list = ${data.aws_ssm_parameter.ip_white_list.name}
  basic_authentication {
    username = ${data.aws_ssm_parameter.basic_authentication_username.name}
    password = ${data.aws_ssm_parameter.basic_authentication_password.name}
  }
}
RESULT
}
