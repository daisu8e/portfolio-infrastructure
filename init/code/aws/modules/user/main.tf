variable "user" {}

output "result" {
  value = <<RESULT
${path.module} = {
  infrastructure_circleci = ${aws_iam_user.infrastructure_circleci.name}
}
RESULT
}
