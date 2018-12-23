resource "aws_s3_bucket" "bucket" {
  bucket   = "${var.name}"
  acl      = "private"
  region   = "${var.region}"

  versioning {
    enabled = true
  }
  logging {
    target_bucket = "access-flow-bucket-tt"
    target_prefix = "${var.name}-${var.region}/log/"
  }
  lifecycle_rule {
    id      = "${var.name}-${var.region}"
    enabled = true

    prefix = "${var.name}-${var.region}/log/"
    transition {
      days          = 60
      storage_class = "GLACIER"
    }
  }

}

output "s3" {
  value = "${aws_s3_bucket.bucket.bucket_domain_name}"
}
output "s3arn" {
  value = "${aws_s3_bucket.bucket.arn}"
}