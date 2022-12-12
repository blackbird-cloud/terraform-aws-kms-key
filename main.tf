resource "aws_kms_key" "kms" {
  description              = "KMS Key for ${var.name}"
  deletion_window_in_days  = 10
  policy                   = var.policy
  enable_key_rotation      = true
  customer_master_key_spec = var.customer_master_key_spec
  multi_region             = var.multi_region
  tags                     = var.tags
}

resource "aws_kms_alias" "alias" {
  target_key_id = aws_kms_key.kms.id
  name_prefix   = "alias/${var.name}"
}

resource "aws_kms_grant" "grants" {
  for_each = {
    for grant in var.grants : grant.name => grant
  }
  name   = each.key
  key_id = aws_kms_key.kms.key_id

  grantee_principal = each.value.grantee_principal
  operations        = each.value.operations
}
