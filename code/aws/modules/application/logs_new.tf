resource "aws_s3_bucket" "logs_new" {
  bucket = "${var.application.domain}.logs.new"
  force_destroy = true
  lifecycle_rule {
    enabled = true
    expiration {
      days = "180"
    }
  }
}
