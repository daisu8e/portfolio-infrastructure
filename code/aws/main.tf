variable "env" {}

locals {
  user = {
    prefix = var.env.name
  }
  parameter = {
    prefix = var.env.name
  }
  ssl = {
    domain = var.env.root_domain
  }
  application = {
    name = var.env.name
    domain = var.env.app_domain
  }
}

module "user" {
  source = "./modules/user"
  user = local.user
}

module "parameter" {
  source = "./modules/parameter"
  parameter = local.parameter
}

module "ssl" {
  source = "./modules/ssl"
  ssl = local.ssl
}

module "application" {
  source = "./modules/application"
  application = local.application
  ssl = module.ssl
  ip_white_list = module.parameter.ip_white_list
}

output "result" {
  value = join("\n", [
    module.user.result,
    module.parameter.result,
    module.ssl.result,
    module.application.result,
  ])
}
