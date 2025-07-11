resource "aws_s3_bucket" "source" {
  provider = aws.source
  bucket   = var.source_bucket_name

  versioning {
    enabled = true
  }

  replication_configuration {
    role = aws_iam_role.replication_role.arn

    rules {
      id     = "crr-rule"
      status = "Enabled"
      filter { prefix = "" }
      destination {
        bucket        = aws_s3_bucket.destination.arn
      }
    }
  }

  depends_on = [aws_s3_bucket.destination]
}

resource "aws_s3_bucket" "destination" {
  provider = aws.destination
  bucket   = var.destination_bucket_name

  versioning {
    enabled = true
  }
}

resource "aws_iam_role" "replication_role" {
  name = var.replication_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "s3.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "replication_policy" {
  name = var.replication_policy_name
  role = aws_iam_role.replication_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetReplicationConfiguration", "s3:ListBucket"],
        Resource = [aws_s3_bucket.source.arn]
      },
      {
        Effect   = "Allow",
        Action   = ["s3:GetObjectVersion", "s3:GetObjectVersionAcl", "s3:GetObjectVersionTagging"],
        Resource = ["${aws_s3_bucket.source.arn}/*"]
      },
      {
        Effect   = "Allow",
        Action   = ["s3:ReplicateObject", "s3:ReplicateDelete", "s3:ReplicateTags"],
        Resource = ["${aws_s3_bucket.destination.arn}/*"]
      }
    ]
  })
}
