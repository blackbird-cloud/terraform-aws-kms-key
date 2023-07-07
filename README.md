[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://www.blackbird.cloud)

# AWS KMS CMK Terraform module
A Terraform module which helps you create AWS KMS Customer managed keys. Read [this](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html) page for more information, and for a secure reference architecture by AWS, read [this](https://docs.aws.amazon.com/prescriptive-guidance/latest/security-reference-architecture/welcome.html) page.

## Example
```hcl
data "aws_caller_identity" "current" {}

module "key" {
  source  = "blackbird-cloud/kms-key/aws"
  version = "~> 0"

  name = "my-cmk"

  policy = <<EOF
  
{
    "Version": "2012-10-17",
    "Id": "mykey-policy",
    "Statement": [
        {
            "Sid": "Allow source account access to KMS key in source account",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOF
  grants = [
    {
      name              = "My grant"
      grantee_principal = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/my-role"
      operations        = ["Encrypt", "Decrypt", "GenerateDataKey"]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_grant.grants](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_grant) | resource |
| [aws_kms_key.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_master_key_spec"></a> [customer\_master\_key\_spec](#input\_customer\_master\_key\_spec) | (Optional) Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC\_DEFAULT, RSA\_2048, RSA\_3072, RSA\_4096, HMAC\_256, ECC\_NIST\_P256, ECC\_NIST\_P384, ECC\_NIST\_P521, or ECC\_SECG\_P256K1. Defaults to SYMMETRIC\_DEFAULT. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_grants"></a> [grants](#input\_grants) | List of Gants to give. { name, grantee\_principal, operations } | `list(any)` | `[]` | no |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | (Optional) Indicates whether the KMS key is a multi-Region (true) or regional (false) key. Defaults to false. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the KMS key to create | `string` | n/a | yes |
| <a name="input_policy"></a> [policy](#input\_policy) | The fully-formed AWS policy as JSON for the KMS key | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alias"></a> [alias](#output\_alias) | KMS key alias |
| <a name="output_grants"></a> [grants](#output\_grants) | KMS key grants |
| <a name="output_kms"></a> [kms](#output\_kms) | KMS key |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://www.blackbird.cloud)
