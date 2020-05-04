variable "route53_zone" {}

data "aws_route53_zone" "this" {
  name = "${var.route53_zone.domain}."
}

output "id" {
  value = data.aws_route53_zone.this.id
}

output "result" {
  value = <<RESULT
${path.module} = OK
RESULT
}
