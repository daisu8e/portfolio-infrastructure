variable "env" {}

locals {
  iam = {
    env = var.env.name
  }
}

module "iam" {
  source = "./modules/iam"
  iam = local.iam
}

output "result" {
  value = <<RESULT
aws = {
  iam = {
    env = ${local.iam.env}
  }
}

${module.iam.result}
RESULT
}
