locals {
  infrastructure = {
    env = "staging"
    domain_prefix = "s."
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
