variable "infrastructure" {
  default = {
    env = "staging"
    domain_prefix = "s."
#    waf = true
  }
}
