
# Generate a random suffix for bucket name
resource "random_id" "this" {
  byte_length = 4
}

# Create S3 bucket
resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_name}-${random_id.this.hex}"

  # Optional: enable versioning
  # versioning {
  #   enabled = true
  # }

  tags = {
    Name = "${var.bucket_name}"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Configure bucket for static website hosting
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload index.html after bucket is created
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.this.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"

  # ensure the bucket exists before uploading
  depends_on = [aws_s3_bucket.this]
}
