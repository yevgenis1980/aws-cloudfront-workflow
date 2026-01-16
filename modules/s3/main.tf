
resource "random_id" "this" {
byte_length = 4
}

resource "aws_s3_bucket" "this" {
bucket = "${var.bucket_name}-${random_id.this.hex}"
}


resource "aws_s3_bucket_public_access_block" "this" {
bucket = aws_s3_bucket.this.id

block_public_acls = true
block_public_policy = true
ignore_public_acls = true
restrict_public_buckets = true
}


resource "aws_s3_bucket_website_configuration" "this" {
bucket = aws_s3_bucket.this.id

index_document {
suffix = "index.html"
}

error_document {
key = "error.html"
}
}
