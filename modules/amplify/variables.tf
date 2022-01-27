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

variable "app_name" {
  type        = string
  description = "Name of application you are deploying"
}

variable "git_repository" {
  type        = string
  description = "Bitbucket Repository URL (aka https cloning URL - https://github.com/org/repo_name)"
}

variable "github_branch" {
  type        = string
  description = "GitHub branch to track for changes"
}

variable "oauth_token" {
  type        = string
  description = "Access Token for repository. (Bitbucket).  Needs repo access at a minimum"
  default     = null
}

variable "domain_name" {
  type        = string
  description = "Domain name to host application - ex -x.com"
}


variable "prefix" {
  type        = string
  description = "domain prefix name for application- ex - dev for dev.i8labs.com"
}


variable "auto_build" {
  type    = bool
  default = true
}

variable "enabled" {
  type    = bool
  default = true
}

variable "environment_variables" {
  type        = map(string)
  description = "The environment variables map for an Amplify app."
  default     = null
}
