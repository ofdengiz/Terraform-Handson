resource "aws_s3_bucket" "www" {
  bucket = var.kittensdomainname

  tags = {
    Name = "My bucket"
  }
}
resource "aws_s3_account_public_access_block" "pab" {
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.www.bucket

  index_document {
    suffix = "index.html"
  }

}
