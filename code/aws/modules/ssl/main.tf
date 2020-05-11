variable "ssl" {}

data "aws_acm_certificate" "this" {
  domain = var.ssl.domain
}

output "acm_certificate_arn" {
  value = data.aws_acm_certificate.this.arn
}

output "result" {
  value = <<RESULT
${path.module} = {
  acm_certificate_arn = ${data.aws_acm_certificate.this.arn}
}
RESULT
}
