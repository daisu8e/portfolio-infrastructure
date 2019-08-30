terraform {
  required_version = "= 0.12.5"
  backend "s3" {
    bucket = "tfstates.portfolio-infrastructure.daisu8e.net"
    key = "development/terraform.tfstate"
    region = "us-west-2"
  }
}
