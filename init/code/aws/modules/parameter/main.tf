variable "parameter" {}

output "result" {
  value = <<RESULT
${path.module} = {
  ip_white_list = ${aws_ssm_parameter.ip_white_list.name}
  basic_authentication {
    username = ${aws_ssm_parameter.basic_authentication_username.name}
    password = ${aws_ssm_parameter.basic_authentication_password.name}
  }
}
RESULT
}
