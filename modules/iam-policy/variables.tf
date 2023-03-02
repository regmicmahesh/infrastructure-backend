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

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources"
}

variable "iam_policy_statements" {
  type        = any
  description = "Map of IAM policy statements to use in the policy. This can be used with or instead of the `var.iam_source_json_url`."
  default     = {}
}

variable "description" {
  type        = string
  description = "Description of IAM policy"
  default     = null
}

variable "iam_policy_enabled" {
  type        = bool
  description = "If set to true will create IAM policy in AWS"
  default     = false
}

variable "iam_policy_id" {
  type        = string
  description = "ID for the policy document."
  default     = null
}

variable "iam_source_policy_documents" {
  type        = list(string)
  description = "List of IAM policy documents that are merged together into the exported document. Statements defined in `source_policy_documents` or `source_json` must have unique sids. Statements with the same sid from documents assigned to the `override_json` and `override_policy_documents` arguments will override source statements."
  default     = null
}

variable "iam_override_policy_documents" {
  type        = list(string)
  description = "List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank sids will override statements with the same sid from earlier documents in the list. Statements with non-blank sids will also override statements with the same sid from documents provided in the `source_json` and `source_policy_documents` arguments. Non-overriding statements will be added to the exported document."
  default     = null
}

variable "name_suffix" {
  type        = string
  description = "Suffix to append to the IAM policy name."
  default     = null
}
