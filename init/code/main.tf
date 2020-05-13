variable "env" {}

module "aws" {
  source = "./aws"
  env = var.env
}

output "result" {
  value = join("\n", [
    module.aws.result,
  ])
}
