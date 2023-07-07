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
