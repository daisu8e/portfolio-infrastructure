locals {
  files = ["index.html"]
}

resource "aws_s3_bucket" "new" {
  bucket = "${var.application.domain}.new"
  force_destroy = true
}

resource "aws_s3_bucket_object" "new" {
  count = length(local.files)
  bucket = aws_s3_bucket.new.id
  key = local.files[count.index]
  source = "${path.module}/files/${local.files[count.index]}"
  etag = filemd5("${path.module}/files/${local.files[count.index]}")
  content_type = "text/html"
  cache_control = "max-age=60"
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_s3_bucket_policy" "new" {
  bucket = aws_s3_bucket.new.id
  policy = data.aws_iam_policy_document.new.json
}

data "aws_iam_policy_document" "new" {
  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.new.arn}/*"]
    principals {
      type = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.this.iam_arn]
    }
  }
  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.new.arn}/*"]
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
