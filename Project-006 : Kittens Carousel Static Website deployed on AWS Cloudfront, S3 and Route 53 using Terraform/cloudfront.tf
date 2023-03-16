
locals {
  s3_origin_id = "KittensOrigin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.www.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
  }

  enabled             = true
  comment             = "CloudFront pointint to S3 bucket"
  default_root_object = "index.html"
  http_version        = "http2"


  aliases = [var.kittensdomainname]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    compress         = true

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }



  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }


  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cer.arn
    ssl_support_method  = "sni-only"
  }
}
