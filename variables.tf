variable "name" {
  description = "The name of the KMS key to create"
  type        = string
}

variable "policy" {
  description = "The fully-formed AWS policy as JSON for the KMS key"
  type        = string
  default     = null
}

variable "grants" {
  description = "List of Gants to give. { name, grantee_principal, operations }"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "customer_master_key_spec" {
  type        = string
  description = "(Optional) Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1. Defaults to SYMMETRIC_DEFAULT."
  default     = "SYMMETRIC_DEFAULT"
}

variable "multi_region" {
  description = "(Optional) Indicates whether the KMS key is a multi-Region (true) or regional (false) key. Defaults to false."
  type        = bool
  default     = false
}
