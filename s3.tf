resource "aws_s3_bucket" "cerberus-bucket" {
  bucket = local.s3-sufix
}