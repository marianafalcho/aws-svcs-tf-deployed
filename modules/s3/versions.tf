terraform {
  required_version = ">= 0.13.1, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9.0, < 5.0.0"
    }
  }
}