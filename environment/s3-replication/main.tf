module "s3_replication" {
  source = "../../modules/data"

  providers = {
    aws.source      = aws.source
    aws.destination = aws.destination
  }

  source_bucket_name      = var.source_bucket_name
  destination_bucket_name = var.destination_bucket_name
  replication_role_name   = var.replication_role_name
  replication_policy_name = var.replication_policy_name
}
