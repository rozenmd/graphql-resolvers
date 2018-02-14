terraform {
  backend "s3" {
    bucket = "${var.site_url}"
    key    = "terraform/${var.name}.tfstate"
    region = "${var.aws_region}"
  }
}
