resource "aws_route53_zone" "website" {
  name = "${var.website_domain}."
}
