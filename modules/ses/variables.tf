variable "domain_name" {
  description = "The domain name to assign to SES"
  type        = string
}

variable "zone_id" {
  description = "Zone ID for the domain"
  type        = string
}

variable "verify_domain" {
  description = "Verify domain ownership or not."
  type        = bool
  default     = true
}

