output  "domain_name" {
  description = "Domain Name of the Amplify URL"
  value       = join("." , [var.prefix, var.domain_name])
}
