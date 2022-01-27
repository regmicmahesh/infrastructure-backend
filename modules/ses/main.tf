resource "aws_ses_domain_identity" "domain-identity" {
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "default" {
  domain = aws_ses_domain_identity.domain-identity.domain
}

resource "aws_route53_record" "verification-record" {
  count   = var.verify_domain ? 1 : 0
  zone_id = var.zone_id
  name    = "_amazonses.${var.domain_name}"
  type    = "TXT"
  ttl     = "60"
  records = [aws_ses_domain_identity.domain-identity.verification_token]
}


resource "aws_route53_record" "dkim-verification-record" {
  count   = var.verify_domain ? 3 : 0
  zone_id = var.zone_id
  name    = "${element(aws_ses_domain_dkim.default.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.default.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_ses_domain_identity_verification" "domain-identity-verification" {
  count      = var.verify_domain ? 1 : 0
  domain     = aws_ses_domain_identity.domain-identity.id
  depends_on = [aws_route53_record.verification-record]
}
