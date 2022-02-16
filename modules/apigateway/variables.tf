variable "namespace" {
  type        = string
  description = "Namespace (e.g. `eg` or `cp`)"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  default     = ""
}

variable "name" {
  type        = string
  description = "Name  (e.g. `app` or `cluster`)"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `{ BusinessUnit = \"XYZ\" }`"
}

variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}


variable "domain_name" {
  description = "Domain Name for the API Gateway"
  type        = string
}

variable "certificate_arn" {
  description = "Certificate ARN of the Domain"
  type        = string
}

variable "stage_name" {
  description = "Name / URI of the stage of API Gateway"
  default     = ""
  type        = string
}

variable "zone_id" {
  description = "Zone ID of the Domain in Route53"
  type        = string
}
