terraform {
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
