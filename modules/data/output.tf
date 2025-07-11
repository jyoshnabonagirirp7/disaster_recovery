output "source_bucket" {
  value = aws_s3_bucket.source.id
}

output "destination_bucket" {
  value = aws_s3_bucket.destination.id
}