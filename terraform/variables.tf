variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu 20.04 AMI"
  default     = "ami-0c7217cdde317cfec"
}

variable "key_name" {
  description = "Your existing AWS key pair name"
  type        = string
}
