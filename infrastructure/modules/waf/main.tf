variable "waf" {}

locals {
  metric_name = replace(title(replace(var.waf.name, "-", " ")), " ", "")
}

resource "aws_waf_ipset" "waf" {
  name = var.waf.name
  # CICCC 3rd floor
  ip_set_descriptors {
    type = "IPV4"
    value = "24.80.197.72/32"
  }
  # CICCC 4th floor
  ip_set_descriptors {
    type = "IPV4"
    value = "50.64.108.229/32"
  }
}

resource "aws_waf_rule" "waf" {
  depends_on = [aws_waf_ipset.ipset]
  name = var.waf.name
  metric_name = local.metric_name
  predicates {
    type = "IPMatch"
    data_id = aws_waf_ipset.waf.id
    negated = false
  }
}

resource "aws_waf_web_acl" "waf" {
  depends_on = [aws_waf_rule.waf, aws_waf_ipset.ipset]
  name = var.waf.name
  metric_name = local.metric_name
  default_action {
    type = "BLOCK"
  }
  rules {
    type = "REGULAR"
    action {
      type = "ALLOW"
    }
    rule_id = aws_waf_rule.waf.id
    priority = 1
  }
}

output "web_acl_id" {
  value = aws_waf_web_acl.waf.id
}

output "result" {
  value = <<RESULT
${path.module} = OK
RESULT
}
