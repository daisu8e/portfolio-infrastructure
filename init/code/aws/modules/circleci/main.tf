variable "circleci" {}

resource "aws_iam_user" "this" {
  name = var.circleci.user
}

resource "aws_iam_user_policy" "this" {
  user = aws_iam_user.this.name
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "cloudfront:*",
    ]
    resources = ["*"]
  }
}

output "result" {
  value = <<RESULT
${path.module} = {
  user = ${aws_iam_user.this.name}
}
RESULT
}
