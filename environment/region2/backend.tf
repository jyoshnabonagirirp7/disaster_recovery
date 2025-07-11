terraform {
  backend "s3" {
    bucket = "s3-backend-disaster-recoveryproj987"
    key    = "region2/terraform.tfstate"
    region = "us-east-1"  # Region where bucket is created
  }
}