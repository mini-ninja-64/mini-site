resource "aws_s3_bucket" "website" {
  bucket = var.website_bucket
}

resource "aws_s3_bucket_ownership_controls" "website" {
  bucket = aws_s3_bucket.website.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "website_cloudfront" {
  bucket     = aws_s3_bucket.website.id
  policy     = data.aws_iam_policy_document.website_cloudfront.json
  depends_on = [aws_cloudfront_origin_access_control.website]
}

data "aws_iam_policy_document" "website_cloudfront" {
  policy_id = "PolicyForCloudFrontPrivateContent"
  statement {
    sid    = "AllowCloudFrontServicePrincipal"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.website.id}/*"]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["arn:aws:cloudfront::${data.aws_caller_identity.this.account_id}:distribution/${aws_cloudfront_distribution.website.id}"]
    }
  }
}
