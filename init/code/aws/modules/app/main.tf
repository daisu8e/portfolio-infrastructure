variable "app" {}

resource "aws_s3_bucket" "this" {
  bucket = "${var.app.domain}.terraform"
  force_destroy = true
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls = true
  ignore_public_acls = true
  block_public_policy = true
  restrict_public_buckets = true
}

output "result" {
  value = <<RESULT
${path.module} = {
  bucket = ${aws_s3_bucket.this.id}
}
RESULT
}
