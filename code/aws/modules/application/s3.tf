locals {
  files = ["index.html"]
}

resource "aws_s3_bucket" "this" {
  bucket = var.application.domain
  force_destroy = true
}

resource "aws_s3_bucket_object" "this" {
  count = length(local.files)
  bucket = aws_s3_bucket.this.id
  key = local.files[count.index]
  source = "${path.module}/files/${local.files[count.index]}"
  etag = filemd5("${path.module}/files/${local.files[count.index]}")
  content_type = "text/html"
  cache_control = "max-age=60"
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]
    principals {
      type = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.this.arn}/*"]
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
    condition {
      test = "IpAddress"
      variable = "aws:SourceIp"
      values = [for it in var.ip_white_list : "${it}/32" ]
    }
  }
}
