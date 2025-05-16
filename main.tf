provider "aws" {
  region = "us-east-1"
}

# KMS Key
module "kms" {
  source = "./modules/kms"
}

# IAM Role
module "iam" {
  source = "./modules/iam"
}

# SSM Parameter (use a different name)
module "ssm" {
  source         = "./modules/ssm"
  kms_key_id     = module.kms.kms_key_id
  parameter_name = "/myapp/new_api_key"
}

# SNS Topic
module "sns" {
  source = "./modules/sns"
}

# Lambda Function
module "lambda" {
  source         = "./modules/lambda"
  role_arn       = module.iam.lambda_role_arn
  kms_key_id     = module.kms.kms_key_id
  parameter_name = module.ssm.parameter_name
}

# EventBridge Rule
module "eventbridge" {
  source         = "./modules/eventbridge"
  sns_topic_arn  = module.sns.topic_arn
  lambda_name    = module.lambda.lambda_function_name
}

output "ssm_parameter_name" {
  value = module.ssm.parameter_name
}

output "sns_topic_arn" {
  value = module.sns.topic_arn
}
