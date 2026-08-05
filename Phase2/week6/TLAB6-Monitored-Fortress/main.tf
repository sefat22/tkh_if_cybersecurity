provider "aws" {
  region = "us-east-1"
}

# Automatically finds the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical ID
}

# ====================================================================
# 1. THE PERIMETER (VPC, Subnet, Gateway, Route Table)
# ====================================================================

# The main network fence
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "titan-vpc"
  }
}

# The street inside your network
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "titan-public-subnet"
  }
}

# The main gate to the internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "titan-igw"
  }
}

# Road sign pointing outward to the gate
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "titan-public-rt"
  }
}

# Attach road sign to public subnet street
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ====================================================================
# 2. THE WIRETAP (CloudWatch Log Group & VPC Flow Log)
# ====================================================================

# Security recording tape storage (1 day retention)
resource "aws_cloudwatch_log_group" "vpc_logs" {
  name              = "/tkh/titan-prod-vpc-logs"
  retention_in_days = 1
}

# Security camera logging ALL network traffic
resource "aws_flow_log" "main" {
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_logs.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}

# ====================================================================
# 3. THE ZERO TRUST COMPUTE (Security Group & EC2 Instance)
# ====================================================================

# Security group with ZERO open incoming ports and all outgoing allowed
resource "aws_security_group" "zero_trust" {
  name        = "titan-zero-trust-sg"
  description = "No inbound doors open, all outbound allowed"
  vpc_id      = aws_vpc.main.id

  # ZERO ingress blocks defined here!

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "titan-zero-trust-sg"
  }
}

# The EC2 vault instance with SSM VIP access attached
resource "aws_instance" "fortress" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.zero_trust.id]
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  tags = {
    Name = "titan-fortress-ec2"
  }
}
