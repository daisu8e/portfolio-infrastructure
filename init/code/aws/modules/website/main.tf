variable "website" {}
variable "ssl" {}

output "result" {
  value = <<RESULT
${path.module} = {
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
