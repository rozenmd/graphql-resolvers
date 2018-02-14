resource "aws_cloudfront_distribution" "site" {
#  origin {
#    domain_name = "${var.site_url}.s3-website-${var.aws_region}.amazonaws.com"
#    origin_id   = "s3"
#
#    custom_origin_config {
#      http_port              = "80"
#      https_port             = "443"
#      origin_protocol_policy = "http-only"
#      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
#    }
#  }

  origin {
    origin_id = "api"

    domain_name = "${aws_api_gateway_rest_api.site_api.id}.execute-api.${var.aws_region}.amazonaws.com"

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    origin_path = "/${aws_api_gateway_deployment.site_api_deployment.stage_name}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = ""
  default_root_object = "index.html"
  retain_on_delete    = true
  aliases             = ["${var.graphql_endpoint_url}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "api"

    forwarded_values {
      query_string = true

      cookies = {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    max_ttl                = 0
    default_ttl            = 0
  }

  cache_behavior {
    path_pattern           = "${var.graphql_endpoint}"
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "api"
    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
    viewer_protocol_policy = "https-only"

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }

      headers = [
        "Accept",
        "Authorization",
        "Origin",
      ]
    }
  }


  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Site = "${var.name}" #Not necessary unless you run a *lot* of sites
  }

  viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
    acm_certificate_arn      = "${var.acm_certificate_arn}"
  }
}
