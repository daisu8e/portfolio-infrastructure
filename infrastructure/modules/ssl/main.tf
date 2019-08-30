variable "ssl" {}
variable "dns" {}

provider "aws" {
  alias = "us-east-1"
  region  = "us-east-1"
}

data "aws_acm_certificate" "ssl" {
  provider = aws.us-east-1
  domain = var.ssl.domain
}

output "certificate_arn" {
  value = data.aws_acm_certificate.ssl.arn
}

output "result" {
  value = <<RESULT
${path.module} = OK
RESULT
}
