locals {
  policies = [
    data.aws_iam_policy.iam_full_access,
    data.aws_iam_policy.amazon_ssm_read_only_access,
    data.aws_iam_policy.aws_certificate_manager_read_only,
    data.aws_iam_policy.aws_lambda_full_access,
    data.aws_iam_policy.amazon_s3_full_access,
    data.aws_iam_policy.cloudfront_full_access,
  ]
}

resource "aws_iam_user" "infrastructure_circleci" {
  name = "${var.user.prefix}-infrastructure-circleci"
  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "infrastructure_circleci" {
  count = length(local.policies)
  user = aws_iam_user.infrastructure_circleci.name
  policy_arn = local.policies[count.index].arn
}
