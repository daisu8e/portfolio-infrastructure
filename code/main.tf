variable "env" {}

module "aws" {
  source = "./aws"
  env = var.env
}

output "result" {
  value = <<RESULT
${module.aws.result}
RESULT
}
