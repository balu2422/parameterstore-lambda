variable "sns_topic_arn" {}
variable "lambda_name" {}

resource "aws_cloudwatch_event_rule" "ssm_change" {
  name        = "ssm-param-change-rule"
  description = "Trigger on SSM Parameter change"
  event_pattern = jsonencode({
    "source": ["aws.ssm"],
    "detail-type": ["Parameter Store Change"],
    "detail": {
      "name": ["/myapp/new_api_key"]
    }
  })
}

resource "aws_cloudwatch_event_target" "sns" {
  rule      = aws_cloudwatch_event_rule.ssm_change.name
  arn       = var.sns_topic_arn
}

resource "aws_lambda_permission" "allow_event" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ssm_change.arn
}
