terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

//create an ECR repository for frontend and backend

resource "aws_ecr_repository" "frontend-repo" {
  name = "frontend"

}

resource "aws_ecr_repository" "backend-repo" {
  name = "backend"

}

