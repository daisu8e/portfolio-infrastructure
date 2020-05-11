resource "aws_cloudfront_distribution" "this" {
  enabled = true
  aliases = [var.application.domain]
  viewer_certificate {
    acm_certificate_arn = var.ssl.acm_certificate_arn
    ssl_support_method = "sni-only"
  }
  origin {
    origin_id = aws_s3_bucket.this.id
    domain_name = aws_s3_bucket.this.bucket_domain_name
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }
  default_root_object = "index.html"
  custom_error_response {
    error_code = "403"
    response_code = "404"
    response_page_path = "/index.html"
    error_caching_min_ttl = 300
  }
  default_cache_behavior {
    target_origin_id = aws_s3_bucket.this.id
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

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = var.application.name
}
