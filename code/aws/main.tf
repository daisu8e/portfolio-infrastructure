variable "env" {}

locals {
  resource_name = "portfolio-${var.env.name}"
  root_domain = "daisu8e.com"
  cdn_domain = "${var.env.domain_prefix}${local.root_domain}"

  dns = {
    domain = local.root_domain
  }
  ssl = {
    domain = local.root_domain
  }
  cdn = {
    domain = local.cdn_domain
  }
}

module "dns" {
  source = "./modules/dns"
  dns = local.dns
}

module "ssl" {
  source = "./modules/ssl"
  ssl = local.ssl
  dns = module.dns
}

module "cdn" {
  source = "./modules/cdn"
  cdn = local.cdn
  dns = module.dns
  ssl = module.ssl
}

output "result" {
  value = <<RESULT
{
  resource_name = ${local.resource_name}
  root_domain = ${local.root_domain}
  cdn_domain = ${local.cdn_domain}
}

${module.dns.result}
${module.ssl.result}
${module.cdn.result}
RESULT
/*
*/
}
