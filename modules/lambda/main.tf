variable "role_arn" {}
variable "kms_key_id" {}
variable "parameter_name" {}

resource "aws_lambda_function" "read_ssm" {
  filename         = "${path.module}/lambda.zip"
  function_name    = "readSSMParameter"
  role             = var.role_arn
  handler          = "lambda_function.lambda_handler"  # Python handler
  runtime          = "python3.10"                      # or use python3.11

  environment {
    variables = {
      PARAM_NAME = var.parameter_name
    }
  }
}

output "lambda_function_name" {
  value = aws_lambda_function.read_ssm.function_name
}
