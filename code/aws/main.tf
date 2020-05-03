variable "env" {}

locals {
  dns = {
    domain = var.env.root_domain
  }
  ssl = {
    domain = var.env.root_domain
  }
  cdn = {
    domain = var.env.app_domain
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
aws = {
  dns = {
    domain = ${var.env.root_domain}
  }
  ssl = {
    domain = ${var.env.root_domain}
  }
  cdn = {
    domain = ${var.env.app_domain}
  }
}

${module.dns.result}
${module.ssl.result}
${module.cdn.result}
RESULT
}
