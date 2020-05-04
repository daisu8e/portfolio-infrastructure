variable "env" {}

locals {
  route53_zone = {
    domain = var.env.root_domain
  }
  ssl = {
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

module "ssl" {
  source = "./modules/ssl"
  ssl = local.ssl
}

module "cdn" {
  source = "./modules/cdn"
  cdn = local.cdn
  route53_zone = module.route53_zone
  ssl = module.ssl
}

output "result" {
  value = <<RESULT
aws = {
  route53_zone = {
    domain = ${var.env.root_domain}
  }
  ssl = {
    domain = ${var.env.root_domain}
  }
  cdn = {
    domain = ${var.env.app_domain}
  }
}

${module.route53_zone.result}
${module.ssl.result}
${module.cdn.result}
RESULT
}
