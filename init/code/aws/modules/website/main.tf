variable "website" {}
variable "ssl" {}

output "result" {
  value = <<RESULT
${path.module} = {
  bucket = ${aws_s3_bucket.this.id}
  cloudfront = {
    hosted_zone_id = ${aws_cloudfront_distribution.this.hosted_zone_id}
    domain_name = ${aws_cloudfront_distribution.this.domain_name}
  }
}
RESULT
}
