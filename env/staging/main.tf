locals {
  env = {
    name = "portfolio-staging"
    root_domain = "daisu8e.com"
    app_domain = "s.daisu8e.com"
  }
}

terraform {
  required_version = "= 0.12.18"
  backend "s3" {
    bucket = "s.daisu8e.com.terraform.old"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  version = "= 2.22.0"
  shared_credentials_file = "~/.aws/credentials"
  region = "us-east-1"
}

module "code" {
  source = "../../code"
  env = local.env
}

output "result" {
  value = <<RESULT
the following:

${module.code.result}
RESULT
}
