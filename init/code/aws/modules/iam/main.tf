variable "iam" {}

data "aws_iam_role" "this" {
  name = "OrganizationAccountAccessRole"
}

output "result" {
  value = <<RESULT
${path.module} = OK
===
${data.aws_iam_role.this.arn}
===
RESULT
}
