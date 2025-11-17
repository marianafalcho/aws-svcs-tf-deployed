variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment for which resources will be deployed."
  type        = string
}

variable "region" {
  description = "The name of the project."
  type        = string
  default     = "us-east-1"
}

variable "subnets" {
  description = "List of at least two subnets in which resources are placed."
  type        = list(string)
  default     = []
}

variable "security_group_id"{

}

variable "s3_bucket" {

 }
