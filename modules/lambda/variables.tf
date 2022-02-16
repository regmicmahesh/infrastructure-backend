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

variable "function_name" {
  type        = string
  description = "Name of the Lambda Function"
}

variable "image_uri" {
  type        = string
  description = "URI of the Docker Container for the Lambda Function in ECR"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC."
}

variable "subnet_ids" {
  type        = set(string)
  description = "List of subnet IDs associated with the Lambda function."
}

variable "internet_enabled" {
  type        = bool
  description = "Whether to enable internet access for the lambda."
}

variable "db_access_enabled" {
  type        = bool
  description = "Whether to enable DB Access."
}

variable "rds_sg_id" {
  type        = string
  description = "Security group ID of the RDS"
}

variable "environment_variables" {
  type        = map(string)
  description = "Environment variables of lambda"

}

variable "timeout" {
  type        = number
  description = "Timeout time for AWS Lambda"
  default     = 90
}


variable "memory_size" {
  type        = number
  description = "Memory size for AWS Lambda"
  default     = 512
}


variable "ses_enabled" {
  type        = bool
  description = "Whether to enable SES"
  default     = false
}
