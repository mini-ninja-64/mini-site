variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type = string
}

variable "iac_state_bucket" {
  type = string
}

variable "website_bucket" {
  type = string
}

variable "website_domain" {
  type    = string
  default = "minis.zone"
}

variable "cloudfront_origin_id" {
  type    = string
  default = "Website bucket"
}

variable "google_site_verification_id" {
  type = string
}
