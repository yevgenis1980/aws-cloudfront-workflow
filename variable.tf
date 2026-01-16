
variable "aws_region" {
default = "us-west-2"
}

variable "project_name" {
default = "static-site"
}

variable "vpc_cidr" {
  type = string
}

variable "bucket_name" {
  type = string
}
