resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.public_access,
  ]

  bucket = aws_s3_bucket.website.id
  acl    = "public-read"
}
resource "aws_s3_object" "index" {
  source       = "index.html"
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  acl          = "public-read"
  content_type = "text/html"
}
resource "aws_s3_object" "error" {
  source       = "error.html"
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  acl          = "public-read"
  content_type = "text/html"
}
resource "aws_s3_object" "superman" {
  source = "superman.jpeg"
  bucket = aws_s3_bucket.website.id
  key    = "superman.jpeg"
  acl    = "public-read"
}
resource "aws_s3_object" "doomsday" {
  source = "superdoom.jpeg"
  bucket = aws_s3_bucket.website.id
  key    = "superdoom.jpeg"
  acl    = "public-read"
}
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.website.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
  depends_on = [aws_s3_bucket_acl.bucket_acl]

}

