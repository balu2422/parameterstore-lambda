resource "aws_sns_topic" "ssm_updates" {
  name = "ssm-updates-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.ssm_updates.arn
  protocol  = "email"
  endpoint  = "balureddy112211@gmail.com" # 
}

output "topic_arn" {
  value = aws_sns_topic.ssm_updates.arn
}
