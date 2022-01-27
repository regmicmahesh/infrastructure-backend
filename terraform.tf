terraform {
  required_version = "~> 1.0.9"
  # Lock down on the versions
  required_providers {
    aws        = "~> 3.0"
    template   = "~> 2.0"
    null       = "~> 2.0"
    local      = "~> 1.3"
    kubernetes = "~> 1.9"
    tls        = "~> 2.1"
  }
  # This sets up the remote backend in terraform cloud mainly with two workspaces
  # `dev` and `prod`.
  # Workspace provides us the way to maintain multiple terraform states in remote
  # backend. It also provides a global name `terraform.workspace` that might be able to
  # differentiate resource in aws based on environment or workspace we are in.
  // backend "remote" {
  //   hostname     = "app.terraform.io"
  //   organization = "x"
  //   # For multiple workspace support
  //   workspaces {
  //     prefix = "infrastructure-"
  //   }
  // }
}
