variable "role_arn" {}
variable "kms_key_id" {}
variable "parameter_name" {}

resource "aws_lambda_function" "read_ssm" {
  filename         = "${path.module}/lambda.zip"
  function_name    = "readSSMParameter"
  role             = var.role_arn
  handler          = "index.handler"
  runtime          = "nodejs18.x"

  environment {
    variables = {
      PARAM_NAME = var.parameter_name
    }
  }
}

output "lambda_function_name" {
  value = aws_lambda_function.read_ssm.function_name
}
