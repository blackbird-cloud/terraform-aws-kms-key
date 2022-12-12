output "kms" {
  value       = aws_kms_key.kms
  description = "KMS key"
}

output "alias" {
  value       = aws_kms_alias.alias
  description = "KMS key alias"
}

output "grants" {
  value       = aws_kms_grant.grants
  description = "KMS key grants"
}
