terraform {
  required_version = "= 0.12.18"
  backend "s3" {
    bucket = "portfolio.daisu8e.com.tfstates"
    key = "development/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "= 2.22.0"
  shared_credentials_file = "~/.aws/credentials"
  region = "us-east-1"
}

locals {
  infrastructure = {
    env = "development"
    domain_prefix = "d."
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
