locals {
  policies = [
    data.aws_iam_policy.amazon_s3_full_access,
    data.aws_iam_policy.cloudfront_full_access,
  ]
}

resource "aws_iam_user" "application_circleci" {
  name = "${var.user.prefix}-application-circleci"
  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "application_circleci" {
  count = length(local.policies)
  user = aws_iam_user.application_circleci.name
  policy_arn = local.policies[count.index].arn
}
