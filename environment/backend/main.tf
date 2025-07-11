resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "s3-backend-disaster-recoveryproj987" 

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "DisasterRecovery"
  }
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
