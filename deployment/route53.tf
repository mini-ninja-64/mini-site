resource "aws_route53_zone" "website" {
  name = "${var.website_domain}."
}

locals {
  a_domains = {
    primary = var.website_domain
    www     = "www.${var.website_domain}"
  }

  dkim_records = {
    "protonmail._domainkey"  = "protonmail.domainkey.${var.proton_mail_dkim_id}.domains.proton.ch."
    "protonmail2._domainkey" = "protonmail2.domainkey.${var.proton_mail_dkim_id}.domains.proton.ch."
    "protonmail3._domainkey" = "protonmail3.domainkey.${var.proton_mail_dkim_id}.domains.proton.ch."
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

resource "aws_route53_record" "verifications" {
  zone_id = aws_route53_zone.website.zone_id
  name    = var.website_domain
  type    = "TXT"
  records = [
    "google-site-verification=${var.google_site_verification_id}",

    "protonmail-verification=${var.proton_mail_verification_id}",
    "v=spf1 include:_spf.protonmail.ch ~all"
  ]
  ttl             = 3600
  allow_overwrite = true
}

resource "aws_route53_record" "mx_records" {
  zone_id = aws_route53_zone.website.zone_id
  name    = var.website_domain
  type    = "MX"
  records = [
    "10 mail.protonmail.ch",
    "20 mailsec.protonmail.ch"
  ]
  ttl = 3600
}

resource "aws_route53_record" "dmarc" {
  zone_id = aws_route53_zone.website.zone_id
  name    = "_dmarc"
  type    = "TXT"
  records = ["v=DMARC1; p=quarantine"]
  ttl     = 3600
}

resource "aws_route53_record" "dkim" {
  for_each = local.dkim_records
  zone_id  = aws_route53_zone.website.zone_id
  name     = each.key
  type     = "CNAME"
  records  = [each.value]
  ttl      = 3600
}
