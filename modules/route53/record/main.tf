resource "aws_route53_record" "example" {
  name    = var.record_name
  type    = var.record_type
  zone_id = var.zone_id

  alias {
    name                   = var.target_domain_name
    zone_id                = var.target_hosted_zone_id
    evaluate_target_health = false
  }
}
