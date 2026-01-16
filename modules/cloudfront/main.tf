
resource "aws_cloudfront_origin_access_control" "this" {
name = "${var.project}-oac"
origin_access_control_origin_type = "s3"
signing_behavior = "always"
signing_protocol = "sigv4"
}


resource "aws_cloudfront_distribution" "this" {
enabled = true
default_root_object = "index.html"


origin {
domain_name = var.bucket_domain_name
origin_id = "s3-origin"
origin_access_control_id = aws_cloudfront_origin_access_control.this.id
}


default_cache_behavior {
target_origin_id = "s3-origin"
viewer_protocol_policy = "redirect-to-https"


allowed_methods = ["GET", "HEAD"]
cached_methods = ["GET", "HEAD"]


forwarded_values {
query_string = false


cookies {
forward = "none"
}
}
}


restrictions {
geo_restriction {
restriction_type = "none"
}
}


viewer_certificate {
cloudfront_default_certificate = true
}
}


# Allow CloudFront to read S3


data "aws_iam_policy_document" "this" {
statement {
actions = ["s3:GetObject"]
resources = ["${var.bucket_arn}/*"]


principals {
type = "Service"
identifiers = ["cloudfront.amazonaws.com"]
}


condition {
test = "StringEquals"
variable = "AWS:SourceArn"
values = [aws_cloudfront_distribution.this.arn]
}
