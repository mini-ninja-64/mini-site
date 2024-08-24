resource "aws_acm_certificate" "website" {
  domain_name               = var.website_domain
  validation_method         = "DNS"
  subject_alternative_names = ["*.${var.website_domain}"]

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "website" {
  certificate_arn         = aws_acm_certificate.website.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_records : record.fqdn]
}

# route53 checker to wait for acm cert to be deployed
resource "aws_route53_record" "validation_records" {
  for_each = {
    for dvo in aws_acm_certificate.website.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.website.zone_id

  depends_on = [aws_acm_certificate.website]
}
