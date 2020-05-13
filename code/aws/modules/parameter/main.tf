variable "parameter" {}

output "result" {
  value = <<RESULT
${path.module} = {
  ip_white_list = {
    name = ${data.aws_ssm_parameter.ip_white_list.name}
    value = ${data.aws_ssm_parameter.ip_white_list.value}
  }
}
RESULT
}
