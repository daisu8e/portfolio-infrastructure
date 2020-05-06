locals {
  env = {
    name = "portfolio-staging"
  }
}

terraform {
  required_version = "= 0.12.18"
  backend "s3" {
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile = "portfolio-staging"
    bucket = "portfolio-staging.daisu8e.com.terraform"
    key = "init/terraform.tfstate"
  }
}

provider "aws" {
  version = "= 2.22.0"
  region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile = "portfolio-staging"
}

module "code" {
  source = "../../code"
  env = local.env
}

output "code" {
  value = <<RESULT
the following:

${module.code.result}
RESULT
}
