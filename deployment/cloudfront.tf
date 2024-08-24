resource "aws_cloudfront_distribution" "website" {
  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
    origin_id                = var.cloudfront_origin_id
  }

  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"

  default_root_object = "index.html"
  aliases             = [var.website_domain]

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id = var.cloudfront_origin_id
    cache_policy_id  = aws_cloudfront_cache_policy.website.id

    compress               = true
    viewer_protocol_policy = "redirect-to-https"


    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.index_html_redirect.arn
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.website.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  depends_on = [aws_cloudfront_cache_policy.website, aws_acm_certificate.website]
}

resource "aws_cloudfront_cache_policy" "website" {
  name        = "website-cache-policy"
  default_ttl = 3600
  max_ttl     = 21600
  min_ttl     = 60

  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_control" "website" {
  name                              = "website-cloudfront-access-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_function" "index_html_redirect" {
  name    = "index_html_redirect"
  runtime = "cloudfront-js-2.0"
  publish = true
  code    = file("${path.module}/index_html_redirect.js")
}
