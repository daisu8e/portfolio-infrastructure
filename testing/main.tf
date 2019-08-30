locals {
  infrastructure = {
    env = "testing"
    domain_prefix = "tst-"
  }
}

module "infrastructure" {
  source = "../infrastructure"
  infrastructure = local.infrastructure
}

output "result" {
  value = module.infrastructure.result
}
