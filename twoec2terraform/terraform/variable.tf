variable "aws_region" {
  description = "The AWS region to deploy resources in"
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

variable "key_name" {
  description = "Name of the SSH key pair to use for the EC2 instance"
  type        = string
  default     = "terraform-keypair"
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
}

variable "mongo_uri" {
  description = "MongoDB URI for the backend server"
  type        = string
}
