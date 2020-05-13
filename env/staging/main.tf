locals {
  env = {
    name = "portfolio-staging"
    root_domain = "daisu8e.com"
    app_domain = "s.daisu8e.com"
    init_domain = "s-init.daisu8e.com"
  }
}

terraform {
  required_version = "= 0.12.18"
  backend "s3" {
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile = "portfolio-staging-infrastructure-circleci"
    bucket = "s.daisu8e.com.terraform"
    key = "terraform.tfstate"
  }
}

provider "aws" {
  version = "= 2.22.0"
  region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile = "portfolio-staging-infrastructure-circleci"
}

module "code" {
  source = "../../code"
  env = local.env
}

output "result" {
  value = "\n\n${module.code.result}"
}
