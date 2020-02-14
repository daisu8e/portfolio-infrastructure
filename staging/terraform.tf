terraform {
  required_version = "= 0.12.18"
  backend "s3" {
    bucket = "tfstates.portfolio-infrastructure.daisu8e.net"
    key = "staging/terraform.tfstate"
    region = "us-west-2"
  }
}
