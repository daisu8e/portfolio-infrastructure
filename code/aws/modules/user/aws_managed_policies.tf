data "aws_iam_policy" "amazon_s3_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "cloudfront_full_access" {
  arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}

