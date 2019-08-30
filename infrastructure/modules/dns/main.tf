variable "dns" {}

data "aws_route53_zone" "domain" {
  name = "${var.dns.domain}."
}

output "zone_id" {
  value = data.aws_route53_zone.domain.id
}

output "result" {
  value = <<RESULT
${path.module} = OK
RESULT
}
