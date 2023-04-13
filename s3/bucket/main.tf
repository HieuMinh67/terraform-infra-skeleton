resource "aws_s3_bucket" "this" {
  bucket = "${var.aws_account_id}-${var.aws_region}-${var.suffix_name}"
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Disabled"
  }
}