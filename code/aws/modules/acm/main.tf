variable "acm" {}

data "aws_acm_certificate" "this" {
  domain = var.acm.domain
}

output "certificate_arn" {
  value = data.aws_acm_certificate.this.arn
}

output "result" {
  value = <<RESULT
${path.module} = OK
RESULT
}
