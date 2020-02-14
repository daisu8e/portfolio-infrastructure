locals {
  infrastructure = {
    env = "production"
    domain_prefix = ""
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
