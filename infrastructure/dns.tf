data "aws_route53_zone" "site_zone" {
  name = "${var.site_url}"
}

resource "aws_route53_record" "cf_alias_A" {
  zone_id = "${data.aws_route53_zone.site_zone.zone_id}"
  name    = "${var.graphql_endpoint_url}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.site.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.site.hosted_zone_id}"
    evaluate_target_health = true
  }
}
#ipv6 is kind of overkill, but future proof!
resource "aws_route53_record" "cf_alias_AAAA" {
  zone_id = "${data.aws_route53_zone.site_zone.zone_id}"
  name    = "${var.graphql_endpoint_url}"
  type    = "AAAA"

  alias {
    name                   = "${aws_cloudfront_distribution.site.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.site.hosted_zone_id}"
    evaluate_target_health = true
  }
}
