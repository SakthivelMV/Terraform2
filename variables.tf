variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "flask_port" {
  description = "Port for Flask backend"
  type        = number
  default     = 5000
}

variable "express_port" {
  description = "Port for Express frontend"
  type        = number
  default     = 3000
}

variable "ssh_port" {
  description = "Port for SSH access"
  type        = number
  default     = 22
}

variable "ami_id" {
  description = "AMI ID for Ubuntu 22.04 in ap-south-1"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "part1"
}

variable "public_key_path" {
  description = "Path to your public SSH key"
  type        = string
  default     = "~/.ssh/part1.pub"
}

# variable "key_name" {
#   description = "part1"
# }