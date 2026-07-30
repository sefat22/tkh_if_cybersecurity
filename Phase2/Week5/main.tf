
provider "aws" {
  region = "us-east-1"
}

# --- Step 2: AWS Budget ($10 Limit, Alert at 80%) ---
resource "aws_budgets_budget" "cost_control" {
  name              = "titan-monthly-budget"
  budget_type       = "COST"
  limit_amount      = "10.0"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["sefate1599@gmail.com"]
  }
}

# Helper: Random ID for unique bucket naming
resource "random_id" "bucket_id" {
  byte_length = 4
}

# --- Step 3: Dynamic & Private S3 Vault ---
resource "aws_s3_bucket" "titan_vault" {
  bucket        = "titan-fintech-vault-sef-${random_id.bucket_id.hex}"
  force_destroy = true
}

# --- Step 4: IAM Role & Least Privilege Policy (s3:PutObject only) ---
resource "aws_iam_role" "titan_ec2_role" {
  name = "Titan-EC2-Vault-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "s3_put_only" {
  name        = "Titan-S3-PutObject-Policy"
  description = "Allows only s3:PutObject to the Titan vault bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.titan_vault.arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "titan_attach" {
  role       = aws_iam_role.titan_ec2_role.name
  policy_arn = aws_iam_policy.s3_put_only.arn
}

resource "aws_iam_instance_profile" "titan_profile" {
  name = "Titan-EC2-Vault-Profile"
  role = aws_iam_role.titan_ec2_role.name
}

# --- Step 5: Ubuntu EC2 Instance wearing the IAM Role ---
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "titan_worker" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.titan_profile.name

  tags = {
    Name = "Titan-FinTech-Worker"
  }
}
