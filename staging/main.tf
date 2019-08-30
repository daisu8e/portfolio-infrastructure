locals {
  infrastructure = {
    env = "staging"
    domain_prefix = "stg-"
  }
}

module "infrastructure" {
  source = "../infrastructure"
  infrastructure = local.infrastructure
}

output "result" {
  value = module.infrastructure.result
}
