locals {
  infrastructure = {
    env = "testing"
    domain_prefix = "t."
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
