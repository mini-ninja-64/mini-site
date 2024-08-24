terraform {
  required_version = "~> 1.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }

  backend "s3" {
    bucket         = var.iac_state_bucket
    key            = "state/terraform.tfstate"
    region         = var.aws_region
    profile        = var.aws_profile
    encrypt        = true
    kms_key_id     = "alias/iac-state-key"
    dynamodb_table = "iac-state"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_caller_identity" "this" {}
