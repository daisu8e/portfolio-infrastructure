variable "application" {}
variable "ssl" {}
variable "ip_white_list" {}

output "result" {
  value = <<RESULT
${path.module} = {
  s3 = {
    bucket = ${aws_s3_bucket.new.id}
  }
  cloudfront = {
    distribution = ${aws_cloudfront_distribution.this.id}
    hosted_zone_id = ${aws_cloudfront_distribution.this.hosted_zone_id}
    domain_name = ${aws_cloudfront_distribution.this.domain_name}
  }
}
RESULT
}
