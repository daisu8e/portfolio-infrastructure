variable "parameter" {}

output "result" {
  value = <<RESULT
${path.module} = {
  ip_white_list = {
    name = ${aws_ssm_parameter.ip_white_list.name}
    value = ${aws_ssm_parameter.ip_white_list.value}
  }
  basic_authentication {
    username = {
      name = ${aws_ssm_parameter.basic_authentication_username.name}
      value = ${aws_ssm_parameter.basic_authentication_username.value}
    }
    password = {
      name = ${aws_ssm_parameter.basic_authentication_password.name}
      value = ${aws_ssm_parameter.basic_authentication_password.value}
    }
  }
}
RESULT
}
