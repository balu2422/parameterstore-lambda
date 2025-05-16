resource "aws_kms_key" "ssm_key" {
  description             = "KMS key for SSM"
  enable_key_rotation    = true
}

output "kms_key_id" {
  value = aws_kms_key.ssm_key.id
}
