variable "create_or_modify_bucket" {
  description = "Controls if S3 bucket should be created or modified"
  type        = bool
  default     = true
}

variable "account_id" {
  description = "Account ID where the bucket will be created"
  type        = string
}

variable "attach_tls_policy" {
  description = "Controls if S3 bucket should have ALB/NLB log delivery policy attached"
  type        = bool
  default     = false
}

variable "attach_deny_insecure_transport_policy" {
  description = "Controls if S3 bucket should have deny non-SSL transport policy attached"
  type        = bool
  default     = false
}

variable "attach_policy" {
  description = "Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy)"
  type        = bool
  default     = false
}

variable "attach_global_policy" {
  description = "Controls if S3 bucket should have global policy attached"
  type        = bool
  default     = false
}

variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}

variable "suffix" {
  description = "Where suffix will represent a resource, service or an application."
  type        = string
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}

variable "aws_accounts"{
description = "List of AWS accounts that will use the S3 policy"
type = list
default = []
}
