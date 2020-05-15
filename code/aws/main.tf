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
  basic_authentication = {
    prefix = var.env.name
  }
  application = {
    domain = var.env.app_domain
    basic_authentication = var.env.basic_authentication
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

module "basic_authentication" {
  source = "./modules/basic_authentication"
  basic_authentication = local.basic_authentication
  parameter = module.parameter.basic_authentication
}

module "application" {
  source = "./modules/application"
  application = local.application
  ssl = module.ssl
  ip_white_list = module.parameter.ip_white_list
  basic_authentication = module.basic_authentication
}

output "result" {
  value = join("\n", [
    module.user.result,
    module.parameter.result,
    module.ssl.result,
    module.basic_authentication.result,
    module.application.result,
  ])
}
