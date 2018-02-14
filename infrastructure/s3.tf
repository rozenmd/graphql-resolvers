output "S3_BUCKET" {
  value = "${data.aws_s3_bucket.site_bucket.id}"
}

data "aws_s3_bucket" "site_bucket" {
  bucket = "${var.site_url}"

}

resource "aws_s3_bucket_object" "graphql" {
  bucket = "${data.aws_s3_bucket.site_bucket.id}"
  key    = "lambda/graphql/index.zip"
  source = "../build/api/index.zip"
  etag   = "${md5(file("../build/api/index.zip"))}"
}
