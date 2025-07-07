terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # access_key = var.access_key
  # secret_key = var.secret_key
}

# resource "aws_s3_bucket" "tutedude_bucket" {
#   bucket = "s3-bucket-tutedude"
#   tags = {
#     Name        = "MyBucket"
#     Environment = "Dev"
#   }
# }

# resource "aws_ssm_parameter" "mongo_uri" {
#   name  = "/app/mongo_uri"
#   type  = "SecureString"
#   value = var.mongo_uri
# }

resource "aws_instance" "python_node_app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_traffic.id]
  user_data              = templatefile("${path.module}/user_data.sh.tpl", {})
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm_profile.name
  tags = {
    Name        = "FullStackApp"
    Environment = "Dev"
  }
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2_ssm_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "ec2_ssm_profile"
  role = aws_iam_role.ec2_ssm_role.name
}


resource "aws_security_group" "allow_traffic" {
  name        = "fullstack_sg"
  description = "Allow ports for Flask, Express, SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
