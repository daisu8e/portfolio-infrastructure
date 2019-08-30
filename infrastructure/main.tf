variable "infrastructure" {}

locals {
  self = var.infrastructure

  resource_name = "portfolio-${local.self.env}"
  root_domain = "daisu8e.net"
  cdn_domain = "${local.self.domain_prefix}${local.root_domain}"

  dns = {
    domain = local.root_domain
  }
  ssl = {
    name = local.resource_name
    domain = local.root_domain
  }
  waf = {
    name = local.resource_name
  }
  cdn = {
    domain = local.cdn_domain
#    waf = local.self waf
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

#module "waf" {
#  source = "./modules/waf"
#  waf = local.waf
#}

module "cdn" {
  source = "./modules/cdn"
  cdn = local.cdn
  dns = module.dns
  ssl = module.ssl
#  waf = module.waf
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
${module.waf.result}
*/
}
