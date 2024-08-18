variable "aws_region" {
  type = string
  default = "eu-west-2"
}

variable "aws_profile" {
  type = string
}

variable "iac_state_bucket" {
  type = string
}

variable "website_state_bucket" {
  type = string
}
