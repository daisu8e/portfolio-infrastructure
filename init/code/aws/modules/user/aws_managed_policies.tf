data "aws_iam_policy" "iam_full_access" {
  arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

data "aws_iam_policy" "iam_read_only_access" {
  arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

data "aws_iam_policy" "aws_certificate_manager_read_only" {
  arn = "arn:aws:iam::aws:policy/AWSCertificateManagerReadOnly"
}

data "aws_iam_policy" "amazon_ssm_read_only_access" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

data "aws_iam_policy" "amazon_s3_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "cloudfront_full_access" {
  arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}

