terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-2025"
    key = "${var.environment}/${var.region}/terraform.tfstate"
    region = var.region
    dynamodb_table = "terraform-state-locks"
    encrypt = true
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
  }
}