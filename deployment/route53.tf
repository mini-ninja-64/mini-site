resource "aws_route53_zone" "website" {
  name = "${var.website_domain}."
}

locals {
  a_domains = {
    primary = var.website_domain
    www     = "www.${var.website_domain}"
  }
}

resource "aws_route53_record" "primary" {
  for_each = local.a_domains
  zone_id  = aws_route53_zone.website.zone_id
  name     = each.value
  type     = "A"
  alias {
    name                   = aws_cloudfront_distribution.website.domain_name
    zone_id                = aws_cloudfront_distribution.website.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "google_search_console" {
  zone_id = aws_route53_zone.website.zone_id
  name    = var.website_domain
  type    = "TXT"
  records = ["google-site-verification=${var.google_site_verification_id}"]
  ttl     = 3600
}
