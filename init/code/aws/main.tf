variable "env" {}

locals {
  circleci = {
    user = var.env.infrastructure_user
  }
  ssl = {
    name = var.env.name
    domain = var.env.root_domain
  }
  website = {
    name = var.env.name
    domain = var.env.init_domain
  }
  app = {
    domain = var.env.app_domain
  }
}

module "circleci" {
  source = "./modules/circleci"
  circleci = local.circleci
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

module "app" {
  source = "./modules/app"
  app = local.app
}

output "result" {
  value = join("\n", [
    module.circleci.result,
    module.ssl.result,
    module.website.result,
    module.app.result,
  ])
}
