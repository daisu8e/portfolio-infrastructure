variable "env" {}

locals {
  route53_zone = {
    domain = var.env.root_domain
  }
  acm = {
    domain = var.env.root_domain
  }
  cdn = {
    domain = var.env.app_domain
  }
}

module "route53_zone" {
  source = "./modules/route53_zone"
  route53_zone = local.route53_zone
}

module "acm" {
  source = "./modules/acm"
  acm = local.acm
}

module "cdn" {
  source = "./modules/cdn"
  cdn = local.cdn
  route53_zone = module.route53_zone
  acm = module.acm
}

output "result" {
  value = <<RESULT
aws = {
  route53_zone = {
    domain = ${var.env.root_domain}
  }
  acm = {
    domain = ${var.env.root_domain}
  }
  cdn = {
    domain = ${var.env.app_domain}
  }
}

${module.route53_zone.result}
${module.acm.result}
${module.cdn.result}
RESULT
}
