variable "dns" {}

data "aws_route53_zone" "dns" {
  name = "${var.dns.domain}."
}

output "zone_id" {
  value = data.aws_route53_zone.dns.id
}

output "result" {
  value = <<RESULT
${path.module} = OK
RESULT
}
