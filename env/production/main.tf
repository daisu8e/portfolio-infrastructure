locals {
  env = {
    name = "portfolio-production"
    root_domain = "daisu8e.com"
    app_domain = "daisu8e.com"
    init_domain = "p-init.daisu8e.com"
    basic_authentication = false
  }
}

terraform {
  required_version = "= 0.12.18"
  backend "s3" {
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile = "portfolio-production-infrastructure-circleci"
    bucket = "daisu8e.com.terraform"
    key = "terraform.tfstate"
  }
}

provider "aws" {
  version = "= 2.22.0"
  region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile = "portfolio-production-infrastructure-circleci"
}

module "code" {
  source = "../../code"
  env = local.env
}

output "result" {
  value = "\n\n${module.code.result}"
}
