variable "env" {}

locals {
  terraform_backend = {
    app_domain = var.env.app_domain
  }
  user = {
    prefix = var.env.name
  }
  parameter = {
    prefix = var.env.name
  }
  ssl = {
    domain = var.env.root_domain
    tag = var.env.name
  }
  website = {
    domain = var.env.init_domain
  }
}

module "terraform_backend" {
  source = "./modules/terraform_backend"
  terraform_backend = local.terraform_backend
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

module "website" {
  source = "./modules/website"
  website = local.website
  ssl = module.ssl
}

output "result" {
  value = join("\n", [
    module.terraform_backend.result,
    module.user.result,
    module.parameter.result,
    module.ssl.result,
    module.website.result,
  ])
}
