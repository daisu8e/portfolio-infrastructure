variable "user" {}

output "result" {
  value = <<RESULT
${path.module} = {
  application_circleci = ${aws_iam_user.application_circleci.name}
}
RESULT
}
