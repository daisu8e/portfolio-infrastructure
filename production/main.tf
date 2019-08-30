locals {
  infrastructure = {
    env = "production"
    domain_prefix = ""
  }
}

module "infrastructure" {
  source = "../infrastructure"
  infrastructure = local.infrastructure
}

output "result" {
  value = module.infrastructure.result
}
