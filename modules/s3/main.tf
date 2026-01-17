

resource "random_id" "this" {
  byte_length = 4
}

resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_name}-${random_id.this.hex}"

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.this.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
}
