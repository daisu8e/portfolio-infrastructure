variable "ssl" {}

resource "aws_acm_certificate" "this" {
  domain_name = var.ssl.domain
  subject_alternative_names = ["*.${var.ssl.domain}"]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = var.ssl.tag
  }
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn = aws_acm_certificate.this.arn
  validation_record_fqdns = [aws_acm_certificate.this.domain_validation_options[0].resource_record_name]
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.this.arn
}

output "result" {
  value = <<RESULT
${path.module} = {
  domain = ${aws_acm_certificate.this.domain_name}, *.${aws_acm_certificate.this.domain_name}
  domain_validation = {
    name = ${aws_acm_certificate.this.domain_validation_options[0].resource_record_name}
    type = ${aws_acm_certificate.this.domain_validation_options[0].resource_record_type}
    value = ${aws_acm_certificate.this.domain_validation_options[0].resource_record_value}
  }
}
RESULT
}
