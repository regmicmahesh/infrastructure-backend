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
variable "engine_name" {
  type        = string
  description = "The name of the database engine to be used for this DB cluster. Defaults to aurora. Valid Values: aurora, aurora-mysql, aurora-postgresql"
  default     = "aurora-postgresql"
}

variable "database_name" {
  type        = string
  description = "Name for an automatically created database on cluster creation."
}

variable "master_username" {
  type        = string
  description = "Username for the master DB user."
}

variable "master_password" {
  type        = string
  description = "Password for the master DB user."
}

variable "min_capacity" {
  type        = string
  description = "The minimum capacity for an Aurora DB cluster in serverless DB engine mode."
}

variable "max_capacity" {
  type        = string
  description = "The maximum capacity for an Aurora DB cluster in serverless DB engine mode."
}

variable "backup_retention_period" {
  type        = string
  description = "Backup retention period for RDS."
  default     = 1
}

variable "subnet_ids" {
  type        = set(string)
  description = "A list of VPC subnet IDs."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the RDS cluster to deploy in."
}

variable "allowed_security_groups" {
  type        = list(string)
  description = "Allowed Security Group for the RDS Cluster."
}

