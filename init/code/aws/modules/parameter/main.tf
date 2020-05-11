variable "parameter" {}

output "result" {
  value = <<RESULT
${path.module} = {
  ip_white_list = {
    name = ${aws_ssm_parameter.ip_white_list.name}
    value = ${aws_ssm_parameter.ip_white_list.value}
  }
}
RESULT
}
