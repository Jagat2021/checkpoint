terraform {
  required_providers {
    name = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
  # Remote state storage
  backend "s3" {
    bucket = "checkpoint-bucket-jagat-2"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}


