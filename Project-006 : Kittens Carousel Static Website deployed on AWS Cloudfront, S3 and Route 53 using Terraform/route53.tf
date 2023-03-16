resource "aws_acm_certificate" "cer" {
  domain_name               = var.domainame
  validation_method         = "DNS"
  subject_alternative_names = [var.kittensdomainname]
}

data "aws_route53_zone" "route53zone" {
  name         = var.domainame
  private_zone = false
}

resource "aws_route53_record" "route53record" {
  for_each = {
    for dvo in aws_acm_certificate.cer.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.route53zone.zone_id
}

resource "aws_acm_certificate_validation" "cervalidate" {
  certificate_arn         = aws_acm_certificate.cer.arn
  validation_record_fqdns = [for record in aws_route53_record.route53record : record.fqdn]
}

resource "aws_route53_record" "kittens" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "example.com"
  type    = "A"

  alias {
    name                   = aws_elb.main.dns_name
    zone_id                = aws_elb.main.zone_id
    evaluate_target_health = true
  }
}