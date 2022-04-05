terraform {
  required_providers {
    name = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}
