resource "aws_s3_bucket" "logs" {
  bucket = "${var.application.domain}.logs"
  force_destroy = true
  lifecycle_rule {
    enabled = true
    expiration {
      days = "180"
    }
  }
}
