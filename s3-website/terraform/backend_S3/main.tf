resource "aws_s3_bucket" "state_bucket" {
  bucket = var.bucket_name
}

resource "aws_dynamodb_table" "tfstate_lock" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-lock"
  }
}

resource "aws_iam_group" "state_access_group" {
  name = "state-access-group"
}

data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "state_access_policy" {
  name        = "state-access-policy"
  description = "Access policy for tfstate in a S3 bucket."

  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::state_bucket.bucket/*"
      },
      {
        Action   = ["dynamodb:PutItem", "dynamodb:UpdateItem"]
        Effect   = "Allow"
       Resource = join("", [
        "arn:aws:dynamodb:eu-north-1:${data.aws_caller_identity.current.account_id}:table/",
        aws_dynamodb_table.tfstate_lock.name
      ])
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "state_policy_attachment" {
  group      = aws_iam_group.state_access_group.name
  policy_arn = aws_iam_policy.state_access_policy.arn
}

resource "aws_iam_user_group_membership" "user_to_group" {
  user  = "lucas"
  groups = [aws_iam_group.state_access_group.name]
}

resource "null_resource" "save_resources_to_file" {
  depends_on = [
    aws_s3_bucket.state_bucket,
    aws_dynamodb_table.tfstate_lock
  ]

  provisioner "local-exec" {
    command = <<EOT
      echo "bucket = \"${aws_s3_bucket.state_bucket.bucket}\"" > ../backend.tfvars
      echo "dynamodb_table = \"${aws_dynamodb_table.tfstate_lock.name}\"" >> ../backend.tfvars
    EOT
  }
}