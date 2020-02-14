terraform {
  required_version = "= 0.12.18"
  backend "s3" {
    bucket = "portfolio.daisu8e.com.tfstates"
    key = "testing/terraform.tfstate"
    region = "us-east-1"
  }
}
