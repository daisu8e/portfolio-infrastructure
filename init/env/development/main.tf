locals {
  env = {
    name = "portfolio-development"
  }
}

terraform {
  required_version = "= 0.12.18"
  backend "s3" {
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"
    profile = "portfolio-development"
    bucket = "portfolio-development.daisu8e.com.terraform"
    key = "init/terraform.tfstate"
  }
}

provider "aws" {
  version = "= 2.22.0"
  region = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
  profile = "portfolio-development"
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
