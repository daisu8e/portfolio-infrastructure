resource "aws_ssm_parameter" "basic_authentication_username" {
  name = "/${var.parameter.prefix}/basic-authentication/username"
  type = "String"
  value = "********"
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_ssm_parameter" "basic_authentication_password" {
  name = "/${var.parameter.prefix}/basic-authentication/password"
  type = "String"
  value = "********"
  lifecycle {
    ignore_changes = all
  }
}
