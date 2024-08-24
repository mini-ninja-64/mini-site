resource "aws_route53_zone" "website" {
  name = "${var.website_domain}."
}

resource "aws_route53_record" "primary" {
  zone_id = aws_route53_zone.website.zone_id
  name    = var.website_domain
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = false
  }
}
