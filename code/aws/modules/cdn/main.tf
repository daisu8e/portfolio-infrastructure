variable "cdn" {}
variable "dns" {}
variable "ssl" {}

locals {
  files = [
    "index.html",
    "404.html"
  ]
}

resource "aws_s3_bucket" "cdn" {
  bucket = var.cdn.domain
  force_destroy = true
  acl = "public-read"
  website {
    index_document = "index.html"
    error_document = "404.html"
  }
}

data "aws_iam_policy_document" "cdn" {
  statement {
    sid = "PublicRead"
    effect = "Allow"
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.cdn.id}/*"]
  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.cdn.id
  policy = data.aws_iam_policy_document.cdn.json
}

resource "aws_s3_bucket_object" "default_files" {
  count = length(local.files)
  bucket = aws_s3_bucket.cdn.bucket
  key = local.files[count.index]
  source = "${path.module}/files/${local.files[count.index]}"
  etag = filemd5("${path.module}/files/${local.files[count.index]}")
  acl = "public-read"
  content_type = "text/html"
  cache_control = "max-age=60"
  lifecycle {
    ignore_changes = [source, etag, content_type, cache_control, version_id]
  }
}

resource "aws_cloudfront_distribution" "cdn" {
  enabled = true
  aliases = [var.cdn.domain]
  viewer_certificate {
    acm_certificate_arn = var.ssl.certificate_arn
    ssl_support_method = "sni-only"
  }
  origin {
    origin_id = var.cdn.domain
    domain_name = aws_s3_bucket.cdn.bucket_domain_name
  }
  default_root_object = "index.html"
  custom_error_response {
    error_code = "404"
    response_code = "404"
    response_page_path = "/404.html"
    error_caching_min_ttl = 300
  }
  default_cache_behavior {
    target_origin_id = var.cdn.domain
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    min_ttl = 0
    default_ttl = 86400
    max_ttl = 31536000
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  is_ipv6_enabled = true
  logging_config {
    bucket = aws_s3_bucket.logs.bucket_domain_name
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "${var.cdn.domain}.logs"
  force_destroy = true
  lifecycle_rule {
    enabled = true
    expiration {
      days = "180"
    }
  }
}

resource "aws_route53_record" "cdn" {
  zone_id = var.dns.zone_id
  name = var.cdn.domain
  type = "A"
  alias {
    zone_id = aws_cloudfront_distribution.cdn.hosted_zone_id
    name = aws_cloudfront_distribution.cdn.domain_name
    evaluate_target_health = false
  }
}

output "result" {
  value = <<RESULT
${path.module} = OK
RESULT
}
