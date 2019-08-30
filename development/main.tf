locals {
  infrastructure = {
    env = "development"
    domain_prefix = "dev."
#    waf = true
  }
}

module "infrastructure" {
  source = "../infrastructure"
  infrastructure = local.infrastructure
}

output "result" {
  value = module.infrastructure.result
}
