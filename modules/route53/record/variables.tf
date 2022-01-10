variable "record_name" {
  type        = string
  description = "The name of the record."
}

variable "record_type" {
  type        = string
  description = "The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT. Defaults to A record"
  default     = "A"
}

variable "zone_id" {
  type        = string
  description = "The ID of the hosted zone to contain this record."
}


variable "target_domain_name" {
  description = "DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone."
  type        = string
}

variable "target_hosted_zone_id" {
  description = "Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone."
  type        = string
}
