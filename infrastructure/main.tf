provider "aws" {
  region = "${var.aws_region}"
}

locals {
  env = "${terraform.workspace}"
}
