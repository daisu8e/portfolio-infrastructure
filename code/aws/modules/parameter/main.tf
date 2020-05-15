variable "parameter" {}

output "result" {
  value = <<RESULT
${path.module} = {
  ip_white_list = {
    name = ${data.aws_ssm_parameter.ip_white_list.name}
    value = ${data.aws_ssm_parameter.ip_white_list.value}
  }
  basic_authentication {
    username = {
      name = ${data.aws_ssm_parameter.basic_authentication_username.name}
      value = ${data.aws_ssm_parameter.basic_authentication_username.value}
    }
    password = {
      name = ${data.aws_ssm_parameter.basic_authentication_password.name}
      value = ${data.aws_ssm_parameter.basic_authentication_password.value}
    }
  }
}
RESULT
}
