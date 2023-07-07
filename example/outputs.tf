output "kms" {
  value       = module.key.kms
  description = "KMS key"
}

output "alias" {
  value       = module.key.alias
  description = "KMS key alias"
}

output "grants" {
  value       = module.key.grants
  description = "KMS key grants"
}
