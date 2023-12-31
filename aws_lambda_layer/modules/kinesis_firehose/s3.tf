resource "aws_s3_bucket" "this" {
  bucket        = "${var.service}-app-access-log-${data.aws_caller_identity.self.account_id}"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
