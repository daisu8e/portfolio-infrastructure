locals {
  files = [
    "index.js.tmpl",
    "function.zip",
  ]
  index_js_tmpl = "${path.module}/files/${local.files[0]}"
  function_zip = "${path.module}/files/${local.files[1]}"
}

data "archive_file" "this" {
  type = "zip"
  source {
    filename = "index.js"
    content = templatefile(local.index_js_tmpl, {
      username = var.parameter.username
      password = var.parameter.password
    })
  }
  output_path = local.function_zip
}

resource "aws_lambda_function" "this" {
  function_name = "${var.basic_authentication.prefix}-basic-authentication"
  role = aws_iam_role.this.arn
  publish  = true
  runtime = "nodejs10.x"
  handler = "index.handler"
  filename = local.function_zip
  source_code_hash = data.archive_file.this.output_base64sha256
}
