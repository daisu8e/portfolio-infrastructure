variable "application" {}
variable "ssl" {}
variable "ip_white_list" {}
variable "basic_authentication" {}

output "result" {
  value = <<RESULT
${path.module} = {
  basic_authentication = ${var.application.basic_authentication}
  s3 = {
    bucket = ${aws_s3_bucket.this.id}
  }
  cloudfront = {
    distribution = ${aws_cloudfront_distribution.this.id}
    domain_name = ${aws_cloudfront_distribution.this.domain_name}
  }
}
RESULT
}
