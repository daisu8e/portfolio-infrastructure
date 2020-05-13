resource "aws_ssm_parameter" "ip_white_list" {
  name = "/${var.parameter.prefix}/ip-white-list"
  type = "StringList"
  value = "0.0.0.0"
  lifecycle {
    ignore_changes = all
  }
}
