resource "aws_s3_bucket" "remote_tf_state" {
  bucket = var.bucket_name

  # Prevent accidental deletion of s3 bucket
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket   = aws_s3_bucket.remote_tf_state.id
  versioning_configuration {
    status = var.versioning_status
  }
}