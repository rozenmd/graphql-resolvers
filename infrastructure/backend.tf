terraform {
  backend "s3" {
    bucket = "YOUR_DOMAIN_URL"
    key    = "terraform/YOUR_DOMAIN_URL.tfstate"
    region = "YOUR_AWS_REGION"
  }
}
