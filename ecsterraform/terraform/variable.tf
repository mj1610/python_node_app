variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "backend_image" {
  description = "ECR image URI for Flask backend"
  type        = string
}

variable "frontend_image" {
  description = "ECR image URI for Express frontend"
  type        = string
}

variable "mongo_uri" {
  description = "MongoDB URI for Flask backend"
  type        = string
}
