resource "aws_s3_bucket" "this" {
  bucket = "${var.aws_account_id}-${var.aws_region}-${var.suffix_name}"
   versioning {
    enabled = var.enable_versioning
  }
}