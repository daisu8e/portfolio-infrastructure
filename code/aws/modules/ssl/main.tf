variable "ssl" {}
variable "dns" {}

data "aws_acm_certificate" "ssl" {
  domain = var.ssl.domain
}

output "certificate_arn" {
  value = data.aws_acm_certificate.ssl.arn
}

output "result" {
  value = <<RESULT
${path.module} = OK
RESULT
}
