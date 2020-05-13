data "aws_ssm_parameter" "ip_white_list" {
  name = "/${var.parameter.prefix}/ip-white-list"
}

output "ip_white_list" {
  value = split(",", data.aws_ssm_parameter.ip_white_list.value)
}
