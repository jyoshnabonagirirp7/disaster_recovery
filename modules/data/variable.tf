variable "source_bucket_name" {
  type = string
}

variable "destination_bucket_name" {
  type = string
}

variable "replication_role_name" {
  type    = string
  default = "s3-replication-role"
}

variable "replication_policy_name" {
  type    = string
  default = "s3-replication-policy"
}
